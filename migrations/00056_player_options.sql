-- +goose Up
CREATE TABLE `player_option` (
  `player_id` int(10) unsigned NOT NULL,
  `subtract_per_dart` TINYINT(1) NOT NULL DEFAULT 1,
  `show_checkout_guide` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`player_id`),
  CONSTRAINT `FK_player_option2player` FOREIGN KEY (`player_id`) REFERENCES `player` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- +goose Down
DROP TABLE `player_option`;