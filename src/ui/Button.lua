local Button = {}
Button.__index = Button

function Button.new(x,y,width,height,text,font,bgColor,textColor,hoverColor)

    local self = setmetatable({},Button)

    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.text = text
    self.font = font
    self.bgColor = bgColor
    self.textColor = textColor
    self.hoverColor = hoverColor
    self.textObject = love.graphics.newText(font, text)

    return self
end

function Button:draw()
    love.graphics.setColor(self.bgColor)
    love.graphics.rectangle("fill",self.x,self.y,self.width,self.height)
    love.graphics.setColor(self.textColor)
    if self:isHovered() then
        love.graphics.setColor(self.hoverColor)
    end
    love.graphics.draw(self.textObject, self.x + 10, self.y + 8)
    love.graphics.setColor(1, 1, 1)
end

function Button:isHovered()
    local mx, my = love.mouse.getPosition()
    if mx >= self.x and mx <= self.x + self.width and my >= self.y and my <= self.y + self.height then
        return true
    else
        return false
    end
end

return Button