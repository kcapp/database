-- +goose Up
-- SQL in this section is executed when the migration is applied.

-- +goose StatementBegin
CREATE PROCEDURE `finalize_match`(IN match_id INT, IN winner_id INT)
BEGIN
	DECLARE is_finished DATETIME;
	declare is_existing_match int;
	declare is_valid_player int;
	
	SELECT end_time INTO is_finished FROM matches WHERE id = match_id;	
	SELECT id INTO is_existing_match FROM matches WHERE id = match_id;
	select id into is_valid_player from player where id = winner_id;
	
	IF is_existing_match IS NULL THEN
		SELECT -1 AS 'status_code';
		SELECT 'Not a valid match id' AS 'status_message';
	ELSE 
		IF is_finished IS NOT NULL THEN
			SELECT -1 AS 'status_code';
			SELECT 'Match already finished' AS 'status_message';
		ELSE
			IF is_valid_player IS NULL THEN
				SELECT -1 AS 'status_code';
				SELECT 'Not a valid played id' AS 'status_message';
			ELSE
				-- Set winner player_id
				UPDATE matches SET end_time = NOW(), winner_player_id = winner_id WHERE id = match_id;
				-- Increment games played from 'player'
				UPDATE player SET games_played = games_played+1 WHERE id IN(SELECT player_id FROM match_players WHERE match_id = match_id);
				-- Set games_won in 'player'
				UPDATE player SET games_won = games_won+1 WHERE id = winner_id;
				-- Increment 'owes'
				UPDATE owes SET amount = amount+1 WHERE player_owee_id = winner_id AND player_ower_id IN (SELECT player_id FROM match_players WHERE match_id = match_id);	
				SELECT 0 AS 'status_code';
			END IF;
		END IF;
	END IF;	
END;
-- +goose StatementEnd

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP PROCEDURE `finalize_match`;