-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE TABLE `match_mode` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `wins_required` int(10) unsigned NOT NULL,
  `legs_required` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `short_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `match_mode`(`id`,`wins_required`,`legs_required`,`name`,`short_name`) VALUES
(1, 1, 1, 'No sets', 'BO1'),
(2, 2, NULL, 'First to win 2', 'BO3'),
(3, 3, NULL, 'First to win 3', 'BO5'),
(4, 2, 2, 'Best of 2', 'BO2'),
(5, 3, 4, 'Best of 4', 'BO4'),
(6, 4, NULL, 'First to win 4', 'BO7');

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP TABLE `match_mode`;