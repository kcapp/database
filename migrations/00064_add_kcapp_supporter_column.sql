-- +goose Up
ALTER TABLE player ADD is_supporter INT DEFAULT 0 NOT NULL AFTER is_placeholder;

-- +goose Down
ALTER TABLE player DROP COLUMN is_supporter;