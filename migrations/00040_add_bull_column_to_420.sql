-- +goose Up
ALTER TABLE statistics_420 ADD hit_rate_bull double AFTER `hit_rate_20`;

-- +goose Down
ALTER TABLE statistics_420 DROP hit_rate_bull;
