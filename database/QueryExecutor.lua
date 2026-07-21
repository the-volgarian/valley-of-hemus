local SqlFileReader = require("database.SqlFileReader")
local Connection = require("src.database.Connection")
local sqlite3 = require("sqlite3")

local QueryExecutor = {}

function QueryExecutor.execute(sqlFilePath, parameters)
    local sql = SqlFileReader.read(sqlFilePath)

    if not sql then
        error("SQL file not found: " .. tostring(sqlFilePath))
    end

    local db = Connection.get()
    local statement = db:prepare(sql)

    if not statement then
        error("Failed to prepare SQL file: " .. tostring(sqlFilePath))
    end

    if parameters then
        statement:bind_names(parameters)
    end

    local result = statement:step()

    statement:finalize()

    return result
end


function QueryExecutor.fetchAll(sqlFilePath, parameters)
    local sql = SqlFileReader.read(sqlFilePath)
    local db = Connection.get()

    if not sql then
        error("SQL file not found: " .. tostring(sqlFilePath))
    end

    local statement = db:prepare(sql)

    if not statement then
        error("Failed to prepare SQL file: " .. tostring(sqlFilePath))
    end

    if parameters then
        statement:bind_names(parameters)
    end

    local rows = {}

    while statement:step() == sqlite3.ROW do
        table.insert(rows, statement:get_named_values())
    end

    statement:finalize()

    return rows
end

return QueryExecutor