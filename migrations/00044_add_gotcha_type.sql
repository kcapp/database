-- +goose Up
INSERT INTO `match_type`(`id`,`name`,`description`) VALUES (13, 'Gotcha', 'Gotcha');

CREATE TABLE `statistics_gotcha` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `leg_id` int(10) unsigned NOT NULL,
  `player_id` int(10) unsigned NOT NULL,
  `darts_thrown` int(11) DEFAULT NULL,
  `highest_score` int(11) NOT NULL DEFAULT '0',
  `times_reset` int(11),
  `others_reset` int(11),
  `score` int(11),
  PRIMARY KEY (`id`),
  KEY `fk_statistics_gotcha_leg_id` (`leg_id`),
  KEY `fk_statistics_gotcha_player_id` (`player_id`),
  CONSTRAINT `fk_statistics_gotcha_leg_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`),
  CONSTRAINT `fk_statistics_gotcha_player_id` FOREIGN KEY (`player_id`) REFERENCES `player` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- +goose Down
DELETE FROM `match_type` WHERE id = 13;
DROP TABLE `statistics_gotcha`;
