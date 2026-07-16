local Button = {}
Button.__index = Button

function Button.new(x,y,width,height,text,font,bgColor,textColor,pressedColor,hoverColor,onClick)

    local self = setmetatable({},Button)

    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.text = text
    self.font = font or love.graphics.getFont()
    self.bgColor = bgColor
    self.textColor = textColor
    self.hoverColor = hoverColor
    self.textObject = love.graphics.newText(font, text)
    self.onClick = onClick
    self.pressedColor = pressedColor
    self.pressed = false

    return self
end

function Button:draw()
    local hovered = self:isHovered()
    local centerX = self.x + self.width / 2
    local centerY = self.y + self.height / 2
    local textX = self.x + (self.width - self.textObject:getWidth()) / 2
    local textY = self.y + (self.height - self.textObject:getHeight()) / 2

    love.graphics.push()

    if hovered then
        love.graphics.translate(centerX, centerY)
        love.graphics.scale(0.95, 0.95)
        love.graphics.translate(-centerX, -centerY)
    end

    if hovered then
        love.graphics.setColor(self.hoverColor)
    else
        love.graphics.setColor(self.bgColor)
    end

    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

    love.graphics.setColor(self.textColor)

    love.graphics.draw(self.textObject, textX, textY)

    love.graphics.pop()
    love.graphics.setColor(1, 1, 1)
end

function Button:contains(x, y)
    return x >= self.x
        and x <= self.x + self.width
        and y >= self.y
        and y <= self.y + self.height
end

function Button:isHovered()
    local mx, my = love.mouse.getPosition()
    return self:contains(mx, my)
end


function Button:click()
    self.pressed = true
    if self.onClick then
        self.onClick()
    end
end

return Button