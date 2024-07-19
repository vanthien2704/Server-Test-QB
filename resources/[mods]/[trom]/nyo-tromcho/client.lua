local player = PlayerPedId()
local entities = {} 
local Catching = false
local Holding = false
local CurrentHolding = nil
local IconBlip = nil
local RadiusBlip = nil
local CurrentCops = 0


RegisterNetEvent('police:SetCopCount', function(Amount)
	CurrentCops = Amount
end)

function IsPlayerInDogZone()
    local retval = false 
    local myPos = GetEntityCoords(PlayerPedId())
    if #(myPos - Config.ToaDo) <= Config.PhamVi then 
        retval = true 
    end 
    return retval
end 


Citizen.CreateThread(function()
	while true do 
		Wait(0)
		if true then
			if Config.HienBlip then 
				local Hours = GetClockHours()
				if Hours >= Config.MinTime and Hours <= Config.MaxTime then 
					if not DoesBlipExist(IconBlip) and not DoesBlipExist(RadiusBlip) then 
						IconBlip = AddBlipForCoord(Config.ToaDo)
						RadiusBlip = AddBlipForRadius(Config.ToaDo, Config.PhamVi)        
						SetBlipRotation(RadiusBlip, 0)
						SetBlipColour(RadiusBlip, Config.BigColour)
						SetBlipAlpha(RadiusBlip, Config.BigAlpha)
						SetBlipSprite (IconBlip, Config.Icon)
						SetBlipDisplay(IconBlip, 4)
						SetBlipScale  (IconBlip, Config.Scale)
						SetBlipAsShortRange(IconBlip, true)
						SetBlipColour(IconBlip, Config.Colour)
						SetBlipAlpha(IconBlip, Config.Alpha)

						BeginTextCommandSetBlipName("STRING")
						AddTextComponentSubstringPlayerName(Config.Title)	
						EndTextCommandSetBlipName(IconBlip)
					end 
				else 
					if DoesBlipExist(IconBlip) and DoesBlipExist(RadiusBlip) then 
						RemoveBlip(IconBlip)
						RemoveBlip(RadiusBlip)
					end
				end 
			end
		end
	end 
end)

AddEventHandler('onResourceStop', function(name)
    if GetCurrentResourceName() ~= name then
        return
    end

    for key, value in pairs(entities) do
        DeleteEntity(value)
    end
end)

function RequestAnimationDict(AnimDict)
	RequestAnimDict(AnimDict)
	while not HasAnimDictLoaded(AnimDict) do
		Citizen.Wait(1)
	end
end

Citizen.CreateThread(function()			 
	while true do
		Wait(100)	
		RandomChoSua = math.random(15000, 30000)
		if true then
			while Holding do
				Citizen.Wait(4)
				if not IsEntityPlayingAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 3) then
					RequestAnimationDict("anim@heists@box_carry@")
					TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 8.0, 8.0, -1, 50, 0, false, false, false)
				else
					Citizen.Wait(100)
				end
			end
			if Holding then 
				if DoesEntityExist(CurrentHolding) then
					TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 6.5, "chosua", 0.18)
					Wait(RandomChoSua)
				end 
			end
		end
	end
end)

function IsDog(entity)
    for i, ped in ipairs(Config.Peds) do
        if GetHashKey(ped) == GetEntityModel(entity) then
            return true
        end
    end
    return false
end

function GetNearbyPed()
	local retval = nil
	local PlayerPeds = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        table.insert(PlayerPeds, ped)
    end
    local player = PlayerPedId()
    local coords = GetEntityCoords(player)
	local closestPed, closestDistance = CoreName.Functions.GetClosestPed(coords, PlayerPeds)
	if not IsEntityDead(closestPed) and not IsPedHuman(closestPed) and IsDog(closestPed) and closestDistance < 2.0 then
		retval = closestPed
	end
	return retval
end

