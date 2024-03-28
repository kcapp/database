-- +goose Up
INSERT INTO badge (id, name, description, secret, hidden, levels, filename) VALUES
(47, "Zebra", "Win a leg scoring alternate black/white numbers", 0, 0, null, "zebra.svg");

-- +goose Down
DELETE FROM badge WHERE id IN (47);