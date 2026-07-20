local SqlFileReader = require("database.SqlFileReader")
local Connection = require("src.database.Connection")

local QueryExecutor = {}

function QueryExecutor.execute(sqlFilePath, parameters)
    local sql = SqlFileReader.read(sqlFilePath)
    local db = Connection.get()
    local statement = db:prepare(sql)

    if not statement then
        error("Failed to prepare SQL file: " .. sqlFilePath)
    end

    if parameters then
        statement:bind_names(parameters)
    end

    local result = statement:step()

    statement:finalize()

    return result
end

return QueryExecutor