local QBCore = exports['qb-core']:GetCoreObject()

local spawnedCrate = 0
local spawnedCrate2 = 0
local spawnedCrate3 = 0
local spawnedCrate4 = 0
local divingCrate = {}
local divingCrate2 = {}
local divingCrate3 = {}
local divingCrate4 = {}
local SucceededAttempts = 0
local NeededAttempts = 4

function fixbug_dupe()
    ExecuteCommand('closeinv')
end

exports['qb-target']:AddTargetModel("prop_drop_crate_01_set2", {
    options = {
        {
            event = "dt-homkhobau:client:SearchSupplyCrate",
            icon = "fas fa-box-open",
            label = "Mở hòm",
        },
    },
distance = 3.9 
})

RegisterNetEvent('dt-homkhobau:client:SearchSupplyCrate', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local Skillbar = exports['minigame-skillbar']:GetSkillbarObject()

	local nearbyObject, nearbyID
	for i=1, #divingCrate, 1 do
		if GetDistanceBetweenCoords(coords, GetEntityCoords(divingCrate[i]), false) < 4.0 then
			nearbyObject, nearbyID = divingCrate[i], i
		end
	end
	for i=1, #divingCrate2, 1 do
		if GetDistanceBetweenCoords(coords, GetEntityCoords(divingCrate2[i]), false) < 4.0 then
			nearbyObject, nearbyID = divingCrate2[i], i
		end
	end
	for i=1, #divingCrate3, 1 do
		if GetDistanceBetweenCoords(coords, GetEntityCoords(divingCrate3[i]), false) < 4.0 then
			nearbyObject, nearbyID = divingCrate3[i], i
		end
	end
	for i=1, #divingCrate4, 1 do
		if GetDistanceBetweenCoords(coords, GetEntityCoords(divingCrate4[i]), false) < 4.0 then
			nearbyObject, nearbyID = divingCrate4[i], i
		end
	end

	if QBCore.Functions.HasItem(Config.CrateSearchItem) then
			if nearbyObject then
				isPickingUp = true
				DeleteObject(nearbyObject) 
				spawnedCrate = spawnedCrate - 1     
				TriggerEvent('ax-ui:StartMinigame',function(retval)
					if retval then
						FreezeEntityPosition(playerPed, true)
						QBCore.Functions.Progressbar("search_dive_supply", Config.Lang["searchsupply"], Config.CrateSearchTime, false, false,{
							disableMovement = true,
							disableCarMovement = false,
							disableMouse = false,
							disableCombat = true,
						}, {
							animDict = "anim@scripted@heist@ig8_cash_dig@male@",
							anim = "action",
							flags = 49,
						}, {}, {}, function() -- Done
							--===== FIX BUG DUPE =====
							Wait(1000)
							fixbug_dupe()
							--========================
							TriggerServerEvent('dt-homkhobau:server:SearchSupplyCrate')
							ClearPedTasks(playerPed)
							FreezeEntityPosition(playerPed, false)
						end, function() -- Cancel
							ClearPedTasks(playerPed)
							FreezeEntityPosition(playerPed, false)
							QBCore.Functions.Notify('Mở hòm thất bại', 'error')
						end)
					else
						QBCore.Functions.Notify('Mở hòm thất bại', 'error')
					end
				end)
			else
				QBCore.Functions.Notify(Config.Lang["outrange"], 'error', 3500)
			end
		else
			QBCore.Functions.Notify(Config.Lang["nocrowbar"], 'error', 3500)
		end
end)

-- RegisterNetEvent('dt-homkhobau:client:SearchTobaccoCrate', function()
-- 	local playerPed = PlayerPedId()
-- 	local coords = GetEntityCoords(playerPed)
-- 	local nearbyObject, nearbyID
-- 	for i=1, #divingCrate, 1 do
-- 		if GetDistanceBetweenCoords(coords, GetEntityCoords(divingCrate[i]), false) < 2.0 then
-- 			nearbyObject, nearbyID = divingCrate[i], i
-- 		end
-- 	end
-- 	for i=1, #divingCrate2, 1 do
-- 		if GetDistanceBetweenCoords(coords, GetEntityCoords(divingCrate2[i]), false) < 2.0 then
-- 			nearbyObject, nearbyID = divingCrate2[i], i
-- 		end
-- 	end
-- 	for i=1, #divingCrate3, 1 do
-- 		if GetDistanceBetweenCoords(coords, GetEntityCoords(divingCrate3[i]), false) < 2.0 then
-- 			nearbyObject, nearbyID = divingCrate3[i], i
-- 		end
-- 	end
-- 	for i=1, #divingCrate4, 1 do
-- 		if GetDistanceBetweenCoords(coords, GetEntityCoords(divingCrate4[i]), false) < 2.0 then
-- 			nearbyObject, nearbyID = divingCrate4[i], i
-- 		end
-- 	end
-- 	QBCore.Functions.TriggerCallback('QBCore.Functions.HasItem', function(HasItem)
-- 		if HasItem then
-- 			if nearbyObject then
-- 				isPickingUp = true
-- 				DeleteObject(nearbyObject) 
-- 				spawnedCrate = spawnedCrate - 1
-- 				QBCore.Functions.Progressbar("search_dive_tobacco", Config.Lang["searchtobacco"], Config.CrateSearchTime, false, false,{
--                     disableMovement = true,
--                     disableCarMovement = false,
--                     disableMouse = false,
--                     disableCombat = true,
-- 				}, {
-- 					animDict = "anim@scripted@heist@ig8_cash_dig@male@",
-- 					anim = "action",
-- 					flags = 49,
-- 				}, {}, {}, function()	
--                 end)
-- 				Wait(Config.CrateSearchTime)

-- 				TriggerServerEvent('dt-homkhobau:server:SearchTobaccoCrate')
-- 				ClearPedTasks(playerPed)
-- 			else
-- 				QBCore.Functions.Notify(Config.Lang["outrange"], 'error', 3500)
-- 			end
-- 		else
-- 			QBCore.Functions.Notify(Config.Lang["nocrowbar"], 'error', 3500)
-- 		end
-- 	end, Config.CrateSearchItem)
-- end)

