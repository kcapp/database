-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE TABLE `player2tournament` (
  `player_id` int(10) unsigned NOT NULL,
  `tournament_id` int(11) NOT NULL,
  `tournament_group_id` int(11) NOT NULL,
  `is_promoted` tinyint(1) NOT NULL DEFAULT '0',
  `is_relegated` tinyint(1) NOT NULL DEFAULT '0',
  `is_winner` tinyint(1) NOT NULL DEFAULT '0',
  `manual_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`player_id`,`tournament_id`,`tournament_group_id`),
  KEY `FK_player2tournament2tournament_group_id` (`tournament_group_id`),
  KEY `FK_player2tournament2tournament_id` (`tournament_id`),
  CONSTRAINT `FK_player2tournament2player_id` FOREIGN KEY (`player_id`) REFERENCES `player` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_player2tournament2tournament_group_id` FOREIGN KEY (`tournament_group_id`) REFERENCES `tournament_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_player2tournament2tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `tournament` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP TABLE `player2tournament`;