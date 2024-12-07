-- +goose Up
CREATE TABLE `match_default` (
  `match_type_id` INT(10) UNSIGNED NOT NULL,
  `match_mode_id` INT(10) UNSIGNED NOT NULL,
  `starting_score` INT(11) NOT NULL,
  `max_rounds` INT(11) NULL,
  `outshot_type_id` int(10) UNSIGNED NOT NULL,
  CONSTRAINT `FK_match_default2match_type_id` FOREIGN KEY (`match_type_id`) REFERENCES `match_type` (`id`),
  CONSTRAINT `FK_match_default2match_mode_id` FOREIGN KEY (`match_mode_id`) REFERENCES `match_mode` (`id`),
  CONSTRAINT `FK_match_default2outshot_type_id` FOREIGN KEY (`outshot_type_id`) REFERENCES `outshot_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO match_default (match_type_id, match_mode_id, starting_score, max_rounds, outshot_type_id) VALUES (1, 1, 501, NULL, 1);

-- +goose Down
DROP TABLE `match_default`;