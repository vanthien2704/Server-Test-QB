local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Commands.Add('tiengiatoc', 'Kiểm tra tiền gia tộc', {}, false, function(source, _)
    local Player = QBCore.Functions.GetPlayer(source)
    local cryptoamount = Player.PlayerData.money.crypto
    TriggerClientEvent('hud:client:ShowAccounts', source, 'crypto', cryptoamount)
end)
QBCore.Commands.Add('tien', 'Kiểm tra số dư tiền mặt', {}, false, function(source, _)
    local Player = QBCore.Functions.GetPlayer(source)
    local cashamount = Player.PlayerData.money.cash
    TriggerClientEvent('hud:client:ShowAccounts', source, 'cash', cashamount)
end)

QBCore.Commands.Add('bank', 'Kiểm tra số dư ngân hàng', {}, false, function(source, _)
    local Player = QBCore.Functions.GetPlayer(source)
    local bankamount = Player.PlayerData.money.bank
    TriggerClientEvent('hud:client:ShowAccounts', source, 'bank', bankamount)
end)
