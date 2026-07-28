local HelpText = {}

local helpText
local font
local x
local y

function HelpText.load()
    font = love.graphics.newFont("assets/fonts/ARCADECLASSIC.TTF", 24)
end

function HelpText.show(text, posX, posY)
    helpText = love.graphics.newText(font, text)
    x = posX
    y = posY
end

function HelpText.hide()
    helpText = nil
end

function HelpText.draw()
    if helpText then
        love.graphics.draw(helpText, x, y)
    end
end

return HelpText