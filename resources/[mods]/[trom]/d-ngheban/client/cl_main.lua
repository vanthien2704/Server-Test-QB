local QBCore = exports['qb-core']:GetCoreObject()
local isTromDongHo = false
local isTromBienBao = false
local isRuaTien = false
local isRaBienBao = false
local inCuopZone = false
local CurrentCops = 0

local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(1)
    end
end

-- TRỘM ĐỒNG HỒ

local function LockPickDongHo(success)
    local ped = PlayerPedId()
    if success then
        TriggerServerEvent('police:server:policeAlert', 'TRỘM ĐỒNG HỒ')
        isTromDongHo = true
        QBCore.Functions.Progressbar('trom_dong_ho', 'Đang Trộm Đồng Hồ', 1200, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true
        }, {}, {}, {}, function()
            isTromDongHo = false
            StopAnimTask(ped, 'missheistfbisetup1', 'hassle_intro_loop_f', 1.0)
            TriggerServerEvent('d-ngheban:sv:RewardTromDongHo') -- BẬT NẾU KHÔNG SÀI FIVEGUARD
            -- exports["tC-mapmisc"]:ExecuteServerEvent("d-ngheban:sv:RewardTromDongHo") -- BẬT NẾU SÀI FIVEGUARD
            TriggerServerEvent('hud:server:GainStress', 50)
        end, function()
            isTromDongHo = false
            StopAnimTask(ped, 'missheistfbisetup1', 'hassle_intro_loop_f', 1.0)
            TriggerServerEvent('hud:server:GainStress', 10)
            QBCore.Functions.Notify('Đã hủy!', 'error')
        end)
    else
        StopAnimTask(ped, 'missheistfbisetup1', 'hassle_intro_loop_f', 1.0)
        TriggerServerEvent('hud:server:GainStress', 10)
        TriggerServerEvent('d-ngheban:sv:thatbaiDongho')
        QBCore.Functions.Notify('Bạn đã thất bại!', 'error')
    end
end

local function TromDongHo()
    local hasItem = QBCore.Functions.HasItem('lockpick')
    if hasItem then
        if CurrentCops < 0 then return QBCore.Functions.Notify('Không đủ cảnh sát trong ca trực!', 'error') end
        TriggerServerEvent('d-ngheban:sv:StartTromDongHo')
    else
        QBCore.Functions.Notify('Bạn cần phải có [' .. QBCore.Shared.Items['lockpick'].label .. '] để trộm đồng hồ!', 'error')
    end
end

RegisterNetEvent('d-ngheban:cl:StartTromDongHo', function()
    local ped = PlayerPedId()
    loadAnimDict('missheistfbisetup1')
    TaskPlayAnim(ped, 'missheistfbisetup1', 'hassle_intro_loop_f', -8.0, -8.0, -1, 1, 0, 0, 0, 0)
    TriggerServerEvent('tC-nghesach:sv:DoBen', 'lockpick', 20)
    TriggerEvent('qb-lockpick:client:openLockpick', LockPickDongHo)
end)

-- TRỘM BIỂN BÁO

local function TromBienBao()
    local hasItem = QBCore.Functions.HasItem('lockpick')
    if hasItem then
        if CurrentCops < 0 then return QBCore.Functions.Notify('Không đủ cảnh sát trong ca trực!', 'error') end
        TriggerServerEvent('d-ngheban:sv:StartTromBienBao')
    else
        QBCore.Functions.Notify('Bạn cần phải có [' .. QBCore.Shared.Items['lockpick'].label .. '] để trộm đồng hồ!', 'error')
    end 
end

