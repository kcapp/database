-- +goose Up
ALTER TABLE `matches` ADD COLUMN `is_practice` TINYINT(1) DEFAULT '0' NOT NULL AFTER `is_walkover`; 
ALTER TABLE `player` ADD COLUMN `is_bot` TINYINT(1) DEFAULT '0' NOT NULL AFTER `office_id`;

-- +goose Down
ALTER TABLE `matches` DROP COLUMN `is_practice`;
ALTER TABLE `player` DROP COLUMN `is_bot`;
