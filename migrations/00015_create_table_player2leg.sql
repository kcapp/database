-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE TABLE `player2leg` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `leg_id` int(10) unsigned NOT NULL,
  `player_id` int(10) unsigned NOT NULL,
  `order` int(11) NOT NULL,
  `match_id` int(10) unsigned NOT NULL DEFAULT '0',
  `handicap` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `player2match_match_id_foreign` (`leg_id`),
  KEY `player2match_player_id_foreign` (`player_id`),
  KEY `player2match_game_id_foreign` (`match_id`),
  CONSTRAINT `FK_player2match2match_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`) ON DELETE CASCADE,
  CONSTRAINT `player2match_game_id_foreign` FOREIGN KEY (`match_id`) REFERENCES `matches` (`id`),
  CONSTRAINT `player2match_player_id_foreign` FOREIGN KEY (`player_id`) REFERENCES `player` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16973 DEFAULT CHARSET=utf8;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP TABLE `player2leg`;