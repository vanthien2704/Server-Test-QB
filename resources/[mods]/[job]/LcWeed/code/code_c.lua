local MenuWaiter = 0
local Weeds = {}
local isMenu = false
local MenuWeed = 1
local disable_actions = false 

function StartSeed()
        local player = PlayerPedId()
        local coord = GetEntityCoords(player)
        local avaible = false  

        local cSCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
        local spatulaspawn = CreateObject(GetHashKey(Config.Props["spatulamodel"]), cSCoords.x, cSCoords.y, cSCoords.z, 1, 1, 1)
        local netid = ObjToNet(spatulaspawn)

        TaskStartScenarioInPlace(PlayerPedId(), "world_human_gardener_plant", 0, false)
        AttachEntityToEntity(spatulaspawn,GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422),-0.005,0.0,0.0,190.0,190.0,-50.0,1,1,0,1,0,1)
        spatula_net = netid
        disable_actions = true
        Citizen.Wait(Config.Wait["Seed"] * 1000)
        disable_actions = false
        DetachEntity(NetToObj(spatula_net), 1, 1)
        DeleteEntity(NetToObj(spatula_net))
        spatula_net = nil
        ClearPedTasks(PlayerPedId())
        for k, v in pairs(Config.Coords) do
            local dst = #(coord - vector3(v.x,v.y,v.z))
            if dst < v.w then
                avaible = true 
            end
        end
        if avaible then 
            if #Weeds + 1 <= Config.MaxWeed then    
                obj = CreateObject(Config.Props["Weed_Lvl1"], vector3(coord.x - 0.75, coord.y, coord.z - 1.5), true)
                FreezeEntityPosition(obj, true)
                Weeds[#Weeds + 1] = {
                    lvl = 1,
                    obj = obj,
                    growth = 5,
                    health = 10,
                    water = 5,
                    fertilizer = 5,
                    objcoord = GetEntityCoords(obj),
                }
            else 
                notify(Config.Langs["MaxWeed"])
        end
    else 
        notify(Config.Langs["Distance"])
    end
end

Citizen.CreateThread(function()
	while true do
		local sleep = 1500
		local playercoord = GetEntityCoords(PlayerPedId())
        if #Weeds >= 1 then  
            for k, v in pairs(Weeds) do
		        local dst = #(playercoord - vector3(v.objcoord.x,v.objcoord.y,v.objcoord.z))
                if dst < 2 then 
				sleep = 1
				DrawText3D(v.objcoord.x, v.objcoord.y, v.objcoord.z+1.0, Config.Langs["OpenWeed"])
                    if dst < 2 then 
                        if IsControlJustReleased(0,38) then
                            OpenMenu(k)
                        end
                    end
                end
                
            end
        end
        Citizen.Wait(sleep)
	end
end)

Citizen.CreateThread(function()
	while true do
		local sleep = 1000
		local playercoord = GetEntityCoords(PlayerPedId())
        if disable_actions then 
            sleep = 0
            DisableAllControlActions(0)
        else 
            sleep = 1000
        end
        Citizen.Wait(sleep)
	end
end)

Citizen.CreateThread(function()
	while true do
        if #Weeds >= 1 then  
            for k, v in pairs(Weeds) do
                if v.growth <= 0 then
                    DeleteEntity(v.obj)
                    table.remove(Weeds, k)
                    SendNUIMessage({action = "Close"})
                else
                    if v.health <= 0 then 
                        if v.water >= 0 and v.fertilizer >= 0 then 
                            Weeds[k].water = v.water - 1
                            Weeds[k].fertilizer = v.fertilizer - 1
                            Weeds[k].health = v.health + 0.5
                        else
                            Weeds[k].growth = v.growth - 0.5
                        end
                    else
                        if v.water >= 0 and v.fertilizer >= 0 then 
                            Weeds[k].water = v.water - 1
                            Weeds[k].fertilizer = v.fertilizer - 1
                            if Weeds[k].health >= 100 then 
                                Weeds[k].health = 100
                            else 
                                Weeds[k].health = v.health + 1
                            end
                        else
                            Weeds[k].health = v.health - 1
                        end
                    end
                    if v.health >= v.growth then 
                        if Weeds[k].growth >= 100 then 
                            Weeds[k].growth = 100
                        else 
                            Weeds[k].growth = v.growth + 1
                        end
                    else
                        Weeds[k].growth = v.growth - 0.5
                    end
                    if (v.growth >= 25 and v.lvl == 1) then
                        UpgradeWeed(k, 2)
                    elseif (v.growth >= 40 and v.lvl == 2) then 
                        UpgradeWeed(k, 3)
                    elseif (v.growth >= 65 and v.lvl == 3) then 
                        UpgradeWeed(k, 4)
                    elseif (v.growth >= 80 and v.lvl == 4) then 
                        UpgradeWeed(k, 5)
                    end
                    if isMenu then 
                        SendNUIMessage({
                            action="OpenMenu", 
                            growth = Weeds[MenuWeed].growth, 
                            health = Weeds[MenuWeed].health,
                            water = Weeds[MenuWeed].water,
                            fertilizer = Weeds[MenuWeed].fertilizer
                        })
                    end
                end
            end
        end
        Citizen.Wait(Config.Wait["Check"] * 1000)
	end
end)

