create
    definer = admin@`%` procedure get_match_result(IN mid int)
BEGIN
    set @home_player_id := (select player_id from player2leg where match_id = mid order by id limit 0,1);
    set @away_player_id := (select player_id from player2leg where match_id = mid order by id limit 1,1);

    set @home_wins := (select count(winner_id) from leg l where match_id = mid and winner_id = @home_player_id);
    set @away_wins := (select count(winner_id) from leg l where match_id = mid and winner_id = @away_player_id);

    set @home_elo := (select new_tournament_elo from player_elo_changelog where match_id = mid and player_id = @home_player_id);
    set @away_elo := (select new_tournament_elo from player_elo_changelog where match_id = mid and player_id = @away_player_id);

    set @home_player := (select concat(first_name, ' ', last_name) from player where id = @home_player_id);
    set @away_player := (select concat(first_name, ' ', last_name) from player where id = @away_player_id);

    set @tournament_id := (select tournament_id from matches where id = mid);
    set @tournament := (select name from tournament where id = @tournament_id);
    set @tournament_group_id := (select tournament_group_id from player2tournament where player_id = @home_player_id and tournament_id = @tournament_id limit 1);
    set @tournament_group := (select name from tournament_group where id = @tournament_group_id);

    set @match_date := (select date(updated_at) from matches where id = mid);
    set @match_mode := (select name from match_mode where id = (select match_mode_id from matches where id = mid));

    CREATE TEMPORARY TABLE IF NOT EXISTS results
    (
       match_id INT,
       match_date DATE,
       match_mode TEXT,
       home_player_id INT,
       home_player TEXT,
       home_wins INT,
       home_elo INT,
       away_player_id INT,
       away_player TEXT,
       away_wins INT,
       away_elo INT,
       tournament TEXT,
       tournament_group TEXT
    );

    insert into results (match_id, match_date, match_mode, home_player_id, home_player, home_wins, home_elo, away_player_id, away_player, away_wins, away_elo, tournament, tournament_group) values
    (mid, @match_date, @match_mode, @home_player_id, @home_player, @home_wins, @home_elo, @away_player_id, @away_player, @away_wins, @away_elo, @tournament, @tournament_group);
END;

