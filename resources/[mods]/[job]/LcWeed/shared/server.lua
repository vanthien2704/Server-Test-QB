QBCore = nil
QBCore = exports['qb-core']:GetCoreObject()
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(0)
    end
end)

QBCore.Functions.CreateCallback('lj-inventory:getItemAmount', function(source, cb, item)
    local player = QBCore.Functions.GetPlayer(source)
    if player then
        local itemCount = player.Functions.GetItemByName(item).count
        cb(itemCount)
    else
        cb(0)
    end
end)


QBCore.Functions.CreateUseableItem(Config.Items["Seed"], function(source, item)
    UseItem(source, item)
end)

RegisterNetEvent('lj-inventory:onUseItem')
AddEventHandler('lj-inventory:onUseItem', function(item)
    if item == Config.Items["Seed"] then
        UseItem(source, item)
    end
end)

function notify(source, text)
    local player = QBCore.Functions.GetPlayer(source)
    if player then
        player.Functions.Notify(text, "success")
    end
end

function removeitem(source, name, count)
    local player = QBCore.Functions.GetPlayer(source)
    if player then
        if Config.Inventory == "lj-inventory" then
            player.Functions.RemoveItem(name, count)
        elseif Config.Inventory == "lj-inventory" then
            exports.ox_inventory:RemoveItem(source, name, count)
        elseif Config.Inventory == "lj-inventory" then
            exports['lj-inventory']:RemoveItem(source, name, count)
        else
            -- Handle other inventory exports if needed
        end
    end
end

function getitem(source, item)
    local player = QBCore.Functions.GetPlayer(source)
    if player then
        if Config.Inventory == "lj-inventory" then
            local itemInfo = player.Functions.GetItemByName(item)
            return itemInfo and itemInfo.count or 0
        elseif Config.Inventory == "lj-inventory" then
            return exports.ox_inventory:GetItemCount(source, item)
        elseif Config.Inventory == "lj-inventory" then
            return exports['lj-inventory']:GetItemTotalAmount(source, item)
        else
            -- Handle other inventory exports if needed
            return 0
        end
    else
        return 0
    end
end

function additem(source, name, count)
    local player = QBCore.Functions.GetPlayer(source)
    if player then
        if Config.Inventory == "lj-inventory" then
            player.Functions.AddItem(name, count)
        elseif Config.Inventory == "lj-inventory" then
            exports.ox_inventory:AddItem(source, name, count)
        elseif Config.Inventory == "lj-inventory" then
            exports['lj-inventory']:AddItem(source, name, count)
        else
            -- Handle other inventory exports if needed
        end
    end
end