-- RegisterNetEvent('dt-homkhobau:client:SearchJewelleryCrate', function()
-- 	local playerPed = PlayerPedId()
-- 	local coords = GetEntityCoords(playerPed)
-- 	local nearbyObject, nearbyID
-- 	for i=1, #divingCrate, 1 do
-- 		if GetDistanceBetweenCoords(coords, GetEntityCoords(divingCrate[i]), false) < 2.0 then
-- 			nearbyObject, nearbyID = divingCrate[i], i
-- 		end
-- 	end
-- 	for i=1, #divingCrate2, 1 do
-- 		if GetDistanceBetweenCoords(coords, GetEntityCoords(divingCrate2[i]), false) < 2.0 then
-- 			nearbyObject, nearbyID = divingCrate2[i], i
-- 		end
-- 	end
-- 	for i=1, #divingCrate3, 1 do
-- 		if GetDistanceBetweenCoords(coords, GetEntityCoords(divingCrate3[i]), false) < 2.0 then
-- 			nearbyObject, nearbyID = divingCrate3[i], i
-- 		end
-- 	end
-- 	for i=1, #divingCrate4, 1 do
-- 		if GetDistanceBetweenCoords(coords, GetEntityCoords(divingCrate4[i]), false) < 2.0 then
-- 			nearbyObject, nearbyID = divingCrate4[i], i
-- 		end
-- 	end
-- 	QBCore.Functions.TriggerCallback('QBCore.Functions.HasItem', function(HasItem)
-- 		if HasItem then
-- 			if nearbyObject then
-- 				isPickingUp = true
-- 				DeleteObject(nearbyObject) 
-- 				spawnedCrate = spawnedCrate - 1
-- 				JewellerySkillGame()	

-- 				ClearPedTasks(playerPed)
-- 			else
-- 				QBCore.Functions.Notify(Config.Lang["outrange"], 'error', 3500)
-- 			end
-- 		else
-- 			QBCore.Functions.Notify(Config.Lang["nolockpick"], 'error', 3500)
-- 		end
-- 	end, Config.JewellerySearchItem)
-- end)

-- function JewellerySkillGame()
-- 	local playerPed = PlayerPedId()
--     playAnim("anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_crouch_checkingleaves_idle_01_inspector", 35000)
-- 	local time = math.random(20,30)
-- 	local circles = math.random(2,4)
-- 	local success = exports['dt-lock']:StartLockPickCircle(circles, time, success)
-- 	if not success then
-- 		isActive = false
-- 		QBCore.Functions.Notify(Config.Lang["brokelockpick"], "error", 3500)
-- 		TriggerServerEvent("QBCore:Server:RemoveItem", "lockpick", 1)
-- 		TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["lockpick"], "remove")
-- 		ClearPedTasks(playerPed)
-- 	else
-- 		if not success then
-- 			isActive = false
-- 			QBCore.Functions.Notify(Config.Lang["brokelockpick"], "error", 3500)
-- 			TriggerServerEvent("QBCore:Server:RemoveItem", "lockpick", 1)
-- 			TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["lockpick"], "remove")
-- 			ClearPedTasks(playerPed)
-- 		else
-- 			if not success then
-- 				isActive = false
-- 				QBCore.Functions.Notify(Config.Lang["brokelockpick"], "error", 3500)
-- 				TriggerServerEvent("QBCore:Server:RemoveItem", "lockpick", 1)
-- 				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["lockpick"], "remove")
-- 				ClearPedTasks(playerPed)
-- 			else  
-- 				SearchJewellery()
-- 				ClearPedTasks(playerPed) 
-- 				FreezeEntityPosition(playerPed, false)
-- 			end
-- 		end
-- 	end
-- end

-- function SearchJewellery()
-- 	local playerPed = PlayerPedId()
-- 	local coords = GetEntityCoords(playerPed)
-- 	local nearbyObject, nearbyID
--[[	for i=1, #divingCrate, 1 do
		if GetDistanceBetweenCoords(coords, GetEntityCoords(divingCrate[i]), false) < 5.0 then
			nearbyObject, nearbyID = divingCrate[i], i
		end
	end
	for i=1, #divingCrate2, 1 do
		if GetDistanceBetweenCoords(coords, GetEntityCoords(divingCrate2[i]), false) < 2.0 then
			nearbyObject, nearbyID = divingCrate2[i], i
		end
	end
	for i=1, #divingCrate3, 1 do
		if GetDistanceBetweenCoords(coords, GetEntityCoords(divingCrate3[i]), false) < 2.0 then
			nearbyObject, nearbyID = divingCrate3[i], i
		end
	end
	for i=1, #divingCrate4, 1 do
		if GetDistanceBetweenCoords(coords, GetEntityCoords(divingCrate4[i]), false) < 2.0 then
			nearbyObject, nearbyID = divingCrate4[i], i
		end
	end
	if nearbyObject then]]
	-- 	isPickingUp = true
	-- 	DeleteObject(nearbyObject) 
	-- 	spawnedCrate = spawnedCrate - 1
	-- 	QBCore.Functions.Progressbar("search_dive_jewellery", Config.Lang["searchjewellery"], Config.JewellerySearchTime, false, false,{
    --         disableMovement = true,
    --         disableCarMovement = false,
    --         disableMouse = false,
    --         disableCombat = true,
	-- }, {
	-- 		animDict = "anim@scripted@heist@ig8_cash_dig@male@",
	-- 		anim = "action",
	-- 		flags = 49,
	-- }, {}, {}, function()	
    --     end)
	-- 	Wait(Config.JewellerySearchTime)

	-- 	TriggerServerEvent('dt-homkhobau:server:SearchJewelleryCrate')
	-- 	ClearPedTasks(playerPed)
	--else
	--	QBCore.Functions.Notify(Config.Lang["outrange"], 'error', 3500)
	--end
-- end

