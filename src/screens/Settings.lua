local Settings = {}
local Button = require("src.ui.Button")
local HelpText = require("src.ui.HelpText")
local AudioManager = require("src.audio.AudioManager")


local navigationButtons = {}
local generalButtons = {}
local audioButtons = {}

local font
local woodSupport
local settingsPanel
local settingForestPanel
local checkmarkImage
local resolutionText
local resolutionLabel
local fullscreenLabel
local masterVolumeLabel

local isGeneralSelected = true
local isAudioSelected = false
local isFullscreenSelected = false

local currentResolutionIndex = 4
local fullscreen = true

local currentMasterVolume
local masterVolumeText
local currentMusicVolume
local currentSfxVolume

local resolutions = {
    {1280, 720},
    {1366, 768},
    {1600, 900},
    {1920, 1080}
}

local function updateResolutionText()
    local width = resolutions[currentResolutionIndex][1]
    local height = resolutions[currentResolutionIndex][2]

    resolutionText = love.graphics.newText(font, width .. "x" .. height)
end

local function updateMasterVolumeText()
    local PERCENT_MULTIPLIER = 100
    currentMasterVolume = AudioManager.getMasterVolume() * PERCENT_MULTIPLIER
    masterVolumeText = love.graphics.newText(font, currentMasterVolume)
end

local function refreshViewport()
    local width, height = love.graphics.getDimensions()
    love.resize(width, height)
end

local function applyWindowSettings(newFullscreen)
    fullscreen = newFullscreen

    local width = resolutions[currentResolutionIndex][1]
    local height = resolutions[currentResolutionIndex][2]

    local success, errorMessage = love.window.setMode(width, height, {
        fullscreen = fullscreen,
        fullscreentype = fullscreen and "exclusive" or "desktop",
        resizable = not fullscreen,
        usedpiscale = false,
        vsync = 1,
        minwidth = 400,
        minheight = 300
    })

    if not success then
        print(errorMessage)
        return
    end

    isFullscreenSelected = fullscreen

    updateResolutionText()
    refreshViewport()
end

local function findCurrentResolution()
    local pixelWidth, pixelHeight = love.graphics.getPixelDimensions()

    for index, resolution in ipairs(resolutions) do
        if pixelWidth == resolution[1] and pixelHeight == resolution[2] then
            currentResolutionIndex = index
            return
        end
    end
end

