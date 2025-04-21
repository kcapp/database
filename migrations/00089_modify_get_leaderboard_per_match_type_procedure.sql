-- +goose Up
ALTER TABLE match_default ADD leaderboard_matchtypes_min_players INT DEFAULT 0 NOT NULL;

DROP PROCEDURE IF EXISTS `get_leaderboard_per_match_type`;
-- +goose StatementBegin
CREATE PROCEDURE get_leaderboard_per_match_type(IN top_n INT)
BEGIN
    SET @min_players = (SELECT leaderboard_matchtypes_min_players FROM match_default);

    SELECT match_type_id, player_id, leg_id, darts_thrown, score, avg FROM (
        -- X01 (301)
        SELECT * FROM (
            SELECT 1 AS match_type_id, player_id, leg_id, darts_thrown, starting_score as 'score', NULL as 'avg'
            FROM (SELECT l.end_time,
                        s.player_id,
                        s.leg_id,
                        s.darts_thrown,
                        l.starting_score,
                        ROW_NUMBER() OVER (PARTITION BY s.player_id ORDER BY s.darts_thrown ASC, l.end_time ASC) AS rn
                FROM statistics_x01 s
                        JOIN leg l ON s.leg_id = l.id
                        JOIN player p ON p.id = s.player_id
                WHERE l.starting_score = 301
                    AND l.winner_id = s.player_id
                    AND l.num_players > @min_players
                    AND p.is_bot = 0) ranked
            WHERE rn = 1 ORDER BY darts_thrown ASC, end_time ASC LIMIT top_n
        ) x01301
        UNION ALL
        -- X01 (501)
        SELECT * FROM (
            SELECT 1 AS match_type_id, player_id, leg_id, darts_thrown, starting_score, NULL
            FROM (SELECT l.end_time,
                        s.player_id,
                        s.leg_id,
                        s.darts_thrown,
                        l.starting_score,
                        ROW_NUMBER() OVER (PARTITION BY s.player_id ORDER BY s.darts_thrown ASC, l.end_time ASC) AS rn
                FROM statistics_x01 s
                        JOIN leg l ON s.leg_id = l.id
                        JOIN player p ON p.id = s.player_id
                WHERE l.starting_score = 501
                    AND l.winner_id = s.player_id
                    AND l.num_players > @min_players                
                    AND p.is_bot = 0) ranked
            WHERE rn = 1 ORDER BY darts_thrown ASC, end_time ASC LIMIT top_n
        ) x01501
        UNION ALL
        -- X01 (701)
        SELECT * FROM (
            SELECT 1 AS match_type_id, player_id, leg_id, darts_thrown, starting_score, NULL
            FROM (SELECT l.end_time,
                        s.player_id,
                        s.leg_id,
                        s.darts_thrown,
                        l.starting_score,
                        ROW_NUMBER() OVER (PARTITION BY s.player_id ORDER BY s.darts_thrown ASC, l.end_time ASC) AS rn
                FROM statistics_x01 s
                        JOIN leg l ON s.leg_id = l.id
                        JOIN player p ON p.id = s.player_id
                WHERE l.starting_score = 701
                    AND l.winner_id = s.player_id
                    AND l.num_players > @min_players 
                    AND p.is_bot = 0) ranked
            WHERE rn = 1 ORDER BY darts_thrown ASC, end_time ASC LIMIT top_n
        ) x01701
        UNION ALL
        -- Shootout
        SELECT * FROM (
            SELECT 2 AS match_type_id, player_id, leg_id, darts_thrown, score, NULL FROM statistics_shootout s
                LEFT JOIN leg l ON l.id = s.leg_id
                WHERE num_players > @min_players AND (player_id, score) IN (SELECT player_id, MAX(score) FROM statistics_shootout WHERE darts_thrown > 9 GROUP BY player_id) ORDER BY score DESC LIMIT top_n
        ) AS shootout
        UNION ALL
        -- Shootout (max 9)
        SELECT * FROM (
            SELECT 2 AS match_type_id, player_id, leg_id, darts_thrown, score, NULL FROM statistics_shootout s
                LEFT JOIN leg l ON l.id = s.leg_id
            WHERE num_players > @min_players AND (player_id, score) IN (SELECT player_id, MAX(score) FROM statistics_shootout WHERE darts_thrown = 9 GROUP BY player_id) ORDER BY score DESC LIMIT top_n
        ) AS shootout_max9
        UNION ALL
        -- X01 Handicap
        SELECT * FROM (
            SELECT
                3 AS match_type_id,
                leg_stats.winner_id,
                leg_stats.leg_id,
                x.darts_thrown,
                leg_stats.starting_score + leg_stats.handicap_diff as 'score',
                NULL
            FROM (
                SELECT
                    p2l.leg_id,
                    MAX(p2l.handicap) - MIN(p2l.handicap) AS handicap_diff,
                    MAX(p2l.handicap) AS max_handicap,
                    l.winner_id,
                    l.starting_score
                FROM player2leg p2l
                    JOIN leg l ON p2l.leg_id = l.id
                WHERE num_players > @min_players AND p2l.handicap IS NOT NULL AND l.winner_id IS NOT NULL
                GROUP BY p2l.leg_id HAVING handicap_diff > 0 ORDER BY handicap_diff DESC
            ) AS leg_stats
            JOIN player2leg p2l ON p2l.leg_id = leg_stats.leg_id AND p2l.handicap = leg_stats.max_handicap
            JOIN statistics_x01 x ON x.leg_id = leg_stats.leg_id AND x.player_id = leg_stats.winner_id
            WHERE (p2l.player_id = leg_stats.winner_id) = 1
            GROUP BY p2l.player_id
            ORDER BY handicap_diff DESC, leg_stats.leg_id
            LIMIT top_n
        ) AS x01handicap
        UNION ALL
        -- Cricket
        SELECT * FROM (
            SELECT 4 AS match_type_id, player_id, leg_id, rounds * 3 AS 'darts_thrown', score, NULL FROM statistics_cricket s
                JOIN leg l ON l.id = s.leg_id
            WHERE num_players > @min_players AND l.winner_id = s.player_id AND (player_id, rounds) IN (SELECT player_id, MIN(rounds) FROM statistics_cricket GROUP BY player_id)
            GROUP BY s.player_id
            ORDER BY rounds ASC, score ASC, mpr DESC
            LIMIT top_n
        ) AS cricket
        UNION ALL
        -- Darts at X
        SELECT * FROM (
            SELECT 5 AS match_type_id, player_id, leg_id, 99, score, NULL FROM statistics_darts_at_x s
            WHERE (player_id, score) IN (SELECT player_id, MAX(score) FROM statistics_darts_at_x GROUP BY player_id)
            ORDER BY score DESC LIMIT top_n
        ) AS dartsatx
        UNION ALL
        -- Around the World
        SELECT * FROM (
            SELECT 6 AS match_type_id, s.player_id, s.leg_id, s.darts_thrown, s.score, NULL FROM statistics_around_the s
                JOIN leg l ON l.id = s.leg_id
                JOIN matches m ON m.id = l.match_id
            WHERE num_players > @min_players AND m.match_type_id = 6 AND (s.player_id, s.score) IN (
                  SELECT s2.player_id, MAX(s2.score) FROM statistics_around_the s2
                    JOIN leg l2 ON l2.id = s2.leg_id
                    JOIN matches m2 ON m2.id = l2.match_id
                  WHERE m2.match_type_id = 6
                  GROUP BY s2.player_id)
            ORDER BY s.score DESC LIMIT top_n
        ) AS atw
        UNION ALL
        -- Shanghai
        SELECT * FROM (
            SELECT 7 AS match_type_id, s.player_id, s.leg_id, s.darts_thrown, s.score, NULL FROM statistics_around_the s
                JOIN leg l ON l.id = s.leg_id
                JOIN matches m ON m.id = l.match_id
            WHERE num_players > @min_players AND m.match_type_id = 7 AND (s.player_id, s.darts_thrown) IN (
                SELECT s2.player_id, MIN(s2.darts_thrown) FROM statistics_around_the s2
                    JOIN leg l2 ON l2.id = s2.leg_id
                    JOIN matches m2 ON m2.id = l2.match_id
                WHERE m2.match_type_id = 7 AND s2.player_id = l2.winner_id
                GROUP BY s2.player_id)
            ORDER BY s.darts_thrown, s.score DESC LIMIT top_n
        ) AS shanghai
        UNION ALL
        -- Around the Clock
        SELECT * FROM (
            SELECT 8 AS match_type_id, s.player_id, s.leg_id, s.darts_thrown, s.score, NULL FROM statistics_around_the s
                JOIN leg l ON l.id = s.leg_id
                JOIN matches m ON m.id = l.match_id
            WHERE num_players > @min_players AND m.match_type_id = 8 AND s.score = 21 AND (s.player_id, s.darts_thrown) IN (
                SELECT s2.player_id, MIN(s2.darts_thrown) FROM statistics_around_the s2
                    JOIN leg l2 ON l2.id = s2.leg_id
                    JOIN matches m2 ON m2.id = l2.match_id
                WHERE m2.match_type_id = 8 AND s2.score = 21
                GROUP BY s2.player_id)
            ORDER BY s.darts_thrown ASC LIMIT top_n
        ) AS atc
        UNION ALL
        -- Tic Tac Toe
        SELECT * FROM (
            SELECT 9 AS match_type_id, player_id, leg_id, darts_thrown, score, NULL FROM statistics_tic_tac_toe s
                JOIN leg l ON s.leg_id = l.id
            WHERE num_players > @min_players AND numbers_closed >= 3 AND s.player_id = l.winner_id AND (player_id, score) IN (SELECT player_id, MAX(score) FROM statistics_tic_tac_toe GROUP BY player_id)
            GROUP BY player_id
            ORDER BY numbers_closed ASC, score DESC, darts_thrown ASC LIMIT top_n
        ) AS tictactoe
        UNION ALL
        -- Bermuda Triangle
        SELECT * FROM (
            SELECT 10 AS match_type_id, player_id, leg_id, darts_thrown, score, NULL FROM statistics_bermuda_triangle s
                LEFT JOIN leg l ON l.id = s.leg_id
            WHERE num_players > @min_players AND (player_id, score) IN (SELECT player_id, MAX(score) FROM statistics_bermuda_triangle GROUP BY player_id)
            ORDER BY score DESC LIMIT top_n
        ) AS bermuda
        UNION ALL
        -- 420 (lower is better)
        SELECT * FROM (
            SELECT 11 AS match_type_id, player_id, leg_id, 63, score, NULL FROM statistics_420 s
                LEFT JOIN leg l ON l.id = s.leg_id
            WHERE num_players > @min_players AND (player_id, score) IN (SELECT player_id, MIN(score) FROM statistics_420 GROUP BY player_id)
            ORDER BY score ASC LIMIT top_n
        ) AS fourtwenty
        UNION ALL
        -- Kill Bull
        SELECT * FROM (
            SELECT 12 AS match_type_id, player_id, leg_id, darts_thrown, l.starting_score, NULL FROM statistics_kill_bull s
                JOIN leg l ON l.id = s.leg_id
            WHERE num_players > @min_players AND score = 0 AND (player_id, darts_thrown) IN (SELECT player_id, MIN(darts_thrown) FROM statistics_kill_bull GROUP BY player_id)
            ORDER BY starting_score DESC, darts_thrown LIMIT top_n
        ) AS killbull
        UNION ALL
        -- Gotcha
        SELECT * FROM (
            SELECT 13 AS match_type_id, player_id, leg_id, darts_thrown, score, NULL FROM statistics_gotcha s
                JOIN leg l ON l.id = s.leg_id
            WHERE num_players > 1  -- Gotcha with 1 player makes no sense
                AND l.winner_id = s.player_Id AND (player_id, darts_thrown) IN (SELECT player_id, MIN(darts_thrown) FROM statistics_gotcha GROUP BY player_id)
            ORDER BY darts_thrown ASC LIMIT top_n
        ) AS gotcha
        UNION ALL
        -- JDC Practice
        SELECT * FROM (
            SELECT 14 AS match_type_id, player_id, leg_id, darts_thrown, score, NULL FROM statistics_jdc_practice s
                LEFT JOIN leg l on l.id = s.leg_id
            WHERE num_players > @min_players AND (player_id, score) IN (SELECT player_id, MAX(score) FROM statistics_jdc_practice GROUP BY player_id)
            ORDER BY score DESC LIMIT top_n
        ) AS jdc
        UNION ALL
        -- Knockout
        SELECT * FROM (
            SELECT 15 AS match_type_id, player_id, leg_id, darts_thrown, starting_lives, avg_score
            FROM (SELECT s.player_id,
                        s.leg_id,
                        s.darts_thrown,
                        lp.starting_lives,
                        s.avg_score,
                        ROW_NUMBER() OVER (PARTITION BY s.player_id ORDER BY starting_lives*avg_score DESC) AS rn
                FROM statistics_knockout s
                    JOIN leg_parameters lp ON lp.leg_id = s.leg_id
                    JOIN leg l ON l.id = s.leg_id
                WHERE final_position = 1
                    AND num_players > 1 -- Solo knockout matches makes no sense 
                ) ranked
            WHERE rn = 1
            ORDER BY (starting_lives*avg_score) DESC, darts_thrown ASC, avg_score DESC LIMIT top_n
        ) knockout
        UNION ALL
        -- Scam
        SELECT * FROM (
            SELECT 16 AS match_type_id, player_id, leg_id, darts_thrown_stopper, score, NULL FROM statistics_scam s
                LEFT JOIN leg l ON l.id = s.leg_id
            WHERE num_players > 1 -- Scam with 1 player makes no sense
                AND (player_id, darts_thrown_stopper) IN (SELECT player_id, MIN(darts_thrown_stopper) FROM statistics_scam GROUP BY player_id)
            ORDER BY darts_thrown_stopper ASC LIMIT top_n
        ) AS scam
        UNION ALL
        -- 170
        SELECT * FROM (
            SELECT 17 AS match_type_id, player_id, leg_id, darts_thrown, highest_checkout, NULL FROM statistics_170 s
                LEFT JOIN leg l ON l.id = s.leg_id
            WHERE num_players > @min_players AND (player_id, highest_checkout) IN (SELECT player_id, MAX(highest_checkout) FROM statistics_170 WHERE checkout_percentage IS NOT NULL GROUP BY player_id)
            ORDER BY highest_checkout DESC, checkout_3_darts DESC, checkout_4_darts DESC, checkout_5_darts DESC, checkout_6_darts DESC, checkout_7_darts DESC, checkout_8_darts DESC, checkout_9_darts DESC LIMIT top_n
        ) AS oneseventy
    ) AS leaderboard;
