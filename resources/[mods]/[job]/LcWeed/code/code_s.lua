QBCore = exports['qb-core']:GetCoreObject()
function UseItem(source) 
    -- if getitem(source, Config.Items["Seed"]) >= 1 then 
    if true then
        removeitem(source, Config.Items["Seed"], 1)
        TriggerClientEvent("LcWeed:Seed", source)
        -- sendToDiscord(Config.Webhook, source, "Seed Planted! ", "\n" .. GetPlayerName(source) .. "(" .. source .. ") \n\n**Seed Type : **" .. Config.Items["Seed"], 15158332)
    end
end

RegisterNetEvent("LcWeed:giveSV")
AddEventHandler("LcWeed:giveSV", function (menu, id)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if id == "Water" then
        if Player.Functions.GetItemByName('pistol_ammo') then
            Player.Functions.RemoveItem(Config.Items["Water"], 1)
            TriggerClientEvent("LcWeed:giveCl", src, menu, id)
        else
            Player.Functions.Notify('Bạn không có nước')
        end
    elseif id == "Fertilizer" then 
        if Player.Functions.GetItemByName(Config.Items["Fertilizer"]) then 
            Player.Functions.RemoveItem(Config.Items["Fertilizer"], 1)
            TriggerClientEvent("LcWeed:giveCl", src, menu, id)
        else
            Player.Functions.Notify('Bạn không có phân bón')
        end
    elseif id == "Dust" then 
        if Player.Functions.GetItemByName(Config.Items["Dust"]) then 
            Player.Functions.RemoveItem(Config.Items["Dust"], 1)
            TriggerClientEvent("LcWeed:giveCl", src, menu, id)
        else
            Player.Functions.Notify('Bạn không có thuốc tăng trưởng')
        end
    end
end)

RegisterNetEvent("LcWeed:Harvest")
AddEventHandler("LcWeed:Harvest", function (weed)
    local src = source
    additem(src, Config.Items["Weed"], weed)
end)
