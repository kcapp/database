-- +goose Up
create index idx_score_leg_id on score (leg_id);
create index idx_score_player_id on score (player_id);
create index idx_player_is_bot on player (is_bot);
create index idx_matches_is_abandoned on matches (is_abandoned);

-- +goose Down
drop index idx_score_leg_id on score;
drop index idx_score_player_id on score;
drop index idx_player_is_bot on player;
drop index idx_matches_is_abandoned on matches;
