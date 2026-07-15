-- SQLite
CREATE TRIGGER trg_check_monster_health
AFTER UPDATE OF current_health ON location_monsters
WHEN NEW.current_health <= 0 
 AND OLD.current_health > 0 --това е интересно
BEGIN 
   UPDATE location_monsters
   SET alive = 0 
   WHERE location_monster_id = NEW.location_monster_id;

   INSERT INTO game_log(player_id, message, read, created_at)
   VALUES(1,"The enemy is down!",1,CURRENT_TIMESTAMP);

END;