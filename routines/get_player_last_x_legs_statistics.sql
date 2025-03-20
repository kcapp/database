DROP PROCEDURE IF EXISTS `get_player_last_x_legs_statistics`;

CREATE PROCEDURE `get_player_last_x_legs_statistics`(IN num_legs INT)
BEGIN
    -- Step 1: Create a temporary table to store last N legs per player
    CREATE TEMPORARY TABLE IF NOT EXISTS LastNLegsPerPlayer (
        player_id INT,
        leg_id INT,
        end_time DATETIME,
        PRIMARY KEY (player_id, leg_id) -- Prevent duplicates
    );

    -- Clear the temporary table in case it already exists
    DELETE FROM LastNLegsPerPlayer;

    -- Step 2: Populate the temporary table with the latest N legs per player
    INSERT INTO LastNLegsPerPlayer (player_id, leg_id, end_time)
    SELECT
        player_id,
        leg_id,
        end_time
    FROM (
        SELECT
            p2l.player_id,
            p2l.leg_id,
            l.end_time,
            ROW_NUMBER() OVER (PARTITION BY p2l.player_id ORDER BY l.end_time DESC) AS leg_rank
        FROM player2leg p2l
        JOIN leg l ON l.id = p2l.leg_id
        JOIN matches m ON m.id = l.match_id
        WHERE m.is_finished = 1 
            AND m.is_abandoned = 0 AND m.is_bye = 0 AND l.has_scores = 1
            AND IFNULL(l.leg_type_id, m.match_type_id) = 1 -- X01 games only
    ) AS RankedLegs
    WHERE leg_rank <= num_legs;

    -- Step 3: Generate statistics based on only the selected legs
    SELECT
        p.id AS 'player_id',
        COUNT(DISTINCT m.id) AS 'matches_played',
        COUNT(DISTINCT m2.id) AS 'matches_won',
        COUNT(DISTINCT l.id) AS 'legs_played',
        COUNT(DISTINCT l2.id) AS 'legs_won',
        m.office_id AS 'office_id',
        SUM(s.ppd_score) / SUM(s.darts_thrown) AS 'ppd',
        SUM(s.first_nine_ppd) / COUNT(p.id) AS 'first_nine_ppd',
        (SUM(s.ppd_score) / SUM(s.darts_thrown)) * 3 AS 'three_dart_avg',
        SUM(s.first_nine_ppd) / COUNT(p.id) * 3 AS 'first_nine_three_dart_avg',
        SUM(s.60s_plus) AS '60s_plus',
        SUM(s.100s_plus) AS '100s_plus',
        SUM(s.140s_plus) AS '140s_plus',
        SUM(s.180s) AS '180s',
        SUM(s.accuracy_20) / COUNT(s.accuracy_20) AS 'accuracy_20s',
        SUM(s.accuracy_19) / COUNT(s.accuracy_19) AS 'accuracy_19s',
        SUM(s.overall_accuracy) / COUNT(s.overall_accuracy) AS 'accuracy_overall',
        (COUNT(s.checkout_percentage) / SUM(s.checkout_attempts)) * 100 AS 'checkout_percentage',
        MAX(s.checkout) AS 'checkout',
        MAX(lastN.end_time) AS 'last_played_leg'
    FROM statistics_x01 s
        JOIN player p ON p.id = s.player_id
        JOIN leg l ON l.id = s.leg_id
        JOIN matches m ON m.id = l.match_id
        JOIN LastNLegsPerPlayer lastN on lastN.leg_id = s.leg_id AND lastN.player_id = s.player_id
        LEFT JOIN leg l2 ON l2.id = s.leg_id AND l2.winner_id = p.id
        LEFT JOIN matches m2 ON m2.id = l.match_id AND m2.winner_id = p.id
    WHERE p.is_bot = 0 AND p.active = 1
    GROUP BY p.id
    HAVING legs_played >= num_legs AND last_played_leg >= NOW() - INTERVAL (SELECT leaderboard_active_period_weeks FROM match_default LIMIT 1) WEEK
    ORDER BY three_dart_avg DESC;

    -- Step 4: Drop the temporary table
    DROP TEMPORARY TABLE LastNLegsPerPlayer;
END;