-- +goose Up
INSERT INTO badge (id, name, description, secret, hidden, levels, filename) VALUES
(48, "Kingslayer", "Defeat the current king by winning a Challenge match with a higher average", 0, 0, null, "kingslayer.svg");

ALTER TABLE match_mode ADD is_challenge TINYINT DEFAULT 0 NOT NULL AFTER is_draw_possible;

INSERT INTO match_mode (wins_required, legs_required, tiebreak_match_type_id, is_draw_possible, is_challenge, name, short_name) VALUES
(3, null, null, 0, 1, 'Kingslayer Challenge', 'KNGSLR-BO5');

-- +goose Down
DELETE FROM badge WHERE id = 48;
DELETE FROM match_mode WHERE is_challenge = 1;
ALTER TABLE match_mode DROP COLUMN is_challenge;

