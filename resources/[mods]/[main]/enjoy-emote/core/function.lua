local is_open = false
local loadanimation = false
local focus_left = false
data_emote = {}
local ins
AnimationDuration = -1
ChosenAnimation = ""
ChosenDict = ""
IsInAnimation = false
MostRecentChosenAnimation = ""
MostRecentChosenDict = ""
MovementType = 0
PlayerGender = "male"
PlayerHasProp = false
PlayerProps = {}
PlayerParticles = {}
SecondPropEmote = false
lang = Config.MenuLanguage
PtfxNotif = false
PtfxPrompt = false
PtfxWait = 500
PtfxNoProp = false

isRequestAnim = false
requestedemote = ''


function GetPedInFront()
    local player = PlayerId()
    local plyPed = GetPlayerPed(player)
    local plyPos = GetEntityCoords(plyPed, false)
    local plyOffset = GetOffsetFromEntityInWorldCoords(plyPed, 0.0, 1.3, 0.0)
    local rayHandle = StartShapeTestCapsule(plyPos.x, plyPos.y, plyPos.z, plyOffset.x, plyOffset.y, plyOffset.z, 10.0, 12, plyPed, 7)
    local _, _, _, _, ped2 = GetShapeTestResult(rayHandle)
    return ped2
end

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)

    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = GetDistanceBetweenCoords(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    return closestPlayer, closestDistance
end

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end


function RequestWalking(set)
    RequestAnimSet(set)
    while not HasAnimSetLoaded(set) do
        Citizen.Wait(1)
    end 
end

function WalkMenuStart(name)
    RequestWalking(name)
    SetPedMovementClipset(PlayerPedId(), name, 0.2)
    RemoveAnimSet(name)
end

function EmoteCancel()
    if ChosenDict == "MaleScenario" and IsInAnimation then
      ClearPedTasksImmediately(PlayerPedId())
      IsInAnimation = false
      --print("Forced scenario exit")
    elseif ChosenDict == "Scenario" and IsInAnimation then
      ClearPedTasksImmediately(PlayerPedId())
      IsInAnimation = false
      --print("Forced scenario exit")
    end
  
    PtfxNotif = false
    PtfxPrompt = false
  
    if IsInAnimation then
      PtfxStop()
      ClearPedTasks(GetPlayerPed(-1))
      DestroyAllProps()
      IsInAnimation = false
    end
end

function PtfxStart()
    if PtfxNoProp then
      PtfxAt = PlayerPedId()
    else
      PtfxAt = prop
    end
    UseParticleFxAssetNextCall(PtfxAsset)
    Ptfx = StartNetworkedParticleFxLoopedOnEntityBone(PtfxName, PtfxAt, Ptfx1, Ptfx2, Ptfx3, Ptfx4, Ptfx5, Ptfx6, GetEntityBoneIndexByName(PtfxName, "VFX"), 1065353216, 0, 0, 0, 1065353216, 1065353216, 1065353216, 0)
    SetParticleFxLoopedColour(Ptfx, 1.0, 1.0, 1.0)
    table.insert(PlayerParticles, Ptfx)
end

function PtfxStop()
  for a,b in pairs(PlayerParticles) do
    --print("Stopped PTFX: "..b)
    StopParticleFxLooped(b, false)
    table.remove(PlayerParticles, a)
  end
end

function pairsByKeys (t, f)
    local a = {}
    for n in pairs(t) do
        table.insert(a, n)
    end
    table.sort(a, f)
    local i = 0      -- iterator variable
    local iter = function ()   -- iterator function
        i = i + 1
        if a[i] == nil then
            return nil
        else
            return a[i], t[a[i]]
        end
    end
    return iter
end

function returnType(data)
    local data = data
    if data == 'mood' then
        data = "expression"
    elseif data == 'emote' then
        data = "emotes"
    elseif data == "dance" then
        data = "dances"
    elseif data == "prop" then
        data = "props"
    end
    return data
end

function EmoteMenuStart(args, hard)
    local name = args
    local etype = hard
    if etype == "dances" then
        if DP.Dances[name] ~= nil then
          if OnEmotePlay(DP.Dances[name]) then end
        end
    elseif etype == "props" then
        if DP.PropEmotes[name] ~= nil then
          if OnEmotePlay(DP.PropEmotes[name]) then end
        end
    elseif etype == "emotes" then
        if DP.Emotes[name] ~= nil then
          if OnEmotePlay(DP.Emotes[name]) then end
        else
          if name ~= "🕺 Dance Emotes" then end
        end
    elseif etype == "expression" then
        if DP.Expressions[name] ~= nil then
          if OnEmotePlay(DP.Expressions[name]) then end
        end
    end
end

function LoadAnim(dict)
    while not HasAnimDictLoaded(dict) do
      RequestAnimDict(dict)
      Wait(10)
    end
end

function LoadPropDict(model)
    while not HasModelLoaded(GetHashKey(model)) do
        RequestModel(GetHashKey(model))
        Wait(10)
    end
end

function PtfxThis(asset)
    while not HasNamedPtfxAssetLoaded(asset) do
        RequestNamedPtfxAsset(asset)
        Wait(10)
    end
    UseParticleFxAssetNextCall(asset)
end

function DestroyAllProps()
    for _,v in pairs(PlayerProps) do
        DeleteEntity(v)
    end
    PlayerHasProp = false
    --print("Destroyed Props")
end

function AddPropToPlayer(prop1, bone, off1, off2, off3, rot1, rot2, rot3)
    local Player = PlayerPedId()
    local x,y,z = table.unpack(GetEntityCoords(Player))

    if not HasModelLoaded(prop1) then
        LoadPropDict(prop1)
    end

    prop = CreateObject(GetHashKey(prop1), x, y, z+0.2,  true,  true, true)
    AttachEntityToEntity(prop, Player, GetPedBoneIndex(Player, bone), off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)
    table.insert(PlayerProps, prop)
    PlayerHasProp = true
    SetModelAsNoLongerNeeded(prop1)
end
  
function CheckGender()
    local hashSkinMale = GetHashKey("mp_m_freemode_01")
    local hashSkinFemale = GetHashKey("mp_f_freemode_01")
  
    if GetEntityModel(PlayerPedId()) == hashSkinMale then
      PlayerGender = "male"
    elseif GetEntityModel(PlayerPedId()) == hashSkinFemale then
      PlayerGender = "female"
    end
    --print("Set gender as = ("..PlayerGender..")")
end

function OnEmotePlay(EmoteName)
    InVehicle = IsPedInAnyVehicle(PlayerPedId(), true)
    if not Config.AllowedInCars and InVehicle == 1 then
      return
    end
  
    if not DoesEntityExist(GetPlayerPed(-1)) then
      return false
    end
  
    if Config.DisarmPlayer then
      if IsPedArmed(GetPlayerPed(-1), 7) then
        SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey('WEAPON_UNARMED'), true)
      end
    end
  
    ChosenDict,ChosenAnimation,ename = table.unpack(EmoteName)
    AnimationDuration = -1
  
    if PlayerHasProp then
      DestroyAllProps()
    end
  
    if ChosenDict == "Expression" then
      SetFacialIdleAnimOverride(PlayerPedId(), ChosenAnimation, 0)
      return
    end
  
    if ChosenDict == "MaleScenario" or "Scenario" then 
      CheckGender()
      if ChosenDict == "MaleScenario" then if InVehicle then return end
        if PlayerGender == "male" then
          ClearPedTasks(GetPlayerPed(-1))
          TaskStartScenarioInPlace(GetPlayerPed(-1), ChosenAnimation, 0, true)
          --print("Playing scenario = ("..ChosenAnimation..")")
          IsInAnimation = true
        else
          EmoteChatMessage(Config.Languages[lang]['maleonly'])
        end return
      elseif ChosenDict == "ScenarioObject" then if InVehicle then return end
        BehindPlayer = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0 - 0.5, -0.5);
        ClearPedTasks(GetPlayerPed(-1))
        TaskStartScenarioAtPosition(GetPlayerPed(-1), ChosenAnimation, BehindPlayer['x'], BehindPlayer['y'], BehindPlayer['z'], GetEntityHeading(PlayerPedId()), 0, 1, false)
        --print("Playing scenario = ("..ChosenAnimation..")")
        IsInAnimation = true
        return
      elseif ChosenDict == "Scenario" then if InVehicle then return end
        ClearPedTasks(GetPlayerPed(-1))
        TaskStartScenarioInPlace(GetPlayerPed(-1), ChosenAnimation, 0, true)
        --print("Playing scenario = ("..ChosenAnimation..")")
        IsInAnimation = true
      return end 
    end
  
    LoadAnim(ChosenDict)
  
    if EmoteName.AnimationOptions then
      if EmoteName.AnimationOptions.EmoteLoop then
        MovementType = 1
      if EmoteName.AnimationOptions.EmoteMoving then
        MovementType = 51
    end
  
    elseif EmoteName.AnimationOptions.EmoteMoving then
      MovementType = 51
    elseif EmoteName.AnimationOptions.EmoteMoving == false then
      MovementType = 0
    elseif EmoteName.AnimationOptions.EmoteStuck then
      MovementType = 50
    end
  
    else
      MovementType = 0
    end
  
    if InVehicle == 1 then
      MovementType = 51
    end
  
    if EmoteName.AnimationOptions then
      if EmoteName.AnimationOptions.EmoteDuration == nil then 
        EmoteName.AnimationOptions.EmoteDuration = -1
        AttachWait = 0
      else
        AnimationDuration = EmoteName.AnimationOptions.EmoteDuration
        AttachWait = EmoteName.AnimationOptions.EmoteDuration
      end
  
      if EmoteName.AnimationOptions.PtfxAsset then
        PtfxAsset = EmoteName.AnimationOptions.PtfxAsset
        PtfxName = EmoteName.AnimationOptions.PtfxName
        if EmoteName.AnimationOptions.PtfxNoProp then
          PtfxNoProp = EmoteName.AnimationOptions.PtfxNoProp
        else
          PtfxNoProp = false
        end
        Ptfx1, Ptfx2, Ptfx3, Ptfx4, Ptfx5, Ptfx6, PtfxScale = table.unpack(EmoteName.AnimationOptions.PtfxPlacement)
        PtfxInfo = EmoteName.AnimationOptions.PtfxInfo
        PtfxWait = EmoteName.AnimationOptions.PtfxWait
        PtfxNotif = false
        PtfxPrompt = true
        PtfxThis(PtfxAsset)
      else
        --print("Ptfx = none")
        PtfxPrompt = false
      end
    end
  
    TaskPlayAnim(GetPlayerPed(-1), ChosenDict, ChosenAnimation, 2.0, 2.0, AnimationDuration, MovementType, 0, false, false, false)
    RemoveAnimDict(ChosenDict)
    IsInAnimation = true
    MostRecentDict = ChosenDict
    MostRecentAnimation = ChosenAnimation
  
    if EmoteName.AnimationOptions then
      if EmoteName.AnimationOptions.Prop then
          PropName = EmoteName.AnimationOptions.Prop
          PropBone = EmoteName.AnimationOptions.PropBone
          PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6 = table.unpack(EmoteName.AnimationOptions.PropPlacement)
          if EmoteName.AnimationOptions.SecondProp then
            SecondPropName = EmoteName.AnimationOptions.SecondProp
            SecondPropBone = EmoteName.AnimationOptions.SecondPropBone
            SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6 = table.unpack(EmoteName.AnimationOptions.SecondPropPlacement)
            SecondPropEmote = true
          else
            SecondPropEmote = false
          end
          Wait(AttachWait)
          AddPropToPlayer(PropName, PropBone, PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6)
          if SecondPropEmote then
            AddPropToPlayer(SecondPropName, SecondPropBone, SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6)
          end
      end
    end
    return true
