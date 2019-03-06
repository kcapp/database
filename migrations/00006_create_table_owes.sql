-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE TABLE `owes` (
  `player_ower_id` int(10) unsigned NOT NULL,
  `player_owee_id` int(10) unsigned NOT NULL,
  `owe_type_id` int(10) unsigned NOT NULL,
  `amount` int(11) NOT NULL,
  UNIQUE KEY `owes_player_ower_id_player_owee_id_owe_type_id_unique` (`player_ower_id`,`player_owee_id`,`owe_type_id`),
  KEY `owes_player_owee_id_foreign` (`player_owee_id`),
  KEY `owes_owe_type_id_foreign` (`owe_type_id`),
  CONSTRAINT `owes_owe_type_id_foreign` FOREIGN KEY (`owe_type_id`) REFERENCES `owe_type` (`id`),
  CONSTRAINT `owes_player_owee_id_foreign` FOREIGN KEY (`player_owee_id`) REFERENCES `player` (`id`),
  CONSTRAINT `owes_player_ower_id_foreign` FOREIGN KEY (`player_ower_id`) REFERENCES `player` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP TABLE `owes`;