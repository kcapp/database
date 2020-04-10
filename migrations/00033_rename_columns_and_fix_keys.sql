-- +goose Up
ALTER TABLE `venue` CHANGE `id` `id` INT(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `venue_configuration` CHANGE `has_leg_lights` `has_led_lights` TINYINT(4) DEFAULT '0' NOT NULL;

-- +goose Down
ALTER TABLE `venue_configuration` CHANGE `has_led_lights` `has_leg_lights` TINYINT(4) DEFAULT '0' NOT NULL;
ALTER TABLE `venue` CHANGE `id` `id` INT(11) NOT NULL;