-- RegisterNetEvent('dt-homkhobau:client:SearchMedicalCrate', function()
-- 	local playerPed = PlayerPedId()
-- 	local coords = GetEntityCoords(playerPed)
-- 	local nearbyObject, nearbyID
-- 	for i=1, #divingCrate, 1 do
-- 		if GetDistanceBetweenCoords(coords, GetEntityCoords(divingCrate[i]), false) < 2.0 then
-- 			nearbyObject, nearbyID = divingCrate[i], i
-- 		end
-- 	end
-- 	for i=1, #divingCrate2, 1 do
-- 		if GetDistanceBetweenCoords(coords, GetEntityCoords(divingCrate2[i]), false) < 2.0 then
-- 			nearbyObject, nearbyID = divingCrate2[i], i
-- 		end
-- 	end
-- 	for i=1, #divingCrate3, 1 do
-- 		if GetDistanceBetweenCoords(coords, GetEntityCoords(divingCrate3[i]), false) < 2.0 then
-- 			nearbyObject, nearbyID = divingCrate3[i], i
-- 		end
-- 	end
-- 	for i=1, #divingCrate4, 1 do
-- 		if GetDistanceBetweenCoords(coords, GetEntityCoords(divingCrate4[i]), false) < 2.0 then
-- 			nearbyObject, nearbyID = divingCrate4[i], i
-- 		end
-- 	end
-- 	QBCore.Functions.TriggerCallback('QBCore.Functions.HasItem', function(HasItem)
-- 		if HasItem then
-- 			if nearbyObject then
-- 				isPickingUp = true
-- 				DeleteObject(nearbyObject) 
-- 				spawnedCrate = spawnedCrate - 1
-- 				TriggerEvent("mhacking:show")
-- 				TriggerEvent("mhacking:start", math.random(4, 6), 45, HackingSuccess)	

-- 				ClearPedTasks(playerPed)
-- 			else
-- 				QBCore.Functions.Notify(Config.Lang["outrange"], 'error', 3500)
-- 			end
-- 		else
-- 			QBCore.Functions.Notify(Config.Lang["nomedickey"], 'error', 3500)
-- 		end
-- 	end, Config.MedicalSearchItem)
-- end)

-- function HackingSuccess(success)
--     if success then
-- 		TriggerEvent('mhacking:hide')
--         TriggerServerEvent('dt-homkhobau:server:SearchMedicalCrate')
-- 		TriggerServerEvent("QBCore:Server:RemoveItem", "medickeycard", 1)
-- 		TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["medickeycard"], "remove")
--     else
-- 		TriggerEvent('mhacking:hide')
-- 		TriggerServerEvent("QBCore:Server:RemoveItem", "medickeycard", 1)
-- 		TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["medickeycard"], "remove")	
-- 	end
-- end

-- RegisterNetEvent('dt-homkhobau:client:SearchAntiqueBox', function()
-- 	local playerPed = PlayerPedId()
-- 	local coords = GetEntityCoords(playerPed)
-- 	local nearbyObject, nearbyID
-- 	for i=1, #divingCrate, 1 do
-- 		if GetDistanceBetweenCoords(coords, GetEntityCoords(divingCrate[i]), false) < 2.0 then
-- 			nearbyObject, nearbyID = divingCrate[i], i
-- 		end
-- 	end
-- 	for i=1, #divingCrate2, 1 do
-- 		if GetDistanceBetweenCoords(coords, GetEntityCoords(divingCrate2[i]), false) < 2.0 then
-- 			nearbyObject, nearbyID = divingCrate2[i], i
-- 		end
-- 	end
-- 	for i=1, #divingCrate3, 1 do
-- 		if GetDistanceBetweenCoords(coords, GetEntityCoords(divingCrate3[i]), false) < 2.0 then
-- 			nearbyObject, nearbyID = divingCrate3[i], i
-- 		end
-- 	end
-- 	for i=1, #divingCrate4, 1 do
-- 		if GetDistanceBetweenCoords(coords, GetEntityCoords(divingCrate4[i]), false) < 2.0 then
-- 			nearbyObject, nearbyID = divingCrate4[i], i
-- 		end
-- 	end
-- 	QBCore.Functions.TriggerCallback('QBCore.Functions.HasItem', function(HasItem)
-- 		if HasItem then
-- 			if nearbyObject then
-- 				isPickingUp = true
-- 				DeleteObject(nearbyObject) 
-- 				spawnedCrate = spawnedCrate - 1
-- 				AntiqueSkillGame()	

-- 				ClearPedTasks(playerPed)
-- 			else
-- 				QBCore.Functions.Notify(Config.Lang["outrange"], 'error', 3500)
-- 			end
-- 		else
-- 			QBCore.Functions.Notify(Config.Lang["noadvlockpick"], 'error', 3500)
-- 		end
-- 	end, Config.AntiqueSearchItem)
-- end)
-- Antique box skill game -- required; tgiann-skillbar
-- function AntiqueSkillGame()
-- 	local playerPed = PlayerPedId()
--     playAnim("anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_crouch_checkingleaves_idle_01_inspector", 35000)
-- 	local time = math.random(20,30)
-- 	local circles = math.random(2,4)
-- 	local success = exports['dt-lock']:StartLockPickCircle(circles, time, success)
-- 	if not success then
-- 		isActive = false
-- 		QBCore.Functions.Notify(Config.Lang["failedbox"], "error", 3500)
-- 		ClearPedTasks(playerPed)
-- 	else
-- 		if not success then
-- 			isActive = false
-- 			QBCore.Functions.Notify(Config.Lang["failedbox"], "error", 3500)
-- 			ClearPedTasks(playerPed)
-- 		else
-- 			if not success then
-- 				isActive = false
-- 				QBCore.Functions.Notify(Config.Lang["failedbox"], "error", 3500)
-- 				ClearPedTasks(playerPed)
-- 			else  
-- 				SearchAntique()
-- 				ClearPedTasks(playerPed) 
-- 				FreezeEntityPosition(playerPed, false)
-- 			end
-- 		end
-- 	end
-- end
-- Function to trigger search event
-- function SearchAntique()
-- 	local playerPed = PlayerPedId()
-- 	local coords = GetEntityCoords(playerPed)
-- 	local nearbyObject, nearbyID
--[[	for i=1, #divingCrate, 1 do
		if GetDistanceBetweenCoords(coords, GetEntityCoords(divingCrate[i]), false) < 2.0 then
			nearbyObject, nearbyID = divingCrate[i], i
		end
	end
	for i=1, #divingCrate2, 1 do
		if GetDistanceBetweenCoords(coords, GetEntityCoords(divingCrate2[i]), false) < 2.0 then
			nearbyObject, nearbyID = divingCrate2[i], i
		end
	end
	for i=1, #divingCrate3, 1 do
		if GetDistanceBetweenCoords(coords, GetEntityCoords(divingCrate3[i]), false) < 2.0 then
			nearbyObject, nearbyID = divingCrate3[i], i
		end
	end
	for i=1, #divingCrate4, 1 do
		if GetDistanceBetweenCoords(coords, GetEntityCoords(divingCrate4[i]), false) < 2.0 then
			nearbyObject, nearbyID = divingCrate4[i], i
		end
	end
	if nearbyObject then]]
	-- 	isPickingUp = true
	-- 	DeleteObject(nearbyObject) 
	-- 	spawnedCrate = spawnedCrate - 1
	-- 	QBCore.Functions.Progressbar("search_dive_antique", Config.Lang["searchantique"], Config.AntiqueSearchTime, false, false,{
    --         disableMovement = true,
    --         disableCarMovement = false,
    --         disableMouse = false,
    --         disableCombat = true,
	-- }, {
	-- 		animDict = "anim@scripted@heist@ig8_cash_dig@male@",
	-- 		anim = "action",
	-- 		flags = 49,
	-- }, {}, {}, function()	
    --     end)
	-- 	Wait(Config.AntiqueSearchTime)

	-- 	TriggerServerEvent('dt-homkhobau:server:SearchAntiqueBox')
	-- 	ClearPedTasks(playerPed)
