local p

function StartGame(data)
    if p then return end

    p = promise.new()

    SetNuiFocus(true, false)
    SendNUIMessage({
        Type = "Start",
        Reverse = data.Reverse or false,
        ReverseRate = data.ReverseRate or 50,
        use8Direct = data.use8Direct or false,
        KeyAmount = data.KeyAmount or 5,
        Duration = data.Duration or 0.5,
        delayed = data.delayed or 0.5
    })

    local result = Citizen.Await(p)

    p = nil

    return result
end

exports("StartGame", StartGame)

RegisterNUICallback("Finished", function(data, cb)
    if p then
        p:resolve(data)
    end
    SetNuiFocus(false, false)
    cb('ok')
end)
RegisterNetEvent('enjoy-minigame1:startMiniGame')
AddEventHandler('enjoy-minigame1:startMiniGame', function(amount, useRev, use8Direct)
    local result = StartGame({
        Reverse = useRev,
        ReverseRate = 50,
        use8Direct = use8Direct,
        KeyAmount = 2,
        Duration = 1,
        delayed = 0.1
    })
end)
RegisterCommand("testgame", function(source, arg)
    local Amount = tonumber(arg[1]) or 5
    local useRev = arg[2] == "true" and true or false
    local use8Direct = arg[3] == "true" and true or false
    local result = StartGame({
        Reverse = useRev,
        ReverseRate = 50,
        use8Direct = use8Direct,
        KeyAmount = Amount,
        Duration = 1,
        delayed = 0.5
    })
end)