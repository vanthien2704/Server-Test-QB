local QBCore = exports['qb-core']:GetCoreObject()

local allEvents = {
    ["d-ngheban:sv:RewardTromDongHo"] = false,
    ["d-ngheban:sv:RewardTromBienBao"] = false,
    ["d-ngheban:sv:RewardRuaTien"] = false,
    ["d-ngheban:sv:RewardRaBienBao"] = false,
}
-- TRỘM ĐỒNG HỒ

local CoolDownDongHo = 0
RegisterNetEvent('d-ngheban:sv:thatbaiDongho', function()
    CoolDownDongHo = 0
end)


RegisterNetEvent('d-ngheban:sv:StartTromDongHo', function()
    local src = source
    if CoolDownDongHo <= 0 then
        TriggerClientEvent('d-ngheban:cl:StartTromDongHo', src)
        CoolDownDongHo = 6 * 60
    else
        TriggerClientEvent("QBCore:Notify", src, "Vừa xảy ra 1 vụ trộm đồng hồ vui lòng thử lại sau " .. CoolDownDongHo .. " giây!", "error")
    end
end)

RegisterNetEvent('d-ngheban:sv:RewardTromDongHo', function()
	local src = source
    -- if not exports[fiveguard_resource]:VerifyToken(src) then return end -- BẬT NẾU SÀI FIVEGUARD
	local Player = QBCore.Functions.GetPlayer(src)
	local amount = 1
    local item
    if math.random() <= 0.6 then
        item = 'dong_xu'
        amount = 7
    else
        item = 'the_nha'
    end
	if Player.Functions.AddItem(item, amount) then
		TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[item], "add", amount)
		TriggerClientEvent("QBCore:Notify", src, "Bạn vừa nhận được " .. amount .. "x [" .. QBCore.Shared.Items[item].label .. "]", "success")
	else
		TriggerClientEvent("QBCore:Notify", src, "Túi đồ của bạn quá đầy!", "error")
	end

    TriggerEvent('qb-log:server:CreateLog', 'log_cuop', '**TRỘM ĐỒNG HỒ**', 'orange',
    '\n- **Tên Nhân Vật:** ' .. Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname ..
    '\n- **CID:** ' .. Player.PlayerData.citizenid ..
    '\n- **ID Hiện Tại:** ' .. Player.PlayerData.source ..
    '\n- **Vị Trí:** ' .. GetEntityCoords(GetPlayerPed(src)) ..
    '\n- **Nhận Được:** ' .. amount .. 'x [' .. QBCore.Shared.Items[item].label .. ']', false)
end)

-- TRỘM BIỂN BÁO

local CoolDownBienBao = 0
RegisterNetEvent('d-ngheban:sv:thatbaiBienbao', function()
    CoolDownBienBao = 0
end)
RegisterNetEvent('d-ngheban:sv:StartTromBienBao', function()
    local src = source
    if CoolDownBienBao <= 0 then
        TriggerClientEvent('d-ngheban:cl:StartTromBienBao', src)
        CoolDownBienBao = 5 * 60
    else
        TriggerClientEvent("QBCore:Notify", src, "Vừa xảy ra 1 vụ trộm biển báo vui lòng thử lại sau " .. CoolDownBienBao .. " giây!", "error")
    end
end)

CreateThread(function()
    while true do
        if CoolDownBienBao > 0 then
            CoolDownBienBao = CoolDownBienBao - 1
        end
        if CoolDownDongHo > 0 then
            CoolDownDongHo = CoolDownDongHo - 1
        end
        Wait(1000)
    end
end)

RegisterNetEvent('d-ngheban:sv:RewardTromBienBao', function()
	local src = source
    -- if not exports[fiveguard_resource]:VerifyToken(src) then return end -- BẬT NẾU SÀI FIVEGUARD
	local Player = QBCore.Functions.GetPlayer(src)
	local amount = 1
	if Player.Functions.AddItem('bien_bao', amount) then
		TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['bien_bao'], "add", amount)
		TriggerClientEvent("QBCore:Notify", src, "Bạn vừa nhận được " .. amount .. "x [" .. QBCore.Shared.Items['bien_bao'].label .. "]", "success")
	else
		TriggerClientEvent("QBCore:Notify", src, "Túi đồ của bạn quá đầy!", "error")
	end

    TriggerEvent('qb-log:server:CreateLog', 'log_cuop', '**TRỘM BIỂN BÁO**', 'orange',
    '\n- **Tên Nhân Vật:** ' .. Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname ..
    '\n- **CID:** ' .. Player.PlayerData.citizenid ..
    '\n- **ID Hiện Tại:** ' .. Player.PlayerData.source ..
    '\n- **Vị Trí:** ' .. GetEntityCoords(GetPlayerPed(src)) ..
    '\n- **Nhận Được:** 1x [' .. QBCore.Shared.Items['bien_bao'].label .. ']', false)