--	else
--		QBCore.Functions.Notify(Config.Lang["outrange"], 'error', 3500)
--	end
-- end
--<!>-- ANTIQUE BOX CODE END --<!>--

--<!>-- JEWELLERY BAG CODE START --<!>--
-- RegisterNetEvent('dt-homkhobau:client:JewelleryBag', function()
-- 	QBCore.Functions.Progressbar("diving_opendoc", Config.Lang["openjewel"], Config.JewelleryBagOpenTime, false, false, {
--         disableMovement = true,
--         disableCarMovement = false,
-- 		disableMouse = false,
-- 		disableCombat = true,
-- 	}, {
--         animDict = "amb@prop_human_parking_meter@female@base",
--         anim = "base_female",
--         flags = 49,
--     }, {}, {}, function()
-- 	TriggerServerEvent("QBCore:Server:RemoveItem", "jewellerybag", 1)
-- 	TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["jewellerybag"], "remove")
-- 	TriggerServerEvent("dt-homkhobau:server:JewelleryBag")
-- 	end)
-- end)
--<!>-- JEWELLERY BAG CODE END --<!>--

--<!>-- DOCUMENT TUBE CODE START --<!>--
-- RegisterNetEvent('dt-homkhobau:client:DocumentTube', function()
-- 	QBCore.Functions.Progressbar("diving_opendoc", Config.Lang["opendoctube"], Config.DocumentTubeOpenTime, false, false, {
--         disableMovement = true,
--         disableCarMovement = false,
-- 		disableMouse = false,
-- 		disableCombat = true,
-- 	}, {
--         animDict = "amb@prop_human_parking_meter@female@base",
--         anim = "base_female",
--         flags = 49,
--     }, {}, {}, function()
-- 	TriggerServerEvent("QBCore:Server:RemoveItem", "documenttube", 1)
-- 	TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["documenttube"], "remove")
-- 	TriggerServerEvent("dt-homkhobau:server:DocumentTube")
-- 	end)
-- end)
--<!>-- DOCUMENT TUBE CODE END --<!>--

-----------------------------------------------------------------------------------------------------------------------------------------------------
--<!>-- **DO NOT CHANGE ANYTHING BELOW HERE UNLESS YOU KNOW WHAT YOU ARE DOING! SUPPORT WILL NOT BE PROVIDED IF YOU BREAK THINGS BELOW HERE** --<!>--
-- Animations function
function playAnim(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do 
      Wait(0) 
    end
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
    RemoveAnimDict(animDict)
end
--<!>-- START DIVING ZONE 1 --<!>--
-- Get coords for player and diving zone
CreateThread(function()
	while true do
		Wait(10)
		local coords = GetEntityCoords(PlayerPedId())
		if GetDistanceBetweenCoords(coords, Config.DivingZone1, true) < 50 then
			SpawnDivingCrates()
			Wait(500)
		else
			Wait(500)
		end
	end
end)
-- Deletes the spawned crates on stop
AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(divingCrate) do
			DeleteObject(v)
		end
	end
end)
-- Spawns the crates
function SpawnObject(model, coords, cb)
	local model = (type(model) == 'number' and model or GetHashKey(model))
	RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(1)
	end
    local obj = CreateObject(model, coords.x, coords.y, coords.z, false, false, true)
    SetModelAsNoLongerNeeded(model)
    PlaceObjectOnGroundProperly(obj)
    FreezeEntityPosition(obj, true)
    if cb then
        cb(obj)
    end
end
-- Gen coords for crates
function SpawnDivingCrates()
	while spawnedCrate < 28 do
		Wait(1)
		local crateCoords = GenCrateCoords()
		SpawnObject('prop_drop_crate_01_set2', crateCoords, function(obj)
			table.insert(divingCrate, obj)
			spawnedCrate = spawnedCrate + 1
		end)
		-- local crateCoords = GenCrateCoords2()
		-- SpawnObject('sm_prop_smug_crate_s_tobacco', crateCoords, function(obj)
		-- 	table.insert(divingCrate, obj)
		-- 	spawnedCrate = spawnedCrate + 1
		-- end)
		-- local crateCoords = GenCrateCoords3()
		-- SpawnObject('sm_prop_smug_crate_s_medical', crateCoords, function(obj)
		-- 	table.insert(divingCrate, obj)
		-- 	spawnedCrate = spawnedCrate + 1
		-- end)
		-- local crateCoords = GenCrateCoords4()
		-- SpawnObject('sm_prop_smug_crate_s_jewellery', crateCoords, function(obj)
		-- 	table.insert(divingCrate, obj)
		-- 	spawnedCrate = spawnedCrate + 1
		-- end)
		-- local crateCoords = GenCrateCoords5()
		-- SpawnObject('ba_prop_battle_antique_box', crateCoords, function(obj)
		-- 	table.insert(divingCrate, obj)
		-- 	spawnedCrate = spawnedCrate + 1
		-- end)
	end
