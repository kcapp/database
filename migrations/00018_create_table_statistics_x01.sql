-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE TABLE `statistics_x01` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `leg_id` int(10) unsigned NOT NULL,
  `player_id` int(10) unsigned NOT NULL,
  `ppd` double NOT NULL,
  `ppd_score` int(11) NOT NULL,
  `first_nine_ppd` double NOT NULL,
  `first_nine_ppd_score` int(11) NOT NULL,
  `checkout_percentage` double DEFAULT NULL,
  `checkout_attempts` int(11) DEFAULT NULL,
  `darts_thrown` int(11) DEFAULT NULL,
  `60s_plus` int(11) DEFAULT NULL,
  `100s_plus` int(11) DEFAULT NULL,
  `140s_plus` int(11) DEFAULT NULL,
  `180s` int(11) DEFAULT NULL,
  `accuracy_20` double DEFAULT NULL,
  `accuracy_19` double DEFAULT NULL,
  `overall_accuracy` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `statistics_x01_match_id_foreign` (`leg_id`),
  KEY `statistics_x01_player_id_foreign` (`player_id`),
  CONSTRAINT `statistics_x01_match_id_foreign` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`),
  CONSTRAINT `statistics_x01_player_id_foreign` FOREIGN KEY (`player_id`) REFERENCES `player` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP TABLE `statistics_x01`;