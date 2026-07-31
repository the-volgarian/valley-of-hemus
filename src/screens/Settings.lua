local Settings = {}
local Button = require("src.ui.Button")
local HelpText = require("src.ui.HelpText")


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
local musicVolumeLabel
local sfxVolumeLabel
local muteMusicLebel
local muteMasterLebel

local isGeneralSelected = true
local isAudioSelected = false
local isFullscreenSelected = false
local isMusicMute = not true
local isMasterMute = not true

local currentResolutionIndex = 4
local fullscreen = true

local MasterVolume
local masterVolumeText

local musicVolume
local musicVolumeText

local sfxVolume
local sfxVolumeText


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
    MasterVolume = AudioManager.getMasterVolume() * PERCENT_MULTIPLIER
    masterVolumeText = love.graphics.newText(font, MasterVolume)
end

local function updateMusicVolumeText()
    local PERCENT_MULTIPLIER = 100
    musicVolume = AudioManager.getMusicVolume() * PERCENT_MULTIPLIER
    musicVolumeText = love.graphics.newText(font, musicVolume)
end

local function updateSfxVolumeText()
    local PERCENT_MULTIPLIER = 100
    sfxVolume = AudioManager.getSfxVolume() * PERCENT_MULTIPLIER
    sfxVolumeText = love.graphics.newText(font, sfxVolume)
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
    musicVolumeLabel = love.graphics.newText(font, "Music volume")
    sfxVolumeLabel = love.graphics.newText(font,"Sfx volume")
    muteMusicLebel = love.graphics.newText(font, "Mute music")
    muteMasterLebel = love.graphics.newText(font, "Mute audio")

    isFullscreenSelected = love.window.getFullscreen()
    fullscreen = isFullscreenSelected

    findCurrentResolution()
    updateResolutionText()
    updateMasterVolumeText()
    updateMusicVolumeText()
    updateSfxVolumeText()

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

    table.insert(audioButtons, Button.new(1450, 350, 70, 70, "", font, "assets/images/ui/btn.png", {62 / 255, 39 / 255, 24 / 255}, {1, 1, 1}, nil, {145 / 255, 94 / 255, 45 / 255}, function()
        AudioManager.decreaseMusicVolume()
        updateMusicVolumeText()
    end))

    table.insert(audioButtons, Button.new(1650, 350, 70, 70, "", font, "assets/images/ui/btn.png", {62 / 255, 39 / 255, 24 / 255}, {1, 1, 1}, nil, {145 / 255, 94 / 255, 45 / 255}, function()
         AudioManager.increaseMusicVolume()
         updateMusicVolumeText()
    end))

    table.insert(audioButtons, Button.new(1450, 435, 70, 70, "", font, "assets/images/ui/btn.png", {62 / 255, 39 / 255, 24 / 255}, {1, 1, 1}, nil, {145 / 255, 94 / 255, 45 / 255}, function()
        AudioManager.decreaseSfxVolume()
        updateSfxVolumeText()
    end))

    table.insert(audioButtons, Button.new(1650, 435, 70, 70, "", font, "assets/images/ui/btn.png", {62 / 255, 39 / 255, 24 / 255}, {1, 1, 1}, nil, {145 / 255, 94 / 255, 45 / 255}, function()
         AudioManager.increaseSfxVolume()
         updateSfxVolumeText()
    end))

    table.insert(audioButtons, Button.new(1550, 520, 70, 70, "", font, "assets/images/ui/btn.png", {62 / 255, 39 / 255, 24 / 255}, {1, 1, 1}, nil, {145 / 255, 94 / 255, 45 / 255}, function()
        if isMusicMute then
            AudioManager.unmuteMusicVolume()
            isMusicMute = false
        else
            AudioManager.muteMusicVolume()
            isMusicMute = true
        end
    end))

    table.insert(audioButtons, Button.new(1550, 605, 70, 70, "", font, "assets/images/ui/btn.png", {62 / 255, 39 / 255, 24 / 255}, {1, 1, 1}, nil, {145 / 255, 94 / 255, 45 / 255}, function()
        if isMasterMute then
            AudioManager.unmuteMasterVolume()
            isMasterMute = false
        else
            AudioManager.muteMasterVolume()
            isMasterMute = true
        end
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
        love.graphics.draw(masterVolumeLabel, 1100, 280)
        love.graphics.draw(musicVolumeLabel, 1100, 365)
        love.graphics.draw(sfxVolumeLabel, 1100, 450)
        love.graphics.draw(muteMusicLebel, 1100, 535)
        love.graphics.draw(muteMasterLebel, 1100, 620)
        love.graphics.draw(masterVolumeText, 1550, 280)
        love.graphics.draw(musicVolumeText, 1550, 365)
        love.graphics.draw(sfxVolumeText, 1550, 450)
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

    elseif mouseX >= 1000 and mouseX <= 1050
    and mouseY >= 880 and mouseY <= 950 then

        HelpText.show(
            "Even   the   village   healer   refuses   to   identify   it",
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