DROP TRIGGER IF EXISTS trg_monster_loot_drop;

CREATE TRIGGER trg_monster_loot_drop
AFTER UPDATE OF alive ON location_monsters
WHEN NEW.alive = 0 AND OLD.alive = 1
BEGIN
	UPDATE players
	SET 
		gold = gold + (
			SELECT m.gold_drop
			FROM monsters m
			WHERE m.monster_id = NEW.monster_id
		),
		experience = experience + (
			SELECT m.xp_drop
			FROM monsters m
			WHERE m.monster_id = NEW.monster_id
		)
	WHERE player_id = 1;
END;