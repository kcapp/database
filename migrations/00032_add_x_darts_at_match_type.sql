-- +goose Up
-- SQL in this section is executed when the migration is applied.
INSERT INTO `match_type`(`id`,`name`,`description`) VALUES (5, '99 Darts', '99 Darts throw at X');

CREATE TABLE `statistics_darts_at_x` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `leg_id` int(10) unsigned NOT NULL,
  `player_id` int(10) unsigned NOT NULL,
  `score` int(11) NOT NULL,
  `singles` int(11) NOT NULL,
  `doubles` int(11) NOT NULL,
  `triples` int(11) NOT NULL,
  `hit_rate` double NOT NULL,
  `hits5` int(11) NOT NULL DEFAULT '0',
  `hits6` int(11) NOT NULL DEFAULT '0',
  `hits7` int(11) NOT NULL DEFAULT '0',
  `hits8` int(11) NOT NULL DEFAULT '0',
  `hits9` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `statistics_darts_at_x_leg_id_foreign` (`leg_id`),
  KEY `statistics_darts_at_x_player_id_foreign` (`player_id`),
  CONSTRAINT `statistics_darts_at_x_leg_id_foreign` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`),
  CONSTRAINT `statistics_darts_at_x_player_id_foreign` FOREIGN KEY (`player_id`) REFERENCES `player` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DELETE FROM `match_type` WHERE id = 5;
DROP TABLE `statistics_darts_at_x`;