-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE TABLE `match_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `description` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `match_type`(`id`,`name`,`description`) VALUES
(1, 'x01', 'Normal x01 Mode'),
(2, '9 Dart Shootout', 'Nine Dart Shootout Mode'),
(3, 'X01 Handicap', 'x01 Mode with Custom Handicaps per player');

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP TABLE `match_type`;