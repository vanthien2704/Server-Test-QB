--Main Creation Thread
Citizen.CreateThread(function()
	for _,v in pairs(Config.PedList) do
		RequestModel(GetHashKey(v.ped))
		while not HasModelLoaded(GetHashKey(v.ped)) do
			Wait(1)
		end
		ped = CreatePed(4, GetHashKey(v.ped), v.pos.x, v.pos.y, v.pos.z, v.pos.w, false, false)

		v.newPed = ped
		SetEntityHeading(ped, v.pos.w)
		FreezeEntityPosition(ped, true)
		SetEntityInvincible(ped, true)
		SetBlockingOfNonTemporaryEvents(ped, true)
			
		if v.blip.enabled then
		    blip = AddBlipForCoord(v.pos.x, v.pos.y, v.pos.z)
		    SetBlipSprite(blip, v.blip.sprite)
		    SetBlipScale(blip, v.blip.scale)
		    SetBlipAsShortRange(blip, v.blip.shortRange)
		    BeginTextCommandSetBlipName("STRING")
		    AddTextComponentString(v.blip.label)
		    EndTextCommandSetBlipName(blip) 
		end	
			
		if Config.useTarget then
			createTarget(v)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		if Config.useTarget then
			break;
		end
		local sleep = 5000
		local plyped = PlayerPedId()
		for _,v in pairs(Config.PedList) do
			if #(GetEntityCoords(plyped) - v.pos.xyz) < 20 then
				sleep = 0
				if #(GetEntityCoords(plyped) - v.pos.xyz) < 1.9 then
					ShowHelpNotification("Press ~INPUT_CONTEXT~ to ask "..v.name.." to repair your vehicle")
					if IsControlJustPressed(0, 51) then
						TriggerEvent("nvt_suaxepolice:startvehrepair", {name = v.name})
					end
				end
			end
		end
		Wait(sleep)
	end
end)


-- Function to check if a model name is in the allowed list
local function isModelAllowed(modelName)
    for _, allowedModel in ipairs(Config.carpolice) do
        if modelName == allowedModel then
            return true
        end
    end
    return false
end

AddEventHandler('nvt_suaxepolice:startvehrepair', function(data)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), true) -- Get the vehicle player is in
    local vehicleModel = GetEntityModel(vehicle) -- Get the vehicle model
    local modelName = GetDisplayNameFromVehicleModel(vehicleModel) -- Get the model name

    if isModelAllowed(modelName) then
        if Config.checkForOnlineMechanic then
            ServerCallback('nvt_suaxepolice:checkForMechanics', function(mechNum)
                print("Number of mechanics online: " .. mechNum) -- Debug print
                if mechNum > 0 then
                    ShowNotification('Có sửa xe trong thành phố, liên hệ với họ.')
                else
                    verRepFunc(data)
                end
            end)
        else
            verRepFunc(data)
        end
    else
        ShowNotification('Đây không phải là xe cảnh sát!')
    end
end)



function verRepFunc(data)
	local mechped = GetClosestMech()
	if mechped == nil then
		ShowNotification(data.name ..' đang bận, hãy đợi anh ấy')
	else
		startCarRepair(mechped)
	end
end


function createTarget(ent)
	exports.qtarget:AddTargetEntity(ent.newPed, {
		options = {
			{
				event = "nvt_suaxepolice:startvehrepair",
				icon = "fa-solid fa-wrench",
				label = "Sửa xe police",
				name = ent.name,
				jobType = "leo"
			},
		},
		distance = 1.5
	})