end

function GetPlayerFromPed(ped)
    for _,player in ipairs(GetActivePlayers()) do
        if GetPlayerPed(player) == ped then
            return player
        end
    end
    return -1
end

function SimpleNotify(message,wait,tyo)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(0,1)
end

function CreateAnimation()
    if loadanimation then return end
    SimpleNotify('Loading Emote 1sec.',3,3)
    local data = {
        ['mood'] = {},
        ['walk'] = {},
        ['share'] = {},
        ['dance'] = {},
        ['emote'] = {},
        ['prop'] = {},
        ['dance'] = {},
        ['danceshare'] = {},
    }
    for k,v in pairs(DP.Expressions) do
        if k ~= 'RESET' then
            data['mood'][#data['mood']+1] = {
                name = k,
                sync = k,
                type = 'mood'
            }
        end
    end
    table.sort(data['mood'], function(a, b)
        return a.name < b.name
    end)

    for k,v in pairs(DP.Walks) do
        if k ~= 'RESET' then
            data['walk'][#data['walk']+1] = {
                name = k,
                sync = k,
                type = 'walk'
            }
        end
    end
    table.sort(data['walk'], function(a, b)
        return a.name < b.name
    end)

    for k,v in pairs(DP.Shared) do
        data['share'][#data['share']+1] = {
            name = v[3],
            sync = k,
            type = 'share'
        }
    end
    table.sort(data['share'], function(a, b)
        return a.name < b.name
    end)

    for k,v in pairs(DP.Dances) do
        data['dance'][#data['dance']+1] = {
            name = v[3],
            sync = k,
            type = 'dance'
        }

        data['danceshare'][#data['danceshare']+1] = {
            name = v[3],
            sync = k,
            type = 'danceshare'
        }
    end
    table.sort(data['dance'], function(a, b)
        return a.name < b.name
    end)
    table.sort(data['danceshare'], function(a, b)
        return a.name < b.name
    end)

    for k,v in pairs(DP.Emotes) do
        data['emote'][#data['emote']+1] = {
            name = v[3],
            sync = k,
            type = 'emote'
        }

    end
    table.sort(data['emote'], function(a, b)
        return a.name < b.name
    end)

    for k,v in pairs(DP.PropEmotes) do
        data['prop'][#data['prop']+1] = {
            name = v[3],
            sync = k,
            type = 'prop'
        }
    end
    table.sort(data['prop'], function(a, b)
        return a.name < b.name
    end)

    for k,v in pairs(data) do
        for ks,vs in pairs(v) do

            local w = (ks - 1)
            if k == 'walk' or k == 'mood' then
                w = ks
            end
            data[k][ks]['slot'] = w
            --print(k,ks,vs.sync,data[k][ks]['slot'])
        end
    end

    data_emote  = data
    SendNUIMessage({
        type = "INIT",
        data = data_emote
    })
    
    loadanimation = true
    Wait(1000)
