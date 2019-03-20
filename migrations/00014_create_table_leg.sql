-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE TABLE `leg` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `end_time` datetime DEFAULT NULL,
  `starting_score` int(11) NOT NULL,
  `is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `current_player_id` int(10) unsigned NOT NULL,
  `winner_id` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `board_stream_url` varchar(256) DEFAULT NULL,
  `match_id` int(10) unsigned NOT NULL DEFAULT '0',
  `has_scores` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `match_current_player_id_foreign` (`current_player_id`),
  KEY `match_winner_id_foreign` (`winner_id`),
  KEY `match_game_id_foreign` (`match_id`),
  CONSTRAINT `match_current_player_id_foreign` FOREIGN KEY (`current_player_id`) REFERENCES `player` (`id`),
  CONSTRAINT `match_game_id_foreign` FOREIGN KEY (`match_id`) REFERENCES `matches` (`id`),
  CONSTRAINT `match_winner_id_foreign` FOREIGN KEY (`winner_id`) REFERENCES `player` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP TABLE `leg`;