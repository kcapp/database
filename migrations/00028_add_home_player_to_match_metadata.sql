-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE `match_metadata`
	ADD COLUMN `is_winner_outcome_home` TINYINT(1) DEFAULT '0' NOT NULL AFTER `winner_outcome_match_id`,
	ADD COLUMN `is_looser_outcome_home` TINYINT(1) DEFAULT '0' NOT NULL AFTER `looser_outcome_match_id`;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
ALTER TABLE `match_metadata` DROP COLUMN `is_looser_outcome_home`, DROP COLUMN `is_winner_outcome_home`;