local Monster = {}

Monster.__index = Monster

function Monster.new(health, id, name, x, y, width, height, font)
    local self = setmetatable({}, Monster)

    self.font = font
    self.health = health
    self.id = id
    self.name = name
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.textId = love.graphics.newText(self.font, tostring(self.id))
    self.textName = love.graphics.newText(self.font, self.name)

    return self
end

function Monster:draw()
    local radius = 5
    local textY = self.y - 20

    love.graphics.draw(self.textName, self.x, textY)
    love.graphics.draw(self.textId, self.x + self.textName:getWidth() + 5, textY)
    for i = 1, math.ceil(self.health/10) do
        love.graphics.circle("fill",  self.x + radius + (i - 1) * 14, self.y-24, radius)
    end
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return Monster