end 
-- Coord validation
function ValCrateCoords(crateCoord)
	if spawnedCrate > 0 then
		local validate = true
		for k, v in pairs(divingCrate) do
			if GetDistanceBetweenCoords(crateCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end
		if GetDistanceBetweenCoords(crateCoord, Config.DivingZone1, false) > 50 or GetDistanceBetweenCoords(crateCoord, Config.DivingZone2, false) > 50 or GetDistanceBetweenCoords(crateCoord, Config.DivingZone3, false) > 50 or GetDistanceBetweenCoords(crateCoord, Config.DivingZone4, false) > 50 then
			validate = false
		end
		return validate
	else
		return true
	end
end
-- Generate supply crate coords
function GenCrateCoords()
	while true do
		Wait(1)
		local crateCoordX, crateCoordY
		math.randomseed(GetGameTimer())
		local modX = math.random(-100, 50)
		Wait(100)
		math.randomseed(GetGameTimer())
		local modY = math.random(-100, 30)
		crateCoordX = Config.DivingZone1.x + modX
		crateCoordY = Config.DivingZone1.y + modY
		local coordZ = GetCoordZCrate(crateCoordX, crateCoordY)
		local coord = vector3(crateCoordX, crateCoordY, coordZ)
		if ValCrateCoords(coord) then
			return coord
		end
	end
end
-- -- Generate estancia crate coords
-- function GenCrateCoords2()
-- 	while true do
-- 		Wait(1)
-- 		local crateCoordX, crateCoordY
-- 		math.randomseed(GetGameTimer())
-- 		local modX = math.random(-120, 90)
-- 		Wait(100)
-- 		math.randomseed(GetGameTimer())
-- 		local modY = math.random(-90, 100)
-- 		crateCoordX = Config.DivingZone1.x + modX
-- 		crateCoordY = Config.DivingZone1.y + modY
-- 		local coordZ = GetCoordZCrate(crateCoordX, crateCoordY)
-- 		local coord = vector3(crateCoordX, crateCoordY, coordZ)
-- 		if ValCrateCoords(coord) then
-- 			return coord
-- 		end
-- 	end
-- end
-- -- Generate medical crate coords
-- function GenCrateCoords3()
-- 	while true do
-- 		Wait(1)
-- 		local crateCoordX, crateCoordY
-- 		math.randomseed(GetGameTimer())
-- 		local modX = math.random(-110, 110)
-- 		Wait(100)
-- 		math.randomseed(GetGameTimer())
-- 		local modY = math.random(-50, 80)
-- 		crateCoordX = Config.DivingZone1.x + modX
-- 		crateCoordY = Config.DivingZone1.y + modY
-- 		local coordZ = GetCoordZCrate(crateCoordX, crateCoordY)
-- 		local coord = vector3(crateCoordX, crateCoordY, coordZ)
-- 		if ValCrateCoords(coord) then
-- 			return coord
-- 		end
-- 	end
-- end
-- -- Generate jewellery crate coords
-- function GenCrateCoords4()
-- 	while true do
-- 		Wait(1)
-- 		local crateCoordX, crateCoordY
-- 		math.randomseed(GetGameTimer())
-- 		local modX = math.random(-130, 110)
-- 		Wait(100)
-- 		math.randomseed(GetGameTimer())
-- 		local modY = math.random(-50, 90)
-- 		crateCoordX = Config.DivingZone1.x + modX
-- 		crateCoordY = Config.DivingZone1.y + modY
-- 		local coordZ = GetCoordZCrate(crateCoordX, crateCoordY)
-- 		local coord = vector3(crateCoordX, crateCoordY, coordZ)
-- 		if ValCrateCoords(coord) then
-- 			return coord
-- 		end
-- 	end
-- end
-- -- Generate jewellery box coords
-- function GenCrateCoords5()
-- 	while true do
-- 		Wait(1)
-- 		local crateCoordX, crateCoordY
-- 		math.randomseed(GetGameTimer())
-- 		local modX = math.random(-60, 150)
-- 		Wait(100)
-- 		math.randomseed(GetGameTimer())
-- 		local modY = math.random(-190, 190)
-- 		crateCoordX = Config.DivingZone1.x + modX
-- 		crateCoordY = Config.DivingZone1.y + modY
-- 		local coordZ = GetCoordZCrate(crateCoordX, crateCoordY)
-- 		local coord = vector3(crateCoordX, crateCoordY, coordZ)
-- 		if ValCrateCoords(coord) then
-- 			return coord
-- 		end
-- 	end
-- end

--<!>-- START DIVING ZONE 2 --<!>--
-- Get coords for player and diving zone
CreateThread(function()
	while true do
		Wait(10)
		local coords = GetEntityCoords(PlayerPedId())
		if GetDistanceBetweenCoords(coords, Config.DivingZone2, true) < 50 then
			SpawnDivingCrates2()
			Wait(500)
		else
			Wait(500)
		end
	end
end)
-- Deletes the spawned crates on stop
AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(divingCrate2) do
			DeleteObject(v)
		end
	end
end)
-- Spawns the crates
function SpawnCrate2(model, coords, cb)
	local model = (type(model) == 'number' and model or GetHashKey(model))
	RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(1)
	end
    local obj = CreateObject(model, coords.x, coords.y, coords.z, false, false, true)
    SetModelAsNoLongerNeeded(model)
    PlaceObjectOnGroundProperly(obj)
    FreezeEntityPosition(obj, true)
    if cb then
        cb(obj)
    end
end
-- Gen coords for crates
function SpawnDivingCrates2()
	while spawnedCrate2 < 28 do
		Wait(1)
		local crateCoord2 = GenCrateCoordsA()
		SpawnCrate2('prop_drop_crate_01_set2', crateCoord2, function(obj)
			table.insert(divingCrate2, obj)
			spawnedCrate2 = spawnedCrate2 + 1
		end)
		-- local crateCoord2 = GenCrateCoords2A()
		-- SpawnCrate2('sm_prop_smug_crate_s_tobacco', crateCoord2, function(obj)
		-- 	table.insert(divingCrate2, obj)
		-- 	spawnedCrate2 = spawnedCrate2 + 1
		-- end)
		-- local crateCoord2 = GenCrateCoords3A()
		-- SpawnCrate2('sm_prop_smug_crate_s_medical', crateCoord2, function(obj)
		-- 	table.insert(divingCrate2, obj)
		-- 	spawnedCrate2 = spawnedCrate2 + 1
		-- end)
		-- local crateCoord2 = GenCrateCoords4A()
		-- SpawnCrate2('sm_prop_smug_crate_s_jewellery', crateCoord2, function(obj)
		-- 	table.insert(divingCrate2, obj)
		-- 	spawnedCrate2 = spawnedCrate2 + 1
		-- end)
		-- local crateCoord2 = GenCrateCoords5A()
		-- SpawnCrate2('ba_prop_battle_antique_box', crateCoord2, function(obj)
		-- 	table.insert(divingCrate2, obj)
		-- 	spawnedCrate2 = spawnedCrate2 + 1
		-- end)
	end
