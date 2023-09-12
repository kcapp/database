-- +goose Up
ALTER TABLE leg ADD num_players INT NULL AFTER match_id;
UPDATE leg l JOIN player2leg p2l ON l.id = p2l.leg_id
    SET l.num_players = (SELECT COUNT(DISTINCT player_Id) FROM player2leg p2l WHERE p2l.leg_id = l.id GROUP BY leg_id LIMIT 1)
WHERE l.num_players IS NULL;
ALTER TABLE leg MODIFY num_players INT NOT NULL;

-- +goose Down
ALTER TABLE leg DROP COLUMN num_players;