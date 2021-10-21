-- +goose Up
INSERT INTO `match_mode`(`id`,`wins_required`,`legs_required`,`tiebreak_match_type_id`,`name`,`short_name`) VALUES
(8, 3, 5, 2, 'Best of 4 (Shootout)', 'BO4-NDS');

-- +goose Down
DELETE FROM `match_mode` WHERE id = 8;
