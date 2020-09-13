-- +goose Up
INSERT INTO `match_type`(`id`,`name`,`description`) VALUES (11, '420', 'Fourtwenty');

CREATE TABLE `statistics_420` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `leg_id` int(10) unsigned NOT NULL,
  `player_id` int(10) unsigned NOT NULL,
  `score` int(11),
  `total_hit_rate` double,
  `hit_rate_1` double,
  `hit_rate_2` double,
  `hit_rate_3` double,
  `hit_rate_4` double,
  `hit_rate_5` double,
  `hit_rate_6` double,
  `hit_rate_7` double,
  `hit_rate_8` double,
  `hit_rate_9` double,
  `hit_rate_10` double,
  `hit_rate_11` double,
  `hit_rate_12` double,
  `hit_rate_13` double,
  `hit_rate_14` double,
  `hit_rate_15` double,
  `hit_rate_16` double,
  `hit_rate_17` double,
  `hit_rate_18` double,
  `hit_rate_19` double,
  `hit_rate_20` double,
  PRIMARY KEY (`id`),
  KEY `fk_statistics_420_leg_id` (`leg_id`),
  KEY `fk_statistics_420_player_id` (`player_id`),
  CONSTRAINT `fk_statistics_420_leg_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`),
  CONSTRAINT `fk_statistics_420_player_id` FOREIGN KEY (`player_id`) REFERENCES `player` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- +goose Down
DELETE FROM `match_type` WHERE id = 11;
DROP TABLE `statistics_420`;
