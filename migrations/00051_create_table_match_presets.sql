-- +goose Up
CREATE TABLE `match_preset` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `match_type_id` int(10) unsigned NOT NULL,
  `match_mode_id` int(10) unsigned NOT NULL,
  `starting_score` int(11) NULL,
  `smartcard_uid` varchar(24),
  `description` text,
  PRIMARY KEY (`id`),
  KEY `fk_match_preset_match_mode_id` (`match_type_id`),
  KEY `fk_match_preset_match_type_id` (`match_mode_id`),
  CONSTRAINT `fk_match_preset_match_mode_id` FOREIGN KEY (`match_mode_id`) REFERENCES `match_mode` (`id`),
  CONSTRAINT `fk_match_preset_match_type_id` FOREIGN KEY (`match_type_id`) REFERENCES `match_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- +goose Down
DROP TABLE `match_preset`;