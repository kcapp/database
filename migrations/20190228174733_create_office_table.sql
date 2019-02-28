-- +goose Up
CREATE TABLE `office`( `id` INT(11) NOT NULL , `name` VARCHAR(30) NOT NULL , PRIMARY KEY (`id`) );

-- +goose Down
DROP TABLE `office`;