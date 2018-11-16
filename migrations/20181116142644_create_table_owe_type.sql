-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE TABLE `owe_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP TABLE `owe_type`;