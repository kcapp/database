-- +goose Up
ALTER TABLE `office` ADD COLUMN `is_global` TINYINT(1) DEFAULT '0' NOT NULL AFTER `name`;

-- +goose Down
ALTER TABLE `office` DROP COLUMN `is_global`;