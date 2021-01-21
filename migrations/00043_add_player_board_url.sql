-- +goose Up
ALTER TABLE `player` ADD COLUMN `board_stream_url` VARCHAR(512) NULL AFTER `profile_pic_url`;
ALTER TABLE `player` ADD COLUMN `board_stream_css` TEXT NULL AFTER `board_stream_url`;

-- +goose Down
ALTER TABLE `player` DROP COLUMN `board_stream_url`;
ALTER TABLE `player` DROP COLUMN `board_stream_css`;