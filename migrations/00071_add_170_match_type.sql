-- +goose Up
INSERT INTO `match_type`(`id`,`name`,`description`) VALUES (17, '170', '170');

CREATE TABLE `statistics_170` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `leg_id` int(10) unsigned NOT NULL,
  `player_id` int(10) unsigned NOT NULL,
  `points` int(11) DEFAULT 0 NOT NULL,
  `ppd` double NOT NULL,
  `ppd_score` int(11) NOT NULL,
  `rounds` int(11) NOT NULL,
  `checkout_percentage` double DEFAULT NULL,
  `checkout_attempts` int(11) DEFAULT 0 NOT NULL,
  `checkout_completed` int(11) DEFAULT 0 NOT NULL,
  `highest_checkout` int(11) DEFAULT NULL,
  `darts_thrown` int(11) NOT NULL,
  `checkout_9_darts` int(11) DEFAULT 0 NOT NULL,
  `checkout_8_darts` int(11) DEFAULT 0 NOT NULL,
  `checkout_7_darts` int(11) DEFAULT 0 NOT NULL,
  `checkout_6_darts` int(11) DEFAULT 0 NOT NULL,
  `checkout_5_darts` int(11) DEFAULT 0 NOT NULL,
  `checkout_4_darts` int(11) DEFAULT 0 NOT NULL,
  `checkout_3_darts` int(11) DEFAULT 0 NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_statistics_170_leg_id` (`leg_id`),
  KEY `fk_statistics_170_player_id` (`player_id`),
  CONSTRAINT `fk_statistics_170_leg_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`),
  CONSTRAINT `fk_statistics_170_player_id` FOREIGN KEY (`player_id`) REFERENCES `player` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE leg_parameters ADD points_to_win INT NULL;
ALTER TABLE leg_parameters ADD max_rounds INT NULL;

-- +goose Down
ALTER TABLE leg_parameters DROP COLUMN points_to_win;
ALTER TABLE leg_parameters DROP COLUMN max_rounds;
DELETE FROM `match_type` WHERE id = 17;
DROP TABLE `statistics_170`;