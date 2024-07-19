local InSellZone = false
local CurrentSellZone = nil

CreateThread(function()
	while true do
		Wait(500)
		for k = 1, #Config.Main, 1 do
			v = Config.Main[k]
			local playerCoords = GetEntityCoords(PlayerPedId())
			local dist = #(playerCoords - vector3(v.coords.x, v.coords.y, v.coords.z))

			if dist < 15.0 and not v.isRendered then
				local ped = nearPed(v.model, vector3(v.coords.x, v.coords.y, v.coords.z), v.coords.w, v.animDict, v.animName, v.scenario)
				v.ped = ped
				v.isRendered = true
				CurrentSellZone = k
			end
			
			if v.isRendered then 
				if dist < 2.0 then 
					InSellZone = true 
					-- exports['qb-core']:DrawText("[E] - Nói Chuyện",  'left')
				else	
					if InSellZone then 
						-- exports['qb-core']:HideText()
					end 
					InSellZone = false 
				end 
			end 
			
			if dist >= 15.0 and v.isRendered then
				CurrentSellZone = nil
				DeletePed(v.ped)
				v.ped = nil
				v.isRendered = false
			end
		end
	end
end)

CreateThread(function() 
    exports['qb-target']:AddBoxZone("chamsoc_thucung", vector3(Config.Pet_Shop.x, Config.Pet_Shop.y, Config.Pet_Shop.z), 2, 2, {
        name = "chamsoc_thucung",
        heading = 0,
        debugPoly = false,
    }, {
        options = {
            -- {
            --     type = "client",
            --     event = "dt-chamsocthucung:client:cua_hang",
            --     icon = "fas fa-store",
            --     label = 'Cửa hàng chăm sóc thú cưng'
            -- },
			{
                type = "client",
                action = function(entity) 
                    TriggerEvent('dt-chamsocthucung:client:OpenMenu', CurrentSellZone)
                end,
                icon = "fas fa-paw",
                label = 'Giao lại thú cưng trưởng thành'
            },
        },
        distance = 2.5
    })
end)

function nearPed(model, coords, heading, animDict, animName, scenario)
	local genderNum = 0
--AddEventHandler('nearPed', function(model, coords, heading, gender, animDict, animName)
	-- Request the models of the peds from the server, so they can be ready to spawn.
	RequestModel(GetHashKey(model))
	while not HasModelLoaded(GetHashKey(model)) do
		Wait(1)
	end
		

	--Check if someones coordinate grabber thingy needs to subract 1 from Z or not.
	local x, y, z = table.unpack(coords)
	ped = CreatePed(3, GetHashKey(model), x, y, z - 1, heading, false, true)
		
	
	SetEntityAlpha(ped, 0, false)
	
	FreezeEntityPosition(ped, true) --Don't let the ped move.
	
	SetEntityInvincible(ped, true) --Don't let the ped die.

	SetBlockingOfNonTemporaryEvents(ped, true) --Don't let the ped react to his surroundings.
	
	--Add an animation to the ped, if one exists.
	if animDict and animName then
		RequestAnimDict(animDict)
		while not HasAnimDictLoaded(animDict) do
			Wait(1)
		end
		TaskPlayAnim(ped, animDict, animName, 8.0, 0, -1, 1, 0, 0, 0)
	end

	if scenario then
		TaskStartScenarioInPlace(ped, scenario, 0, true) -- begins peds animation
	end
	
	for i = 0, 255, 51 do
		Wait(50)
		SetEntityAlpha(ped, i, false)
	end

	return ped
end





