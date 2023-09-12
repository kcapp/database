-- +goose Up
CREATE TABLE `badge` (
    `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(200) NOT NULL,
    `description` TEXT NOT NULL,
    `secret` TINYINT DEFAULT 0 NOT NULL,
    `hidden` TINYINT DEFAULT 0 NOT NULL,
    `filename` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- TODO add match_id and tournament_id (?)
CREATE TABLE `player2badge` (
    `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
    `player_id` int(10) unsigned NOT NULL,
    `badge_id` int(10) unsigned NOT NULL,
    `level` int (10) unsigned NULL,
    `value` int (10) unsigned NULL,
    `leg_id` int(10) unsigned NULL,
    `match_id` int(10) unsigned NULL,
    `opponent_player_id` int(10) unsigned NULL,
    `tournament_id` int NULL,
    `darts` text NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `UNQ_player2badge_player_id_badge_id` (`player_id`,`badge_id`),
    KEY `FK_player2badge_player_id` (`player_id`),
    KEY `FK_player2badge_badge_id` (`badge_id`),
    KEY `FK_player2badge_leg_id` (`leg_id`),
    CONSTRAINT `FK_player2badge_player_id` FOREIGN KEY (`player_id`) REFERENCES `player` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `FK_player2badge_badge_id` FOREIGN KEY (`badge_id`) REFERENCES `badge` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `FK_player2badge_leg_id` FOREIGN KEY (`leg_id`) REFERENCES `leg` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `FK_player2badge_match_id` FOREIGN KEY (`match_id`) REFERENCES `matches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `FK_player2badge_opponent_player_id` FOREIGN KEY (`opponent_player_id`) REFERENCES `player` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `FK_player2badge_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `tournament` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Add all the badges
INSERT INTO badge (id, name, description, secret, hidden, filename) VALUES
(1, "High Score", "Hit 100", 0, 0, "100-1.svg"),
(2, "Higher Score", "Hit 140", 0, 0, "140-1.svg"),
(3, "The Maximum", "Hit 180", 0, 0, "180-1.svg"),
(4, "kcapp Supporter", "Donated to kcapp", 0, 0, "kcapp_supporter.svg"),
(5, "kcapp Developer", "Developed kcapp", 0, 0, "kcapp_developer.svg"),
(6, "Double Double", "Checkout with 2 doubles", 0, 0, "double_double.svg"),
(7, "Triple Double", "Checkout with 3 doubles", 0, 0, "triple_double.svg"),
(8, "Mad House", "D1 Checkout", 0, 0, "mad_house.svg"),
(9, "Merry Christmas", "Played a match on Christmas Day", 0, 0, "merry_christmas.svg"),
(10, "Happy New Year", "Played a match on New Years", 0, 0, "happy_newyear.svg"),
(11, "Big Fish", "170 Checkout", 0, 0, "big_fish.svg"),
(12, "Say My Name", "Has Custom Vocal Name", 0, 0, "say_my_name.svg"),
(13, "Getting Crowded", "Played a match with 5+ players", 0, 0, "getting_crowded.svg"),
(14, "Bullseye", "Checkout on Double Bullseye", 0, 0, "bullseye.svg"),
(15, "Easy as 123", "Checkout with a score of 123", 0, 0, "easy_as_123.svg"),
(16, "Close To Perfect", "Win a 501 Match in <15 darts", 0, 0, "close_to_perfect.svg"),
(17, "It's Official", "Play in a Tournament", 0, 0, "its_official.svg"),
(18, "Tournament #1", "1st Place in Tournament", 0, 0, "tournament_1st.svg"),
(19, "Tournament #2", "2nd Place in Tournament", 0, 0, "tournament_2nd.svg"),
(20, "Tournament #3", "3rd Place in Tournament", 0, 0, "tournament_3rd.svg"),
(21, "Impersonator", "Beat Mock Bot", 0, 0, "impersonator.svg"),
(22, "Bot Beater Easy", "Beat Easy Bot", 0, 0, "bot_beater_easy.svg"),
(23, "Bot Beater Medium", "Beat Medium Bot", 0, 0, "bot_beater_medium.svg"),
(24, "Bot Beater Hard", "Beat Hard Bot", 0, 0, "bot_beater_hard.svg"),
(25, "The Frank", "???", 1, 0, "the_frank.svg"),
(26, "Untouchable", "Win all your matches in a tournament", 0, 0, "untouchable.svg");

-- +goose Down
DROP TABLE `player2badge`;
DROP TABLE `badge`;