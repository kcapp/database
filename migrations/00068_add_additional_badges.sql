-- +goose Up
UPDATE badge SET name = "Shanghai Checkout", filename = "shanghai_checkout.svg" WHERE id = 36;

INSERT INTO badge (id, name, description, secret, hidden, levels, filename) VALUES
(39, "Triple Trouble", "Checkout on 3x same double", 0, 0, null, "triple_trouble.svg"),
(40, "Perfection", "Hit a 9 Dart 501 leg", 0, 0, null, "perfection.svg"),
(41, "Officially Good", "Hit a 180 in a tournament match", 0, 0, null, "officially_good.svg"),
(42, "Champagne Shot", "Checkout a 132 on D25, D25, D16", 0, 0, null, "champagne_shot.svg"),
(43, "Beer Game", "Checkout with opponents score over 200", 0, 0, null, "beer_game.svg"),
(44, "Yin", "Win a leg scoring only on Black numbers", 0, 0, null, "yin.svg"),
(45, "Yang", "Win a leg scoring only on White numbers", 0, 0, null, "yang.svg"),
(46, "Shanghai", "Hit a Shanghai", 0, 0, 5, "shanghai-1.svg");

-- +goose Down
UPDATE badge SET name = "Shanghai", filename = "shanghai.svg" WHERE id = 36;
DELETE FROM badge WHERE id IN (39, 40, 41, 42, 43, 44, 45, 46);