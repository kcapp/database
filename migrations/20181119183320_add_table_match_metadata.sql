-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE TABLE match_metadata (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    match_id INT UNSIGNED NOT NULL,
    order_of_play INT NOT NULL,
    tournament_group_id INT NOT NULL,
    match_displayname VARCHAR (100) NOT NULL,
    elimination TINYINT (1) NOT NULL,
    trophy TINYINT (1) NOT NULL,
    promotion TINYINT (1) NOT NULL,
    semi_final TINYINT (1) NOT NULL,
    grand_final TINYINT (1) NOT NULL,
    winner_outcome VARCHAR (200),
    looser_outcome VARCHAR(200),
    PRIMARY KEY (id)
) ;

ALTER TABLE match_metadata ADD CONSTRAINT FK_match_metadata2match_id FOREIGN KEY (match_id) REFERENCES matches (id) ON DELETE CASCADE ON UPDATE CASCADE ; 
ALTER TABLE match_metadata ADD CONSTRAINT FK_match_metadata2tournament_group_id FOREIGN KEY (tournament_group_id) REFERENCES tournament_group (id) ON DELETE CASCADE ON UPDATE CASCADE ; 
ALTER TABLE match_metadata ADD UNIQUE UNQ_match_metadata_match_id (match_id);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP TABLE match_metadata;