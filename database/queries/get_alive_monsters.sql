SELECT
lm.location_id,
lm.alive,
lm.monster_id,
m.name
FROM location_monsters lm
LEFT JOIN monsters m
ON lm.monster_id = m.monster_id
WHERE lm.alive = 1
AND lm.location_id = :locationId;