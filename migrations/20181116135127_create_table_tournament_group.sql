-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE TABLE `tournament_group` (
  `id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `division` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP TABLE `tournament_group`;