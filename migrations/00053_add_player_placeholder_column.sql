-- +goose Up
ALTER TABLE `player` ADD COLUMN `is_placeholder` tinyint(1) NOT NULL DEFAULT'0' AFTER `is_bot`;

-- +goose Down
ALTER TABLE `player` DROP COLUMN `is_placeholder`;
