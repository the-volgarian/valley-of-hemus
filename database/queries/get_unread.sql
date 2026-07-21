SELECT *
FROM game_log
WHERE player_id = :playerId
  AND read = 0;