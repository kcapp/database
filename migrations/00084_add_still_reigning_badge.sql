-- +goose Up
INSERT INTO badge (id, name, description, secret, hidden, levels, filename) VALUES
(49, "Still Reigning", "Survive a Challenge match when you are the king", 0, 0, null, "still_reigning.svg");

-- +goose Down
DELETE FROM badge WHERE id = 49;