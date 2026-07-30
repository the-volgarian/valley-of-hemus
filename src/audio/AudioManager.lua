local AudioManager = {}
local music = {}
local sound = {}

local masterVolume = 1
local musicVolume = 1
local sfxVolume = 1

function AudioManager.load()
    music.main_menu = love.audio.newSource("src/audio/test.mp3", "stream")
    music.main_menu:setLooping(true)

    sound.button_select = love.audio.newSource("src/audio/button_select_sound.wav","static")
    sound.button_hover = love.audio.newSource("src/audio/button_hover_sound.wav","static")

end

function AudioManager.playMusic(name)
    music[name]:play()
end

function AudioManager.playSound(name)
    sound[name]:stop()
    sound[name]:play()
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

function AudioManager.decreaseMusicVolume()
    if musicVolume <= 0.1 then
        return
    end
    musicVolume = musicVolume - 0.1
    
    love.audio.setVolume(musicVolume)
end

function AudioManager.increaseMusicVolume()
    if musicVolume >= 1 then
        return
    end
    musicVolume = musicVolume + 0.1
    
    love.audio.setVolume(musicVolume)
end

function AudioManager.decreaseSfxVolume()
    if sfxVolume <= 0.1 then
        return
    end
    sfxVolume = masterVolume - 0.1
    
    love.audio.setVolume(sfxVolume)
end

function AudioManager.increaseSFxVolume()
    if sfxVolume >= 1 then
        return
    end
    sfxVolume = sfxVolume + 0.1
    
    love.audio.setVolume(sfxVolume)
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