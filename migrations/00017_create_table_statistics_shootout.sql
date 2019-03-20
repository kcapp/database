-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE TABLE `statistics_shootout` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `leg_id` int(10) unsigned NOT NULL,
  `player_id` int(10) unsigned NOT NULL,
  `ppd` double NOT NULL,
  `60s_plus` int(11) DEFAULT NULL,
  `100s_plus` int(11) DEFAULT NULL,
  `140s_plus` int(11) DEFAULT NULL,
  `180s` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKstatistics_shootout2match_id` (`leg_id`),
  KEY `FK_statistics_shootout2player_id` (`player_id`),
  CONSTRAINT `FK_statistics_shootout2match_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`),
  CONSTRAINT `FK_statistics_shootout2player_id` FOREIGN KEY (`player_id`) REFERENCES `player` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP TABLE `statistics_shootout`;