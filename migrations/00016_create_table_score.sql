-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE TABLE `score` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `leg_id` int(10) unsigned NOT NULL,
  `player_id` int(10) unsigned NOT NULL,
  `first_dart` int(11) DEFAULT NULL,
  `second_dart` int(11) DEFAULT NULL,
  `third_dart` int(11) DEFAULT NULL,
  `first_dart_multiplier` int(11) NOT NULL DEFAULT '1',
  `second_dart_multiplier` int(11) NOT NULL DEFAULT '1',
  `third_dart_multiplier` int(11) NOT NULL DEFAULT '1',
  `is_bust` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `score_match_id_foreign` (`leg_id`),
  KEY `score_player_id_foreign` (`player_id`),
  CONSTRAINT `FK_score2match_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`) ON DELETE CASCADE,
  CONSTRAINT `score_player_id_foreign` FOREIGN KEY (`player_id`) REFERENCES `player` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=111461 DEFAULT CHARSET=utf8;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP TABLE `score`;