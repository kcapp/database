-- +goose Up

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

-- +goose Down
DROP PROCEDURE IF EXISTS `get_leaderboard_per_match_type`;