-- +goose Up
INSERT INTO tournament_group(name, is_generated, is_playoffs, division) VALUES
("Group E", 1, 0, 1),
("Group F", 1, 0, 1),
("Group G", 1, 0, 1),
("Group H", 1, 0, 1);

-- +goose Down
DELETE FROM tournament_group WHERE is_generated = 1 AND `name` IN ("Group E","Group F","Group G","Group H");