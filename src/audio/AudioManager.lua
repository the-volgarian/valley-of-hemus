local AudioManager = {}
local music = {}

local masterVolume = 1
local musicVolume = 1
local sfxVolume = 1

function AudioManager.load()
    music.main_menu = love.audio.newSource("src/audio/test.mp3", "stream")
    music.main_menu:setLooping(true)
end

function AudioManager.playMusic(name)
    music[name]:play()
end

function AudioManager.decreaseMasterVolume()
    if masterVolume <= 0.1 then
        return
    end
    masterVolume = masterVolume - 0.1
    
    love.audio.setVolume(masterVolume)
end

function AudioManager.increaseMasterVolume()
    if masterVolume >= 1 then
        return
    end
    masterVolume = masterVolume + 0.1
    
    love.audio.setVolume(masterVolume)
end

function AudioManager.getMasterVolume()
    return masterVolume
end

function AudioManager.getMusicVolume()
    return musicVolume
end

function AudioManager.getSfxVolume()
    return sfxVolume
end

return AudioManager