local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData()
local config = Config
local cashAmount = 0
local bankAmount = 0
local cryptoAmount = 0

RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
    Wait(2000)
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent("QBCore:Client:OnPlayerUnload", function()
    PlayerData = {}
end)

RegisterNetEvent("QBCore:Player:SetPlayerData", function(val)
    PlayerData = val
end)

-- Money HUD

RegisterNetEvent('hud:client:ShowAccounts', function(type, amount)
    if type == 'cash' then
        SendNUIMessage({
            action = 'show',
            type = 'cash',
            cash = amount
        })
    end
    if type == 'bank' then 
        SendNUIMessage({
            action = 'show',
            type = 'bank',
            bank = amount
        })
    end
    if type == 'crypto' then
        SendNUIMessage({
            action = 'show',
            type = 'crypto',
            crypto = amount
        })
    end
end)

RegisterNetEvent('hud:client:OnMoneyChange', function(type, amount, isMinus)
    cashAmount = PlayerData.money['cash']
    bankAmount = PlayerData.money['bank']
    cryptoAmount = PlayerData.money['crypto']
    SendNUIMessage({
        action = 'updatemoney',
        cash = cashAmount,
        bank = bankAmount,
        crypto = cryptoAmount,
        amount = amount,
        minus = isMinus,
        type = type
    })
end)
