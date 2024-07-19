local QBCore = exports['qb-core']:GetCoreObject()
local Server_Price = Config.Price

local allEvents = {
    ["dt-chamsocthucung:server:Nhan_Corgi"] = false,
    ["dt-chamsocthucung:server:SellItem"] = false
}

-- local fiveguard_resource = "dt-fixitem"
-- AddEventHandler("fg:ExportsLoaded", function(fiveguard_res, res)
--     if res == "*" or res == GetCurrentResourceName() then
--         fiveguard_resource = fiveguard_res
--         for event,cross_scripts in pairs(allEvents) do
--             local retval, errorText = exports[fiveguard_res]:RegisterSafeEvent(event, {
--                 ban = true,
--                 log = true
--             }, cross_scripts)
--             if not retval then
--                 print("[fiveguard safe-events] "..errorText)
--             end
--         end
--     end
-- end)

QBCore.Functions.CreateCallback('dt-chamsocthucung:server:has:checkitem', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local _CheckItem = Player.Functions.GetItemByName("corgi")
	if _CheckItem ~= nil then
        if _CheckItem.amount >= 1 then
            cb(true)
		else
            cb(false)
		end
	   else
        cb(false)
	end
end)

for i =1, #Config.Feed, 1 do
    QBCore.Functions.CreateUseableItem(Config.Feed[i].item.use, function(source, item)
        local Player = QBCore.Functions.GetPlayer(source)
        TriggerClientEvent('dt-chamsocthucung:client:Start', source, Config.Feed[i])
    end)
end

RegisterNetEvent("dt-chamsocthucung:server:Nhan_Corgi")
AddEventHandler("dt-chamsocthucung:server:Nhan_Corgi", function(src)
    local src = source
    --if not exports[fiveguard_resource]:VerifyToken(src) then return end -- Bật nếu sử dụng Fiveguard
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.AddItem(Config.PhanThuong, Config.SoLuong)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.PhanThuong], "add")
    TriggerClientEvent('QBCore:Notify', src, 'Nhận được một chú Corgi trưởng thành', 'success', 3000)
end)

-- RegisterNetEvent("dt-chamsocthucung:server:giao_thucung")
-- AddEventHandler("dt-chamsocthucung:server:giao_thucung", function(Client_Price)
--     local src = source
--     -- if not exports[fiveguard_resource]:VerifyToken(src) then return end -- Bật nếu sử dụng Fiveguard
--     local Player = QBCore.Functions.GetPlayer(src)

--     Player.Functions.AddItem(Config.PhanThuong, Config.SoLuong)
--     TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.PhanThuong], "add")
--     TriggerClientEvent('QBCore:Notify', src, 'Nhận được một chú Corgi trưởng thành', 'success', 3000)
-- end)

RegisterNetEvent('dt-chamsocthucung:server:RemoveItem', function(ItemName, ItemAmount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.RemoveItem(ItemName, ItemAmount)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[ItemName], "remove", ItemAmount)
end)

--======================================== GIAO THÚ CƯNG ========================================
QBCore.Functions.CreateCallback("dt-chamsocthucung:server:GetPrice", function(source, cb)
    cb(Server_Price)
end)

CreateThread(function()
    while true do
        Wait(3000) 
        for k, v in pairs(Server_Price) do
            new_price = math.random(v.min_price, v.max_price)
            Server_Price[k] = {
                old_price = v.price, 
                price = new_price,
                min_price = v.min_price,
                max_price = v.max_price,
            }
        end
        TriggerClientEvent("dt-chamsocthucung:client:UpdatePrice", -1, Server_Price)
        Wait(Config._ResetTime * 60000) 
    end 
end)

RegisterNetEvent("dt-chamsocthucung:server:SellItem", function(item, amount, price)
    local src = source
    -- if not exports[fiveguard_resource]:VerifyToken(src) then return end -- Bật nếu sử dụng Fiveguard
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.RemoveItem(item, amount) then 
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item], 'remove')
        Player.Functions.AddMoney("bank", amount*price, "Giao thú cưng")

        TriggerEvent('qb-log:server:CreateLog', 'log_giaothu', '**GIAO CORGI**', 'lightgreen', 
        '\n- Tên nhân vật: `'..Player.PlayerData.charinfo.firstname..''..Player.PlayerData.charinfo.lastname..
        '`\n- CitizenID: `'..Player.PlayerData.citizenid..
        '`\n- ID hiện tại: `'..Player.PlayerData.source..
        '`\n- Đã giao: `'..QBCore.Shared.Items[item]["label"]..
        '`\n- Số lượng: `'..amount..
        '`\n- Giá: **'..amount*price..'**', false) -- True là tag @everyone
    else 
        TriggerClientEvent("QBCore:Notify", source, "Bạn không có Corgi để giao", "error")
    end
end)

RegisterNetEvent("dt-chamsocthucung:server:SellItemAll", function(item, price)
    local src = source
   -- if not exports[fiveguard_resource]:VerifyToken(src) then return end -- Bật nếu sử dụng Fiveguard
    local Player = QBCore.Functions.GetPlayer(source)
    local Item = Player.Functions.GetItemByName(item)
    if Item then 
        local Amount = Item.amount 
        if Player.Functions.RemoveItem(Item.name, Amount) then 
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Item.name], 'remove')
            Player.Functions.AddMoney("bank", Amount*price, "Giao thú cưng")

            TriggerEvent('qb-log:server:CreateLog', 'log_giaothu', '**GIAO CORGI**', 'lightgreen', 
            '\n- Tên nhân vật: `'..Player.PlayerData.charinfo.firstname..''..Player.PlayerData.charinfo.lastname..
            '`\n- CitizenID: `'..Player.PlayerData.citizenid..
            '`\n- ID hiện tại: `'..Player.PlayerData.source..
            '`\n- Đã giao: `'..QBCore.Shared.Items[item]["label"]..
            '`\n- Số lượng: `'..Amount..
            '`\n- Giá: **'..Amount*price..'**', false) -- True là tag @everyone
        else 
            TriggerClientEvent("QBCore:Notify", src, "Bạn không có Corgi để giao", "error")
        end
    end 
end)