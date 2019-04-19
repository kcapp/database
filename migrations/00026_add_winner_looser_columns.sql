-- +goose Up
-- +goose StatementBegin
ALTER TABLE `match_metadata` ADD COLUMN `winner_outcome_match_id` INT(10) UNSIGNED NULL AFTER `grand_final`, ADD COLUMN `looser_outcome_match_id` INT(10) UNSIGNED NULL AFTER `winner_outcome_match_id`;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
ALTER TABLE `match_metadata` DROP COLUMN `winner_outcome_match_id`, DROP COLUMN `looser_outcome_match_id`;
-- +goose StatementEnd