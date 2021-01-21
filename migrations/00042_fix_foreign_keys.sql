-- +goose Up
ALTER TABLE `leg` DROP FOREIGN KEY `match_game_id_foreign`;
ALTER TABLE `leg` ADD CONSTRAINT `FK_leg_match_id` FOREIGN KEY (`match_id`) REFERENCES `matches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE ;

ALTER TABLE `leg_parameters` DROP FOREIGN KEY `fk_leg_parameters_leg_id`;
ALTER TABLE `leg_parameters` ADD CONSTRAINT `FK_leg_parameters_leg_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`) ON DELETE CASCADE ON UPDATE CASCADE ;

ALTER TABLE `player2leg` DROP FOREIGN KEY `player2match_game_id_foreign`;
ALTER TABLE `player2leg` ADD CONSTRAINT `FK_player2leg_match_id` FOREIGN KEY (`match_id`) REFERENCES `matches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE ;

ALTER TABLE `score` DROP FOREIGN KEY `FK_score2match_id`;
ALTER TABLE `score` ADD CONSTRAINT `FK_score_leg_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`) ON DELETE CASCADE ON UPDATE CASCADE ;

ALTER TABLE `player2leg` DROP FOREIGN KEY `FK_player2match2match_id`;
ALTER TABLE `player2leg` ADD CONSTRAINT `FK_player2leg_leg_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`) ON DELETE CASCADE ON UPDATE CASCADE ;

ALTER TABLE `statistics_around_the` DROP FOREIGN KEY `FK_statistics_around_the_leg_id`;
ALTER TABLE `statistics_around_the` ADD CONSTRAINT `FK_statistics_around_the_leg_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`) ON DELETE CASCADE ON UPDATE CASCADE ;

ALTER TABLE `statistics_cricket` DROP FOREIGN KEY `statistics_cricket_match_id_foreign`;
ALTER TABLE `statistics_cricket` ADD CONSTRAINT `FK_statistics_cricket_leg_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`) ON DELETE CASCADE ON UPDATE CASCADE ;

ALTER TABLE `statistics_darts_at_x` DROP FOREIGN KEY `statistics_darts_at_x_leg_id_foreign`;
ALTER TABLE `statistics_darts_at_x` ADD CONSTRAINT `FK_statistics_darts_at_x_leg_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`) ON DELETE CASCADE ON UPDATE CASCADE ;

ALTER TABLE `statistics_shootout` DROP FOREIGN KEY `FK_statistics_shootout2match_id`;
ALTER TABLE `statistics_shootout` ADD CONSTRAINT `FK_statistics_shootout_leg_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`) ON DELETE CASCADE ON UPDATE CASCADE ;

ALTER TABLE `statistics_x01` DROP FOREIGN KEY `statistics_x01_match_id_foreign`;
ALTER TABLE `statistics_x01` ADD CONSTRAINT `FK_statistics_x01_leg_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`) ON DELETE CASCADE ON UPDATE CASCADE ;

ALTER TABLE `statistics_420` DROP FOREIGN KEY `fk_statistics_420_leg_id`;
ALTER TABLE `statistics_420` ADD CONSTRAINT `FK_statistics_420_leg_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`) ON DELETE CASCADE ON UPDATE CASCADE ;

ALTER TABLE `statistics_bermuda_triangle` DROP FOREIGN KEY `fk_statistics_bermuda_triangle_leg_id`;
ALTER TABLE `statistics_bermuda_triangle` ADD CONSTRAINT `FK_statistics_bermuda_triangle_leg_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`) ON DELETE CASCADE ON UPDATE CASCADE ;

ALTER TABLE `statistics_tic_tac_toe` DROP FOREIGN KEY `fk_statistics_tic_tac_toe_leg_id`;
ALTER TABLE `statistics_tic_tac_toe` ADD CONSTRAINT `FK_statistics_tic_tac_toe_leg_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`) ON DELETE CASCADE ON UPDATE CASCADE ;

ALTER TABLE `statistics_kill_bull` DROP FOREIGN KEY `fk_statistics_kill_bull_leg_id`;
ALTER TABLE `statistics_kill_bull` ADD CONSTRAINT `FK_statistics_kill_bull_leg_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`) ON DELETE CASCADE ON UPDATE CASCADE ;

-- +goose Down
ALTER TABLE `leg` DROP FOREIGN KEY `FK_leg_match_id`;
ALTER TABLE `leg` ADD CONSTRAINT `match_game_id_foreign` FOREIGN KEY (`match_id`) REFERENCES `matches` (`id`);

ALTER TABLE `leg_parameters` DROP FOREIGN KEY `FK_leg_parameters_leg_id`;
ALTER TABLE `leg_parameters` ADD CONSTRAINT `fk_leg_parameters_leg_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`);

ALTER TABLE `player2leg` DROP FOREIGN KEY `FK_player2leg_match_id`;
ALTER TABLE `player2leg` ADD CONSTRAINT `player2match_game_id_foreign` FOREIGN KEY (`match_id`) REFERENCES `matches` (`id`);

ALTER TABLE `score` DROP FOREIGN KEY `FK_score_leg_id`;
ALTER TABLE `score` ADD CONSTRAINT `FK_score2match_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`);

ALTER TABLE `player2leg` DROP FOREIGN KEY `FK_player2leg_leg_id`;
ALTER TABLE `player2leg` ADD CONSTRAINT `FK_player2match2match_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`);

ALTER TABLE `statistics_around_the` DROP FOREIGN KEY `FK_statistics_around_the_leg_id`;
ALTER TABLE `statistics_around_the` ADD CONSTRAINT `FK_statistics_around_the_leg_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`);

ALTER TABLE `statistics_cricket` DROP FOREIGN KEY `FK_statistics_cricket_leg_id`;
ALTER TABLE `statistics_cricket` ADD CONSTRAINT `statistics_cricket_match_id_foreign` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`);

ALTER TABLE `statistics_darts_at_x` DROP FOREIGN KEY `FK_statistics_darts_at_x_leg_id`;
ALTER TABLE `statistics_darts_at_x` ADD CONSTRAINT `statistics_darts_at_x_leg_id_foreign` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`);

ALTER TABLE `statistics_shootout` DROP FOREIGN KEY `FK_statistics_shootout_leg_id`;
ALTER TABLE `statistics_shootout` ADD CONSTRAINT `FK_statistics_shootout2match_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`);

ALTER TABLE `statistics_x01` DROP FOREIGN KEY `FK_statistics_x01_leg_id`;
ALTER TABLE `statistics_x01` ADD CONSTRAINT `statistics_x01_match_id_foreign` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`);

ALTER TABLE `statistics_420` DROP FOREIGN KEY `FK_statistics_420_leg_id`;
ALTER TABLE `statistics_420` ADD CONSTRAINT `fk_statistics_420_leg_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`);

ALTER TABLE `statistics_bermuda_triangle` DROP FOREIGN KEY `FK_statistics_bermuda_triangle_leg_id`;
ALTER TABLE `statistics_bermuda_triangle` ADD CONSTRAINT `fk_statistics_bermuda_triangle_leg_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`);

ALTER TABLE `statistics_tic_tac_toe` DROP FOREIGN KEY `FK_statistics_tic_tac_toe_leg_id`;
ALTER TABLE `statistics_tic_tac_toe` ADD CONSTRAINT `fk_statistics_tic_tac_toe_leg_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`);

ALTER TABLE `statistics_kill_bull` DROP FOREIGN KEY `FK_statistics_kill_bull_leg_id`;
ALTER TABLE `statistics_kill_bull` ADD CONSTRAINT `fk_statistics_kill_bull_leg_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`);