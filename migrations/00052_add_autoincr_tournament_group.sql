-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE match_metadata DROP FOREIGN KEY FK_match_metadata2tournament_group_id;
ALTER TABLE player2tournament DROP FOREIGN KEY FK_player2tournament2tournament_group_id;
ALTER TABLE `tournament_group` MODIFY COLUMN `id` INT(11) AUTO_INCREMENT;
ALTER TABLE match_metadata ADD CONSTRAINT FK_match_metadata2tournament_group_id FOREIGN KEY (tournament_group_id) REFERENCES tournament_group (id) ON DELETE CASCADE ON UPDATE CASCADE ;
ALTER TABLE player2tournament ADD CONSTRAINT FK_player2tournament2tournament_group_id FOREIGN KEY (tournament_group_id) REFERENCES tournament_group (id) ON DELETE CASCADE ON UPDATE CASCADE ;

-- +goose Down
ALTER TABLE match_metadata DROP FOREIGN KEY FK_match_metadata2tournament_group_id;
ALTER TABLE player2tournament DROP FOREIGN KEY FK_player2tournament2tournament_group_id;
ALTER TABLE `tournament_group` MODIFY COLUMN `id` INT(11);
ALTER TABLE match_metadata ADD CONSTRAINT FK_match_metadata2tournament_group_id FOREIGN KEY (tournament_group_id) REFERENCES tournament_group (id) ON DELETE CASCADE ON UPDATE CASCADE ;
ALTER TABLE player2tournament ADD CONSTRAINT FK_player2tournament2tournament_group_id FOREIGN KEY (tournament_group_id) REFERENCES tournament_group (id) ON DELETE CASCADE ON UPDATE CASCADE ;