end 
-- Coord validation
function ValCrateCoords2(crateCoord)
	if spawnedCrate2 > 0 then
		local validate = true
		for k, v in pairs(divingCrate2) do
			if GetDistanceBetweenCoords(crateCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end
		if GetDistanceBetweenCoords(crateCoord, Config.DivingZone2, false) > 50 then
			validate = false
		end
		return validate
	else
		return true
	end
end
-- Generate supply crate coords
function GenCrateCoordsA()
	while true do
		Wait(1)
		local crateCoordX, crateCoordY
		math.randomseed(GetGameTimer())
		local modX = math.random(-70, 50)
		Wait(100)
		math.randomseed(GetGameTimer())
		local modY = math.random(-75, 80)
		crateCoordX = Config.DivingZone2.x + modX
		crateCoordY = Config.DivingZone2.y + modY
		local coordZ = GetCoordZCrate(crateCoordX, crateCoordY)
		local coord = vector3(crateCoordX, crateCoordY, coordZ)
		if ValCrateCoords2(coord) then
			return coord
		end
	end
end
-- -- Generate estancia crate coords
-- function GenCrateCoords2A()
-- 	while true do
-- 		Wait(1)
-- 		local crateCoordX, crateCoordY
-- 		math.randomseed(GetGameTimer())
-- 		local modX = math.random(-120, 90)
-- 		Wait(100)
-- 		math.randomseed(GetGameTimer())
-- 		local modY = math.random(-90, 100)
-- 		crateCoordX = Config.DivingZone2.x + modX
-- 		crateCoordY = Config.DivingZone2.y + modY
-- 		local coordZ = GetCoordZCrate(crateCoordX, crateCoordY)
-- 		local coord = vector3(crateCoordX, crateCoordY, coordZ)
-- 		if ValCrateCoords2(coord) then
-- 			return coord
-- 		end
-- 	end
-- end
-- -- Generate medical crate coords
-- function GenCrateCoords3A()
-- 	while true do
-- 		Wait(1)
-- 		local crateCoordX, crateCoordY
-- 		math.randomseed(GetGameTimer())
-- 		local modX = math.random(-110, 110)
-- 		Wait(100)
-- 		math.randomseed(GetGameTimer())
-- 		local modY = math.random(-50, 80)
-- 		crateCoordX = Config.DivingZone2.x + modX
-- 		crateCoordY = Config.DivingZone2.y + modY
-- 		local coordZ = GetCoordZCrate(crateCoordX, crateCoordY)
-- 		local coord = vector3(crateCoordX, crateCoordY, coordZ)
-- 		if ValCrateCoords2(coord) then
-- 			return coord
-- 		end
-- 	end
-- end
-- -- Generate jewellery crate coords
-- function GenCrateCoords4A()
-- 	while true do
-- 		Wait(1)
-- 		local crateCoordX, crateCoordY
-- 		math.randomseed(GetGameTimer())
-- 		local modX = math.random(-130, 130)
-- 		Wait(100)
-- 		math.randomseed(GetGameTimer())
-- 		local modY = math.random(-90, 90)
-- 		crateCoordX = Config.DivingZone2.x + modX
-- 		crateCoordY = Config.DivingZone2.y + modY
-- 		local coordZ = GetCoordZCrate(crateCoordX, crateCoordY)
-- 		local coord = vector3(crateCoordX, crateCoordY, coordZ)
-- 		if ValCrateCoords2(coord) then
-- 			return coord
-- 		end
-- 	end
-- end
-- -- Generate jewellery box coords
-- function GenCrateCoords5A()
-- 	while true do
-- 		Wait(1)
-- 		local crateCoordX, crateCoordY
-- 		math.randomseed(GetGameTimer())
-- 		local modX = math.random(-60, 150)
-- 		Wait(100)
-- 		math.randomseed(GetGameTimer())
-- 		local modY = math.random(-190, 190)
-- 		crateCoordX = Config.DivingZone2.x + modX
-- 		crateCoordY = Config.DivingZone2.y + modY
-- 		local coordZ = GetCoordZCrate(crateCoordX, crateCoordY)
-- 		local coord = vector3(crateCoordX, crateCoordY, coordZ)
-- 		if ValCrateCoords2(coord) then
-- 			return coord
-- 		end
-- 	end
-- end

--<!>-- START DIVING ZONE 3 --<!>--
-- Get coords for player and diving zone
CreateThread(function()
	while true do
		Wait(10)
		local coords = GetEntityCoords(PlayerPedId())
		if GetDistanceBetweenCoords(coords, Config.DivingZone3, true) < 50 then
			SpawnDivingCrates3()
			Wait(500)
		else
			Wait(500)
		end
	end
end)
-- Deletes the spawned crates on stop
AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(divingCrate3) do
			DeleteObject(v)
		end
	end
end)
-- Spawns the crates
function SpawnCrate3(model, coords, cb)
	local model = (type(model) == 'number' and model or GetHashKey(model))
	RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(1)
	end
    local obj = CreateObject(model, coords.x, coords.y, coords.z, false, false, true)
    SetModelAsNoLongerNeeded(model)
    PlaceObjectOnGroundProperly(obj)
    FreezeEntityPosition(obj, true)
    if cb then
        cb(obj)
    end
