SELECT
    p.map_location,
    l.name AS location_name
FROM players AS p
JOIN locations AS l
    ON l.location_id = p.map_location
WHERE p.player_id = :playerId;