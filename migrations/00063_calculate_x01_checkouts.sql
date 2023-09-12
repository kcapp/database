-- +goose Up
UPDATE statistics_x01 x
    LEFT JOIN score s on x.leg_id = s.leg_id
    LEFT JOIN leg l on l.id = x.leg_id
SET x.checkout = (
    SELECT IFNULL(s.first_dart * s.first_dart_multiplier, 0) +
            IFNULL(s.second_dart * s.second_dart_multiplier, 0) +
            IFNULL(s.third_dart * s.third_dart_multiplier, 0) AS 'checkout'
    FROM score s
    WHERE id IN (SELECT MAX(s.ID) as 'max'
                FROM score s
                        LEFT JOIN leg l on s.leg_id = l.id
                        LEFT JOIN matches m on l.match_id = m.id
                WHERE COALESCE(l.leg_type_id, m.match_type_id) IN (1, 3) -- X01
                GROUP BY leg_id)
    AND leg_id = x.leg_id)
WHERE x.checkout IS NULL AND x.player_id = l.winner_id;

-- +goose Down
UPDATE statistics_x01 SET checkout = NULL;