end
-- Function to spawn diving crates
function SpawnDivingCrates3()
	while spawnedCrate3 < 28 do
		Wait(1)
		local crateCoord3 = GenCrateCoordsB()
		SpawnCrate3('prop_drop_crate_01_set2', crateCoord3, function(obj)
			table.insert(divingCrate3, obj)
			spawnedCrate3 = spawnedCrate3 + 1
		end)
		-- local crateCoord3 = GenCrateCoords2B()
		-- SpawnCrate3('sm_prop_smug_crate_s_tobacco', crateCoord3, function(obj)
		-- 	table.insert(divingCrate3, obj)
		-- 	spawnedCrate3 = spawnedCrate3 + 1
		-- end)
		-- local crateCoord3 = GenCrateCoords3B()
		-- SpawnCrate3('sm_prop_smug_crate_s_medical', crateCoord3, function(obj)
		-- 	table.insert(divingCrate3, obj)
		-- 	spawnedCrate3 = spawnedCrate3 + 1
		-- end)
		-- local crateCoord3 = GenCrateCoords4B()
		-- SpawnCrate3('sm_prop_smug_crate_s_jewellery', crateCoord3, function(obj)
		-- 	table.insert(divingCrate3, obj)
		-- 	spawnedCrate3 = spawnedCrate3 + 1
		-- end)
		-- local crateCoord3 = GenCrateCoords5B()
		-- SpawnCrate3('ba_prop_battle_antique_box', crateCoord3, function(obj)
		-- 	table.insert(divingCrate3, obj)
		-- 	spawnedCrate3 = spawnedCrate3 + 1
		-- end)
	end
end 
-- Coord validation
function ValCrateCoords3(crateCoord)
	if spawnedCrate3 > 0 then
		local validate = true
		for k, v in pairs(divingCrate3) do
			if GetDistanceBetweenCoords(crateCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end
		if GetDistanceBetweenCoords(crateCoord, Config.DivingZone3, false) > 50 then
			validate = false
		end
		return validate
	else
		return true
	end
end
-- Generate supply crate coords
function GenCrateCoordsB()
	while true do
		Wait(1)
		local crateCoordX, crateCoordY
		math.randomseed(GetGameTimer())
		local modX = math.random(-70, 50)
		Wait(100)
		math.randomseed(GetGameTimer())
		local modY = math.random(-75, 80)
		crateCoordX = Config.DivingZone3.x + modX
		crateCoordY = Config.DivingZone3.y + modY
		local coordZ = GetCoordZCrate(crateCoordX, crateCoordY)
		local coord = vector3(crateCoordX, crateCoordY, coordZ)
		if ValCrateCoords3(coord) then
			return coord
		end
	end
end
-- -- Generate estancia crate coords
-- function GenCrateCoords2B()
-- 	while true do
-- 		Wait(1)
-- 		local crateCoordX, crateCoordY
-- 		math.randomseed(GetGameTimer())
-- 		local modX = math.random(-120, 90)
-- 		Wait(100)
-- 		math.randomseed(GetGameTimer())
-- 		local modY = math.random(-90, 100)
-- 		crateCoordX = Config.DivingZone3.x + modX
-- 		crateCoordY = Config.DivingZone3.y + modY
-- 		local coordZ = GetCoordZCrate(crateCoordX, crateCoordY)
-- 		local coord = vector3(crateCoordX, crateCoordY, coordZ)
-- 		if ValCrateCoords3(coord) then
-- 			return coord
-- 		end
-- 	end
-- end
-- -- Generate medical crate coords
-- function GenCrateCoords3B()
-- 	while true do
-- 		Wait(1)
-- 		local crateCoordX, crateCoordY
-- 		math.randomseed(GetGameTimer())
-- 		local modX = math.random(-110, 110)
-- 		Wait(100)
-- 		math.randomseed(GetGameTimer())
-- 		local modY = math.random(-50, 80)
-- 		crateCoordX = Config.DivingZone3.x + modX
-- 		crateCoordY = Config.DivingZone3.y + modY
-- 		local coordZ = GetCoordZCrate(crateCoordX, crateCoordY)
-- 		local coord = vector3(crateCoordX, crateCoordY, coordZ)
-- 		if ValCrateCoords3(coord) then
-- 			return coord
-- 		end
-- 	end
-- end
-- -- Generate jewellery crate coords
-- function GenCrateCoords4B()
-- 	while true do
-- 		Wait(1)
-- 		local crateCoordX, crateCoordY
-- 		math.randomseed(GetGameTimer())
-- 		local modX = math.random(-130, 130)
-- 		Wait(100)
-- 		math.randomseed(GetGameTimer())
-- 		local modY = math.random(-90, 90)
-- 		crateCoordX = Config.DivingZone3.x + modX
-- 		crateCoordY = Config.DivingZone3.y + modY
-- 		local coordZ = GetCoordZCrate(crateCoordX, crateCoordY)
-- 		local coord = vector3(crateCoordX, crateCoordY, coordZ)
-- 		if ValCrateCoords3(coord) then
-- 			return coord
-- 		end
-- 	end
-- end
-- -- Generate jewellery box coords
-- function GenCrateCoords5B()
-- 	while true do
-- 		Wait(1)
-- 		local crateCoordX, crateCoordY
-- 		math.randomseed(GetGameTimer())
-- 		local modX = math.random(-60, 150)
-- 		Wait(100)
-- 		math.randomseed(GetGameTimer())
-- 		local modY = math.random(-190, 190)
-- 		crateCoordX = Config.DivingZone3.x + modX
-- 		crateCoordY = Config.DivingZone3.y + modY
-- 		local coordZ = GetCoordZCrate(crateCoordX, crateCoordY)
-- 		local coord = vector3(crateCoordX, crateCoordY, coordZ)
-- 		if ValCrateCoords3(coord) then
-- 			return coord
-- 		end
-- 	end
-- end

--<!>-- START DIVING ZONE 4 --<!>--
-- Get coords for player and diving zone
CreateThread(function()
	while true do
		Wait(10)
		local coords = GetEntityCoords(PlayerPedId())
		if GetDistanceBetweenCoords(coords, Config.DivingZone4, true) < 50 then
			SpawnDivingCrates4()
			Wait(500)
		else
			Wait(500)
		end
	end
end)
-- Deletes the spawned crates on stop
AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(divingCrate4) do
			DeleteObject(v)
		end
	end
end)
-- Spawns the crates
function SpawnCrate4(model, coords, cb)
	local model = (type(model) == 'number' and model or GetHashKey(model))
	RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(1)
	end
    local obj = CreateObject(model, coords.x, coords.y, coords.z, false, false, true)
    SetModelAsNoLongerNeeded(model)
    PlaceObjectOnGroundProperly(obj)
    FreezeEntityPosition(obj, true)
    if cb then
        cb(obj)
    end
