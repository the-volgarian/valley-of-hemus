GameLog = {}
QueryExecutor = require("database.QueryExecutor")

GameLog.__index = GameLog

function GameLog.getUnreadLog(playerId)

    local unreadLogs = QueryExecutor.fetchAll("database/queries/get_unread.sql",{playerId = playerId})
    QueryExecutor.execute("database/queries/mark_all_as_read.sql", {playerId = playerId})
    return unreadLogs
    
end

return GameLog