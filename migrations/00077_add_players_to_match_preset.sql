-- +goose Up
ALTER TABLE `match_preset` ADD `players` TEXT NULL AFTER `starting_score`;

-- +goose Down
ALTER TABLE `match_preset` DROP COLUMN `players`;
