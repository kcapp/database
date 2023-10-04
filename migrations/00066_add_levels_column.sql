-- +goose Up
ALTER TABLE badge ADD levels INT NULL AFTER hidden;
UPDATE badge SET levels = 4 WHERE id IN (1, 2, 3);
ALTER TABLE player2badge ADD visit_id INT(10) unsigned NULL AFTER tournament_id;
ALTER TABLE player2badge ADD CONSTRAINT FK_player2badge_visit_id FOREIGN KEY (visit_id) REFERENCES score (id);

-- +goose Down
ALTER TABLE badge DROP COLUMN levels;
ALTER TABLE player2badge DROP FOREIGN KEY `FK_player2badge_visit_id`;
ALTER TABLE player2badge DROP COLUMN visit_id;