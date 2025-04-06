-- +goose Up
DROP PROCEDURE IF EXISTS `get_player_x01_statistics_per_leg_bucket`;
-- +goose StatementBegin
CREATE PROCEDURE get_player_x01_statistics_per_leg_bucket(
    IN player_id INT, -- Player ID to get stats forq
    IN bucket_size INT, -- Number of legs per bucket to look at
    IN starting_score INT, -- Specify a starting score, or NULL for all
    IN 1v1_only TINYINT, -- Filter only 1v1 matches
    IN official_only TINYINT) -- Filter only official matches
BEGIN
    SELECT
        BucketStats.player_id,
        BucketStats.leg_bucket+1 AS bucket,
        BucketStats.first_leg_in_bucket,
        BucketStats.last_leg_in_bucket,
        BucketStats.legs_in_bucket,
        BucketStats.start_date,
        BucketStats.end_date,
        Stats.ppd,
        Stats.first_nine_ppd,
        Stats.three_dart_avg,
        Stats.first_nine_three_dart_avg,
        Stats.60s_plus,
        Stats.100s_plus,
        Stats.140s_plus,
        Stats.180s,
        Stats.accuracy_20s,
        Stats.accuracy_19s,
        Stats.accuracy_overall,
        Stats.checkout_percentage,
        Stats.highest_checkout
    FROM (
        SELECT
            player_id,
            MIN(leg_id) AS first_leg_in_bucket,
            MAX(leg_id) AS last_leg_in_bucket,
            DATE(MIN(end_time)) AS 'start_date',
            DATE(MAX(end_time)) AS 'end_date',            
            FLOOR((leg_rank - 1) / bucket_size) AS leg_bucket,
            COUNT(*) AS legs_in_bucket
        FROM (
            SELECT
                p2l.player_id,
                p2l.leg_id,
                l.end_time,
                ROW_NUMBER() OVER (PARTITION BY p2l.player_id ORDER BY l.end_time) AS leg_rank
            FROM player2leg p2l
                JOIN leg l ON l.id = p2l.leg_id
                JOIN matches m ON m.id = l.match_id
            WHERE m.is_finished = 1 AND l.is_finished = 1
              AND m.is_abandoned = 0 AND m.is_bye = 0 AND l.has_scores = 1
              AND IFNULL(l.leg_type_id, m.match_type_id) = 1 -- X01 games only
              AND p2l.player_id = player_id
              AND (l.num_players = IF(1v1_only, 2, l.num_players))
              AND (IF(official_only, m.tournament_id IS NOT NULL, TRUE))
              AND (IF(starting_score IS NOT NULL AND starting_score != 0, l.starting_score = starting_score, TRUE))
            ORDER BY l.end_time
        ) AS RankedLegs
        GROUP BY player_id, leg_bucket
    ) AS BucketStats
    JOIN (
        SELECT
            player_id,
            SUM(ppd_score) / SUM(darts_thrown) AS 'ppd',
            SUM(first_nine_ppd) / COUNT(id) AS 'first_nine_ppd',
            (SUM(ppd_score) / SUM(darts_thrown)) * 3 AS 'three_dart_avg',
            SUM(first_nine_ppd) / COUNT(id) * 3 AS 'first_nine_three_dart_avg',
            SUM(60s_plus) AS '60s_plus',
            SUM(100s_plus) AS '100s_plus',
            SUM(140s_plus) AS '140s_plus',
            SUM(180s) AS '180s',
            SUM(accuracy_20) / COUNT(accuracy_20) AS 'accuracy_20s',
            SUM(accuracy_19) / COUNT(accuracy_19) AS 'accuracy_19s',
            SUM(overall_accuracy) / COUNT(overall_accuracy) AS 'accuracy_overall',
            (COUNT(checkout_percentage) / SUM(checkout_attempts)) * 100 AS 'checkout_percentage',
            MAX(checkout) AS 'highest_checkout',
            FLOOR((leg_rank - 1) / bucket_size) AS leg_bucket
        FROM (
            SELECT
                s.*,
                ROW_NUMBER() OVER (PARTITION BY s.player_id ORDER BY l.end_time) AS leg_rank
            FROM statistics_x01 s
                JOIN player p ON p.id = s.player_id
                JOIN leg l ON l.id = s.leg_id
                JOIN matches m ON m.id = l.match_id
                LEFT JOIN leg l2 ON l2.id = s.leg_id AND l2.winner_id = p.id
                LEFT JOIN matches m2 ON m2.id = l.match_id AND m2.winner_id = p.id
            WHERE s.player_id = player_id
                AND (l.num_players = IF(1v1_only, 2, l.num_players))
                AND (IF(official_only, m.tournament_id IS NOT NULL, TRUE))
                AND (IF(starting_score IS NOT NULL AND starting_score != 0, l.starting_score = starting_score, TRUE))
        ) AS StatsWithRank
        GROUP BY player_id, leg_bucket
    ) AS Stats
    ON BucketStats.player_id = Stats.player_id AND BucketStats.leg_bucket = Stats.leg_bucket
    ORDER BY BucketStats.leg_bucket;
END;
-- +goose StatementEnd

-- +goose Down
DROP PROCEDURE IF EXISTS `get_player_x01_statistics_per_leg_bucket`;

