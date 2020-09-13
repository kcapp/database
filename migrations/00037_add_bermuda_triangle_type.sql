-- +goose Up
INSERT INTO `match_type`(`id`,`name`,`description`) VALUES (10, 'Bermuda Triangle', 'Bermuda Triangle');

CREATE TABLE `statistics_bermuda_triangle` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `leg_id` int(10) unsigned NOT NULL,
  `player_id` int(10) unsigned NOT NULL,
  `darts_thrown` int(11) NOT NULL,
  `score` int(11) NOT NULL DEFAULT '0',
  `mpr` double NOT NULL DEFAULT '0',
  `total_marks` int(11) NOT NULL,
  `highest_score_reached` int(11) NOT NULL DEFAULT '0',
  `total_hit_rate` double NOT NULL DEFAULT '0',
  `hit_rate_1` double NOT NULL DEFAULT '0',
  `hit_rate_2` double NOT NULL DEFAULT '0',
  `hit_rate_3` double NOT NULL DEFAULT '0',
  `hit_rate_4` double NOT NULL DEFAULT '0',
  `hit_rate_5` double NOT NULL DEFAULT '0',
  `hit_rate_6` double NOT NULL DEFAULT '0',
  `hit_rate_7` double NOT NULL DEFAULT '0',
  `hit_rate_8` double NOT NULL DEFAULT '0',
  `hit_rate_9` double NOT NULL DEFAULT '0',
  `hit_rate_10` double NOT NULL DEFAULT '0',
  `hit_rate_11` double NOT NULL DEFAULT '0',
  `hit_rate_12` double NOT NULL DEFAULT '0',
  `hit_rate_13` double NOT NULL DEFAULT '0',
  `hit_count` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_statistics_bermuda_triangle_leg_id` (`leg_id`),
  KEY `fk_statistics_bermuda_triangle_player_id` (`player_id`),
  CONSTRAINT `fk_statistics_bermuda_triangle_leg_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`),
  CONSTRAINT `fk_statistics_bermuda_triangle_player_id` FOREIGN KEY (`player_id`) REFERENCES `player` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- +goose Down
DELETE FROM `match_type` WHERE id = 10;
DROP TABLE `statistics_bermuda_triangle`;