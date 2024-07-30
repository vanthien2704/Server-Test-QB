local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('d-moneyhud:getaccount', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player then
        local cash = Player.PlayerData.money['cash']
        local bank = Player.PlayerData.money['bank']
        local table_data = {
            cash = cash,
            bank = bank,
        }
        
        cb(table_data)
    else
        cb(nil) -- Trả về nil nếu không tìm thấy người chơi
    end
end)
