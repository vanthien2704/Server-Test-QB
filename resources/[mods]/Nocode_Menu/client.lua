local QBCore = exports['qb-core']:GetCoreObject()

local blur = "MenuMGIn"

Citizen.CreateThread(function()
    while QBCore == nil do
        -- TriggerEvent('esx:getSharedObject', function(obj)ESX = obj end)
        Citizen.Wait(7)
    end
end)

RegisterKeyMapping(Config.Command, Config.Command, 'keyboard', Config.Key)

RegisterCommand(Config.Command, function()
    OpenMenu()
end)

function OpenMenu()
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'openUi',
    })
    StartScreenEffect(blur, 1, true)
end

RegisterNUICallback('action', function(data, cb)
    if data.action == 'close' then
        StopScreenEffect(blur)
        SetNuiFocus(false, false)
    elseif data.action == 'boostOn' then
        boostOn()
    elseif data.action == 'boostOff' then
        boostOff()
    elseif data.action == 'KillfeedOn' then
        TriggerEvent("codem_killfeed:Toggle", false)
    elseif data.action == 'KillfeedOff' then
        TriggerEvent("codem_killfeed:Toggle", true)
    elseif data.action == 'Chaton' then
       TriggerEvent('chat:hide')
    elseif data.action == 'Chatoff' then
        TriggerEvent('chat:show')
    elseif data.action == 'fashionOn' then
        fashionCheck = 'one'
    elseif data.action == 'otherFashionOn' then
        fashionCheck = 'two'
    elseif data.action == 'fashionOff' then
        fashionCheck = 'three'
    elseif data.action == 'effectOn' then
        effectCheck = 'one'
    elseif data.action == 'otherEffectOn' then
        effectCheck = 'two'
    elseif data.action == 'effectOff' then
        effectCheck = 'three'
    elseif data.action == 'bloodOn' then
        blood = true
    elseif data.action == 'bloodOff' then
        blood = false
    elseif data.action == 'EXTRASUNNY' then
        EXTRASUNNY()
    elseif data.action == 'RAIN' then
        RAIN()
    elseif data.action == 'OVERCAST' then
        OVERCAST()
    elseif data.action == 'THUNDER' then
        THUNDER()
    elseif data.action == 'FOGGY' then
        FOGGY()
    elseif data.action == 'SNOW' then
        SNOW()
    elseif data.action == 'XMAS' then
        XMAS()
    elseif data.action == 'HALLOWEEN' then
        HALLOWEEN()
    elseif data.action == 'NEUTRAL' then
        NEUTRAL()
    elseif data.action == 'morning' then
        morning()
    elseif data.action == 'afternoon' then
        afternoon()
    elseif data.action == 'evening' then
        evening()
    elseif data.action == 'night' then
        night()
    end
end)

function boostOn()
    SetTimecycleModifier('yell_tunnel_nodirect')
end

function boostOff()
    SetTimecycleModifier()
    ClearTimecycleModifier()
    ClearExtraTimecycleModifier()
end

