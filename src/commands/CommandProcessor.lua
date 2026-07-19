CommandProcessor = {}

CommandProcessor.__index = CommandProcessor

function CommandProcessor.process(parsedCommand)
    local existingCommands =  {
        "attack",
        "go",
        "look"
    }

    local result = "Unrecognize command"


    for i = 1, #existingCommands do
        if parsedCommand == existingCommands[i] then
            result =  parsedCommand .."command selected"
            break
        end
    end

    return result
    
end