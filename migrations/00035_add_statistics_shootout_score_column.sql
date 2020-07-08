-- +goose Up
ALTER TABLE `statistics_shootout` ADD COLUMN `score` INT(10) UNSIGNED NOT NULL AFTER `player_id`;

-- +goose Down
ALTER TABLE `statistics_shootout` DROP COLUMN `score`;