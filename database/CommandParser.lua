CommandParser = {}

CommandParser.__index = CommandParser

local command = {
    "attack",
    "look",
    "go"
}

local idRegex = "^%d+$"
local commandRegex = "^%a+$"

function Split(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    table.insert(t, str)
  end
  return t
end


function CommandParser.getCommand(userInputCommand)
    local userInputCommandArray = Split(userInputCommand, " ")
    local map = {}
    local command
    local arguments = {}

    command = userInputCommandArray[1]
    for i = 2, #userInputCommandArray do
        table.insert(arguments, userInputCommandArray[i])
    end

    map = {command = command, arguments = arguments}

    return map
end

return CommandParser