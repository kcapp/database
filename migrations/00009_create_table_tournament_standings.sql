-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE TABLE `tournament_standings` (
  `tournament_id` int(11) NOT NULL,
  `player_id` int(10) unsigned NOT NULL,
  `rank` int(11) NOT NULL,
  `elo` int(11) DEFAULT NULL,
  UNIQUE KEY `UNQ_tournament_player_rank` (`tournament_id`,`player_id`,`rank`),
  KEY `FK_tournament_standings2player_id` (`player_id`),
  CONSTRAINT `FK_tournament_standings2player_id` FOREIGN KEY (`player_id`) REFERENCES `player` (`id`),
  CONSTRAINT `FK_tournament_standings2tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `tournament` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP TABLE `tournament_standings`;