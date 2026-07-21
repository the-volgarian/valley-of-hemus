local QueryExecutor = require("database.QueryExecutor")

local AttackCommand = {}

function AttackCommand.execute(arguments)
    local targetType = arguments[1]
    local targetId = tonumber(arguments[2])

    if targetType ~= "monster" then
        error("Attack command supports only monster targets.")
    end

    if not targetId then
        error("Usage: attack monster <id>")
    end

    QueryExecutor.execute(
        "database/commands/attack.sql",
        {
            playerId = 1,
            targetType = targetType,
            targetId = targetId
        }
    )
end

return AttackCommand