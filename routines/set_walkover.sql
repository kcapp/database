create
    definer = kcapp@"%" procedure set_walkover(IN mid int, IN looser_id int, IN num_legs int)
BEGIN
    DECLARE idx INT;
    DECLARE leg_id INT;

    SET @winner_id := (SELECT player_id FROM player2leg WHERE match_id = mid AND player_id <> looser_id);

    -- Delete all existing statistics/legs
    DELETE FROM statistics_x01 WHERE leg_id IN (SELECT id FROM leg WHERE match_id = mid);
    DELETE FROM score WHERE leg_id IN (SELECT id FROM leg WHERE match_id = mid);
    DELETE FROM leg WHERE match_id = mid;

    -- Insert new legs
    SET idx = 1;
    legs_loop:  LOOP
        IF  idx > num_legs THEN
            LEAVE  legs_loop;
        END  IF;
        SET  idx = idx + 1;

        INSERT INTO leg (end_time,starting_score,is_finished,current_player_id,winner_id,created_at,updated_at,board_stream_url,match_id,num_players,has_scores)
            VALUES (NOW(), 301, 1, @winner_id, @winner_id, NOW(), NOW(), NULL, mid, 2, 0);
        SET leg_id = LAST_INSERT_ID();

        INSERT INTO player2leg(leg_id, player_id, `order`, match_id) VALUES
            (leg_id, @winner_id, 1, mid),
            (leg_id, looser_id, 2, mid);

        ITERATE legs_loop;
    END LOOP;

    -- Update status of match
    UPDATE matches SET is_walkover = 1, is_finished = 1, winner_id = @winner_id, current_leg_id = leg_id WHERE id = mid;

    -- Check match metadata
    SET @winner_outcome = NULL;
    SET @is_winner_home = NULL;
    SET @looser_outcome = NULL;
    SET @is_looser_home = NULL;
    SELECT winner_outcome_match_id, is_winner_outcome_home, looser_outcome_match_id, is_looser_outcome_home
        INTO @winner_outcome, @is_winner_home, @looser_outcome, @is_looser_home FROM match_metadata WHERE match_id = mid;
    IF @looser_outcome IS NOT NULL THEN
        SET @id := (SELECT MIN(id) FROM player2leg WHERE match_id = @looser_outcome);
        IF @is_looser_home = 0 THEN
            SET @id := (SELECT MAX(id) FROM player2leg WHERE match_id = @looser_outcome);
        END IF;
        UPDATE kcapp.player2leg SET player_id = looser_id WHERE id = @id;
        UPDATE leg SET current_player_id = @winner_id WHERE match_id = @looser_outcome;
    END IF;
    IF @winner_outcome IS NOT NULL THEN
        SET @id := (SELECT MIN(id) FROM player2leg WHERE match_id = @winner_outcome);
        IF @is_winner_home = 0 THEN
            SET @id := (SELECT MAX(id) FROM player2leg WHERE match_id = @winner_outcome);
        END IF;
        UPDATE player2leg SET player_id = @winner_id WHERE id = @id;
        UPDATE leg SET current_player_id = @winner_id WHERE match_id = @winner_outcome;
    END IF;
END;