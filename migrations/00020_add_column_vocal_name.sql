-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE player ADD vocal_name VARCHAR(255) AFTER name;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
ALTER TABLE player DROP vocal_name;