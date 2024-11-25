-- +goose Up
-- Insert placeholder players
INSERT INTO player (first_name, last_name, active, office_id, is_placeholder)
SELECT first_name, last_name, active, office_id, is_placeholder
FROM (
    SELECT '' AS first_name, '' AS last_name, 0 AS active, MIN(id) AS office_id, 1 AS is_placeholder FROM office UNION ALL
    SELECT '', '', 0, MIN(id), 1 FROM office UNION ALL
    SELECT 'Bye', '', 0, MIN(id), 1 FROM office
) AS new_players
WHERE (SELECT COUNT(*) FROM player WHERE is_placeholder = 1) < 3;

-- Insert default elos for all placeholder players
INSERT IGNORE INTO player_elo (player_id, current_elo, current_elo_matches, tournament_elo, tournament_elo_matches)
SELECT p.id, 1500, 0, 1500, 0 FROM player p WHERE p.is_placeholder = 1;

-- +goose Down
-- Don't rollback any added players, since we don´t want to risk removing lots of matches form users databases