end

function OpenUI()
    if GetEntityHealth(PlayerPedId()) <= 100 then return end
    if is_open then return end
    if not loadanimation then
        CreateAnimation()
    end
    SendNUIMessage({
        type = "OPEN",
    })
    SetNuiFocus(true,true)
    is_open = true
end

exports('EmoteIsOpen',function()
    return is_open
end)

RegisterNUICallback("ClearTask",function()
    ClearPedTasks(PlayerPedId())
    DestroyAllProps()
end)

RegisterNUICallback("ToggleFocus",function(data)
    local f = not data.focus
    SetNuiFocus(true,f)
    SetNuiFocusKeepInput(not f)
end)

RegisterNUICallback("Close",function()
    SetNuiFocus(false)
    is_open = false
end)

RegisterNUICallback("Emote",function(data)
    if data == nil then return end
    InVehicle = IsPedInAnyVehicle(PlayerPedId(), true)
    if not Config.AllowedInCars and InVehicle == 1 then
        if is_open then
            SimpleNotify('not allowed',5,2)
        end
        return
    end
    if data.type == 'mood' and data.sync == 'RESET' then ClearFacialIdleAnimOverride(PlayerPedId()) return end
    if data.type == 'walk' then  
		if data.sync == 'RESET'then
			ResetPedMovementClipset(PlayerPedId())
			return
		end

		WalkMenuStart(DP.Walks[data.sync][1]) 
		return 
	end
    if data.type == 'share' or data.type == 'danceshare' then 
        target, distance = GetClosestPlayer()
        if(distance ~= -1 and distance < 3) then
            if data.type == 'share' then
                if DP.Shared[data.sync] ~= nil then
                    dict, anim, ename = table.unpack(DP.Shared[data.sync])
                    TriggerServerEvent("ServerEmoteRequest", GetPlayerServerId(target), data.sync, 'Shared')
                end
            else
                if DP.Dances[data.sync] ~= nil then
                    dict, anim, ename = table.unpack(DP.Dances[data.sync])
                    TriggerServerEvent("ServerEmoteRequest", GetPlayerServerId(target), data.sync, 'Dances')
                end
            end
        else
            SimpleNotify(Config.Languages[lang]['nobodyclose'])
        end
    end
    local types = returnType(data.type)
    EmoteMenuStart(data.sync, types)
end)


RegisterCommand('emote', function()
    if ins and ins > GetGameTimer() then else
        ins = 1000 + GetGameTimer()
        if not is_open then
            OpenUI()
        end
    end
end)

RegisterKeyMapping('emote','EMOTE','keyboard', 'F3')

function checkOpenEmote()
    return is_open
end