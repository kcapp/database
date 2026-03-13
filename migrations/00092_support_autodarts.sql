-- +goose Up
ALTER TABLE `venue_configuration` ADD COLUMN `has_autodarts` TINYINT DEFAULT '0' NOT NULL AFTER `smartboard_button_number`;
ALTER TABLE `venue_configuration` ADD COLUMN `autodarts_url` TEXT NULL AFTER `has_autodarts`;

-- +goose Down
ALTER TABLE `venue_configuration` DROP COLUMN `has_autodarts`;
ALTER TABLE `venue_configuration` DROP COLUMN `autodarts_url`;

