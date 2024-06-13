-- +goose Up
ALTER TABLE `venue_configuration` ADD COLUMN `has_wled_lights` TINYINT DEFAULT '0' NOT NULL AFTER `has_led_lights`;

-- +goose Down
ALTER TABLE `venue_configuration` DROP COLUMN `has_wled_lights`;
