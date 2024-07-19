local QBCore = exports['qb-core']:GetCoreObject()
local Bail = {}

QBCore.Functions.CreateCallback('dt-cauca:server:can:pay', function(source, cb, price)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.RemoveMoney("cash", price, "boat-price") then
        cb(true)
    else 
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('dt-cauca:server:HasMoney', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local CitizenId = Player.PlayerData.citizenid

    if Player.PlayerData.money.cash >= Config.BailPrice then
        Bail[CitizenId] = "cash"
        Player.Functions.RemoveMoney('cash', Config.BailPrice)
        cb(true)
    elseif Player.PlayerData.money.bank >= Config.BailPrice then
        Bail[CitizenId] = "bank"
        Player.Functions.RemoveMoney('bank', Config.BailPrice)
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('dt-cauca:server:CheckBail', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local CitizenId = Player.PlayerData.citizenid

    if Bail[CitizenId] ~= nil then
        Player.Functions.AddMoney(Bail[CitizenId], Config.BailPrice, 'dt-cauca:server:CheckBail')
        Bail[CitizenId] = nil
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('dt-cauca:server:can:pay', function(source, cb, price)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.RemoveMoney("cash", price, "boat-price") then
        cb(true)
    else 
        cb(false)
    end
end)

QBCore.Functions.CreateCallback("dt-cauca:receiveFish", function(source, callback, rewardtype)
	 local player = QBCore.Functions.GetPlayer(source)
	if not player then return callback(false) end

	player.Functions.AddItem(rewardtype, 1)
	TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[""..rewardtype..""], "add")
	TriggerClientEvent('QBCore:Notify', source, "Đã câu được " .. rewardtype .. "")
	callback(true)
end)

QBCore.Functions.CreateCallback('dt-cauca:GetItemData', function(source, cb, itemName)
	local retval = false
	local Player = QBCore.Functions.GetPlayer(source)
	if Player ~= nil then 
		if Player.Functions.GetItemByName(itemName) ~= nil then
			retval = true
		end
	end
	cb(retval)
end)

QBCore.Functions.CreateUseableItem("lockpick", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('dt-cauca:tryToFish', source, 'normal')
end)

RegisterServerEvent('dt-cauca:server:remove_moicau')
AddEventHandler('dt-cauca:server:remove_moicau', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem('pistol_ammo', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["pistol_ammo"], "remove")
end)

QBCore.Commands.Add('fixcauca', 'Sửa lỗi câu cá', {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('dt-cauca:fixloi_cauca', source)
end)