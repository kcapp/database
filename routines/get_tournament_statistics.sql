create
    definer = admin@`%` procedure get_tournament_statistics(IN tid int)
BEGIN
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_tournament_statistics
    (
		tournament_id 		INT,
		legs				INT,
		max_legs			INT,
		min_legs			INT,
		60s_plus			INT,
		100s_plus			INT,
		140s_plus			INT,
		180s				INT,
		fish_n_chips		INT,
		checkout_d1			INT,
		bulls				INT,
		double_bulls		INT,
		checkout_percentage	DOUBLE,
		max_darts_thrown	INT,
		min_darts_throw		INT
    );
    DELETE FROM temp_tournament_statistics where tournament_id = tid;

    INSERT INTO temp_tournament_statistics(tournament_id, legs, max_legs, min_legs, 60s_plus, 100s_plus, 140s_plus, 180s, fish_n_chips, checkout_d1, bulls, double_bulls, checkout_percentage, max_darts_thrown, min_darts_throw)
	SELECT
	    tid,
	    SUM(legs) as 'legs',
	    SUM(max_legs) as 'max_legs',
	    SUM(min_legs) as 'min_legs',
	    SUM(60s_plus) AS '60s_plus',
	    SUM(100s_plus) AS '100s_plus',
	    SUM(140s_plus) AS '140s_plus',
	    SUM(180s) AS '180s',
	    SUM(fnc) AS 'fish_n_chips',
	    SUM(checkout_d1) AS 'checkout_d1',
	    SUM(bulls) as 'bulls',
	    SUM(double_bulls) as 'double_bulls',
	    SUM(checkout_percentage) as 'checkout_percentage',
	    SUM(max_darts_thrown) as 'max_darts_thrown',
	    SUM(min_darts_thrown) as 'min_darts_thrown'
	FROM (
	    -- Tournament Statistics
	     SELECT tid        AS 'tid',
	            SUM(60s_plus)        AS '60s_plus',
	            SUM(100s_plus)       AS '100s_plus',
	            SUM(140s_plus)       AS '140s_plus',
	            SUM(180s)            AS '180s',
	            COUNT(distinct l.id) AS 'legs',
	            round(count(distinct l.id) / sum(checkout_attempts) * 100, 2) AS 'checkout_percentage',
	            0 AS 'max_darts_thrown',
	            0 AS 'min_darts_thrown',
	            0 AS 'fnc',
	            0 AS 'checkout_d1',
	            0 AS 'bulls',
	            0 AS 'double_bulls',
	            0 AS 'max_legs',
	            0 AS 'min_legs'
	     FROM statistics_x01 s
	        LEFT JOIN leg l ON l.id = s.leg_id
	        LEFT JOIN matches m ON m.id = l.match_id
	     WHERE m.tournament_id = tid
     UNION ALL
	     -- Min/Max Darts thrown
	     SELECT tid, 0, 0, 0, 0, 0, 0, MAX(darts_thrown), MIN(darts_thrown), 0, 0, 0, 0, 0, 0
	     FROM statistics_x01 s
	        LEFT JOIN leg l ON l.id = s.leg_id
	        LEFT JOIN matches m ON m.id = l.match_id
	     WHERE m.tournament_id = tid AND l.winner_id = s.player_id AND l.leg_type_id = 1
	 UNION ALL
	     -- Tournament Fish-N-Chips
	     SELECT
	         tid, 0, 0, 0, 0, 0, 0, 0, 0, count(s.id) AS 'fnc', 0, 0, 0, 0, 0
	     FROM score s
	              LEFT JOIN leg l ON l.id = s.leg_id
	              LEFT JOIN matches m ON m.id = l.match_id
	     WHERE
	             first_dart IN (1, 20, 5) AND first_dart_multiplier = 1
	       AND second_dart IN (1, 20, 5) AND second_dart_multiplier = 1
	       AND third_dart IN (1, 20, 5) AND third_dart_multiplier = 1
	       AND first_dart + second_dart + third_dart = 26
	       AND m.tournament_id = tid AND l.is_finished = 1
	 UNION ALL
	     -- Tournament D1 Checkouts
	     SELECT
	         tid, 0, 0, 0, 0, 0, 0, 0, 0, 0, count(leg_id) as 'checkout_d1', 0, 0, 0, 0
	     FROM score s
	              JOIN leg l ON l.id = s.leg_id
	              JOIN matches m on l.match_id = m.id
	     WHERE l.winner_id = s.player_id
	       AND s.leg_id IN (SELECT id FROM leg WHERE match_id IN (SELECT id FROM matches WHERE tid = tid))
	       AND s.id IN (SELECT MAX(s.id) FROM score s JOIN leg l ON l.id = s.leg_id JOIN matches m on l.match_id = m.id WHERE m.tournament_id = tid AND l.winner_id = s.player_id GROUP BY leg_id)
	       AND IFNULL(s.first_dart * s.first_dart_multiplier, 0) + IFNULL(s.second_dart * s.second_dart_multiplier, 0) + IFNULL(s.third_dart * s.third_dart_multiplier, 0) = 2
	       AND IFNULL(l.leg_type_id, m.match_type_id) = 1
	       AND l.is_finished = 1
	 UNION ALL
	     -- Tournament Bullseye
	     SELECT
	         tid, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	         SUM(IF(first_dart = 25 AND first_dart_multiplier = 1, 1, 0)+IF(second_dart = 25 AND second_dart_multiplier = 1, 1, 0)+IF(third_dart = 25 AND third_dart_multiplier = 1, 1, 0)) as 'bull',
	         SUM(IF(first_dart = 25 AND first_dart_multiplier = 2, 1, 0)+IF(second_dart = 25 AND second_dart_multiplier = 2, 1, 0)+IF(third_dart = 25 AND third_dart_multiplier = 2, 1, 0)) as 'double_bull',
	         0, 0
	     FROM score s
	              LEFT JOIN leg l ON l.id = s.leg_id
	              LEFT JOIN matches m ON m.id = l.match_id
	     WHERE m.tournament_id = tid AND l.is_finished
	 UNION ALL
	     -- Tournament Legs Max/Min
	     SELECT
	         tid, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
             SUM(IF(legs_required is null, wins_required + (wins_required - 1), legs_required)) AS 'max_legs',
             SUM(wins_required) AS 'min_legs'
	     FROM matches m
	              LEFT JOIN match_mode mm ON m.match_mode_id = mm.id
	              LEFT JOIN tournament t ON t.id = m.tournament_id
	     WHERE m.tournament_id = tid AND m.match_type_id = 1
	     GROUP BY t.id
	) statistics;
END;