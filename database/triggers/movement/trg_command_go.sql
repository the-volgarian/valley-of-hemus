DROP TRIGGER IF EXISTS trg_command_queue_go;

CREATE TRIGGER trg_command_queue_go 
AFTER INSERT ON command_queue
WHEN NEW.command = 'go'
 AND NEW.target_type = 'location'
BEGIN
    UPDATE players
    SET map_location = NEW.target_id
    WHERE player_id = NEW.player_id
      AND EXISTS (
          SELECT 1
          FROM locations l
          WHERE l.location_id = NEW.target_id
            AND l.unlocked_int = 1
      );
	  
	  
    INSERT INTO game_log(player_id, message, read, created_at)
    VALUES(NEW.player_id, 'GO trigger executed', 0, CURRENT_TIMESTAMP);
END;

-- command_queue
-- command_id | player_id | command | target_type | target_id

-- трябва да помисля да не може да се телепортира