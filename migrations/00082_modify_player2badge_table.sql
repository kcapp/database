-- +goose Up
ALTER TABLE player2badge ADD data TEXT NULL AFTER darts;

-- Remove the FK on opponent_player_id, since we want to allow 0 as a valid value,
-- as it will be part of the unique constraint.
ALTER TABLE player2badge DROP FOREIGN KEY FK_player2badge_opponent_player_id;
UPDATE player2badge SET opponent_player_id = 0 WHERE opponent_player_id IS NULL;
ALTER TABLE player2badge MODIFY COLUMN opponent_player_id INT UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE player2badge DROP KEY UNQ_player2badge_player_id_badge_id;
ALTER TABLE player2badge ADD CONSTRAINT UNQ_player2badge_player_id_badge_id UNIQUE (player_id, badge_id, opponent_player_id);

-- +goose Down
ALTER TABLE player2badge DROP KEY UNQ_player2badge_player_id_badge_id;
ALTER TABLE player2badge ADD CONSTRAINT UNQ_player2badge_player_id_badge_id UNIQUE (player_id, badge_id);
ALTER TABLE player2badge MODIFY COLUMN opponent_player_id INT UNSIGNED NULL DEFAULT NULL;
UPDATE player2badge SET opponent_player_id = NULL WHERE opponent_player_id = 0;
ALTER TABLE player2badge ADD CONSTRAINT FK_player2badge_opponent_player_id FOREIGN KEY (opponent_player_id) REFERENCES player (id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE player2badge DROP COLUMN data;