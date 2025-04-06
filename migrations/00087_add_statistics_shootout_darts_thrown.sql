-- +goose Up
ALTER TABLE statistics_shootout ADD darts_thrown INT NULL AFTER ppd;

-- +goose Down
ALTER TABLE statistics_shootout DROP COLUMN darts_thrown;