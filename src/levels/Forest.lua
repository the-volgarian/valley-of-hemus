local Forest = {}

local QueryExecutor = require("database.QueryExecutor")
local Monster = require("src.entities.Monster")

local font = love.graphics.newFont("assets/fonts/ARCADECLASSIC.TTF", 24)

local usedPositions = {}
local MIN_DISTANCE = 100

local function GetRandomPosition()
    while true do
        local x = love.math.random(50, 700)
        local y = love.math.random(50, 500)

        local isValid = true

        for _, position in ipairs(usedPositions) do
            local dx = x - position.x
            local dy = y - position.y
            local distance = math.sqrt(dx * dx + dy * dy)

            if distance < MIN_DISTANCE then
                isValid = false
                break
            end
        end

        if isValid then
            table.insert(usedPositions, { x = x, y = y })
            return x, y
        end
    end
end

function Forest.load()
    local monsters = QueryExecutor.fetchAll("database/queries/get_alive_monsters.sql", { locationId = 1 })
    local monstersOnMap = {}

    usedPositions = {}

    for _, monster in ipairs(monsters) do
        if monster.alive == 1 then
            local x, y = GetRandomPosition()
            table.insert(monstersOnMap, Monster.new(100, monster.monster_id, monster.name, x, y, 100, 100, font))
        end
    end

    return monstersOnMap
end

return Forest