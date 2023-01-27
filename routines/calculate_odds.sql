
DELIMITER //

CREATE PROCEDURE calculate_odds()
BEGIN
	select
        concat(p.first_name, ' ', p.last_name) as 'player',
        `60+`,
        `100+`,
        `140+`,
        three_dart_avg,
        checkout_percentage,
        legs
    from (
        select
                p.id as 'player',
                sum(s.`60s_plus`) as '60+',
                sum(s.`100s_plus`) as '100+',
                sum(s.`140s_plus`) as '140+',
                sum(s.ppd_score) / sum(s.darts_thrown) * 3 as 'three_dart_avg',
                count(s.checkout_percentage) / sum(s.checkout_attempts) * 100 AS 'checkout_percentage',
                count(distinct l.id) as 'legs'
        from statistics_x01 s
                left join leg l on s.leg_id = l.id
                left join matches m on l.match_id = m.id
                left join tournament t on t.id = m.tournament_id
                left join player p on s.player_id = p.id
            where m.tournament_id is not null
        group by p.id
        order by p.id
    ) s
    left join player p on s.player = p.id
    where s.player in (select player_id from player2tournament where tournament_id = 38)
    order by p.first_name;
END //

DELIMITER ;