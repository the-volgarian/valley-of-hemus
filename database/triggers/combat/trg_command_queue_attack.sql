DROP TRIGGER IF EXISTS trg_command_queue_attack;

CREATE TRIGGER trg_command_queue_attack
AFTER INSERT ON command_queue
WHEN NEW.command = 'attack'
BEGIN

    INSERT INTO game_log (player_id, message, read, created_at)
    SELECT NEW.player_id, 'You hit the enemy', 0, CURRENT_TIMESTAMP
    WHERE EXISTS (
        SELECT 1
        FROM location_monsters
        WHERE location_monster_id = NEW.target_id
          AND alive = 1
    );

    UPDATE location_monsters
    SET current_health = current_health - (
        SELECT
            CASE 
                WHEN (p.strength + w.damage - m.defense) < 1 THEN 1
                ELSE p.strength + w.damage - m.defense
            END
        FROM players p
        JOIN weapons_inventory wi
            ON p.player_id = wi.player_id
        JOIN weapons w 
            ON wi.weapon_id = w.weapon_id 
        JOIN location_monsters lm
            ON lm.location_monster_id = NEW.target_id
        JOIN monsters m
            ON lm.monster_id = m.monster_id
        WHERE wi.equipped = 1
          AND p.player_id = NEW.player_id
    )
    WHERE location_monster_id = NEW.target_id
      AND alive = 1;

END;