end
-- Gen coords for crates
function SpawnDivingCrates4()
	while spawnedCrate4 < 28 do
		Wait(1)
		local crateCoord4 = GenCrateCoordsC()
		SpawnCrate4('prop_drop_crate_01_set2', crateCoord4, function(obj)
			table.insert(divingCrate4, obj)
			spawnedCrate4 = spawnedCrate4 + 1
		end)
		-- local crateCoord4 = GenCrateCoords2C()
		-- SpawnCrate4('sm_prop_smug_crate_s_tobacco', crateCoord4, function(obj)
		-- 	table.insert(divingCrate4, obj)
		-- 	spawnedCrate4 = spawnedCrate4 + 1
		-- end)
		-- local crateCoord4 = GenCrateCoords3C()
		-- SpawnCrate4('sm_prop_smug_crate_s_medical', crateCoord4, function(obj)
		-- 	table.insert(divingCrate4, obj)
		-- 	spawnedCrate4 = spawnedCrate4 + 1
		-- end)
		-- local crateCoord4 = GenCrateCoords4C()
		-- SpawnCrate4('sm_prop_smug_crate_s_jewellery', crateCoord4, function(obj)
		-- 	table.insert(divingCrate4, obj)
		-- 	spawnedCrate4 = spawnedCrate4 + 1
		-- end)
		-- local crateCoord4 = GenCrateCoords5C()
		-- SpawnCrate4('ba_prop_battle_antique_box', crateCoord4, function(obj)
		-- 	table.insert(divingCrate4, obj)
		-- 	spawnedCrate4 = spawnedCrate4 + 1
		-- end)
	end
end 
-- Coord validation
function ValCrateCoords4(crateCoord4)
	if spawnedCrate4 > 0 then
		local validate = true
		for k, v in pairs(divingCrate4) do
			if GetDistanceBetweenCoords(crateCoord4, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end
		if GetDistanceBetweenCoords(crateCoord4, Config.DivingZone4, false) > 50 then
			validate = false
		end
		return validate
	else
		return true
	end
end
-- -- Generate supply crate coords
function GenCrateCoordsC()
	while true do
		Wait(1)
		local crateCoordX, crateCoordY
		math.randomseed(GetGameTimer())
		local modX = math.random(-70, 50)
		Wait(100)
		math.randomseed(GetGameTimer())
		local modY = math.random(-75, 80)
		crateCoordX = Config.DivingZone4.x + modX
		crateCoordY = Config.DivingZone4.y + modY
		local coordZ = GetCoordZCrate(crateCoordX, crateCoordY)
		local coord = vector3(crateCoordX, crateCoordY, coordZ)
		if ValCrateCoords4(coord) then
			return coord
		end
	end
end
-- -- Generate estancia crate coords
-- function GenCrateCoords2C()
-- 	while true do
-- 		Wait(1)
-- 		local crateCoordX, crateCoordY
-- 		math.randomseed(GetGameTimer())
-- 		local modX = math.random(-120, 90)
-- 		Wait(100)
-- 		math.randomseed(GetGameTimer())
-- 		local modY = math.random(-90, 100)
-- 		crateCoordX = Config.DivingZone4.x + modX
-- 		crateCoordY = Config.DivingZone4.y + modY
-- 		local coordZ = GetCoordZCrate(crateCoordX, crateCoordY)
-- 		local coord = vector3(crateCoordX, crateCoordY, coordZ)
-- 		if ValCrateCoords4(coord) then
-- 			return coord
-- 		end
-- 	end
-- end
-- -- Generate medical crate coords
-- function GenCrateCoords3C()
-- 	while true do
-- 		Wait(1)
-- 		local crateCoordX, crateCoordY
-- 		math.randomseed(GetGameTimer())
-- 		local modX = math.random(-110, 110)
-- 		Wait(100)
-- 		math.randomseed(GetGameTimer())
-- 		local modY = math.random(-50, 80)
-- 		crateCoordX = Config.DivingZone4.x + modX
-- 		crateCoordY = Config.DivingZone4.y + modY
-- 		local coordZ = GetCoordZCrate(crateCoordX, crateCoordY)
-- 		local coord = vector3(crateCoordX, crateCoordY, coordZ)
-- 		if ValCrateCoords4(coord) then
-- 			return coord
-- 		end
-- 	end
-- end
-- -- Generate jewellery crate coords
-- function GenCrateCoords4C()
-- 	while true do
-- 		Wait(1)
-- 		local crateCoordX, crateCoordY
-- 		math.randomseed(GetGameTimer())
-- 		local modX = math.random(-130, 130)
-- 		Wait(100)
-- 		math.randomseed(GetGameTimer())
-- 		local modY = math.random(-90, 90)
-- 		crateCoordX = Config.DivingZone4.x + modX
-- 		crateCoordY = Config.DivingZone4.y + modY
-- 		local coordZ = GetCoordZCrate(crateCoordX, crateCoordY)
-- 		local coord = vector3(crateCoordX, crateCoordY, coordZ)
-- 		if ValCrateCoords4(coord) then
-- 			return coord
-- 		end
-- 	end
-- end
-- -- Generate jewellery box coords
-- function GenCrateCoords5C()
-- 	while true do
-- 		Wait(1)
-- 		local crateCoordX, crateCoordY
-- 		math.randomseed(GetGameTimer())
-- 		local modX = math.random(-60, 150)
-- 		Wait(100)
-- 		math.randomseed(GetGameTimer())
-- 		local modY = math.random(-190, 190)
-- 		crateCoordX = Config.DivingZone4.x + modX
-- 		crateCoordY = Config.DivingZone4.y + modY
-- 		local coordZ = GetCoordZCrate(crateCoordX, crateCoordY)
-- 		local coord = vector3(crateCoordX, crateCoordY, coordZ)
-- 		if ValCrateCoords4(coord) then
-- 			return coord
-- 		end
-- 	end
-- end
-- Check height coords
function GetCoordZCrate(x, y)
	local groundCheckHeights = { 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 35, 36.0, 37.0, 38.0, 39.0, 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0, 49.0, 50.0, 51.0, 52.0, 53.0, 54.0, 55.0 }
	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)
		if foundGround then
			return z
		end
	end
	return 2.00
end