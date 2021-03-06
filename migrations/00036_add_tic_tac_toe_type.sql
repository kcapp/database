-- +goose Up
INSERT INTO `match_type`(`id`,`name`,`description`) VALUES (9, 'Tic Tac Toe', 'Tic Tac Toe');

CREATE TABLE `outshot_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `short_name` varchar(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `outshot_type`(`id`,`name`, `short_name`) VALUES (1, 'Double Out', 'DO'), (2, 'Master Out', 'MO'), (3, 'Any Out', 'AO');

CREATE TABLE `leg_parameters` (
  `leg_id` int(10) unsigned NOT NULL,
  `outshot_type_id` int(10) unsigned NULL,
  `number_1` int(11),
  `number_2` int(11),
  `number_3` int(11),
  `number_4` int(11),
  `number_5` int(11),
  `number_6` int(11),
  `number_7` int(11),
  `number_8` int(11),
  `number_9` int(11),
  PRIMARY KEY (`leg_id`),
  UNIQUE KEY `UNQ_leg_parameters_leg_id` (`leg_id`),
  KEY `fk_leg_parameters_leg_id` (`leg_id`),
  CONSTRAINT `fk_leg_parameters_leg_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`),
  CONSTRAINT `fk_outshot_type_id` FOREIGN KEY (`outshot_type_id`) REFERENCES `outshot_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `statistics_tic_tac_toe` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `leg_id` int(10) unsigned NOT NULL,
  `player_id` int(10) unsigned NOT NULL,
  `darts_thrown` int(11) NOT NULL,
  `score` int(11),
  `total_hit_rate` double,
  `hit_rate_1` double,
  `hit_rate_2` double,
  `hit_rate_3` double,
  `hit_rate_4` double,
  `hit_rate_5` double,
  `hit_rate_6` double,
  `hit_rate_7` double,
  `hit_rate_8` double,
  `hit_rate_9` double,
  `hit_rate_10` double,
  `hit_rate_11` double,
  `hit_rate_12` double,
  `hit_rate_13` double,
  `hit_rate_14` double,
  `hit_rate_15` double,
  `hit_rate_16` double,
  `hit_rate_17` double,
  `hit_rate_18` double,
  `hit_rate_19` double,
  `hit_rate_20` double,
  `hit_rate_bull` double,
  `numbers_closed` int(11),
  `highest_closed` int(11),
  PRIMARY KEY (`id`),
  KEY `fk_statistics_tic_tac_toe_leg_id` (`leg_id`),
  KEY `fk_statistics_tic_tac_toe_player_id` (`player_id`),
  CONSTRAINT `fk_statistics_tic_tac_toe_leg_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`),
  CONSTRAINT `fk_statistics_tic_tac_toe_player_id` FOREIGN KEY (`player_id`) REFERENCES `player` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- +goose Down
DELETE FROM `match_type` WHERE id = 9;
DROP TABLE `statistics_tic_tac_toe`;
DROP TABLE `leg_parameters`;
DROP TABLE `outshot_type`;