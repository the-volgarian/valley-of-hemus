require("sqlite3")

local Connection = {}

local db = nil

function Connection.open()
    db = sqlite3.open("database/game.db")
end

function Connection.get()
    return db
end

function Connection.close()
    if db then
        db:close()
        db = nil
    end
end

return Connection