RegisterNetEvent('d-ngheban:cl:StartTromBienBao', function()
    TriggerEvent('qb-lockpick:client:openLockpick', function(success)
        print(success)
        if success then
            TriggerServerEvent('tC-nghesach:sv:DoBen', 'lockpick', 20)
            TriggerServerEvent('police:server:policeAlert', 'TRỘM BIỂN BÁO')
            isTromBienBao = true
            loadAnimDict('amb@prop_human_bum_bin@base')
            TaskPlayAnim(ped, 'amb@prop_human_bum_bin@base', 'base', -8.0, -8.0, -1, 1, 0, 0, 0, 0)
            QBCore.Functions.Progressbar('trom_bien_bao', 'Đang Trộm Biển Báo', 900, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true
            }, {}, {}, {}, function()
                isTromBienBao = false
                StopAnimTask(ped, 'amb@prop_human_bum_bin@base', 'base', 1.0)
                TriggerServerEvent('hud:server:GainStress', 50)
                TriggerServerEvent('d-ngheban:sv:RewardTromBienBao') -- BẬT NẾU KHÔNG SÀI FIVEGUARD
            end, function()
                isTromBienBao = false
                StopAnimTask(ped, 'amb@prop_human_bum_bin@base', 'base', 1.0)
                TriggerServerEvent('hud:server:GainStress', 10)
                QBCore.Functions.Notify('Đã hủy!', 'error')
            end)
        else
            TriggerServerEvent('d-ngheban:sv:thatbaiBienbao')
        end
    end)
    
    
end)

-- RỬA TIỀN

local function RuaTien()
    local ped = PlayerPedId()
    if CurrentCops < 5 then return QBCore.Functions.Notify('Không đủ cảnh sát trong ca trực!', 'error') end
    local ped = PlayerPedId()
    local hasItem = QBCore.Functions.HasItem('dong_xu')
    if hasItem then
        isRuaTien = true
        loadAnimDict('amb@prop_human_bum_bin@base')
        TaskPlayAnim(ped, 'amb@prop_human_bum_bin@base', 'base', -8.0, -8.0, -1, 1, 0, 0, 0, 0)
        QBCore.Functions.Progressbar('trom_bien_bao', 'Đang Rửa Tiền', 60000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true
        }, {}, {}, {}, function()
            isRuaTien = false
            StopAnimTask(ped, 'amb@prop_human_bum_bin@base', 'base', 1.0)
            TriggerServerEvent('hud:server:GainStress', 15)
            TriggerServerEvent('d-ngheban:sv:RewardRuaTien') -- BẬT NẾU KHÔNG SÀI FIVEGUARD
            -- exports["tC-mapmisc"]:ExecuteServerEvent("d-ngheban:sv:RewardRuaTien") -- BẬT NẾU SÀI FIVEGUARD
        end, function()
            isRuaTien = false
            StopAnimTask(ped, 'amb@prop_human_bum_bin@base', 'base', 1.0)
            TriggerServerEvent('hud:server:GainStress', 10)
            QBCore.Functions.Notify('Đã hủy!', 'error')
        end)
    else
        QBCore.Functions.Notify('Bạn cần phải có [' .. QBCore.Shared.Items['dong_xu'].label .. '] để rửa tiền!', 'error')
    end
end

-- RÃ BIỂN BÁO

local function RaBienBao()
    local ped = PlayerPedId()
    local hasItem = QBCore.Functions.HasItem('bien_bao')
    if hasItem then
        if not isRaBienBao then
            isRaBienBao = true
            loadAnimDict("mp_common")
            TaskPlayAnim(ped, "mp_common", "givetake1_b", -8.0, -8.0, -1, 1, 0, 0, 0, 0)
            QBCore.Functions.Progressbar("ra_bien_bao", "Đang Rã Biển Báo", 15 * 1000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function()
                isRaBienBao = false
                StopAnimTask(ped, "mp_common", "givetake1_b", 1.0)
                TriggerServerEvent('hud:server:GainStress', 15)
                TriggerServerEvent('d-ngheban:sv:RewardRaBienBao') -- BẬT NẾU KHÔNG SÀI FIVEGUARD
                -- exports["tC-mapmisc"]:ExecuteServerEvent("d-ngheban:sv:RewardRaBienBao") -- BẬT NẾU SÀI FIVEGUARD
            end, function()
                isRaBienBao = false
                StopAnimTask(ped, "mp_common", "givetake1_b", 1.0)
                TriggerServerEvent('hud:server:GainStress', 10)
                QBCore.Functions.Notify('Đã hủy!', 'error')
            end)
        else
            QBCore.Functions.Notify('Vội cái hand thế bro!', 'error')
        end
    else
        QBCore.Functions.Notify('Có cái gì đâu mà rã!', 'error')
    end
