-- +goose Up
ALTER TABLE `tournament_preset` ADD `match_mode_id` INT UNSIGNED DEFAULT 2 NOT NULL AFTER `starting_score`;
ALTER TABLE `tournament_preset` ADD CONSTRAINT `FK_tournament_preset2match_mode_id` FOREIGN KEY (`match_mode_id`) REFERENCES `match_mode` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- +goose Down
ALTER TABLE `tournament_preset` DROP FOREIGN KEY `FK_tournament_preset2match_mode_id`;
ALTER TABLE `tournament_preset` DROP COLUMN `match_mode_id`;