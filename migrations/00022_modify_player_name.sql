-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE player ADD last_name VARCHAR(255) AFTER `name`;
ALTER TABLE player CHANGE `name` first_name VARCHAR(255);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
ALTER TABLE player DROP last_name;
ALTER TABLE player CHANGE first_name `name` VARCHAR(255);
