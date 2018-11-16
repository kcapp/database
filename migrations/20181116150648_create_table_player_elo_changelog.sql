-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE TABLE `player_elo_changelog` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `match_id` int(10) unsigned NOT NULL,
  `player_id` int(10) unsigned NOT NULL,
  `old_elo` int(11) NOT NULL,
  `new_elo` int(11) NOT NULL,
  `old_tournament_elo` int(11) DEFAULT NULL,
  `new_tournament_elo` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_elo_changlog_player_id_match_id` (`match_id`,`player_id`),
  KEY `FK_player_elo_changelog2player` (`player_id`),
  CONSTRAINT `FK_player_elo_changelog2match_id` FOREIGN KEY (`match_id`) REFERENCES `matches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_player_elo_changelog2player` FOREIGN KEY (`player_id`) REFERENCES `player` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6936 DEFAULT CHARSET=utf8;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP TABLE `player_elo_changelog`;