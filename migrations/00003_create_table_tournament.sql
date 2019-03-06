-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE TABLE `tournament` (
  `id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `short_name` varchar(5) NOT NULL,
  `is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `is_playoffs` int(11) NOT NULL DEFAULT '0',
  `playoffs_tournament_id` int(11) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP TABLE `tournament`;