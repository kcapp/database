-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE TABLE `office` (
  `id` INT(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP TABLE `office`;