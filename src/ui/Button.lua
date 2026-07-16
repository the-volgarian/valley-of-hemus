local Button = {}
Button.__index = Button

function Button.new(x,y,width,height,text,font)

    local self = setmetatable({},Button)

    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.text = text
    self.font = font
    
    self.textObject = love.graphics.newText(font, text)

    return self
end

function Button:draw()
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("fill",self.x,self.y,self.width,self.height)

    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(self.textObject, self.x + 10, self.y + 8)

    love.graphics.setColor(1, 1, 1)
end

return Button