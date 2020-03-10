-- +goose Up
INSERT INTO `match_type`(`id`,`name`,`description`) VALUES (4, 'Cricket', 'Normal Cricket');
ALTER TABLE `score` ADD COLUMN `current_score` INT(11) NULL AFTER `is_bust`;

CREATE TABLE `statistics_cricket` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `leg_id` int(10) unsigned NOT NULL,
  `player_id` int(10) unsigned NOT NULL,
  `total_marks` int(11) NOT NULL,
  `rounds` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `first_nine_marks` int(11) NOT NULL,
  `mpr` double NOT NULL,
  `first_nine_mpr` double NOT NULL,
  `marks5` int(11) NOT NULL DEFAULT '0',
  `marks6` int(11) NOT NULL DEFAULT '0',
  `marks7` int(11) NOT NULL DEFAULT '0',
  `marks8` int(11) NOT NULL DEFAULT '0',
  `marks9` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `statistics_cricket_match_id_foreign` (`leg_id`),
  KEY `statistics_cricket_player_id_foreign` (`player_id`),
  CONSTRAINT `statistics_cricket_match_id_foreign` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`),
  CONSTRAINT `statistics_cricket_player_id_foreign` FOREIGN KEY (`player_id`) REFERENCES `player` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- +goose Down
DELETE FROM `match_type` WHERE id = 4;
ALTER TABLE `score` DROP COLUMN `current_score`;
DROP TABLE `statistics_cricket`;