end)

-- RỬA TIỀN

QBCore.Functions.CreateCallback('d-ngheban:sv:CheckTienBan', function(source, cb)
    local src = source
    local amount = 0
    local Player = QBCore.Functions.GetPlayer(src)

    for slot, data in pairs(Player.PlayerData.items) do
        if data ~= nil then
            if data.name == item then
                amount = amount + data.amount
                Player.Functions.RemoveItem(item, data.amount, slot)
            end
        end
    end

    cb(amount)
end)

QBCore.Functions.CreateCallback('d-ngheban:sv:GetCoordRuaTien', function(source, cb)
    local coords = vector3(-1175.85, -1547.76, 17.33)
    cb(coords)
end)

RegisterNetEvent('d-ngheban:sv:RewardRuaTien', function()
	local src = source
    -- if not exports[fiveguard_resource]:VerifyToken(src) then return end -- BẬT NẾU SÀI FIVEGUARD
	local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem('dong_xu', 10) then
       Player.Functions.AddItem('cuon_tien_ban', 1)
       TriggerClientEvent('QBCore:Notify', src, 'Mày đã rửa 10 đồng xu ra 1 cuộn tiền bẩn', "success")
    else
        TriggerClientEvent("QBCore:Notify", src, 'Bạn không có đủ: [' .. QBCore.Shared.Items['dong_xu'].label .. ']!', "error")
    end

    TriggerEvent('qb-log:server:CreateLog', 'log_cuop', '**RỬA TIỀN**', 'orange',
    '\n- **Tên Nhân Vật:** ' .. Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname ..
    '\n- **CID:** ' .. Player.PlayerData.citizenid ..
    '\n- **ID Hiện Tại:** ' .. Player.PlayerData.source ..
    '\n- **Vị Trí:** ' .. GetEntityCoords(GetPlayerPed(src)), false)
end)

-- RÃ BIỂN BÁO

QBCore.Functions.CreateCallback('d-ngheban:sv:GetCoordRaBienBao', function(source, cb)
    local coords = vector4(1126.78, -980.07, 45.42, 188.14)
    cb(coords)
end)

RegisterNetEvent('d-ngheban:sv:RewardRaBienBao', function()
    local src = source
    -- if not exports[fiveguard_resource]:VerifyToken(src) then return end -- BẬT NẾU SÀI FIVEGUARD
    local amount = 5
	local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem('bien_bao', 1) then
        if Player.Functions.AddItem('dong_xu', amount) then
            TriggerClientEvent("QBCore:Notify", src, 'Bạn vừa rã 1x [Biển Báo] và nhận được: ' .. amount .. 'x [' .. QBCore.Shared.Items['dong_xu'].label .. ']', "success")
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['dong_xu'], "add", amount)
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['bien_bao'], "remove", 1)
        else
            Player.Functions.AddItem('bien_bao', am1ount)
            TriggerClientEvent("QBCore:Notify", src, "Túi đồ của bạn quá đầy!", "error")
        end
    else
        TriggerClientEvent("QBCore:Notify", src, 'Bạn không có đủ: [' .. QBCore.Shared.Items['bien_bao'].label .. ']!', "error")
    end

    TriggerEvent('qb-log:server:CreateLog', 'log_cuop', '**RÃ BIỂN BÁO**', 'orange',
    '\n- **Tên Nhân Vật:** ' .. Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname ..
    '\n- **CID:** ' .. Player.PlayerData.citizenid ..
    '\n- **ID Hiện Tại:** ' .. Player.PlayerData.source ..
    '\n- **Vị Trí:** ' .. GetEntityCoords(GetPlayerPed(src)), false)
end)