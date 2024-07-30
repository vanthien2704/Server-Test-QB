-- QBCore = exports['qb-core']:GetCoreObject()


-- RegisterServerEvent(GetCurrentResourceName() .. ':Wanted:SV', function (data)
--     local _source = source
--     local Player = QBCore.Functions.GetPlayer(_source)
--     if xPlayer then
-- print('ccc')
--         local playerGroup = xPlayer.PlayerData.group
--     end
--     local TargetPlayer=  QBCore.Functions.GetPlayer(data.targetId)
--     local TargetName = QBCore.Functions.GetPlayer

--     if xPlayerGroup == 'superadmin' or xPlayerGroup == 'admin' or xPlayerGroup == 'dev' then
--         TriggerClientEvent(GetCurrentResourceName() .. ':Wanted', -1, {
--             time = data.time,
--             money = data.money,
--             playerId = data.targetId,
--             text = data.text,
--             playername = TargetName
--         })
--     end
-- end)
-- RegisterServerEvent(GetCurrentResourceName() .. ':END:SV', function (data)
--     local _source = source
    
--     local xPlayer = QBCore.Functions.GetPlayer(_source)
--     if xPlayer then

--     local playerGroup = xPlayer.PlayerData.group
-- end


--     if xPlayerGroup == 'superadmin' or xPlayerGroup == 'admin' or xPlayerGroup == 'dev' then
--         TriggerClientEvent(GetCurrentResourceName() .. 'END', -1)
--     end
-- end)
QBCore = exports['qb-core']:GetCoreObject()


RegisterServerEvent(GetCurrentResourceName() .. ':Wanted:SV', function (data)
    local _source = source
    local xPlayer =  QBCore.Functions.GetPlayer(_source)
    local xPlayerGroup = xPlayer.PlayerData.group
    local TargetPlayer=   QBCore.Functions.GetPlayer(data.targetId)
    local TargetName = GetPlayerName(data.targetId)
    

    if QBCore.Functions.HasPermission(_source, "admin") or QBCore.Functions.HasPermission(_source, "god") then
        TriggerClientEvent(GetCurrentResourceName() .. ':Wanted', -1, {
            time = data.time,
            money = data.money,
            playerId = data.targetId,
            text = data.text,
            playername = TargetName
        })
    else
        TriggerClientEvent('QBCore:Notify', src, 'Bạn không có quyền admin', 'error')
    end
end)
RegisterServerEvent(GetCurrentResourceName() .. ':END:SV', function (data)
    local _source = source
    local xPlayer =  QBCore.Functions.GetPlayer(_source)

    if QBCore.Functions.HasPermission(_source, "admin") or QBCore.Functions.HasPermission(_source, "god") then
        TriggerClientEvent(GetCurrentResourceName() .. 'END', -1)
    else
        TriggerClientEvent('QBCore:Notify', src, 'Bạn không có quyền admin', 'error')
    end
end)

-- Handle the request for server-side player IDs
RegisterServerEvent('requestServerPlayerIDs')
AddEventHandler('requestServerPlayerIDs', function()
    local source = source
    local players = GetPlayers()  -- GetPlayers() returns server-side player IDs
    TriggerClientEvent('receiveServerPlayerIDs', source, players)
end)
