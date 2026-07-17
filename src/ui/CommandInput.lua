local CommandInput = {}

local utf8 = require("utf8")

CommandInput.__index = CommandInput

function CommandInput.new(x, y, width, height, font, textColor, backgroundColor, borderColor)
    local self = setmetatable({}, CommandInput)

    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.text = ""
    self.font = font

    self.textColor = textColor
    self.backgroundColor = backgroundColor
    self.borderColor = borderColor

    self.padding = 8
    self.deleteTimer = 0

    return self
end

function CommandInput:textinput(t)
    self.text = self.text .. t
end

function CommandInput:draw()

    love.graphics.setFont(self.font)

    love.graphics.setColor(self.backgroundColor)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

    love.graphics.setColor(self.borderColor)
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height)

    love.graphics.setColor(self.textColor)
    love.graphics.printf(
        self.text,
        self.x + self.padding,
        self.y + self.padding,
        self.width - self.padding * 2,
        "left"
    )

    love.graphics.setColor(1, 1, 1)
end

function CommandInput:keypressed(key)
    if key == "backspace" then
        local byteoffset = utf8.offset(self.text, -1)

        if byteoffset then
            self.text = string.sub(self.text, 1, byteoffset - 1)
        end
    elseif key == "return" then
        return self:getText()
    end
end

function CommandInput:getText()
    local text = self.text
    self.text = ""
    return text
end

function CommandInput:update(dt)
    if love.keyboard.isDown("backspace") then
        self.deleteTimer = self.deleteTimer + dt

        if self.deleteTimer >= 0.25 then
            self:keypressed("backspace")
            self.deleteTimer = 0
        end
    else
        self.deleteTimer = 0
    end
end

return CommandInput