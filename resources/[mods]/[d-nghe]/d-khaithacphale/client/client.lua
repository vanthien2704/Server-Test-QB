
CreateThread(function()
    exports['qb-target']:AddTargetModel(thaitu_dev.obj_model, {
        options = {
            {
                icon = 'fas fa-circle',
                label = 'Khai thác đá',
                -- item = 'advancedlockpick',
                action = function()
                    Khaithac()
                end,
            }
        },
        distance = 2.0,
    })
end)
function Khaithac()
	local time = math.random(5, 6)

    local success = exports["enjoy-minigame3"]:startGame(5, 2, 4, 5)---Kích thước slot, số cơ hội được đưa ra, số lượng cần thiết để giành chiến thắng, thời lượng ống (tính bằng giây)
	print(success)
    if success then
        QBCore.Functions.Progressbar("d-khaithac", "Đang khai thác..", 3000, false, false, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "amb@world_human_maid_clean@idle_a",
            anim = "idle_a",
        }, {}, {}, function()
            ClearPedTasks(PlayerPedId())
            TriggerServerEvent("d-khaithac:server:reward")
            DeleteObject(nearbyObject)
            table.remove(crabPlants, nearbyID)
            spawnedCrab = spawnedCrab - 1
        end, function()
            ClearPedTasks(PlayerPedId())
        end)
        local questId = 1 -- Replace with the actual quest ID
        TriggerServerEvent('QuestRewards', questId)
    else
        exports['bkNotify']:Alert("WINTER TOWN", "Khai thác thất bại", 5000, 'error')
        Wait(300)
    end
end
CreateThread(function()
	while true do
		Wait(10)
		sleep = 5000
		while onlineplayer do
			sleep = 10000
			
			local coords = GetEntityCoords(PlayerPedId())
			if #(coords - thaitu_dev.blips.jobCoords) < 300 then
				sleep = 1000
				SpawnCrabs()
			else
				sleep = 10000
			end
			Wait(sleep)
		end
	end
end)

-- CreateThread(function()
--     while true do
--         Wait(0)

--         local playerPed = PlayerPedId()
--         local coords = GetEntityCoords(playerPed)
--         local nearbyObject, nearbyID
        
--         for i=1, #crabPlants, 1 do
--             if #(coords - GetEntityCoords(crabPlants[i])) < 2.0 then
--                 nearbyObject, nearbyID = crabPlants[i], i
--                 break
--             end
--         end

--         if nearbyObject and IsPedOnFoot(playerPed) then
--             if not isPickingUp then
--                 exports["HB_TextUI"]:ShowHelpNotification("Nhấn ~INPUT_CONTEXT~ để khai thác")
--             end

--             if IsControlJustReleased(0, 38) and not isPickingUp then
--                 isPickingUp = true
--                 local time = math.random(5, 6)
--                 local success = false
--                 if exports["enjoy-minigame3"] then
--                     success = exports["enjoy-minigame3"]:startGame(5, 2, 4, 5)---Kích thước slot, số cơ hội được đưa ra, số lượng cần thiết để giành chiến thắng, thời lượng ống (tính bằng giây)
--                 end

--                 if success then
--                     QBCore.Functions.Progressbar("d-khaithac", "Đang khai thác..", 3000, false, false, {
--                         disableMovement = true,
--                         disableCarMovement = true,
--                         disableMouse = false,
--                         disableCombat = true,
--                     }, {
--                         animDict = "amb@world_human_maid_clean@idle_a",
--                         anim = "idle_a",
--                     }, {}, {}, function()
--                         isPickingUp = false
--                         ClearPedTasks(PlayerPedId())
--                         TriggerServerEvent("d-khaithac:server:reward")
--                         DeleteObject(nearbyObject)
--                         table.remove(crabPlants, nearbyID)
--                         spawnedCrab = spawnedCrab - 1
--                     end, function()
--                         ClearPedTasks(PlayerPedId())
--                     end)

--                     local questId = 1 -- Replace with the actual quest ID
--                     TriggerServerEvent('QuestRewards', questId)
--                 else
--                     exports['bkNotify']:Alert("WINTER TOWN", "Khai thác thất bại", 5000, 'error')
--                     Wait(300)
--                     isPickingUp = false
--                 end
--             end
--         end
--     end
-- end)

-- Example client-side code to trigger the QuestRewards event
-- Citizen.CreateThread(function()
--     -- Replace 'your_keybind_here' with the keybind or trigger condition you want
--     while true do
--         Citizen.Wait(0)
--         if IsControlJustPressed(0, your_keybind_here) then
--             local questId = 1  -- Example quest ID
--             TriggerServerEvent('QuestRewards', questId)
--         end
--     end
-- end)

function DoRequestModel(model)
    local hash = GetHashKey(model)
    if HasModelLoaded(hash) then
        return
    end

    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Citizen.Wait(100)
    end
end

