UPDATE game_log
SET read = 1
WHERE player_id = :playerId
  AND read = 0;