-- +goose Up

CREATE TABLE `tournament_preset` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `match_type_id` INT(10) UNSIGNED NOT NULL,
  `starting_score` INT(11) NOT NULL,
  `match_mode_id_last_16` INT(10) UNSIGNED NOT NULL,
  `match_mode_id_quarter_final` INT(10) UNSIGNED NOT NULL,
  `match_mode_id_semi_final` INT(10) UNSIGNED NOT NULL,
  `match_mode_id_grand_final` INT(10) UNSIGNED NOT NULL,
  `group1_tournament_group_id` INT(11) NOT NULL,
  `group2_tournament_group_id` INT(11) NOT NULL,
  `playoffs_tournament_group_id` INT(11) NOT NULL,
  `player_id_walkover` INT(10) UNSIGNED NOT NULL,
  `player_id_placeholder_home` INT(10) UNSIGNED NOT NULL,
  `player_id_placeholder_away` INT(10) UNSIGNED NOT NULL,
  `description` TEXT,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_tournament_preset2match_type_id` FOREIGN KEY (`match_type_id`) REFERENCES `match_type` (`id`),
  CONSTRAINT `FK_tournament_preset2match_mode_id_last_16` FOREIGN KEY (`match_mode_id_last_16`) REFERENCES `match_mode` (`id`),
  CONSTRAINT `FK_tournament_preset2match_mode_id_quarter_final` FOREIGN KEY (`match_mode_id_quarter_final`) REFERENCES `match_mode` (`id`),
  CONSTRAINT `FK_tournament_preset2match_mode_id_semi_final` FOREIGN KEY (`match_mode_id_semi_final`) REFERENCES `match_mode` (`id`),
  CONSTRAINT `FK_tournament_preset2match_mode_id_grand_final` FOREIGN KEY (`match_mode_id_grand_final`) REFERENCES `match_mode` (`id`),
  CONSTRAINT `FK_tournament_preset2player_id_walkover` FOREIGN KEY (`player_id_walkover`) REFERENCES `player` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_tournament_preset2player_id_placeholder_home` FOREIGN KEY (`player_id_placeholder_home`) REFERENCES `player` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_tournament_preset2player_id_placeholder_away` FOREIGN KEY (`player_id_placeholder_away`) REFERENCES `player` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_tournament_preset2playoffs_tournament_group_id` FOREIGN KEY (`playoffs_tournament_group_id`) REFERENCES `tournament_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_tournament_preset2group1_tournament_group_id` FOREIGN KEY (`group1_tournament_group_id`) REFERENCES `tournament_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_tournament_preset2group2_tournament_group_id` FOREIGN KEY (`group2_tournament_group_id`) REFERENCES `tournament_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `matches` ADD COLUMN `is_bye` TINYINT NOT NULL DEFAULT 0 AFTER `is_walkover`;
ALTER TABLE `tournament` ADD COLUMN `preset_id` INT(10) UNSIGNED NULL AFTER `playoffs_tournament_id`;
ALTER TABLE `tournament` ADD COLUMN `manual_admin` TINYINT NOT NULL DEFAULT 0 AFTER `preset_id`;
ALTER TABLE `tournament` ADD CONSTRAINT `FK_tournament2preset_id` FOREIGN KEY (`preset_id`) REFERENCES `tournament_preset` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- +goose Down
ALTER TABLE `tournament` DROP FOREIGN KEY `FK_tournament2preset_id`;
ALTER TABLE `tournament` DROP COLUMN `preset_id`;
DROP TABLE `tournament_preset`;
ALTER TABLE `matches` DROP COLUMN `is_bye`;