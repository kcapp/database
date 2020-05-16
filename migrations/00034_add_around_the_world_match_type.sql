-- +goose Up
INSERT INTO `match_type`(`id`,`name`,`description`) VALUES (6, 'Around The World', 'Around the World');
INSERT INTO `match_type`(`id`,`name`,`description`) VALUES (7, 'Shanghai', 'Shanghai');
INSERT INTO `match_type`(`id`,`name`,`description`) VALUES (8, 'Around The Clock', 'Around the Clock');

CREATE TABLE `statistics_around_the` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `leg_id` int(10) unsigned NOT NULL,
  `player_id` int(10) unsigned NOT NULL,
  `darts_thrown` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `shanghai` int(11) NULL,
  `mpr` double NULL,
  `longest_streak` int NULL,
  `total_hit_rate` double DEFAULT 0 NOT NULL,
  `hit_rate_1` double DEFAULT 0 NOT NULL,
  `hit_rate_2` double DEFAULT 0 NOT NULL,
  `hit_rate_3` double DEFAULT 0 NOT NULL,
  `hit_rate_4` double DEFAULT 0 NOT NULL,
  `hit_rate_5` double DEFAULT 0 NOT NULL,
  `hit_rate_6` double DEFAULT 0 NOT NULL,
  `hit_rate_7` double DEFAULT 0 NOT NULL,
  `hit_rate_8` double DEFAULT 0 NOT NULL,
  `hit_rate_9` double DEFAULT 0 NOT NULL,
  `hit_rate_10` double DEFAULT 0 NOT NULL,
  `hit_rate_11` double DEFAULT 0 NOT NULL,
  `hit_rate_12` double DEFAULT 0 NOT NULL,
  `hit_rate_13` double DEFAULT 0 NOT NULL,
  `hit_rate_14` double DEFAULT 0 NOT NULL,
  `hit_rate_15` double DEFAULT 0 NOT NULL,
  `hit_rate_16` double DEFAULT 0 NOT NULL,
  `hit_rate_17` double DEFAULT 0 NOT NULL,
  `hit_rate_18` double DEFAULT 0 NOT NULL,
  `hit_rate_19` double DEFAULT 0 NOT NULL,
  `hit_rate_20` double DEFAULT 0 NOT NULL,
  `hit_rate_bull` double DEFAULT 0 NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_statistics_around_the_leg_id` (`leg_id`),
  KEY `FK_statistics_around_the_player_id` (`player_id`),
  CONSTRAINT `FK_statistics_around_the_leg_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`),
  CONSTRAINT `FK_statistics_around_the_player_id` FOREIGN KEY (`player_id`) REFERENCES `player` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- +goose Down
DELETE FROM `match_type` WHERE id in (6, 7, 8);
DROP TABLE `statistics_around_the`;
