DROP TRIGGER IF EXISTS trg_monster_attack_player;

CREATE TRIGGER trg_monster_attack_player 
AFTER UPDATE OF current_health ON location_monsters
WHEN NEW.current_health > 0
BEGIN
    UPDATE players
    SET health = health - (
        SELECT m.damage
        FROM location_monsters lm
        JOIN monsters m
            ON lm.monster_id = m.monster_id
        WHERE lm.location_monster_id = NEW.location_monster_id
    )
    WHERE player_id = 1;

    INSERT INTO game_log(player_id, message, read, created_at)
    VALUES(1, 'The monster attacks you!', 0, CURRENT_TIMESTAMP);
END;