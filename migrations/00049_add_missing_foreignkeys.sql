-- +goose Up
ALTER TABLE `statistics_gotcha` DROP FOREIGN KEY `fk_statistics_gotcha_leg_id`;
ALTER TABLE `statistics_gotcha` ADD CONSTRAINT `FK_statistics_gotcha_leg_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`) ON DELETE CASCADE ON UPDATE CASCADE ;

ALTER TABLE `statistics_jdc_practice` DROP FOREIGN KEY `fk_statistics_jdc_practice_leg_id`;
ALTER TABLE `statistics_jdc_practice` ADD CONSTRAINT `FK_statistics_jdc_practice_leg_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`) ON DELETE CASCADE ON UPDATE CASCADE ;

ALTER TABLE `statistics_knockout` DROP FOREIGN KEY `fk_statistics_knockout_leg_id`;
ALTER TABLE `statistics_knockout` ADD CONSTRAINT `FK_statistics_knockout_leg_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`) ON DELETE CASCADE ON UPDATE CASCADE ;

-- +goose Down
ALTER TABLE `statistics_gotcha` DROP FOREIGN KEY `FK_statistics_gotcha_leg_id`;
ALTER TABLE `statistics_gotcha` ADD CONSTRAINT `fk_statistics_gotcha_leg_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`);

ALTER TABLE `statistics_jdc_practice` DROP FOREIGN KEY `FK_statistics_jdc_practice_leg_id`;
ALTER TABLE `statistics_jdc_practice` ADD CONSTRAINT `fk_statistics_jdc_practice_leg_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`);

ALTER TABLE `statistics_knockout` DROP FOREIGN KEY `FK_statistics_knockout_leg_id`;
ALTER TABLE `statistics_knockout` ADD CONSTRAINT `fk_statistics_knockout_leg_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`);