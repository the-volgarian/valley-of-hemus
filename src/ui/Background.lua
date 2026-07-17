local Background = {}
Background.__index = Background

function Background.new(bgImagePath)
    local self = setmetatable({},Background)
    
    self.bgImagePath = bgImagePath
    self.bgImage = love.graphics.newImage(self.bgImagePath)
    self.bgImageWidth = self.bgImage:getWidth()
    self.bgImageHeight = self.bgImage:getHeight()
    self.screenWidth = love.graphics.getWidth()
    self.screenHeight = love.graphics.getHeight()

    return self
end

function Background:draw()
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()

    local scaleX = screenWidth / self.bgImageWidth
    local scaleY = screenHeight / self.bgImageHeight

    local scale = math.max(scaleX, scaleY)

    local drawWidth = self.bgImageWidth * scale
    local drawHeight = self.bgImageHeight * scale

    local x = (screenWidth - drawWidth) / 2
    local y = (screenHeight - drawHeight) / 2

    love.graphics.draw(self.bgImage,x,y,0,scale,scale)
end

return Background