-- +goose Up
ALTER TABLE `tournament_group` ADD `is_generated` TINYINT(1) DEFAULT 0 NOT NULL AFTER `name`;
ALTER TABLE `tournament_group` ADD `is_playoffs` TINYINT(1) DEFAULT 0 NOT NULL AFTER `is_generated`;
INSERT INTO tournament_group(name, is_generated, is_playoffs, division) VALUES
("Group A", 1, 0, 1),
("Group B", 1, 0, 1),
("Group C", 1, 0, 1),
("Group D", 1, 0, 1),
("Playoffs", 1, 1, 1);

-- +goose Down
DELETE FROM tournament_group WHERE is_generated = 1;
ALTER TABLE `tournament_group` DROP COLUMN `is_generated`;
ALTER TABLE `tournament_group` DROP COLUMN `is_playoffs`;
