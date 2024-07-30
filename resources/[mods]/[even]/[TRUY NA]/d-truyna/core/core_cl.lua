QBCore = exports['qb-core']:GetCoreObject()
FLKZ = nil or {}



FLKZ.GetTargetPlayerCoordsFromServerId = function(targetServerId)
    for _, playerId in ipairs(GetActivePlayers()) do
        local serverId = GetPlayerServerId(playerId)
        if serverId == targetServerId then
            local playerPed = GetPlayerPed(playerId)
            if playerPed ~= 0 then
                return GetEntityCoords(playerPed)
            else
                return nil
            end
        end
    end
    return nil
end

FLKZ.GetTargetProfile = function(targetServerId)
    for _, playerId in ipairs(GetActivePlayers()) do
        local serverId = GetPlayerServerId(playerId)
        if serverId == targetServerId then
            local playerPed = GetPlayerPed(playerId)
            if playerPed ~= 0 then
                return exports['MugShotBase64']:GetMugShotBase64(playerPed, false)
            else
                return nil
            end
        end
    end
    return nil
end

FLKZ.GetTargetPlayerDead = function(targetServerId)
    for _, playerId in ipairs(GetActivePlayers()) do
        local serverId = GetPlayerServerId(playerId)
        if serverId == targetServerId then
            local playerPed = GetPlayerPed(playerId)
            if playerPed ~= 0 then
                if IsPlayerDead(targetServerId) then
                    return true
                else
                    return false
                end
            else
                return false
            end
        end
    end
    return false
end

FLKZ.GetTargetId = function(targetServerId)
    for _, playerId in ipairs(GetActivePlayers()) do
        local serverId = GetPlayerServerId(playerId)
        if serverId == targetServerId then
            local playerPed = GetPlayerPed(playerId)
            if playerPed ~= 0 then
                return GetPlayerName(playerPed)
            else
                return nil
            end
        end
    end
    return nil
end

FLKZ.GetDistance = function(coords)
    return GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), coords.x, coords.y, coords.z)
end

local EventEnd = false
local InGame = false
FLKZ.Wanted = function(data)
    InGame = true
    local Time = tonumber(data.time)
    local TimeAdd = data.timeadd
    local Money = tonumber(data.money)
    -- local AddMoney = math.random(200,500)
    local PlayerIX = tonumber(data.playerId)
    local PlayerId = FLKZ.GetTargetPlayerCoordsFromServerId(PlayerIX)

    if PlayerId ~= nil then
        CreateThread(function()
            local openui = false
            while true do
                Wait(0)
                if EventEnd then
                    openui = false
                else
                    openui = true
                end
                SendNUIMessage({
                    openui = openui,
                    money = Money,
                    time = Time,
                    name = data.playername,
                    reason = data.text,
                    Profile = FLKZ.GetTargetProfile(PlayerIX)
                })
                if EventEnd or Time < 0 then
                    SendNUIMessage({
                        openui = false,
                        money = Money,
                        time = Time,
                        name = data.playername,
                        reason = data.text,
                        Profile = FLKZ.GetTargetProfile(PlayerIX)
                    })
                    break
                end
            end
        end)

        CreateThread(function()
            while true do
                Wait(0)
                if FLKZ.GetDistance(PlayerId) < 150.0 then
                    local getreal = FLKZ.GetTargetPlayerCoordsFromServerId(PlayerIX)
                    local markerCoords = vector3(getreal.x, getreal.y, getreal.z + 1.5)
                    DrawMarker(
                        0,
                        markerCoords.x, markerCoords.y, markerCoords.z,
                        0, 0, 0,
                        0, 0, 0.0,
                        0.5, 0.5, 0.5,
                        255, 0, 0, 200,
                        true, false, 2, false, nil, nil, false
                    )
                end
                if EventEnd or Time < 0 then
                    break
                end
            end
        end)

        CreateThread(function()
            while true do
                Wait(2 * 1000)
                Money = Money + math.random(100, 300)
                if EventEnd or Time < 0 then
                    break
                end
            end
        end)

        CreateThread(function()
            while true do
                Wait(1000)
                Time = Time - 1
                -- Money = Money + math.random(5, 50)

                if FLKZ.GetTargetPlayerDead(PlayerIX) then
                    SendNuiMessage({
                        playerdead = true
                    })
                else
                    SendNuiMessage({
                        playerdead = false
                    })
                end



                if EventEnd or Time < 0 then
                    EventEnd = true
                    SendNUIMessage({
                        openui = false,
                        money = 0,
                        time = 0,
                        name = '',
                        reason = '',
                        Profile = ''
                    })
                    InGame = false
                    Wait(1)
                    SendNUIMessage({
                        openui = false,
                        money = 0,
                        time = 0,
                        name = '',
                        reason = '',
                        Profile = ''
                    })
                    InGame = false
                    EventEnd = true
                    Wait(1)
                    EventEnd = false
                    break
                end
            end
        end)

        if EventEnd then
            SendNUIMessage({
                eventclose = true
            })
        end
    end
end

RegisterNetEvent(GetCurrentResourceName() .. ':Wanted', function(data)
    FLKZ.Wanted(data)
end)

-- Wanted 2 200 30 1 Test
local serverPlayerIDs = {}

-- Request server-side player IDs from the server
RegisterNetEvent('receiveServerPlayerIDs')
AddEventHandler('receiveServerPlayerIDs', function(playerIDs)
    serverPlayerIDs = playerIDs
end)

function RequestServerPlayerIDs()
    TriggerServerEvent('requestServerPlayerIDs')
end

-- Function to get a random player ID from the server-side IDs
function GetRandomServerPlayerID()
    if #serverPlayerIDs > 0 then
        local randomIndex = math.random(1, #serverPlayerIDs)
        return serverPlayerIDs[randomIndex]
    else
        return nil
    end
end

-- Register the command 'truyna'
RegisterCommand('truyna', function(source, args, rawCommand)
    if not InGame then
        RequestServerPlayerIDs()
        Citizen.Wait(500)  -- Wait for the server to respond
        local randomTargetId = GetRandomServerPlayerID()
        if randomTargetId then
            TriggerServerEvent(GetCurrentResourceName() .. ':Wanted:SV', {
                targetId = randomTargetId,
                money = 1000,
                time = 200,
                text = ''
            })
        else
            print('No players found to select a random target ID.')
        end
    end
end, false)

TriggerEvent('chat:addSuggestion', '/truyna', 'Truy nã đối tượng ngẫu nhiên', {
})

RegisterCommand('WantedEnd', function(source, args, rawCommand)
    TriggerServerEvent(GetCurrentResourceName() .. ':END:SV')
end, false)

RegisterNetEvent(GetCurrentResourceName() .. 'END', function()
    EventEnd = true
    InGame = false
    Wait(2000)
    EventEnd = false
end)
