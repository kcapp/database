-- +goose Up
ALTER TABLE `player` ADD COLUMN `slack_handle` VARCHAR(100) NULL AFTER `nickname`, ADD COLUMN `office_id` INT(11) NULL AFTER `active`;
ALTER TABLE `player` ADD CONSTRAINT `FK_player2office_id` FOREIGN KEY (`office_id`) REFERENCES `office` (`id`) ON DELETE SET NULL ON UPDATE SET NULL ;

-- +goose Down
ALTER TABLE `player` DROP COLUMN `slack_handle`, DROP COLUMN `office_id`;
ALTER TABLE `player` DROP FOREIGN KEY `FK_player2office_id` ;