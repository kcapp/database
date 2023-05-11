-- +goose Up
-- +goose StatementBegin
INSERT INTO `match_mode`(`id`,`wins_required`,`legs_required`,`is_draw_possible`, `name`,`short_name`) VALUES
(9, 5, NULL, 0, 'First to win 5', 'BO9'),
(10, 6, NULL, 0, 'First to win 6', 'BO11'),
(11, 7, NULL, 0, 'First to win 7', 'BO13'),
(12, 8, NULL, 0, 'First to win 8', 'BO15'),
(13, 4, 6, 1, 'Best of 6', 'BO6');
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DELETE FROM `match_mode` WHERE id IN(9, 10, 11, 12, 13);
-- +goose StatementEnd
