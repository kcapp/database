-- +goose Up
INSERT INTO player (first_name, last_name, vocal_name, nickname, slack_handle, color, profile_pic_url, smartcard_uid, board_stream_url, board_stream_css, active, office_id, is_bot, is_placeholder, created_at)
SELECT 'kcapp-bot', '', 'kcappbot.wav', null, null, '#1c2efb', null, null, null, null, 1, 1, 1, 0, NOW()
FROM player
WHERE NOT EXISTS (SELECT 1 FROM player WHERE first_name = 'kcapp-bot');

-- +goose Down
-- Don't rollback this, since we don't want to risk removing lots of bot legs from users databases