Citizen.CreateThread(function()
    while true do
        Wait(100)
        
        if CoreName.Functions.GetPlayerData().metadata["ishandcuffed"] or
           CoreName.Functions.GetPlayerData().metadata["isdead"] or
           CoreName.Functions.GetPlayerData().metadata["inlaststand"] then
           
           if Holding and DoesEntityExist(CurrentHolding) then
               DetachEntity(CurrentHolding, true, true)
               SetPedAsNoLongerNeeded(CurrentHolding)
               CurrentHolding = nil
               Holding = false
           end
           
        end
    end
end)


Citizen.CreateThread(function()			 
	while true do
		Wait(200)		
		if true then
			Wait(1500)
			local pos = GetEntityCoords(player, 1)
			local model = Config.Peds[math.random(1, #Config.Peds)]
			local Ground
			local Hours = GetClockHours()
			if Hours >= Config.MinTime and Hours <= Config.MaxTime then
				if IsPlayerInDogZone() then 
					if #entities < Config.MaxSpawn then
						RequestModel(model)
						while not HasModelLoaded(model) or not HasCollisionForModelLoaded(model) do
							Wait(1)
						end				
						posX = Config.ToaDo.x+math.random(-Config.PhamVi/2, Config.PhamVi/2)
						posY = Config.ToaDo.y+math.random(-Config.PhamVi/2, Config.PhamVi/2)
						Z = Config.ToaDo.z+999.0
						heading = math.random(0,359)+0.0

						Ground, posZ = GetGroundZFor_3dCoord(posX+0.0,posY+0.0,Z,1)

						if (Ground) then
							ped = CreatePed(28, model, posX, posY, posZ, heading, true, true)
							SetEntityAsMissionEntity(ped, true, true)
							TaskWanderStandard(ped, 10.0, 10)
							SetModelAsNoLongerNeeded(ped)
							table.insert(entities,ped)		   
							
							if Config.Debug then 
								local blip = AddBlipForEntity(ped)
								SetBlipSprite(blip, 1)
								SetBlipColour(blip, 0)
								BeginTextCommandSetBlipName("STRING")
								AddTextComponentString("CHÓ")
								EndTextCommandSetBlipName(blip)      
							end 
						end
					end
				else
					for i, ped in pairs(entities) do
						local model = GetEntityModel(ped)
						SetEntityAsNoLongerNeeded(ped)
						SetModelAsNoLongerNeeded(model)
						DeleteEntity(ped)
						table.remove(entities,i)	
					end
				end
			else 
				if CurrentHolding then 
					CurrentHolding = nil 
					ClearPedTasksImmediately()
				end 
				if Holding then 
					Holding = false 
					ClearPedTasksImmediately()
				end 
				for i, ped in pairs(entities) do
					local model = GetEntityModel(ped)
					SetEntityAsNoLongerNeeded(ped)
					SetModelAsNoLongerNeeded(model)
					DeleteEntity(ped)
					table.remove(entities,i)	
				end
			end

			for i, ped in pairs(entities) do
				if DoesEntityExist(ped) then 
					if not IsEntityAttached(ped) then 
						if IsEntityDead(ped) or IsEntityInWater(ped) then
							local model = GetEntityModel(ped)
							SetEntityAsNoLongerNeeded(ped)
							SetModelAsNoLongerNeeded(model)
							DeleteEntity(ped)
							table.remove(entities,i)	
						end 
					else 
						table.remove(entities,i)
					end
				else 
					table.remove(entities,i)
				end
			end

		end
	end
end)

local SucceededAttempts = 0

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		if true then
			local Hours = GetClockHours()
			if IsPlayerInDogZone() and Hours >= Config.MinTime and Hours <= Config.MaxTime then
				local playerPed = PlayerPedId()
				local pos = GetEntityCoords(playerPed)
				local ped = GetNearbyPed()
				local dogPos = GetEntityCoords(ped)
				local dist = #(pos - dogPos)
				if not IsPedInAnyVehicle(PlayerPedId()) then
					if dist <= 1.5 and not IsEntityAttached(ped) then 
						DrawText3Ds(dogPos.x, dogPos.y, dogPos.z+0.5, "~g~[E]~w~ - Bắt Chó") 
						if IsControlJustPressed(1, 38) and not Catching and not Holding then
							CopsCall()
							local dict = "anim@heists@box_carry@"
							RequestAnimDict(dict)
							while not HasAnimDictLoaded(dict) do
								RequestAnimDict(dict)
								Citizen.Wait(100)
							end
							if CurrentCops >= Config.CopRequired then 
								CoreName.Functions.TriggerCallback(''..Config.Framework..':HasItem', function(result)
									if result == true then
										Catching = true
										TriggerServerEvent(''..Config.Framework..':Server:RemoveItem', Config.VatPham, 1)
										local Skillbar = exports[Config.Skillbar.Type]:GetSkillbarObject()
										FreezeEntityPosition(ped, true)
										FreezeEntityPosition(playerPed, true)
										TriggerEvent('animations:client:EmoteCommandStart', {"mechanic2"})
										Skillbar.Start({
											duration = Config.Skillbar.Tocdo,
											pos = math.random(5, 15),
											width = math.random(10, 20),
										}, function()
											if SucceededAttempts + 1 >= Config.Skillbar.Solan then 
												SucceededAttempts = 0
												Catching = false
												Holding = true
												CurrentHolding = ped
												ClearPedTasksImmediately()
												FreezeEntityPosition(ped, false)
												FreezeEntityPosition(playerPed, false)
												TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 6.5, "chosua", 0.18)
												TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 8.0, 8.0, -1, 50, 0, false, false, false)
												local bone = GetPedBoneIndex(PlayerPedId(), 28422)
												AttachEntityToEntity(ped, PlayerPedId(), bone, 0.01, -0.1, -0.1, 50.0, 50.0, 50.0, true, false, false, false, 1, true)
												CoreName.Functions.Notify('Đã bắt thành công một con chó!', 'success')
												TriggerEvent('animations:client:EmoteCommandStart', {"c"})
											else 
												SucceededAttempts = SucceededAttempts + 1
												Skillbar.Repeat({
													duration = Config.Skillbar.Tocdo,
													pos = math.random(10, 30),
													width = math.random(8, 12),
												})
											end
										end, function()
											SucceededAttempts = 0
											if Config.ChoCan then 
												if math.random(1,10) <= Config.ChanceChoCan then 
													local model = GetEntityModel(ped)
													SetPedAsNoLongerNeeded(ped)
													SetModelAsNoLongerNeeded(model)
													TaskCombatPed(ped, PlayerPedId(), 0, 16)
													TriggerEvent('animations:client:EmoteCommandStart', {"c"})
													SetEntityHealth(PlayerPedId(),GetEntityHealth(PlayerPedId()) - Config.MauBiCan)
													CoreName.Functions.Notify('Bạn đã bị chó cắn!', 'error')
													TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 6.5, "chocan", 0.18)
													Wait(1500)
													SetEntityAsNoLongerNeeded(ped)
													SetModelAsNoLongerNeeded(model)
													DeleteEntity(ped)
												else 
													local model = GetEntityModel(ped)
													SetEntityAsNoLongerNeeded(ped)
													SetModelAsNoLongerNeeded(model)
													DeleteEntity(ped)
													TriggerEvent('animations:client:EmoteCommandStart', {"c"})
													CoreName.Functions.Notify('Chó đã chạy đi!', 'error')
												end
											else 
												local model = GetEntityModel(ped)
												SetEntityAsNoLongerNeeded(ped)
												SetModelAsNoLongerNeeded(model)
												DeleteEntity(ped)
												TriggerEvent('animations:client:EmoteCommandStart', {"c"})
												CoreName.Functions.Notify('Chó đã chạy đi!', 'error')
											end
											Catching = false
											FreezeEntityPosition(PlayerPedId(), false)
										end)
									else
										CoreName.Functions.Notify('Bạn không có xích chó!', 'error')
									end
								end, Config.VatPham)
							else 
								CoreName.Functions.Notify("Không đủ cảnh sát ("..Config.CopRequired.." trở lên)", "error")
							end
						end
					end
				else 
					if Config.PhuongTien.Allow then 
						local MyVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
						if GetVehicleClass(MyVehicle) == 8 then 
							if GetEntityModel(MyVehicle) == GetHashKey(Config.PhuongTien.Xe) then 
								if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) ~= PlayerPedId() then
									if dist <= Config.PhuongTien.Distance then
										DrawText3Ds(dogPos.x, dogPos.y, dogPos.z+0.5, "~g~[E]~w~ - Bắt Chó") 
										if IsControlJustPressed(1, 38) and not Catching and not Holding then
											CopsCall()
											local dict = "anim@heists@box_carry@"
											RequestAnimDict(dict)
											while not HasAnimDictLoaded(dict) do
												RequestAnimDict(dict)
												Citizen.Wait(100)
											end
											if CurrentCops >= Config.CopRequired then 
												CoreName.Functions.TriggerCallback(''..Config.Framework..':HasItem', function(result)
													if result == true then
														Catching = true
														TriggerServerEvent(''..Config.Framework..':Server:RemoveItem', Config.PhuongTien.VatPham, 1)
														local Skillbar = exports[Config.Skillbar.Type]:GetSkillbarObject()
														FreezeEntityPosition(ped, true)
														TriggerEvent('animations:client:EmoteCommandStart', {"mechanic"})
														Skillbar.Start({
															duration = Config.Skillbar.Tocdo,
															pos = math.random(10, 30),
															width = math.random(10, 20),
														}, function()
															if SucceededAttempts + 1 >= Config.Skillbar.Solan then 
																SucceededAttempts = 0
																Catching = false
																Holding = true
																CurrentHolding = ped
																ClearPedTasksImmediately()
																FreezeEntityPosition(ped, false)
																FreezeEntityPosition(playerPed, false)
																TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 6.5, "chosua", 0.18)
																TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 8.0, 8.0, -1, 50, 0, false, false, false)
																local bone = GetPedBoneIndex(PlayerPedId(), 28422)
																AttachEntityToEntity(ped, PlayerPedId(), bone, 0.01, -0.1, -0.1, 50.0, 50.0, 50.0, true, false, false, false, 1, true)
																CoreName.Functions.Notify('Đã bắt thành công một con chó!', 'success')
															else 
																SucceededAttempts = SucceededAttempts + 1
																Skillbar.Repeat({
																	duration = Config.Skillbar.Tocdo,
																	pos = math.random(10, 30),
																	width = math.random(8, 12),
																})
															end
														end, function()
															SucceededAttempts = 0
															if Config.ChoCan then 
																if math.random(1,10) <= Config.ChanceChoCan then 
																	local model = GetEntityModel(ped)
																	SetPedAsNoLongerNeeded(ped)
																	SetModelAsNoLongerNeeded(model)
																	TaskCombatPed(ped, PlayerPedId(), 0, 16)
																	TriggerEvent('animations:client:EmoteCommandStart', {"c"})
																	SetEntityHealth(PlayerPedId(),GetEntityHealth(PlayerPedId()) - Config.MauBiCan)
																	CoreName.Functions.Notify('Bạn đã bị chó cắn!', 'error')
																	TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 6.5, "chocan", 0.18)
																	Wait(1500)
																	SetEntityAsNoLongerNeeded(ped)
																	SetModelAsNoLongerNeeded(model)
																	DeleteEntity(ped)
																else 
																	local model = GetEntityModel(ped)
																	SetEntityAsNoLongerNeeded(ped)
																	SetModelAsNoLongerNeeded(model)
																	DeleteEntity(ped)
																	TriggerEvent('animations:client:EmoteCommandStart', {"c"})
																	CoreName.Functions.Notify('Chó đã chạy đi!', 'error')
																end
															else 
																local model = GetEntityModel(ped)
																SetEntityAsNoLongerNeeded(ped)
																SetModelAsNoLongerNeeded(model)
																DeleteEntity(ped)
																TriggerEvent('animations:client:EmoteCommandStart', {"c"})
																CoreName.Functions.Notify('Chó đã chạy đi!', 'error')
															end
															Catching = false
															FreezeEntityPosition(PlayerPedId(), false)
														end)
													else
														CoreName.Functions.Notify('Bạn không có thòng lọng!', 'error')
													end
												end, Config.PhuongTien.VatPham)
											else 
												CoreName.Functions.Notify("Không đủ cảnh sát ("..Config.CopRequired.." trở lên)", "error")
											end
										end 
									end 
								end
							end 
						end 
					else 
						CoreName.Functions.Notify("Vui lòng xuống xe để bắt chó", "error")
					end							
				end
			end
		end
	end