end
function startCarRepair(mech)
	local playerPed = PlayerPedId()
	if GetVehiclePedIsIn(playerPed, false) ~= 0 then
		ShowNotification('Get out of the vehicle.')
	else
		local veh = GetVehiclePedIsIn(playerPed,true)
		if veh then
			local engine = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh, "engine"))
			if engine == vector3(0.0, 0.0, 0.0) then
				engine = GetEntityCoords(veh)
			end
			if #(engine - mech.pos.xyz) < 20 then
				local repairCost = math.floor((1000 - GetVehicleEngineHealth(veh))/1000*Config.price*Config.DamageMultiplier)
				if Config.chargeForRepair then
					if getCash() >= repairCost then	
						ShowNotification(mech.name.." nói rằng anh ấy có thể sửa nó")
						TriggerServerEvent("nvt_suaxepolice:triggerServerSync", repairCost, mech, veh, engine)
					else
						ShowNotification('Bạn không đủ khả năng đó. Việc sửa chữa sẽ tốn $'..repairCost..' ')
					end	
				else
					ShowNotification(mech.name.." nói rằng anh ấy có thể sửa nó")
					TriggerServerEvent("nvt_suaxepolice:triggerServerSync", repairCost, mech, veh, engine)
				end
			else
				ShowNotification('Xe quá xa.')
			end
		else
			ShowNotification('Xe không được tìm thấy.')
		end
	end
end

RegisterNetEvent('nvt_suaxepolice:triggerClientSyncAnim')
AddEventHandler('nvt_suaxepolice:triggerClientSyncAnim', function(firstclmech, veh, engine)
	
	local mech = GetClosestMech(firstclmech.pos)
	FreezeEntityPosition(mech.newPed, false)
	TaskGoStraightToCoord(mech.newPed,engine.x, engine.y, engine.z, 1.0, 5000, (GetEntityHeading(veh)-180), 0)
	Wait(200)
	while #(engine.xyz - GetEntityCoords(mech.newPed, true)) > 2 do
		Wait(200)
	end

	Wait(1000)
	SetVehicleDoorOpen(veh, 4, false, false)

	TaskTurnPedToFaceCoord(mech.newPed, engine.x, engine.y, engine.z, -1)

	Wait(500)

	TaskStartScenarioInPlace(mech.newPed, "PROP_HUMAN_BUM_BIN", 0, 1)
	Wait(15000)

	ClearPedTasksImmediately(mech.newPed)

	SetVehicleFixed(veh)
    SetVehicleUndriveable(veh, false)
    SetVehicleEngineOn(veh, true, true)
	SetVehicleDoorShut(veh, 4, false)

	Wait(500)
	TaskGoStraightToCoord(mech.newPed, mech.pos.x, mech.pos.y, mech.pos.z+1, 1.0, 5000, mech.pos.w, 0)
	while #(mech.pos.xyz - GetEntityCoords(mech.newPed, true)) > 1.5 do
		Wait(200)
	end

	SetEntityHeading(mech.newPed, mech.pos.w) 
	

	
	FreezeEntityPosition(mech.newPed, true)
end)

function GetClosestMech(orgPos)
	if orgPos then
		for k,v in pairs(Config.PedList) do
			if #(orgPos.xyz - v.pos.xyz) < 2 then
				return v
			end
		end
	else
		for k,v in pairs(Config.PedList) do
			local pedCoords = GetEntityCoords(PlayerPedId(), true)
			if #(v.pos.xyz - pedCoords) < 2 then
				return v
			end
		end
	end
end

AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
	for k,v in pairs(Config.PedList) do
		DeleteEntity(v.newPed)
	end
end)

function ShowNotification(msg, _type)
	if GetResourceState('es_extended') == 'started' or GetResourceState('qb-core') == 'started' then
	     notify(msg, _type)
	else
	    if GetResourceState('nass_notifications') == 'started' then
		exports["nass_notifications"]:ShowNotification("alert", "Info", msg, 5000)
	    else
		BeginTextCommandThefeedPost('STRING')
		AddTextComponentSubstringPlayerName(msg)
		EndTextCommandThefeedPostTicker(0, 1)
	    end
	end
end

function ShowHelpNotification(msg)
	AddTextEntry('helpnotification', msg) 
	BeginTextCommandDisplayHelp('helpnotification')
	EndTextCommandDisplayHelp(0, false, false, -1) 
end
