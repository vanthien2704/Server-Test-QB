local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData()
local config = Config
local speedMultiplier = config.UseMPH and 2.23694 or 3.6
local stress = 0
local hunger = 100
local thirst = 100
local oxygen = 100
local w = 0

local CAM_HEIGHT = 0.2 -- decimal of screen height, where 1.0 is 100% and 0.0 is 0%
local camActive = false
local camMoving = false
local camHeight = 0.0

local display = true
local check_map = false

local function hideHUDComponents()
    for i = 0, 22 do
        if IsHudComponentActive(i) then
            HideHudComponentThisFrame(i)
        end
    end
end

local function setupHealthArmour(minimap, barType)
    BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
    ScaleformMovieMethodAddParamInt(barType)
    EndScaleformMovieMethod()
end

local function handleCinmetaicAnim() -- [[Handles Displaying Radar, Body Armour and the rects themselves.]]
    camMoving = true

    DisplayRadar(not camActive)
    setupHealthArmour(camActive and 3 or 0)

    if camActive then
        for i = 0, CAM_HEIGHT, 0.01 do
            camHeight = i

            Wait(10)
        end
    else
        for i = CAM_HEIGHT, 0, -0.01 do
            camHeight = i

            Wait(10)
        end
    end

    camMoving = false
end

local function loadSettings()
    QBCore.Functions.Notify(Lang:t("notify.hud_settings_loaded"), "success")
    Wait(1000)
    TriggerEvent("hud:client:LoadMap")
end

RegisterNetEvent("hud:client:LoadMap", function()
    Wait(500)
    -- Credit to Dalrae for the solve.
    local defaultAspectRatio = 1920/1080 -- Don't change this.
    local resolutionX, resolutionY = GetActiveScreenResolution()
    local aspectRatio = resolutionX/resolutionY
    local minimapOffset = 0
    if aspectRatio > defaultAspectRatio then
        minimapOffset = ((defaultAspectRatio-aspectRatio)/3.6)-0.008
    end
        RequestStreamedTextureDict("squaremap", false)
        if not HasStreamedTextureDictLoaded("squaremap") then
            Wait(150)
        end
        SetMinimapClipType(0)
        AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "squaremap", "radarmasksm")
        AddReplaceTexture("platform:/textures/graphics", "radarmask1g", "squaremap", "radarmasksm")
        -- 0.0 = nav symbol and icons left
        -- 0.1638 = nav symbol and icons stretched
        -- 0.216 = nav symbol and icons raised up
        SetMinimapComponentPosition("minimap", "L", "B", 0.0 + minimapOffset, -0.047, 0.1638, 0.183)

        -- icons within map
        SetMinimapComponentPosition("minimap_mask", "L", "B", 0.0 + minimapOffset, 0.0, 0.128, 0.20)

        -- -0.01 = map pulled left
        -- 0.025 = map raised up
        -- 0.262 = map stretched
        -- 0.315 = map shorten
        SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.01 + minimapOffset, 0.025, 0.262, 0.300)
        SetBlipAlpha(GetNorthRadarBlip(), 0)
        SetRadarBigmapEnabled(true, false)
        SetMinimapClipType(0)
        Wait(50)
        SetRadarBigmapEnabled(false, false)
        Wait(1200)
end)

RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
    PlayerData = QBCore.Functions.GetPlayerData()
    Wait(1000)
    DisplayRadar(true)
    loadSettings()
    Wait(1000)
end)

RegisterNetEvent("QBCore:Client:OnPlayerUnload", function()
    PlayerData = {}
end)

RegisterNetEvent("QBCore:Player:SetPlayerData", function(val)
    PlayerData = val
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    Wait(1000)
    loadSettings()
    Wait(1000)
end)

CreateThread(function()
    while true do
        SetRadarBigmapEnabled(false, false)
        SetRadarZoom(1000)
        Wait(500)
    end
end)