end)
	
Citizen.CreateThread(function()
		RequestModel(GetHashKey(Config.BanCho.NPC))
		while not HasModelLoaded(GetHashKey(Config.BanCho.NPC)) do 
			RequestModel(GetHashKey(Config.BanCho.NPC))
			Wait(0)
		end 
		NPC = CreatePed(4, Config.BanCho.NPC, Config.BanCho.ViTri.x, Config.BanCho.ViTri.y, Config.BanCho.ViTri.z-1, Config.BanCho.ViTri.w)
		SetEntityInvincible(NPC, true)
		SetEntityAsMissionEntity(NPC, true)
		SetBlockingOfNonTemporaryEvents(NPC, true)
		FreezeEntityPosition(NPC, true)
		if Config.BanCho.HienBlip then 
			Icon = AddBlipForCoord(Config.BanCho.ViTri)
			SetBlipSprite (Icon, Config.BanCho.Icon)
			SetBlipDisplay(Icon, 4)
			SetBlipScale  (Icon, 0.5)
			SetBlipAsShortRange(Icon, true)
			SetBlipColour(Icon, Config.BanCho.MauIcon)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentSubstringPlayerName(Config.BanCho.TenIcon)	
			EndTextCommandSetBlipName(Icon)
		end 

	while true do 
		Citizen.Wait(0)
		if true then 
			local PlayerPed = PlayerPedId()
			local Pos = GetEntityCoords(PlayerPed)
			if #(Pos - vector3(Config.BanCho.ViTri.x, Config.BanCho.ViTri.y, Config.BanCho.ViTri.z)) <= 2 then		
				DrawText3Ds(Config.BanCho.ViTri.x, Config.BanCho.ViTri.y, Config.BanCho.ViTri.z, "~g~[E]~w~ - Bán Chó")
				if IsControlJustPressed(1, 38) then
					if Holding then 
						if DoesEntityExist(CurrentHolding) then 
							for k, v in pairs(Config.BanCho.GiaCho) do 
								if GetEntityModel(CurrentHolding) == GetHashKey(k) then 
									TriggerServerEvent("nyo-tromcho:server:BanCho", k)
									DeleteEntity(CurrentHolding)
									SetModelAsNoLongerNeeded(CurrentHolding)
									CurrentHolding = nil
									Holding = false
									ClearPedTasksImmediately()
								end 
							end 
						end
					else 
						CoreName.Functions.Notify("Bạn không ôm bất kỳ con chó nào", "error")
					end 
				end 
			end 
		end				
	end
end)


function CopsCall()
	if Config.BCS.Enable then
		if math.random(1,10) <= Config.BCS.Chance then
			if Config.Framework == "QBCore" then
				TriggerServerEvent("police:server:policeAlert", "TRỘM CHÓ")
			else 
				local StreetLabel = CoreName.Functions.GetStreetLabel()
				TriggerServerEvent(Config.BCS.Event, GetEntityCoords(PlayerPedId()), StreetLabel)
			end 
		end
	end
end

function DrawText3Ds(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local factor = #text / 460
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	
	SetTextScale(0.3, 0.3)
	SetTextFont(6)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 160)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
end