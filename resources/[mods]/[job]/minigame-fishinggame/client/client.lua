Citizen.CreateThread(function()
    SendNUIMessage({ --these are just the text in the ui. head over to the config file to easily swap these
        type = "setLocale", 
        hook =  Config.locale["hook"],
        success =  Config.locale["success"],
        fail = Config.locale["fail"],
        gotaway = Config.locale["got_away2"],
        fishon = Config.locale["fish_on"],
        toosoon = Config.locale["too_soon"],
    })
end)

uiOpen = false
isReeling = false
value = nil
isItOver = false
reelingProgress = 0

local currentDiff = nil
local startingDiff = nil


local difficulty = {
    ['easy'] = {                                 --*I would probably not touch these, or save the original values if you do*
        tensionIncrease =  {min = 35, max = 40}, --speed of tension increase. lower = harder
        tensionDecrease =  {min = 50, max = 55}, --speed of tension decrease. lower = easier
        progressIncrease = {min = 1,  max = 8},  --speed of percent increase. lower = easier
        progressDecrease = {min = 50, max = 55}, --speed of percent decrease. lower = harder
    },
    ['medium'] = {
        tensionIncrease =  {min = 30, max = 35},
        tensionDecrease =  {min = 55, max = 60},
        progressIncrease = {min = 5,  max = 13},
        progressDecrease = {min = 45, max = 50},
    },
    ['hard'] = {
        tensionIncrease =  {min = 25, max = 30},
        tensionDecrease =  {min = 60, max = 65},
        progressIncrease = {min = 8,  max = 17},
        progressDecrease = {min = 40, max = 45},
    },
}

function DisableControls()
    Citizen.CreateThread(function()
        while uiOpen do
            Citizen.Wait(0)
            DisableControlAction(0, 24, true)
        end
    end)
end

function fishingGameStart(diff, delayTime) --"easy", "medium", "hard"
    currentDiff = diff or "medium"
    SendNUIMessage({type = "updateDifficulty", 
        tensionIncrease =  math.random(difficulty[currentDiff].tensionIncrease.min, difficulty[currentDiff].tensionIncrease.max),
        tensionDecrease =  math.random(difficulty[currentDiff].tensionDecrease.min, difficulty[currentDiff].tensionDecrease.max),
        progressIncrease = math.random(difficulty[currentDiff].progressIncrease.min, difficulty[currentDiff].progressIncrease.max),
        progressDecrease = math.random(difficulty[currentDiff].progressDecrease.min, difficulty[currentDiff].progressDecrease.max),
    })
    Citizen.Wait(250)
    reelingProgress = 0
    uiOpen = true
    isItOver = false
    SetNuiFocus(true, false)
    DisableControls()
    local ply = PlayerPedId()
    local plyCords = GetEntityCoords(ply)
    local fishcoords = GetOffsetFromEntityInWorldCoords(ply, 0.0, 15.0, 0.0) -- 15.0 is the distance from the player that the ui starts
    local onScreen,_x,_y = GetScreenCoordFromWorldCoord(fishcoords.x,fishcoords.y,fishcoords.z)
    local dist = #(plyCords - fishcoords)
    local savedcord = nil
    SendNUIMessage({
        type = "start",
        x = _x, 
        y = _y,
        delay = delayTime
    });
    while uiOpen do
        Citizen.Wait(10)
        local progresscords = GetOffsetFromEntityInWorldCoords(ply, 0, (dist - (dist * (reelingProgress/100))) + 1, -0.5)
        if not isItOver then
            savedcord = progresscords
            Draw3DNUI(progresscords)
        else
            Draw3DNUI(savedcord)
        end
    end
    print("Final Result = " .. tostring(value))
    return value --value returned here is pass or fail true/false
end

exports("fishingGameStart", fishingGameStart)

function cancelGame()
    uiOpen = false
    value = nil
    SendNUIMessage({
        type = "close",
    })
    Citizen.Wait(100)
    SetNuiFocus(false, false)
end

exports("cancelGame", cancelGame)

function DiffChanger() -- this dynamically changes the difficulty while you are playing the minigame so that it switches up mid reel. gets harder/easier.
    Citizen.CreateThread(function()
        while isReeling do
            Citizen.Wait(math.random(12000,15000))
            if currentDiff == "easy" and startingDiff == "easy" then
                    currentDiff = "medium"
            elseif currentDiff == "medium" and startingDiff == "easy" then
                    currentDiff = "easy"
            elseif currentDiff == "medium" and startingDiff == "medium" then
                if math.random(1, 2) == 1 then
                    currentDiff = "hard"
                else
                    currentDiff = "easy"
                end
            elseif currentDiff == "easy" and startingDiff == "medium" then
                if math.random(1, 2) == 1 then
                    currentDiff = "hard"
                else
                    currentDiff = "medium"
                end
            elseif currentDiff == "hard" and startingDiff == "medium" then
                if math.random(1, 2) == 1 then
                    currentDiff = "easy"
                else
                    currentDiff = "medium"
                end
            elseif currentDiff == "medium" and startingDiff == "hard" then
                currentDiff = "hard"
            elseif currentDiff == "hard" and startingDiff == "hard" then
                currentDiff = "medium"
            end
            SendNUIMessage({type = "updateDifficulty", 
                tensionIncrease =  math.random(difficulty[currentDiff].tensionIncrease.min, difficulty[currentDiff].tensionIncrease.max),
                tensionDecrease =  math.random(difficulty[currentDiff].tensionDecrease.min, difficulty[currentDiff].tensionDecrease.max),
                progressIncrease = math.random(difficulty[currentDiff].progressIncrease.min, difficulty[currentDiff].progressIncrease.max),
                progressDecrease = math.random(difficulty[currentDiff].progressDecrease.min, difficulty[currentDiff].progressDecrease.max),
            })
        end
    end)
end

function Draw3DNUI(coords)
	local paused = false
	if IsPauseMenuActive() then paused = true end
	local onScreen,_x,_y = GetScreenCoordFromWorldCoord(coords.x,coords.y,coords.z)
	if paused then SendNUIMessage ({action = "hide"}) else SendNUIMessage({type = "updatePos", x = _x, y = _y}) end
end

RegisterNUICallback("close", function(data)
    value = data.success
    SendNUIMessage({
        type = "close",
    })
    Citizen.Wait(100)
    SetNuiFocus(false, false)
    uiOpen = false
    isItOver = true
end)

RegisterNUICallback("updateTrackingFish", function(data)
    reelingProgress = data.progress
    if data.isitover then
        isItOver = isitover
    end
end)