local MainMenu = {}

local Button = require("src.ui.Button")
local ScreenManager = require("src.game.ScreenManager")

local buttons = {}

local font
local woodSupport
local menuPanel
local background
local title

function MainMenu.load()
    buttons = {}

    font = love.graphics.newFont("assets/fonts/ARCADECLASSIC.TTF", 40)

    background = love.graphics.newImage("assets/images/ui/workbench.png")
    woodSupport = love.graphics.newImage("assets/images/ui/wood_support.png")
    menuPanel = love.graphics.newImage("assets/images/ui/settings_panel.png.png")

    title = love.graphics.newText(love.graphics.newFont("assets/fonts/ARCADECLASSIC.TTF", 100), "VALLEY OF HEMUS")

    table.insert(buttons, Button.new(1150, 250, 460, 100, "PLAY", font, "assets/images/ui/Sp.png", nil, {62/255, 39/255, 24/255}, nil, {145/255, 94/255, 45/255}, function()
        print("Play")
    end))

    table.insert(buttons, Button.new(1150, 400, 460, 100, "SETTINGS", font, "assets/images/ui/Sp.png", nil, {62/255, 39/255, 24/255}, nil, {145/255, 94/255, 45/255}, function()
        ScreenManager.setScreen("settings")
    end))

    table.insert(buttons, Button.new(1150, 550, 460, 100, "CREDITS", font, "assets/images/ui/Sp.png", nil, {62/255, 39/255, 24/255}, nil, {145/255, 94/255, 45/255}, function()
        print("Credits")
    end))

    table.insert(buttons, Button.new(1150, 700, 460, 100, "QUIT", font, "assets/images/ui/Sp.png", nil, {62/255, 39/255, 24/255}, nil, {145/255, 94/255, 45/255}, function()
        love.event.quit()
    end))
end

function MainMenu.draw(mouseX, mouseY)
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.draw(background, 0, 0, 0, 6.8, 6.8)
    love.graphics.draw(woodSupport, 1030, 80, 0, 5.5, 5.5)
    love.graphics.draw(menuPanel, 840, 0, 0, 6.8, 6.8)

    Button.setMousePosition(mouseX, mouseY)

    love.graphics.draw(title, (1920 - title:getWidth()) / 2, 80)

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