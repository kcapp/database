-- +goose Up
INSERT INTO `match_type`(`id`,`name`,`description`) VALUES (16, 'Scam', 'Scam');

CREATE TABLE `statistics_scam` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `leg_id` int(10) unsigned NOT NULL,
  `player_id` int(10) unsigned NOT NULL,
  `darts_thrown_stopper` int(11) NOT NULL,
  `darts_thrown_scorer` int(11) NOT NULL,
  `mpr` double NOT NULL,
  `ppd` double NOT NULL,
  `score` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_statistics_scam_leg_id` (`leg_id`),
  KEY `fk_statistics_scam_player_id` (`player_id`),
  CONSTRAINT `fk_statistics_scam_leg_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`),
  CONSTRAINT `fk_statistics_scam_player_id` FOREIGN KEY (`player_id`) REFERENCES `player` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- +goose Down
DELETE FROM `match_type` WHERE id = 16;
DROP TABLE `statistics_scam`;