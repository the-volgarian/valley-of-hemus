INSERT INTO command_queue (
    player_id,
    command,
    target_type,
    target_id
)
VALUES (
    :playerId,
    'attack',
    :targetType,
    :targetId
);