function SpawnCrabs()
	while spawnedCrab < thaitu_dev.soluong do
		Wait(1)
			local coordcaynam = GenerateCoord()
			local x, y, z, h = table.unpack(coordcaynam)
			local hash = thaitu_dev.obj_model
			DoRequestModel(hash)
			
			local closest = GetClosestObjectOfType(x, y, z, 1.0, GetHashKey(hash), false)
			
			while closest ~= 0 do
				SetEntityAsMissionEntity(closest, true, true)
				DeleteEntity(closest)
				closest = GetClosestObjectOfType(x, y, z, 1.0, GetHashKey(hash), false)
				Wait(1)
			end
			Wait(500)
			--caycanxa = CreateObjectNoOffset(hash,x, y, z, true,false,false)
			caycanxa = CreateObject(hash,x, y, z, false,true,false)
			FreezeEntityPosition(caycanxa, true)
			table.insert(crabPlants, caycanxa)
			spawnedCrab = spawnedCrab + 1
			print(spawnedCrab)
	end
end

function ValidateCrabsCoord(plantCoord)
	if spawnedCrab > 0 then
		local validate = true

		for k, v in pairs(crabPlants) do
			if #(plantCoord - GetEntityCoords(v)) < 5 then
				validate = false
			end
		end

		if #(plantCoord - thaitu_dev.blips.jobCoords) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateCoord()
	while true do
		Citizen.Wait(1)

		local cradsCoordX, cradsCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-1, 1)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-30, 30)

		cradsCoordX = thaitu_dev.blips.jobCoords.x + modX
		cradsCoordY = thaitu_dev.blips.jobCoords.y + modY

		local waste, coordZ = GetGroundZFor_3dCoord(cradsCoordX, cradsCoordY, 999.0, true)
		local coord = vector3(cradsCoordX, cradsCoordY, coordZ)

		if ValidateCrabsCoord(coord) then
			return coord
		end
	end
end

function GetCoordZ(x, y)
	local groundCheckHeights = {1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0, 33.0, 34.0, 35.0, 36.0, 37.0, 38.0, 39.0, 40.0, 50.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 31.85
end

function IsInVehicle()
    local ped = PlayerPedId()
    if IsPedSittingInAnyVehicle(ped) then
        return true
    else
        return false
    end
end

function loadModel(model)
    if HasModelLoaded(model) then return end
	RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(10)
	end
end

function loadAnimDict(dict)
    if HasAnimDictLoaded(dict) then return end
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Wait(10)
	end
end

Draw2DText = function(x, y, text, scale)
    SetTextFont(4)
    SetTextProportional(7)
    SetTextScale(scale, scale)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
	SetTextCentre(true)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

DrawText3Ds = function(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z+0.5, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 211
    DrawRect(0.0, 0.0+0.0185, 0.017+ factor, 0.03, 0, 0, 0, 115)
    ClearDrawOrigin()
end

function Draw3DText(x, y, z, textInput, fontId, scaleX, scaleY)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = #(vector3(px, py, pz) - vector3(x, y, z))
    local scale = (1 / dist) * 20
    local fov = (1 / GetGameplayCamFov()) * 100
    scale = scale * fov
    SetTextScale(scaleX * scale, scaleY * scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextDropshadow(1, 1, 1, 1, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

for k,v in pairs(thaitu_dev.lonuong) do
	exports['qb-target']:AddCircleZone("khaithac"..k, v.vitri, 0.8, {
		name="khaithac"..k,
		-- debugPoly=true,
		}, {
			options = {
			{
				data = v.vitri,
				event = "d-khaithac:client:khaithac",
				icon = "fa-brands fa-canadian-maple-leaf",
				label = "Cắt Thạch Anh",
			},
		},
		job = {},
		distance = 4.0
})
end

local notuseprocess = false
RegisterNetEvent('d-khaithac:client:khaithac', function(data)
	local HasItem = QBCore.Functions.HasItem("cuabien", 1)
	if not notuseprocess then
		notuseprocess = true
		if HasItem then
			cuacon = CreateObject(GetHashKey('vk_cua'), data.data[1], data.data[2], data.data[3]+0.2, true, true, true)
			SetEntityRotation(cuacon,0, 0.0, 276.22, 1,true)
			QBCore.Functions.Progressbar("d-bat", "Đang mài..", 5000, false, true, {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			}, {
				animDict = "misscarsteal2mugging",
				anim = "mugging_action_mugger",
			}, {}, {}, function() -- Done
				notuseprocess = false
				ClearPedTasks(PlayerPedId())
				DeleteEntity(cuacon)
				TriggerServerEvent("d-khaithac:sv:khaithac")
			end, function()
				ClearPedTasks(PlayerPedId())
				notuseprocess = false
			end)
		else
			notuseprocess = false
			exports['bkNotify']:Alert("KHAI THÁC", "BẠN KHÔNG CÓ PHA LÊ CỤC NÀO !", 5000, 'error')
		end
	end
end)