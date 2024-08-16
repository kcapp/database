-- +goose Up
ALTER TABLE `venue_configuration` ADD COLUMN `tts_voice` TEXT NULL AFTER `has_wled_lights`;

-- +goose Down
ALTER TABLE `venue_configuration` DROP COLUMN `tts_voice`;
