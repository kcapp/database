create
    definer = developer@`10.12.%` procedure set_walkover(IN mid int, IN winner_id int, IN looser_id int, IN num_legs int)
BEGIN
    DECLARE idx INT;

    -- Update status of match
    UPDATE matches SET is_walkover = 1, is_finished = 1, winner_id = winner_id WHERE id = mid;

    -- Delete all existing staistics/legs
    DELETE FROM statistics_x01 WHERE leg_id IN (SELECT id FROM leg WHERE match_id = MID);
    DELETE FROM score WHERE leg_id IN (SELECT id FROM leg WHERE match_id = MID);
    DELETE FROM leg WHERE match_id = MID;

    -- Insert new legs
    SET idx = 1;
    legs_loop:  LOOP
        IF  idx > num_legs THEN
            LEAVE  legs_loop;
        END  IF;
        SET  idx = idx + 1;

        INSERT INTO leg (end_time,starting_score,is_finished,current_player_id,winner_id,created_at,updated_at,board_stream_url,match_id,has_scores) VALUES (NOW(), 301, 1, winner_id, winner_id, NOW(), NOW(), NULL, mid, 0);
        SET @leg_id = LAST_INSERT_ID();

        INSERT INTO player2leg(leg_id, player_id, `order`, match_id) VALUES
            (@leg_id, winner_id, 1, mid),
            (@leg_id, looser_id, 2, mid);

        ITERATE legs_loop;
    END LOOP;
END;