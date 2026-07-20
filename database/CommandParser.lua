local CommandParser = {}

local function split(input)
    local result = {}

    for word in string.gmatch(input, "%S+") do
        table.insert(result, word)
    end

    return result
end

function CommandParser.getCommand(userInput)
    local parts = split(userInput)

    if #parts == 0 then
        return nil
    end

    local arguments = {}

    for i = 2, #parts do
        table.insert(arguments, parts[i])
    end

    return {
        command = parts[1],
        arguments = arguments
    }
end

return CommandParser