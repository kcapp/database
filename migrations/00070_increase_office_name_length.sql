-- +goose Up
ALTER TABLE office MODIFY name VARCHAR(50) NOT NULL;

-- +goose Down
ALTER TABLE office MODIFY name VARCHAR(30) NOT NULL;