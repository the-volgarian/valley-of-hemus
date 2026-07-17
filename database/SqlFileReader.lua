local SqlFileReader = {}

function SqlFileReader.read(filePath)
    local sql = love.filesystem.read(filePath)

    return sql
end

return SqlFileReader