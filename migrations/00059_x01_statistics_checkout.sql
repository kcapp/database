-- +goose Up
-- +goose StatementBegin
ALTER TABLE statistics_x01 ADD checkout INT NULL AFTER checkout_attempts;

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
ALTER TABLE statistics_x01 DROP COLUMN checkout;
-- +goose StatementEnd