RegisterNetEvent('hud:client:UpdateNeeds', function(newHunger, newThirst)
    hunger = newHunger
    thirst = newThirst
    if hunger >= 100 then hunger = 100 end
    if thirst >= 100 then thirst = 100 end
end)
RegisterNetEvent('hud:client:UpdateStress', function(newStress)
    stress = newStress
    if stress >= 100 then stress = 100 end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(200)
        local playerPed = GetPlayerPed(-1)
        local playerArmor = GetPedArmour(playerPed)
        local playerhealth = GetEntityHealth(GetPlayerPed(-1))
        local oxygen = GetPlayerUnderwaterTimeRemaining(PlayerId()) * 10
        if oxygen <= 0 then oxygen = 0 end
        if oxygen >= 100 then oxygen = 100 end
        SendNUIMessage({
            -- show = IsPauseMenuActive() == false and display or false,
            show = LocalPlayer.state.isLoggedIn and display or false,
            my_id = GetPlayerServerId(PlayerId()),
            maxhealth = GetEntityMaxHealth(GetPlayerPed(-1)),
            health = playerhealth - 100,
            stamina = 100 - GetPlayerSprintStaminaRemaining(PlayerId()),
            myhunger = hunger,
            mywater  = thirst,
            mybrain  = stress,
            armor = playerArmor,
            myoxy = oxygen,
        })
        
    end
end)

if not config.DisableStress then
    CreateThread(function() -- Speeding
        while true do
            if LocalPlayer.state.isLoggedIn then
                local ped = PlayerPedId()
                if IsPedInAnyVehicle(ped, false) then
                    local veh = GetVehiclePedIsIn(ped, false)
                    local vehClass = GetVehicleClass(veh)
                    local speed = GetEntitySpeed(veh) * speedMultiplier
                    local vehHash = GetEntityModel(veh)
                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)

                    if config.VehClassStress[tostring(vehClass)] and not config.WhitelistedVehicles[vehHash] then
                        local stressSpeed
                        if vehClass == 8 then -- Motorcycle exception for seatbelt
                            stressSpeed = config.MinimumSpeed
                        else
                            stressSpeed = seatbeltOn and config.MinimumSpeed or config.MinimumSpeedUnbuckled
                        end
                        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
                            if HasItem then
                                if speed >= stressSpeed then
                                    TriggerServerEvent('hud:server:GainStress', math.random(1, 3))
                                end
                            else
                                if speed >= stressSpeed then
                                    if GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
                                        TriggerServerEvent('hud:server:GainStress', math.random(4, 6))
                                        QBCore.Functions.Notify("Bạn đang ngồi trên ghế lại và không mang theo Bằng lái xe nên căng thẳng sẽ tăng cao hơn", "warning")
                                    else
                                        TriggerServerEvent('hud:server:GainStress', math.random(1, 3))
                                    end
                                end
                            end
                        end, "driver_license")
                    end
                end
            end
            Wait(10000)
        end
    end)

    CreateThread(function() -- Shooting
        while true do
            if LocalPlayer.state.isLoggedIn then
                local ped = PlayerPedId()
                local weapon = GetSelectedPedWeapon(ped)
                if weapon ~= `WEAPON_UNARMED` then
                    if IsPedShooting(ped) and not config.WhitelistedWeaponStress[weapon] then
                        if math.random() < config.StressChance then
                            TriggerServerEvent('hud:server:GainStress', math.random(1, 3))
                        end
                    end
                else
                    Wait(1000)
                end
            end
            Wait(0)
        end
    end)
end

--Stress Screen Effects

local function GetBlurIntensity(stresslevel)
    for _, v in pairs(config.Intensity['blur']) do
        if stresslevel >= v.min and stresslevel <= v.max then
            return v.intensity
        end
    end
    return 1500
end

local function GetEffectInterval(stresslevel)
    for _, v in pairs(config.EffectInterval) do
        if stresslevel >= v.min and stresslevel <= v.max then
            return v.timeout
        end
    end
    return 60000
