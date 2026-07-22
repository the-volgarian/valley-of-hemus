local MainMenu = {}

local Button = require("src.ui.Button")

local buttons = {}
local font

function MainMenu.load()
    buttons = {}
    font = love.graphics.newFont("assets/fonts/ARCADECLASSIC.TTF", 40)

    table.insert(buttons, Button.new(450, 220, 380, 70, "PLAY", font, "assets/images/ui/menu_button_bg.png", nil, {62/255,39/255,24/255}, nil, {145/255,94/255,45/255}, function() print("Play") end))
    table.insert(buttons, Button.new(450, 320, 380, 70, "SETTINGS", font, "assets/images/ui/menu_button_bg.png", nil, {62/255,39/255,24/255}, nil, {145/255,94/255,45/255}, function() print("Settings") end))
    table.insert(buttons, Button.new(450, 420, 380, 70, "CREDITS", font, "assets/images/ui/menu_button_bg.png", nil, {62/255,39/255,24/255}, nil, {145/255,94/255,45/255}, function() print("Credits") end))
    table.insert(buttons, Button.new(450, 520, 380, 70, "QUIT", font, "assets/images/ui/menu_button_bg.png", nil, {62/255,39/255,24/255}, nil, {145/255,94/255,45/255}, function() love.event.quit() end))
end

function MainMenu.draw()
    for _, button in ipairs(buttons) do
        button:draw()
    end
end

function MainMenu.mousepressed(x, y, mouseButton)
    if mouseButton ~= 1 then
        return
    end

    for _, button in ipairs(buttons) do
        if button:contains(x, y) then
            button:click()
            return
        end
    end
end

return MainMenu