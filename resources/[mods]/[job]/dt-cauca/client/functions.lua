local difficulty = { "easy", "medium"}
local showing = false
GLOBAL_FISH = {}
fishingRod = nil
isFishing = false
pressG = false

local Fishing_Zone = PolyZone:Create(
    {
		vector2(2811.1059570313, -587.96136474609),
        vector2(2810.6779785156, -592.29010009766),
        vector2(2812.0012207031, -594.14050292969),
        vector2(2814.8649902344, -597.72998046875),
        vector2(2818.2062988281, -601.05694580078),
        vector2(2821.5864257813, -604.07739257813),
        vector2(2825.6147460938, -607.07586669922),
        vector2(2828.8413085938, -609.68273925781),
        vector2(2833.87890625, -612.57312011719),
        vector2(2837.5512695313, -614.6884765625),
        vector2(2840.3017578125, -616.53790283203),
        vector2(2842.6110839844, -618.45526123047),
        vector2(2842.4958496094, -621.14178466797),
        vector2(2843.546875, -622.95812988281),
        vector2(2843.4509277344, -626.25421142578),
        vector2(2842.8544921875, -630.48260498047),
        vector2(2842.4375, -634.17883300781),
        vector2(2841.8986816406, -637.43212890625),
        vector2(2840.7026367188, -641.39019775391),
        vector2(2839.9169921875, -645.28344726563),
        vector2(2839.3649902344, -647.98754882813),
        vector2(2838.9916992188, -650.69720458984),
        vector2(2837.6154785156, -653.23046875),
        vector2(2836.3891601563, -656.54388427734),
        vector2(2835.3828125, -659.00897216797),
        vector2(2834.6906738281, -661.31414794922),
        vector2(2833.7336425781, -665.53918457031),
        vector2(2833.7836914063, -669.57281494141),
        vector2(2832.7678222656, -671.95922851563),
        vector2(2831.7414550781, -674.60064697266),
        vector2(2831.5314941406, -676.92938232422),
        vector2(2831.5656738281, -678.18548583984),
        vector2(2831.4487304688, -680.39770507813),
        vector2(2832.0017089844, -683.64123535156),
        vector2(2835.1838378906, -689.07897949219),
        vector2(2837.7587890625, -691.57220458984),
        vector2(2838.1857910156, -691.26879882813),
        vector2(2838.7958984375, -691.20715332031),
        vector2(2839.4631347656, -690.75634765625),
        vector2(2841.0556640625, -690.52459716797),
        vector2(2843.7109375, -691.07568359375),
        vector2(2844.3073730469, -681.52520751953),
        vector2(2845.3798828125, -671.03863525391),
        vector2(2846.0922851563, -664.34350585938),
        vector2(2847.9118652344, -652.95941162109),
        vector2(2849.583984375, -640.89624023438),
        vector2(2850.775390625, -631.26525878906),
        vector2(2855.3740234375, -620.49053955078),
        vector2(2851.2001953125, -609.49200439453),
        vector2(2851.376953125, -598.40490722656),
        vector2(2848.1447753906, -595.4091796875),
        vector2(2811.7607421875, -587.67999267578)
    },
    {
        name= "Fishing_Zone",
        debugPoly = false,
    }
)

TryToFish = function(types)
    if types == "normal" then
        rod = Config.FishingItems["rod"]["name"]
        bait = Config.FishingItems["bait"]["name"]
    end

    local iPed = PlayerPedId()
	Citizen.Wait(0)
	point = GetEntityCoords(iPed,true)
    local FZ = Fishing_Zone:isPointInside(point)
    
    if FZ then
        QBCore.Functions.TriggerCallback('dt-cauca:GetItemData', function(count)
            if not IsPedInAnyVehicle(PlayerPedId()) then
                if not IsPedSwimming(PlayerPedId()) then
                    if count ~= nil then
                        if count == 0 then
                            QBCore.Functions.Notify("Bạn phải có Cần Câu và Mồi Câu để câu cá", "error", "3000")
                        else
                            local waterValidated, castLocation = IsInWater()

                            if waterValidated then
                                fishingRod = GenerateFishingRod(cachedData["ped"])
                                CastBait(fishingRod, castLocation, types)
                            else
                                QBCore.Functions.Notify("Bạn phải đứng ở khu vực gần nước", "warning", "3000")
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Bạn không thể vừa bơi vừa câu cá", "warning", "3000")
                end
            else
                QBCore.Functions.Notify("Vui lòng rời khỏi phương tiện để bắt đầu câu cá", "warning", "3000")
            end
        end, rod, bait)
    else
        QBCore.Functions.Notify("Bạn không ở trong khu vực câu cá", "warning", "3000")
    end
