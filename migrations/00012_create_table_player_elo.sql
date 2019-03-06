-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE TABLE `player_elo` (
  `player_id` int(10) unsigned NOT NULL,
  `current_elo` int(11) NOT NULL DEFAULT '1500',
  `current_elo_matches` int(11) NOT NULL DEFAULT '0',
  `tournament_elo` int(11) NOT NULL DEFAULT '1500',
  `tournament_elo_matches` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`player_id`),
  CONSTRAINT `FK_player_elo2player` FOREIGN KEY (`player_id`) REFERENCES `player` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP TABLE `player_elo`;