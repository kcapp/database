-- +goose Up
alter table match_mode add is_draw_possible tinyint default 0 not null after tiebreak_match_type_id;
update match_mode set is_draw_possible = 1 where id in(4, 5);

-- +goose Down
alter table match_mode drop column is_draw_possible;