Citizen.CreateThread(function()
    while true do
        Wait(500)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local players = GetActivePlayers()
        if fashionCheck == 'one' then
            for i, v in ipairs(Config.Fashion) do
                local objectId = GetClosestObjectOfType(playerCoords, 100.0, GetHashKey(v), false)
                if DoesEntityExist(objectId) then
                    if objectId ~= PlayerPedId() then
                        SetEntityVisible(objectId, false)
                    end
                end
            end
            for i, v in ipairs(Config.Fashion) do
                local closestObjectDistance = 100.0
                local closestObjectId = 0

                for _, player in ipairs(players) do
                    if player ~= PlayerId() then
                        local ped = GetPlayerPed(player)
                        local pedCoords = GetEntityCoords(ped)
                        local distance = GetDistanceBetweenCoords(playerCoords, pedCoords, true)

                        local objectId = GetClosestObjectOfType(pedCoords, 20.0, GetHashKey(v), false)
                        if DoesEntityExist(objectId) and distance < closestObjectDistance then
                            closestObjectDistance = distance
                            closestObjectId = objectId
                        end
                    end
                end

                if closestObjectId ~= 0 then
                    SetEntityVisible(closestObjectId, false)
                end
            end
        elseif fashionCheck == 'two' then
            for i, v in ipairs(Config.Fashion) do
                local objectId = GetClosestObjectOfType(playerCoords, 20.0, GetHashKey(v), false)
                if DoesEntityExist(objectId) then
                    if objectId ~= PlayerPedId() then
                        SetEntityVisible(objectId, true)
                    end
                end
            end
            for i, v in ipairs(Config.Fashion) do
                local closestObjectDistance = 100.0
                local closestObjectId = 0

                for _, player in ipairs(players) do
                    if player ~= PlayerId() then
                        local ped = GetPlayerPed(player)
                        local pedCoords = GetEntityCoords(ped)
                        local distance = GetDistanceBetweenCoords(playerCoords, pedCoords, true)

                        local objectId = GetClosestObjectOfType(pedCoords, 20.0, GetHashKey(v), false)
                        if DoesEntityExist(objectId) and distance < closestObjectDistance then
                            closestObjectDistance = distance
                            closestObjectId = objectId
                        end
                    end
                end

                if closestObjectId ~= 0 then
                    SetEntityVisible(closestObjectId, false)
                end
            end
        elseif fashionCheck == 'three' then
            for i, v in ipairs(Config.Fashion) do
                local closestObjectDistance = 99999.0
                local closestObjectId = 0

                for _, player in ipairs(players) do
                    if player ~= PlayerId() then
                        local ped = GetPlayerPed(player)
                        local pedCoords = GetEntityCoords(ped)
                        local distance = GetDistanceBetweenCoords(playerCoords, pedCoords, true)

                        local objectId = GetClosestObjectOfType(pedCoords, 20.0, GetHashKey(v), false)
                        if DoesEntityExist(objectId) and distance < closestObjectDistance then
                            closestObjectDistance = distance
                            closestObjectId = objectId
                        end
                    end
                end

                if closestObjectId ~= 0 then
                    SetEntityVisible(closestObjectId, true)
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        sleep = true
        if effectCheck == 'one' then
            sleep = false
            local players = GetActivePlayers()
            for i = 1, #players do
                RemoveParticleFxFromEntity(GetPlayerPed(players[i]))
            end
        elseif effectCheck == 'two' then
            sleep = false
            local playerPed = PlayerPedId()
            local players = GetActivePlayers()
            for i = 1, #players do
                local playerId = players[i]
                if playerId ~= PlayerId() then
                    local ped = GetPlayerPed(playerId)
                    RemoveParticleFxFromEntity(ped)
                end
            end
        elseif effectCheck == 'three' then
        end
        if sleep then
            Wait(1000)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(1000)
        if blood then
            ClearPedBloodDamage(GetPlayerPed(-1))
            RemoveDecalsInRange(GetEntityCoords(PlayerPedId()), 1000.00)
        end
    end
end)

function EXTRASUNNY()
    SetWeatherTypePersist('EXTRASUNNY')
    SetWeatherTypeNowPersist('EXTRASUNNY')
    SetWeatherTypeNow('EXTRASUNNY')
    SetOverrideWeather('EXTRASUNNY')
end

function RAIN()
    SetWeatherTypePersist('RAIN')
    SetWeatherTypeNowPersist('RAIN')
    SetWeatherTypeNow('RAIN')
    SetOverrideWeather('RAIN')
end

function OVERCAST()
    SetWeatherTypePersist('OVERCAST')
    SetWeatherTypeNowPersist('OVERCAST')
    SetWeatherTypeNow('OVERCAST')
    SetOverrideWeather('OVERCAST')
end

function THUNDER()
    SetWeatherTypePersist('THUNDER')
    SetWeatherTypeNowPersist('THUNDER')
    SetWeatherTypeNow('THUNDER')
    SetOverrideWeather('THUNDER')
end

function FOGGY()
    SetWeatherTypePersist('FOGGY')
    SetWeatherTypeNowPersist('FOGGY')
    SetWeatherTypeNow('FOGGY')
    SetOverrideWeather('FOGGY')
end

function SNOW()
    SetWeatherTypePersist('SNOW')
    SetWeatherTypeNowPersist('SNOW')
    SetWeatherTypeNow('SNOW')
    SetOverrideWeather('SNOW')
end

function XMAS()
    SetWeatherTypePersist('XMAS')
    SetWeatherTypeNowPersist('XMAS')
    SetWeatherTypeNow('XMAS')
    SetOverrideWeather('XMAS')
end

function HALLOWEEN()
    SetWeatherTypePersist('HALLOWEEN')
    SetWeatherTypeNowPersist('HALLOWEEN')
    SetWeatherTypeNow('HALLOWEEN')
    SetOverrideWeather('HALLOWEEN')
end

function NEUTRAL()
    SetWeatherTypePersist('NEUTRAL')
    SetWeatherTypeNowPersist('NEUTRAL')
    SetWeatherTypeNow('NEUTRAL')
    SetOverrideWeather('NEUTRAL')
end

function morning()
    Citizen.CreateThread(function()
        while true do
            Wait(0)
            NetworkOverrideClockTime(06, 20, 20)
        end
    end)
end

function afternoon()
    Citizen.CreateThread(function()
        while true do
            Wait(0)
            NetworkOverrideClockTime(13, 20, 20)
        end
    end)
end

function evening()
    Citizen.CreateThread(function()
        while true do
            Wait(0)
            NetworkOverrideClockTime(19, 20, 20)
        end
    end)
end


function night()
    Citizen.CreateThread(function()
        while true do
            Wait(0)
            NetworkOverrideClockTime(23, 20, 20)
        end
    end)
end
