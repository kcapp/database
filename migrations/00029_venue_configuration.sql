-- +goose Up
CREATE TABLE `venue_configuration` (
    `venue_id` INT NOT NULL,
    `has_dual_monitor` TINYINT NOT NULL DEFAULT '0',
    `has_leg_lights` TINYINT NOT NULL DEFAULT '0',
    `has_smartboard` TINYINT NOT NULL DEFAULT '0',
    `smartboard_uuid` VARCHAR (16),
    `smartboard_button_number` INT,
    PRIMARY KEY (`venue_id`)
);

-- +goose Down
DROP TABLE `venue_configuration`;
