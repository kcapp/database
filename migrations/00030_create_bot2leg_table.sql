-- +goose Up
CREATE TABLE `bot2player2leg` (
  `player2leg_id` INT(10) UNSIGNED NOT NULL,
  `player_id` INT(10) UNSIGNED DEFAULT NULL,
  `skill_level` INT(11) NOT NULL,
  PRIMARY KEY (`player2leg_id`),
  KEY `FK_bot2player2leg2player_id` (`player_id`),
  CONSTRAINT `FK_bot2player2leg2player2leg_id` FOREIGN KEY (`player2leg_id`) REFERENCES `player2leg` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_bot2player2leg2player_id` FOREIGN KEY (`player_id`) REFERENCES `player` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=utf8;

-- +goose Down
DROP TABLE `bot2player2leg`; 
