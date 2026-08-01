local ScreenManager = {}

local screens = {}
local currentScreen

function ScreenManager.register(name, screen)
    screens[name] = screen
end

function ScreenManager.setScreen(name)
    currentScreen = screens[name]
end

function ScreenManager.draw(...)
    if currentScreen and currentScreen.draw then
        currentScreen.draw(...)
    end
end

function ScreenManager.mousepressed(...)
    if currentScreen and currentScreen.mousepressed then
        currentScreen.mousepressed(...)
    end
end

function ScreenManager.keypressed(...)
    if currentScreen and currentScreen.keypressed then
        currentScreen.keypressed(...)
    end
end

function ScreenManager.textinput(...)
    if currentScreen and currentScreen.textinput then
        currentScreen.textinput(...)
    end
end

return ScreenManager