END;
-- +goose StatementEnd

-- +goose Down
DROP PROCEDURE IF EXISTS `get_leaderboard_per_match_type`;
-- +goose StatementBegin
CREATE PROCEDURE get_leaderboard_per_match_type(IN top_n INT)
BEGIN
    SELECT match_type_id, player_id, leg_id, darts_thrown, score FROM (
        -- Shootout
        SELECT * FROM (
            SELECT 2 AS match_type_id, player_id, leg_id, darts_thrown, score FROM statistics_shootout s
            WHERE (player_id, score) IN (SELECT player_id, MAX(score) FROM statistics_shootout WHERE darts_thrown > 9 GROUP BY player_id) ORDER BY score DESC LIMIT top_n
        ) AS shootout
        UNION ALL
        -- Shootout (max 9)
        SELECT * FROM (
            SELECT 2 AS match_type_id, player_id, leg_id, darts_thrown, score FROM statistics_shootout s
            WHERE (player_id, score) IN (SELECT player_id, MAX(score) FROM statistics_shootout WHERE darts_thrown = 9 GROUP BY player_id) ORDER BY score DESC LIMIT top_n
        ) AS shootout_max9
        UNION ALL
        -- Darts at X
        SELECT * FROM (
            SELECT 5 AS match_type_id, player_id, leg_id, 99, score FROM statistics_darts_at_x s
            WHERE (player_id, score) IN (SELECT player_id, MAX(score) FROM statistics_darts_at_x GROUP BY player_id)
            ORDER BY score DESC LIMIT top_n
        ) AS dartsatx
        UNION ALL
        -- Around the World
        SELECT * FROM (
            SELECT 6 AS match_type_id, s.player_id, s.leg_id, s.darts_thrown, s.score FROM statistics_around_the s
                JOIN leg l ON l.id = s.leg_id
                JOIN matches m ON m.id = l.match_id
            WHERE m.match_type_id = 6 AND (s.player_id, s.score) IN (
                  SELECT s2.player_id, MAX(s2.score) FROM statistics_around_the s2
                    JOIN leg l2 ON l2.id = s2.leg_id
                    JOIN matches m2 ON m2.id = l2.match_id
                  WHERE m2.match_type_id = 6
                  GROUP BY s2.player_id)
            ORDER BY s.score DESC LIMIT top_n
        ) AS atw
        UNION ALL
        -- Shanghai
        SELECT * FROM (
            SELECT 7 AS match_type_id, s.player_id, s.leg_id, s.darts_thrown, s.score FROM statistics_around_the s
                JOIN leg l ON l.id = s.leg_id
                JOIN matches m ON m.id = l.match_id
            WHERE m.match_type_id = 7 AND (s.player_id, s.darts_thrown) IN (
                SELECT s2.player_id, MIN(s2.darts_thrown) FROM statistics_around_the s2
                    JOIN leg l2 ON l2.id = s2.leg_id
                    JOIN matches m2 ON m2.id = l2.match_id
                WHERE m2.match_type_id = 7 AND s2.player_id = l2.winner_id
                GROUP BY s2.player_id)
            ORDER BY s.darts_thrown, s.score DESC LIMIT top_n
        ) AS shanghai
        UNION ALL
        -- Around the Clock
        SELECT * FROM (
            SELECT 8 AS match_type_id, s.player_id, s.leg_id, s.darts_thrown, s.score FROM statistics_around_the s
                JOIN leg l ON l.id = s.leg_id
                JOIN matches m ON m.id = l.match_id
            WHERE m.match_type_id = 8 AND s.score = 21 AND (s.player_id, s.darts_thrown) IN (
                SELECT s2.player_id, MIN(s2.darts_thrown) FROM statistics_around_the s2
                    JOIN leg l2 ON l2.id = s2.leg_id
                    JOIN matches m2 ON m2.id = l2.match_id
                WHERE m2.match_type_id = 8 AND s2.score = 21
                GROUP BY s2.player_id)
            ORDER BY s.darts_thrown ASC LIMIT top_n
        ) AS atc
        UNION ALL
        -- Tic Tac Toe
        SELECT * FROM (
            SELECT 9 AS match_type_id, player_id, leg_id, darts_thrown, score FROM statistics_tic_tac_toe s
                JOIN leg l ON s.leg_id = l.id
            WHERE numbers_closed >= 3 AND s.player_id = l.winner_id
            ORDER BY numbers_closed ASC, score DESC LIMIT top_n
        ) AS tictactoe
        UNION ALL
        -- Bermuda Triangle
        SELECT * FROM (
            SELECT 10 AS match_type_id, player_id, leg_id, darts_thrown, score FROM statistics_bermuda_triangle s
            WHERE (player_id, score) IN (SELECT player_id, MAX(score) FROM statistics_bermuda_triangle GROUP BY player_id)
            ORDER BY score DESC LIMIT top_n
        ) AS bermuda
        UNION ALL
        -- 420 (lower is better)
        SELECT * FROM (
            SELECT 11 AS match_type_id, player_id, leg_id, 63, score FROM statistics_420 s
            WHERE (player_id, score) IN (SELECT player_id, MIN(score) FROM statistics_420 GROUP BY player_id)
            ORDER BY score ASC LIMIT top_n
        ) AS fourtwenty
        UNION ALL
        -- Kill Bull
        SELECT * FROM (
            SELECT 12 AS match_type_id, player_id, leg_id, darts_thrown, l.starting_score FROM statistics_kill_bull s
                JOIN leg l ON l.id = s.leg_id
            WHERE score = 0 AND (player_id, darts_thrown) IN (SELECT player_id, MIN(darts_thrown) FROM statistics_kill_bull GROUP BY player_id)
            ORDER BY starting_score DESC, darts_thrown LIMIT top_n
        ) AS kill_bull
        UNION ALL
        -- JDC Practice
        SELECT * FROM (
            SELECT 14 AS match_type_id, player_id, leg_id, darts_thrown, score FROM statistics_jdc_practice s
            WHERE (player_id, score) IN (SELECT player_id, MAX(score) FROM statistics_jdc_practice GROUP BY player_id)
            ORDER BY score DESC LIMIT top_n
        ) AS jdc
        UNION ALL
        -- Scam
        SELECT * FROM (
            SELECT 16 AS match_type_id, player_id, leg_id, darts_thrown_stopper, score FROM statistics_scam s
            WHERE (player_id, darts_thrown_stopper) IN (SELECT player_id, MIN(darts_thrown_stopper) FROM statistics_scam GROUP BY player_id)
            ORDER BY darts_thrown_stopper ASC LIMIT top_n
        ) AS scam
        UNION ALL
        -- 170
        SELECT * FROM (
            SELECT 17 AS match_type_id, player_id, leg_id, darts_thrown, highest_checkout FROM statistics_170 s
            WHERE (player_id, highest_checkout) IN (SELECT player_id, MAX(highest_checkout) FROM statistics_170 GROUP BY player_id)
            ORDER BY highest_checkout DESC LIMIT top_n
        ) AS oneseventy
    ) AS leaderboard;
END;
-- +goose StatementEnd
ALTER TABLE match_default DROP COLUMN leaderboard_matchtypes_min_players;