function Settings.load()
    navigationButtons = {}

    HelpText.load()

    font = love.graphics.newFont("assets/fonts/ARCADECLASSIC.TTF", 40)

    woodSupport = love.graphics.newImage("assets/images/ui/wood_support.png")
    settingsPanel = love.graphics.newImage("assets/images/ui/settings_panel.png.png")
    settingForestPanel = love.graphics.newImage("assets/images/ui/workbench.png")
    checkmarkImage = love.graphics.newImage("assets/images/ui/x.png")

    fullscreenLabel = love.graphics.newText(font, "Fullscreen")
    resolutionLabel = love.graphics.newText(font, "Resolution")

    masterVolumeLabel = love.graphics.newText(font, "Master volume")

    isFullscreenSelected = love.window.getFullscreen()
    fullscreen = isFullscreenSelected

    findCurrentResolution()
    updateResolutionText()
    updateMasterVolumeText()
    

    table.insert(navigationButtons, Button.new(60, 120, 460, 100, "GENERAL", font, "assets/images/ui/Sp.png", nil, {62 / 255, 39 / 255, 24 / 255}, nil, {145 / 255, 94 / 255, 45 / 255}, function()
        isGeneralSelected = true
        isAudioSelected = false
    end))

    table.insert(navigationButtons, Button.new(60, 270, 460, 100, "AUDIO", font, "assets/images/ui/Sp.png", nil, {62 / 255, 39 / 255, 24 / 255}, nil, {145 / 255, 94 / 255, 45 / 255}, function()
        isGeneralSelected = false
        isAudioSelected = true
    end))

    table.insert(navigationButtons, Button.new(60, 420, 460, 100, "CONTROLS", font, "assets/images/ui/Sp.png", nil, {62 / 255, 39 / 255, 24 / 255}, nil, {145 / 255, 94 / 255, 45 / 255}, function()
        print("Controls")
    end))

    table.insert(navigationButtons, Button.new(60, 570, 460, 100, "HELP", font, "assets/images/ui/Sp.png", nil, {62 / 255, 39 / 255, 24 / 255}, nil, {145 / 255, 94 / 255, 45 / 255}, function()
        print("Help")
    end))

    table.insert(navigationButtons, Button.new(78, 700, 364, 110, "", font, "assets/images/ui/back_btn_image.png", nil, {62 / 255, 39 / 255, 24 / 255}, nil, {145 / 255, 94 / 255, 45 / 255}, function()
        print("Back")
    end))
    -- 3.31125

    table.insert(generalButtons, Button.new(1450, 265, 70, 70, "", font, "assets/images/ui/btn.png", {62 / 255, 39 / 255, 24 / 255}, {1, 1, 1}, nil, {145 / 255, 94 / 255, 45 / 255}, function()
        applyWindowSettings(true)
    end))

    table.insert(generalButtons, Button.new(1650, 265, 70, 70, "", font, "assets/images/ui/btn.png", {62 / 255, 39 / 255, 24 / 255}, {1, 1, 1}, nil, {145 / 255, 94 / 255, 45 / 255}, function()
        applyWindowSettings(false)
    end))

    table.insert(generalButtons, Button.new(1450, 350, 200, 70, "", font, "assets/images/ui/btn.png", {62 / 255, 39 / 255, 24 / 255}, {1, 1, 1}, nil, {145 / 255, 94 / 255, 45 / 255}, function()
        currentResolutionIndex = currentResolutionIndex + 1

        if currentResolutionIndex > #resolutions then
            currentResolutionIndex = 1
        end

        applyWindowSettings(fullscreen)
    end))

    table.insert(audioButtons, Button.new(1450, 265, 70, 70, "", font, "assets/images/ui/btn.png", {62 / 255, 39 / 255, 24 / 255}, {1, 1, 1}, nil, {145 / 255, 94 / 255, 45 / 255}, function()
        AudioManager.decreaseMasterVolume()
        updateMasterVolumeText()
    end))

    table.insert(audioButtons, Button.new(1650, 265, 70, 70, "", font, "assets/images/ui/btn.png", {62 / 255, 39 / 255, 24 / 255}, {1, 1, 1}, nil, {145 / 255, 94 / 255, 45 / 255}, function()
         AudioManager.increaseMasterVolume()
         updateMasterVolumeText()
    end))

end

function Settings.draw(mouseX, mouseY)
    local resolutionButtonX = 1450
    local resolutionButtonWidth = 200

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(settingForestPanel, 0, 0, 0, 6.8, 6.8)
    love.graphics.draw(woodSupport, 230, 80, 0, 5.5, 5.5)
    love.graphics.draw(settingsPanel, 840, 0, 0, 6.8, 6.8)

    Button.setMousePosition(mouseX, mouseY)

    for _, button in ipairs(navigationButtons) do
        button:draw()
    end
    

    if isGeneralSelected then
        love.graphics.draw(fullscreenLabel, 1100, 280)
        love.graphics.draw(resolutionLabel, 1100, 365)

        for _, button in ipairs(generalButtons) do
            button:draw()
        end

        love.graphics.draw(
            resolutionText,
            resolutionButtonX + (resolutionButtonWidth - resolutionText:getWidth()) / 2,
            365
        )

        if isFullscreenSelected then
            love.graphics.draw(checkmarkImage, 1450, 265, 0, 4.5, 4.5)
        else
            love.graphics.draw(checkmarkImage, 1650, 265, 0, 4.5, 4.5)
        end
    end

    if isAudioSelected then
        love.graphics.draw(masterVolumeLabel, 1100,280)
        love.graphics.draw(masterVolumeText, 1550, 265)
        for _, button in ipairs(audioButtons) do
            button:draw()
        end

    end

if mouseX >= 1100 and mouseX <= 1150
and mouseY >= 880 and mouseY <= 950 then
    HelpText.show(
        "Legend   says   this   is   Emperor   Nikephoros   skull\nBulgarian   craftsmanship   at   its   finest",
        mouseX + 30,
        mouseY + 10
    )
else
    HelpText.hide()
end

HelpText.draw()
end

function Settings.mousepressed(x, y, mouseButton)
    if mouseButton ~= 1 then
        return
    end

    for _, button in ipairs(navigationButtons) do
        if button:contains(x, y) then
            button:click()
            return
        end
    end

    if isGeneralSelected then
        for _, button in ipairs(generalButtons) do
            if button:contains(x, y) then
                button:click()
                return
            end
        end
    end

    if isAudioSelected then
        for _, button in ipairs(audioButtons) do
            if button:contains(x, y) then
                button:click()
                return
            end
        end
    end
end

return Settings