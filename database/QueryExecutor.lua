local SqlFileReader = require("database.SqlFileReader")
local Connection = require("src.database.Connection")

local QueryExecutor = {}


function QueryExecutor.execute(sqlFilePath)
    local sql = SqlFileReader.read(sqlFilePath)
    local db = Connection.get()

    db:execute(sql)

end

return QueryExecutor