end

CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local effectInterval = GetEffectInterval(stress)
        if stress >= 100 then
            local BlurIntensity = GetBlurIntensity(stress)
            local FallRepeat = math.random(2, 4)
            local RagdollTimeout = FallRepeat * 1750
            TriggerScreenblurFadeIn(1000.0)
            Wait(BlurIntensity)
            TriggerScreenblurFadeOut(1000.0)

            if not IsPedRagdoll(ped) and IsPedOnFoot(ped) and not IsPedSwimming(ped) then
                SetPedToRagdollWithFall(ped, RagdollTimeout, RagdollTimeout, 1, GetEntityForwardVector(ped), 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
            end

            Wait(1000)
            for _ = 1, FallRepeat, 1 do
                Wait(750)
                DoScreenFadeOut(200)
                Wait(1000)
                DoScreenFadeIn(200)
                TriggerScreenblurFadeIn(1000.0)
                Wait(BlurIntensity)
                TriggerScreenblurFadeOut(1000.0)
            end
        elseif stress >= config.MinimumStress then
            local BlurIntensity = GetBlurIntensity(stress)
            TriggerScreenblurFadeIn(1000.0)
            Wait(BlurIntensity)
            TriggerScreenblurFadeOut(1000.0)
        end
        Wait(effectInterval)
    end
end)

RegisterCommand('hud', function()
    TriggerEvent("dt-statushud:client:menu_hud")
end, false)

RegisterNetEvent("dt-statushud:client:menu_hud")
AddEventHandler("dt-statushud:client:menu_hud", function()
    exports['qb-menu']:openMenu({
        {
            header = "ĐIỀU CHỈNH HUD",
            isMenuHeader = true,
        },
        {
            id = 1,
            header = "HUD",
            icon = "fas fa-signal",
            txt = "[BẬT/TẮT] Giao diện HUD",
            params = {
                event = "dt-statushud:client:hide_hud",
            }
        },
        {
            id = 2,
            header = "Bản đồ nhỏ",
            icon = "fas fa-map",
            txt = "[BẬT/TẮT] Bản đồ nhỏ",
            params = {
                event = "dt-statushud:client:bando_nho",
            }
        },
        {
            id = 3,
            header = "Chế độ điện ảnh",
            icon = "fas fa-camera",
            txt = "[BẬT/TẮT] Chế độ điện ảnh",
            params = {
                event = "dt-statushud:client:chedo_dienanh",
            }
        },
        {
            id = 4,
            header = "Hẹn gặp lại dịp khác",
            txt = "",
            params = {
                event = "qb-menu:client:closeMenu",
            }
        },
    })
end)

RegisterNetEvent("dt-statushud:client:chedo_dienanh")
AddEventHandler("dt-statushud:client:chedo_dienanh", function()
    if IsPauseMenuActive() then
        return
    end

    if camMoving then
        return
    end

    camActive = not camActive

    CreateThread(handleCinmetaicAnim)

    while camHeight > 0.0 or camActive do
        for i = 0, 1.0, 1.0 do
            DrawRect(0.0, 0.0, 2.0, camHeight, 0, 0, 0, 255)
            DrawRect(0.0, i, 2.0, camHeight, 0, 0, 0, 255)
        end

        hideHUDComponents()

        Wait(0)
    end
end)

RegisterNetEvent("dt-statushud:client:hide_hud")
AddEventHandler("dt-statushud:client:hide_hud", function()
    display = not display
    SendNUIMessage({
        show = display
    })
end)

RegisterNetEvent("dt-statushud:client:bando_nho")
AddEventHandler("dt-statushud:client:bando_nho", function()
    check_map = not check_map
    if check_map == false then
        DisplayRadar(false)
    else
        -- TriggerEvent("hud:client:LoadMap")
        DisplayRadar(true)    
    end
end)