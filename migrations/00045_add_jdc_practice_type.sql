-- +goose Up
INSERT INTO `match_type`(`id`,`name`,`description`) VALUES (14, 'JDC Practice', 'JDC Practice Routine');

CREATE TABLE `statistics_jdc_practice` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `leg_id` int(10) unsigned NOT NULL,
  `player_id` int(10) unsigned NOT NULL,
  `darts_thrown` int(11) DEFAULT NULL,
  `score` int(11) NOT NULL DEFAULT '0',
  `mpr` double NULL,
  `shanghai_count` int(11) DEFAULT 0 NOT NULL,
  `doubles_hitrate` double DEFAULT 0 NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_statistics_jdc_practice_leg_id` (`leg_id`),
  KEY `fk_statistics_jdc_practice_player_id` (`player_id`),
  CONSTRAINT `fk_statistics_jdc_practice_leg_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`),
  CONSTRAINT `fk_statistics_jdc_practice_player_id` FOREIGN KEY (`player_id`) REFERENCES `player` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- +goose Down
DELETE FROM `match_type` WHERE id = 14;
DROP TABLE `statistics_jdc_practice`;
