-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE `tournament` ADD COLUMN `office_id` INT(10) UNSIGNED NOT NULL AFTER `playoffs_tournament_id`;
UPDATE tournament SET office_id = 1;
ALTER TABLE `tournament` ADD CONSTRAINT `FK_tournament2office_id` FOREIGN KEY (`office_id`) REFERENCES `office` (`id`) ON DELETE CASCADE ON UPDATE CASCADE ;

ALTER TABLE `venue` ADD COLUMN `office_id` INT(10) UNSIGNED NOT NULL AFTER `name`;
UPDATE venue SET office_id = 1;
ALTER TABLE `venue` ADD CONSTRAINT `FK_venue2office_id` FOREIGN KEY (`office_id`) REFERENCES `office` (`id`) ON DELETE CASCADE ON UPDATE CASCADE ;

ALTER TABLE `matches` DROP FOREIGN KEY `FK_matches2tournament_id` ;
ALTER TABLE `player2tournament` DROP FOREIGN KEY `FK_player2tournament2tournament_id` ;
ALTER TABLE `tournament_standings` DROP FOREIGN KEY `FK_tournament_standings2tournament_id` ;
ALTER TABLE `tournament` CHANGE `id` `id` INT(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `matches` ADD CONSTRAINT `FK_matches2tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `tournament` (`id`) ON DELETE CASCADE ON UPDATE CASCADE ;
ALTER TABLE `player2tournament` ADD CONSTRAINT `FK_player2tournament2tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `tournament` (`id`) ON DELETE CASCADE ON UPDATE CASCADE ;
ALTER TABLE `tournament_standings` ADD CONSTRAINT `FK_tournament_standings2tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `tournament` (`id`) ON DELETE CASCADE ON UPDATE CASCADE ;

ALTER TABLE `office` ADD COLUMN `is_active` TINYINT DEFAULT '1' NOT NULL AFTER `name`;

ALTER TABLE `matches` ADD COLUMN `office_id` INT(10) UNSIGNED NULL AFTER `is_walkover`;
UPDATE matches SET office_id = 1;
ALTER TABLE `matches` ADD CONSTRAINT `FK_matches2office_id` FOREIGN KEY (`office_id`) REFERENCES `office` (`id`) ON DELETE CASCADE ON UPDATE CASCADE ;


-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
ALTER TABLE `tournament` DROP FOREIGN KEY `FK_tournament2office_id`;
ALTER TABLE `tournament` DROP COLUMN `office_id`;

ALTER TABLE `venue` DROP FOREIGN KEY `FK_venue2office_id`;
ALTER TABLE `venue` DROP COLUMN `office_id`;

ALTER TABLE `office` DROP COLUMN `is_active`;

ALTER TABLE `matches` DROP FOREIGN KEY `FK_matches2office_id`;
ALTER TABLE `matches` DROP COLUMN `office_id`;