Citizen.CreateThread(function()
    Citizen.Wait(1000)
print("[^1LcWeed^0]^1!^0[^2Free!  BY JINGJOK^0]")
end)
function UpgradeWeed(weed_id, lvl)
    lvl = tonumber(lvl)
    weed_id = tonumber(weed_id)
    DeleteEntity(Weeds[weed_id].obj)
    if lvl == 2 then
       obj = CreateObject(Config.Props["Weed_Lvl2"], Weeds[weed_id].objcoord, true)
    elseif lvl == 3 then 
        obj = CreateObject(Config.Props["Weed_Lvl3"], Weeds[weed_id].objcoord, true)
    elseif lvl == 4 then 
        obj = CreateObject(Config.Props["Weed_Lvl4"], vector3(Weeds[weed_id].objcoord.x, Weeds[weed_id].objcoord.y, Weeds[weed_id].objcoord.z - 2.5), true)
    elseif lvl == 5 then 
        obj = CreateObject(Config.Props["Weed_Lvl5"], vector3(Weeds[weed_id].objcoord.x, Weeds[weed_id].objcoord.y, Weeds[weed_id].objcoord.z - 2.5), true)
    end
    FreezeEntityPosition(obj, true)
    Weeds[weed_id] = {
        lvl = lvl,
        obj = obj,
        growth = Weeds[weed_id].growth,
        health = Weeds[weed_id].health,
        water = Weeds[weed_id].water,
        fertilizer = Weeds[weed_id].fertilizer,
        objcoord = GetEntityCoords(obj),
    }
end

function OpenMenu(id)
    if MenuWaiter < GetGameTimer() then 
		MenuWaiter = GetGameTimer() + 3500
        SetNuiFocus(1, 1)
        isMenu = true 
        MenuWeed = id
        w = Weeds[id]
        SendNUIMessage({
            action="OpenMenu", 
            growth = w.growth, 
            health = w.health,
            water = w.water,
            fertilizer = w.fertilizer
        })
    else 
        notify(Config.Langs["Waiter"])
    end
end

RegisterNUICallback("close", function ()
    MenuWaiter = GetGameTimer() + 2000
    SetNuiFocus(0, 0)
    isMenu = false 
end)

Citizen.CreateThread(function()
    for k, v in pairs(Config.Coords) do        
        if Config.Blip.Alpha then 
            local Alpha = AddBlipForRadius(v.x,v.y,v.z, v.w)
            SetBlipHighDetail(Alpha, true)
            SetBlipColour(Alpha, 1)
            SetBlipAlpha (Alpha, 128)
        end
        if Config.Blip.Blip then 
            blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(blip, Config.Blip.sprite)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, Config.Blip.scale)
            SetBlipColour(blip, Config.Blip.color)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(Config.Langs.Blip)
            EndTextCommandSetBlipName(blip)
        end
    end
end)

function LoadProp()
    for k, v in pairs(Config.Props) do        
        if not HasModelLoaded(v) then
            RequestModel(v)
            while not HasModelLoaded(v) do
                Citizen.Wait(1)
            end
        end
    end
end

function Harvest(id)
    local cSCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
    local spatulaspawn = CreateObject(GetHashKey(Config.Props["spatulamodel"]), cSCoords.x, cSCoords.y, cSCoords.z, 1, 1, 1)
    local netid = ObjToNet(spatulaspawn)

    TaskStartScenarioInPlace(PlayerPedId(), "world_human_gardener_plant", 0, false)
    AttachEntityToEntity(spatulaspawn,GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422),-0.005,0.0,0.0,190.0,190.0,-50.0,1,1,0,1,0,1)
    spatula_net = netid
    disable_actions = true
    Citizen.Wait(Config.Wait["Harvest"] * 1000)
    disable_actions = false
    DetachEntity(NetToObj(spatula_net), 1, 1)
    DeleteEntity(NetToObj(spatula_net))
    spatula_net = nil
    ClearPedTasks(PlayerPedId())
    if Weeds[id].growth >= 90 then 
        GiveWeed = math.ceil(Weeds[id].growth * Config.Harvest / 10)
        TriggerServerEvent("LcWeed:Harvest", GiveWeed)
        notify(Config.Langs["Harvest"])
    else 
        notify(Config.Langs["Harvest_eror"])
    end
    DeleteEntity(Weeds[id].obj)
    table.remove(Weeds, id)
    SendNUIMessage({action = "Close"})
end

AddEventHandler('onClientMapStop', function()
    for k, v in pairs(Weeds) do
        DeleteEntity(v.obj)
    end
end)

RegisterNUICallback("Give", function (data)
    if data.idx == "Harvest" then
        Harvest(MenuWeed)
    else 
        TriggerServerEvent("LcWeed:giveSV", MenuWeed, data.idx)
    end
end)

AddEventHandler("LcWeed:giveCl")
RegisterNetEvent("LcWeed:giveCl", function (MenuW,idx)
    if idx == "Water" then
        Weeds[MenuW].water = Weeds[MenuW].water + Config.Give["Water"]
    elseif idx == "Fertilizer" then 
        Weeds[MenuW].fertilizer = Weeds[MenuW].fertilizer + Config.Give["Fertilizer"]
    elseif idx == "Dust" then
        if Weeds[MenuW].health >= 100 then 
            Weeds[MenuW].growth = 100
        else 
            Weeds[MenuW].health = Weeds[MenuW].health + Config.Give.Dust["Healt"]
        end
        if Weeds[MenuW].growth >= 100 then 
            Weeds[MenuW].growth = 100
        else 
            Weeds[MenuW].growth = Weeds[MenuW].growth + Config.Give.Dust["Growth"]
        end
    end
    if isMenu then 
        SendNUIMessage({
            action="OpenMenu", 
            growth = Weeds[MenuW].growth, 
            health =  Weeds[MenuW].health,
            water = Weeds[MenuW].water,
            fertilizer = Weeds[MenuW].fertilizer
        })
    end
end)

AddEventHandler("LcWeed:Seed")
RegisterNetEvent("LcWeed:Seed", function ()
    StartSeed()
end)