end

CastBait = function(rodHandle, castLocation, types)
    if isFishing then return end
        isFishing = true
        local startedCasting = GetGameTimer()

        if not HasFishingBait(types) then
            QBCore.Functions.Notify('Bạn không có mồi câu cá', 'error')
            isFishing = false
            ClearAreaOfObjects(cachedData["ped"], 2.0, 0)
            return DeleteEntity(rodHandle)
        end

        while not IsControlJustPressed(0, 38) do
            Citizen.Wait(5)
            -- exports["ax-ui"]:ShowHelpNotification("Nhấn ~INPUT_CONTEXT~ để quăng mồi")
            exports["j-textui"]:Help("Nhấn ~INPUT_CONTEXT~ để quăng mồi")
            if GetGameTimer() - startedCasting > 5000 then
                QBCore.Functions.Notify("Bạn cần phải quăng mồi", "warning")
                isFishing = false
                ClearAreaOfObjects(cachedData["ped"], 2.0, 0)
                return DeleteEntity(rodHandle)
            end
        end

        PlayAnimation(cachedData["ped"], "mini@tennis", "forehand_ts_md_far", {
            ["flag"] = 48
        })

        while IsEntityPlayingAnim(cachedData["ped"], "mini@tennis", "forehand_ts_md_far", 3) do
            Citizen.Wait(0)
        end

        PlayAnimation(cachedData["ped"], "amb@world_human_stand_fishing@idle_a", "idle_c", {
            ["flag"] = 11
        })
        
        pressG = true
        if types == "normal" then
            QBCore.Functions.Notify("Quăng mồi thành công! Chờ cá cắn câu", "success", "5000")
            TriggerServerEvent("dt-cauca:server:remove_moicau")
            Citizen.Wait(math.random(2000, 10000))
       
            
            --if isInMarker then
            local gameDifficult = difficulty[math.random(1, #difficulty)]
            local success = exports["minigame-fishinggame"]:fishingGameStart(gameDifficult, math.random(100, 200))
            if success then
                if isFishing then
                    SetNuiFocus(false, false)
                    DropFishWhenSuccess()
                    StopProgress()
                end
            else
                QBCore.Functions.Notify('Cá đã chạy thoát! Xin chia buồn', 'error')
                RemoveWhenFail()
                StopProgress()
            end
        --end

    end
    Citizen.Wait(1000)
end

DropFishWhenSuccess = function()
    RemoveLoadingPrompt()
    ClearPedTasks(cachedData["ped"])
	local foundFish = false
    local fishNumber = 0
	
    repeat
        Wait(10)
        local rnd = 1
		--if isInMarker then 
        rnd = math.random(1, #Config.FishTableShark)
        if math.random(100) <= Config.FishTableShark[rnd].chance then
            foundFish = true
            fishNumber = rnd
        --end
		else
		rnd = math.random(1, #Config.FishTable)
        if math.random(100) <= Config.FishTable[rnd].chance then
            foundFish = true
            fishNumber = rnd
        end
		end
    until foundFish
	-- if isInMarker then
    -- rewardtype = Config.FishTableShark[fishNumber]
	-- else
	-- rewardtype = Config.FishTable[fishNumber]
	-- end
    rewardtype = Config.FishTableShark[fishNumber]
    local fishHandle = nil
	------------------------------------------
    local forwardVector = GetEntityForwardVector(cachedData["ped"])
    local forwardPos = vector3(GLOBAL_COORDS["x"] + forwardVector["x"] * 5, GLOBAL_COORDS["y"] + forwardVector["y"] * 5, GLOBAL_COORDS["z"])
    local model = GetHashKey(rewardtype.prop)
    RequestModel(model)
    while not HasModelLoaded(model) do 
        Wait(1000)
    end
    -- if not HasModelLoaded(model) then
    --     isFishing = false
    -- end
	
	
    if rewardtype.ped == true then
        fishHandle = CreatePed(28, model, forwardPos, 0.0, false, true)
    else
        fishHandle = CreateObject(model, forwardPos, false, false)
    end
	
	while not DoesEntityExist(fishHandle) do
        Citizen.Wait(10)
    end

    if rewardtype.ped == true then
        SetEntityHealth(fishHandle, 0.0)
    end
    ClearPedTasks(cachedData["ped"])
    Citizen.CreateThread(function() 
        while true do
            Citizen.Wait(100)
			local ped = PlayerPedId()
            v1 = GetEntityCoords(ped, true)
		
            local asd = GetEntityCoords(fishHandle, false)
            if Vdist(GetEntityCoords(fishHandle, false), forwardPos) <= 1.5 then
                local v3 = vector3(round((forwardVector.x*-1)+8.0, 2), round((forwardVector.y*-1)+8.0, 2), round((forwardVector.z*-1)+8.0, 2))             
				ApplyForceToEntity(fishHandle, 3, v3, 0.0, 0.0, 0.0, 0, true, true, true, false, true)
                Citizen.Wait(1000)
				SetEntityCoords(fishHandle, v1.x-1, v1.y-1, v1.z, false, false, false, true)
            else
                break
            end
        end
    end)


    Citizen.Wait(1500)
	table.insert(GLOBAL_FISH, {["fishHandle"] = fishHandle, ["rewardtype"] = rewardtype})

    if #GLOBAL_FISH > 0 then
        if not showing then
            Wait(500)
            Show3D()
        end
    end
    isFishing = false
	pressG = false
	ClearAreaOfObjects(cachedData["ped"], 2.0, 0)
    return DeleteEntity(fishingRod)
end

RemoveWhenFail = function()
    RemoveLoadingPrompt()
    SetNuiFocus(false, false)
    StopProgress()
    ClearPedTasks(cachedData["ped"])
    isFishing = false
	pressG = false
	ClearAreaOfObjects(cachedData["ped"], 2.0, 0)
    return DeleteEntity(fishingRod)
end

function round(number, decimals)
    local power = 10^decimals
    return math.floor(number * power) / power
end

IsInWater = function()
    local startedCheck = GetGameTimer()

    local ped = cachedData["ped"]
    local pedPos = GetEntityCoords(ped)

    local forwardVector = GetEntityForwardVector(ped)
    local forwardPos = vector3(pedPos["x"] + forwardVector["x"] * 10, pedPos["y"] + forwardVector["y"] * 10, pedPos["z"])

    local fishHash = `a_c_fish`

    WaitForModel(fishHash)

    local waterHeight = GetWaterHeight(forwardPos["x"], forwardPos["y"], forwardPos["z"])

    local fishHandle = CreatePed(1, fishHash, forwardPos, 0.0, false)
    
    SetEntityAlpha(fishHandle, 0, true) -- makes the fish invisible.
    QBCore.Functions.Notify("Đang kiểm tra địa điểm câu cá", "success", "3000")

    while GetGameTimer() - startedCheck < 3000 do
        Citizen.Wait(0)
    end

    RemoveLoadingPrompt()

    local fishInWater = IsEntityInWater(fishHandle)

    DeleteEntity(fishHandle)
    ClearAreaOfObjects(cachedData["ped"], 2.0, 0)
    SetModelAsNoLongerNeeded(fishHash)

    return fishInWater, fishInWater and vector3(forwardPos["x"], forwardPos["y"], waterHeight) or false
end

GenerateFishingRod = function(ped)
    local pedPos = GetEntityCoords(ped)
    
    local fishingRodHash = `prop_fishing_rod_01`

    WaitForModel(fishingRodHash)

    local rodHandle = CreateObject(fishingRodHash, pedPos, true)

    AttachEntityToEntity(rodHandle, ped, GetPedBoneIndex(ped, 18905), 0.1, 0.05, 0, 80.0, 120.0, 160.0, true, true, false, true, 1, true)

    SetModelAsNoLongerNeeded(fishingRodHash)

    return rodHandle
end

PlayAnimation = function(ped, dict, anim, settings)
	if dict then
        Citizen.CreateThread(function()
            RequestAnimDict(dict)

            while not HasAnimDictLoaded(dict) do
                Citizen.Wait(100)
            end

            if settings == nil then
                TaskPlayAnim(ped, dict, anim, 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)
            else 
                local speed = 1.0
                local speedMultiplier = -1.0
                local duration = 1.0
                local flag = 0
                local playbackRate = 0

                if settings["speed"] then
                    speed = settings["speed"]
                end

                if settings["speedMultiplier"] then
                    speedMultiplier = settings["speedMultiplier"]
                end

                if settings["duration"] then
                    duration = settings["duration"]
                end

                if settings["flag"] then
                    flag = settings["flag"]
                end

                if settings["playbackRate"] then
                    playbackRate = settings["playbackRate"]
                end

                TaskPlayAnim(ped, dict, anim, speed, speedMultiplier, duration, flag, playbackRate, 0, 0, 0)
            end
      
            RemoveAnimDict(dict)
		end)
	else
		TaskStartScenarioInPlace(ped, anim, 0, true)
	end
end

FadeOut = function(duration)
    DoScreenFadeOut(duration)
    
    while not IsScreenFadedOut() do
        Citizen.Wait(0)
    end
end

FadeIn = function(duration)
    DoScreenFadeIn(500)

    while not IsScreenFadedIn() do
        Citizen.Wait(0)
    end
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end
end

WaitForModel = function(model)
    if not IsModelValid(model) then
        return
    end

	if not HasModelLoaded(model) then
		RequestModel(model)
	end
	
	while not HasModelLoaded(model) do
		Citizen.Wait(0)
	end
end

ShowHelpNotification = function(msg, thisFrame, beep, duration)
	AddTextEntry('qbHelpNotification', msg)

	if thisFrame then
		DisplayHelpTextThisFrame('qbHelpNotification', false)
	else
		if beep == nil then beep = true end
		BeginTextCommandDisplayHelp('qbHelpNotification')
		EndTextCommandDisplayHelp(0, false, beep, duration or -1)
	end
end

function HasFishingBait(types)
    local rtval = false
    if QBCore.Functions.HasItem(Config.FishingItems.bait.name) then
        rtval = true
    end
	if types == 'normal' then
	    name = 'pistol_ammo'
	end
    return rtval
end


Show3D = function()
    Citizen.CreateThread(function() 
        local coords = nil
        local close = false
        showing = true
        while #GLOBAL_FISH > 0 do
            close = false
            for i=1, #GLOBAL_FISH, 1 do
                coords = GetEntityCoords(GLOBAL_FISH[i].fishHandle, false)
                if Vdist(GLOBAL_COORDS.x, GLOBAL_COORDS.y, GLOBAL_COORDS.z, coords.x, coords.y, coords.z) <= 2.0 then
                    DrawText3Ds(coords.x, coords.y, coords.z, "Nhấn ~y~[E]~w~ để nhặt cá")
                    if IsControlJustPressed(1, 38) then
                        if DoesEntityExist(GLOBAL_FISH[i].fishHandle) then
                            loadAnimDict('pickup_object')
                            TaskPlayAnim(cachedData["ped"],'pickup_object', 'putdown_low',5.0, 1.5, 1.0, 48, 0.0, 0, 0, 0)
                            AttachEntityToEntity(GLOBAL_FISH[i].fishHandle, cachedData["ped"], GetPedBoneIndex(cachedData["ped"], 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
                            if not GLOBAL_FISH[i].rewardtype.trash then
                                Citizen.Wait(1000)
                                DeleteEntity(GLOBAL_FISH[i].fishHandle)
								ClearAreaOfObjects(cachedData["ped"], 2.0, 0)
                                QBCore.Functions.TriggerCallback("dt-cauca:receiveFish", function(received)
                                    if received then
                                    end
                                end, GLOBAL_FISH[i].rewardtype.name)
                            else
                                Citizen.Wait(1000)
                                DetachEntity(GLOBAL_FISH[i].fishHandle, cachedData["ped"], true)
								DeleteEntity(GLOBAL_FISH[i].fishHandle)
								ClearAreaOfObjects(cachedData["ped"], 2.0, 0)
                            end
                            table.remove(GLOBAL_FISH, i)
                            ClearPedSecondaryTask(PlayerPedId())
                        end
                    end
                    close = true
                    break
                end
            end
            if close then
                Citizen.Wait(0)
            else
                Citizen.Wait(250)
            end
        end
        showing = false
    end)
end

function DrawText3Ds(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

RegisterNetEvent('dt-cauca:fixloi_cauca')
AddEventHandler('dt-cauca:fixloi_cauca', function()
    if isFishing == true then
        RemoveWhenFail()
        QBCore.Functions.Notify("Sửa lỗi câu cá thành công! Sử dụng lại cần câu để bắt đầu công việc", "success", "3000")
    end
end)