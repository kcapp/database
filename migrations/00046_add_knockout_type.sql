-- +goose Up
INSERT INTO `match_type`(`id`,`name`,`description`) VALUES (15, 'Knockout', 'Knockout');

ALTER TABLE leg_parameters ADD starting_lives INT NULL;

CREATE TABLE `statistics_knockout` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `leg_id` int(10) unsigned NOT NULL,
  `player_id` int(10) unsigned NOT NULL,
  `darts_thrown` int(11) DEFAULT NULL,
  `avg_score` double DEFAULT 0 NOT NULL,
  `lives_lost` int(11) DEFAULT 0 NOT NULL,
  `lives_taken` int(11) DEFAULT 0 NOT NULL,
  `final_position` int(11) DEFAULT 0 NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_statistics_knockout_leg_id` (`leg_id`),
  KEY `fk_statistics_knockout_player_id` (`player_id`),
  CONSTRAINT `fk_statistics_knockout_leg_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`),
  CONSTRAINT `fk_statistics_knockout_player_id` FOREIGN KEY (`player_id`) REFERENCES `player` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- +goose Down
DELETE FROM `match_type` WHERE id = 15;
DROP TABLE `statistics_knockout`;

ALTER TABLE leg_parameters DROP COLUMN starting_lives;