end

RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

local PropsDongHo = { 'prop_parknmeter_01', 'prop_parknmeter_02' }
local PropsBienBao = { 'prop_sign_road_01a', 'prop_sign_road_05a', 'prop_sign_road_03e', 'prop_sign_road_03m', 'prop_sign_road_04a', 'prop_sign_road_05e', 'prop_sign_road_05f', 'prop_sign_road_restriction_10', 'prop_sign_road_02a' }
local Zone = {
    [1] = {
        points = {
            vector2(243.76, -574.99),
            vector2(248.63604736328, -1143.1447753906),
            vector2(10.233454704285, -1153.4796142578),
            vector2(131.7091217041, -782.44750976563)
        },
        minZ = 28.75066947937,
        maxZ = 31.301898956299
    },
}

CreateThread(function()
    exports['qb-target']:AddTargetModel(PropsDongHo, {
        options = {
            {
                icon = 'fas fa-circle',
                label = 'Trộm Đồng Hồ',
                -- item = 'advancedlockpick',
                action = function()
                    TromDongHo()
                end,
                canInteract = function()
                    return ((not isTromDongHo) and inCuopZone)
                end,
            }
        },
        distance = 2.0,
    })
    exports['qb-target']:AddTargetModel(PropsBienBao, {
        options = {
            {
                icon = 'fas fa-circle',
                label = 'Trộm Biển Báo',
                item = 'lockpick',
                action = function()
                    TromBienBao()
                end,
                canInteract = function()
                    return ((not isTromBienBao) and inCuopZone)
                end,
            }
        },
        distance = 2.0,
    })

    QBCore.Functions.TriggerCallback('d-ngheban:sv:GetCoordRuaTien', function(coords)
        exports['qb-target']:AddBoxZone('rua_tien', coords, 1, 1, {
            name = 'rua_tien',
            heading = 0,
            debugPoly = false,
            minZ = coords.z - 2,
            maxZ = coords.z + 2,
        }, {
            options = {
                {
                    icon = 'fas fa-circle',
                    label = 'Nói Chuyện',
                    item = 'dong_xu',
                    action = function()
                        RuaTien()
                    end,
                    canInteract = function()
                        return not isRuaTien
                    end,
                }
            },
            distance = 2.5
        })
    end)

    QBCore.Functions.TriggerCallback('d-ngheban:sv:GetCoordRaBienBao', function(coords)
        modelped = GetHashKey("a_m_m_salton_03")
        RequestModel(modelped)
        while not HasModelLoaded(modelped) do
            Wait(1)
        end

        ped = CreatePed(0, modelped, coords.x, coords.y, coords.z - 1, coords.w, false, true)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)

        exports['qb-target']:AddBoxZone("ra_bien_bao", vector3(coords.x, coords.y, coords.z), 1, 1, {
            name = "ra_bien_bao",
            heading = 0,
            debugPoly = false,
            minZ= coords.z - 2,
            maxZ= coords.z + 2,
        }, {
            options = {
                {
                    type = "client",
                    icon = "fas fa-circle",
                    label = 'Rã Biển Báo',
                    action = function()
                        ()RaBienBao
                    end,
                    canInteract = function()
                        return not isRaBienBao
                    end,
                },
            },
            distance = 2.5
        })
    end)

    local CuopZone = {}
    for k, v in pairs(Zone) do
        CuopZone[#CuopZone+1] = PolyZone:Create(v.points, {
            name = 'CuopZone'..k,
            minZ = v.minZ,
            maxZ = v.maxZ,
            debugGrid = false,
        })
    end
    local CuopCombo = ComboZone:Create(CuopZone, {
        name = "CuopCombo", 
        debugPoly = false
    })
    CuopCombo:onPlayerInOut(function(isPointInside, point, zone)
        if isPointInside then
            inCuopZone = true
        else
            inCuopZone = false
        end
    end)
end)