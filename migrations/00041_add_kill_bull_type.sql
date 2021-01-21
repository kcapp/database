-- +goose Up
INSERT INTO `match_type`(`id`,`name`,`description`) VALUES (12, 'Kill Bull', 'Kill Bull');

CREATE TABLE `statistics_kill_bull` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `leg_id` int(10) unsigned NOT NULL,
  `player_id` int(10) unsigned NOT NULL,
  `darts_thrown` int(11) NOT NULL,
  `score` int(11) NOT NULL DEFAULT '0',
  `marks3` int(11) NOT NULL DEFAULT '0',
  `marks4` int(11) NOT NULL DEFAULT '0',
  `marks5` int(11) NOT NULL DEFAULT '0',
  `marks6` int(11) NOT NULL DEFAULT '0',
  `longest_streak` int NOT NULL DEFAULT '0',
  `times_busted` int NOT NULL DEFAULT '0',
  `total_hit_rate` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_statistics_kill_bull_leg_id` (`leg_id`),
  KEY `fk_statistics_kill_bull_player_id` (`player_id`),
  CONSTRAINT `fk_statistics_kill_bull_leg_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`),
  CONSTRAINT `fk_statistics_kill_bull_player_id` FOREIGN KEY (`player_id`) REFERENCES `player` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- +goose Down
DELETE FROM `match_type` WHERE id = 12;
DROP TABLE `statistics_kill_bull`;