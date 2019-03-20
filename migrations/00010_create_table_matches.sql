-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE TABLE `matches` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `current_leg_id` int(10) unsigned DEFAULT NULL,
  `match_mode_id` int(10) unsigned NOT NULL,
  `winner_id` int(10) unsigned DEFAULT NULL,
  `is_abandoned` tinyint(1) NOT NULL DEFAULT '0',
  `is_walkover` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `match_type_id` int(10) unsigned NOT NULL,
  `owe_type_id` int(10) unsigned DEFAULT NULL,
  `venue_id` int(11) DEFAULT NULL,
  `tournament_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `game_game_type_id_foreign` (`match_mode_id`),
  KEY `game_winner_id_foreign` (`winner_id`),
  KEY `game_owe_type_id_foreign` (`owe_type_id`),
  KEY `FK_game2game_type_id` (`match_type_id`),
  KEY `FK_matches2tournament_id` (`tournament_id`),
  CONSTRAINT `FK_game2game_mode_id` FOREIGN KEY (`match_mode_id`) REFERENCES `match_mode` (`id`),
  CONSTRAINT `FK_game2game_type_id` FOREIGN KEY (`match_type_id`) REFERENCES `match_type` (`id`),
  CONSTRAINT `FK_game2owe_type_id` FOREIGN KEY (`owe_type_id`) REFERENCES `owe_type` (`id`),
  CONSTRAINT `FK_game2winner_id` FOREIGN KEY (`winner_id`) REFERENCES `player` (`id`),
  CONSTRAINT `FK_matches2tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `tournament` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP TABLE `matches`;