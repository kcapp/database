-- +goose Up
ALTER TABLE tournament ADD is_season TINYINT DEFAULT 0 NOT NULL AFTER is_finished;
ALTER TABLE match_metadata ADD looser_outcome_standing INT NULL;

-- +goose Down
ALTER TABLE tournament DROP COLUMN is_season;
ALTER TABLE match_metadata DROP COLUMN looser_outcome_standing;

