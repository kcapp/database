-- +goose Up
ALTER TABLE leg ADD leg_type_id INT(10) unsigned NULL AFTER winner_id;
ALTER TABLE leg ADD CONSTRAINT FK_leg_type_id FOREIGN KEY (leg_type_id) REFERENCES match_type (id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE match_mode ADD tiebreak_match_type_id INT NULL AFTER legs_required;

INSERT INTO `match_mode`(`id`,`wins_required`,`legs_required`,`tiebreak_match_type_id`,`name`,`short_name`) VALUES
(7, 2, 3, 2, 'Best of 2 (Shootout)', 'BO2-NDS');

-- +goose Down
DELETE FROM `match_mode` WHERE id = 7;

ALTER TABLE match_mode DROP COLUMN tiebreak_match_type_id;
ALTER TABLE leg DROP FOREIGN KEY FK_leg_type_id;
ALTER TABLE leg DROP COLUMN leg_type_id;

