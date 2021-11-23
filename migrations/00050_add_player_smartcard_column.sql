-- +goose Up
ALTER TABLE `player` ADD COLUMN `smartcard_uid` VARCHAR(24) NULL AFTER `profile_pic_url`;

-- +goose Down
ALTER TABLE `player` DROP COLUMN `smartcard_uid`;
