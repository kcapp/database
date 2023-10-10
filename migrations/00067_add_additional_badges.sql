-- +goose Up
INSERT INTO badge (id, name, description, secret, hidden, levels, filename) VALUES
(27, "Bye for Now", "Become an inactive player", 0, 0, null, "bye_for_now.svg"),
(28, "Old Timer", "Stick around for over 3 years", 0, 0, null, "old_timer.svg"),
(29, "Versatile Player", "Play different match types", 0, 0, 4, "versatile_player-1.svg"),
(30, "Monotonous", "Hit the same visit three or more times in a row (No Miss!)", 0, 0, 4, "monotonous-1.svg"),
(31, "Triple Threat", "Hit a T20, T19 and T18 in a single visit", 0, 0, null, "triple_threat.svg"),
(32, "Baby Ton", "Hit T19, 19, 19", 0, 0, null, "baby_ton.svg"),
(33, "Little Fish", "Checkout 130 (T20, 20, D25)", 0, 0, null, "little_fish.svg"),
(34, "BullBullBull", "Hit three double bullseye", 0, 0, null, "bullbullbull.svg"),
(35, "So Close", "Hit T1, T1, T1", 0, 0, null, "so_close.svg"),
(36, "Shanghai", "Checkout with a Shanghai (Triple, Single, Double)", 0, 0, null, "shanghai.svg"),
(37, "Just a Quickie", "Win a Match with 3 Legs in <3 minutes each", 0, 0, null, "just_a_quickie.svg"),
(38, "Around the World", "Hit all numbers of the dartboard during a match", 0, 0, null, "around_the_world.svg");

-- +goose Down
DELETE FROM badge WHERE id IN (27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38);