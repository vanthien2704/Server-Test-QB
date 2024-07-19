local QBCore = exports['qb-core']:GetCoreObject()
local ANIMAL = {}
local Count = 0
local Corgi = false
local Anti_Spam_ChoAn = false
local Anti_Spam_ThuHoach = false
local _CheckSpam = false
local _SpamSpawn = false
local Client_Price = {}

local Zone_ChamSoc = BoxZone:Create(vector3(-1875.48, -817.56, 3.09), 30, 35, {
	name= "Box",
	heading= 400,
	debugPoly=false
  })

CreateThread(function()
	while true do 
		Wait(1)
		point = GetEntityCoords(PlayerPedId(),true)
		local In_Zone_ChamSoc = Zone_ChamSoc:isPointInside(point)
		if In_Zone_ChamSoc then
			for i=1, #Config.Feed, 1 do
				BUDRAWTEXT(0.429, 0.90, "Chăm sóc tối đa: "..Count.."/"..Config.SoLuong_ChamSoc_ToiDa.."")
				BUDRAWTEXT(0.410, 0.93, Config.Feed[i].text)
				-- 	DisableControlAction(1, 140, true)
				-- if not IsPlayerTargettingAnything(PlayerId()) then
				-- 	DisableControlAction(1, 141, true)
				-- 	DisableControlAction(1, 142, true)
				-- end
				DisableControlAction(1, 25, true) -- Right Mouse Button
				DisableControlAction(1, 140, true) -- R
				DisableControlAction(1, 141, true) -- Q
				DisableControlAction(1, 142, true) -- Left Mouse Button
				DisableControlAction(1, 21, true) -- Left Shift
				DisableControlAction(1, 19, true) -- Left Alt
			end
		end
	end
end)

function BUDRAWTEXT(a,b,c)
	SetTextScale(0.0, 0.4)
	SetTextDropShadow()
	SetTextOutline()
	SetTextColour(255, 255, 255, 500)
	SetTextEntry("STRING")
	AddTextComponentString(""..c.."")
	DrawText(a,b)
end
--======================================== CORGI ========================================
RegisterNetEvent("dt-chamsocthucung:client:Start")
AddEventHandler("dt-chamsocthucung:client:Start", function(a)
	point = GetEntityCoords(PlayerPedId(),true)
	local In_Zone_ChamSoc = Zone_ChamSoc:isPointInside(point)
	
	if _SpamSpawn == false then
		if In_Zone_ChamSoc then
			StartAnimals(a)
		else
			QBCore.Functions.Notify("Bạn không ở trong khu vực chăm sóc thú cưng", "error")
		end
	else
		QBCore.Functions.Notify("Chậm cái tay thôi nè đừng có spam như vậy!", "warning")
	end
end)

function StartAnimals(BU)
	Corgi = true
	if not Start then
		if Count < Config.SoLuong_ChamSoc_ToiDa then
			QBCore.Functions.Progressbar("thacorgi", "Đang thả corgi", 1000, false, true, {
				disableMovement = false,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			}, {}, {}, {}, function() -- Done
				Count = Count + 1
				Start = true

				for i =1, #Config.Feed, 1 do
					TriggerServerEvent("dt-chamsocthucung:server:RemoveItem", Config.Feed[i].item.use, 1)
				end

				if not HasAnimDictLoaded('anim@heists@money_grab@briefcase') then RequestAnimDict('anim@heists@money_grab@briefcase') while not HasAnimDictLoaded('anim@heists@money_grab@briefcase') do Wait(1) end end
				TaskPlayAnim(PlayerPedId(), 'anim@heists@money_grab@briefcase', 'put_down_case', 8.0, -8.0, -1, 1, 0, false, false, false)
				Wait(1000)
				ClearPedTasks(PlayerPedId())
			
				CreateThread(function()
					local animal 
					for i =1, #Config.Feed, 1 do
						if Config.Feed[i].item.use == BU.item.use then
							RequestModel(GetHashKey(Config.Feed[i].ped))
							while not HasModelLoaded(GetHashKey(Config.Feed[i].ped)) do Wait(1) end
							local pos = GetEntityCoords(PlayerPedId())
							animal = CreatePed(29, GetHashKey(Config.Feed[i].ped), pos.x + 0.5, pos.y + 0.5, pos.z - 0.9, 90, false, false)
							SetEntityInvincible(animal,true)
							Wait(100)
							_SpamSpawn = false
							table.insert(ANIMAL, {Animal = animal, Hungry = 0, Give = false, Feed = false, Data = Config.Feed[i], Cool = 0, Status = false})
							break
						end
					end
					CreateThread(function()
						while animal ~= nil do
							Wait(1e3)
							local x2, y2, z2 = table.unpack(GetEntityCoords(PlayerPedId()))
							TaskGoToCoordAnyMeans(animal, x2 + math.random(0, 5), y2 + math.random(0, 5), z2, 1, 0, 0, 7.86603e5, 1)
							Wait(math.random(7e3, 1.5e4))
						end
					end)
					CreateThread(function()
						while animal ~= nil do
							Wait(BU.time_need)
							for _,k in pairs(ANIMAL) do
								if k.Animal == animal then
									if k.Give == false or k.Feed == true then
										if k.Hungry < 100 then
											k.Hungry = k.Hungry + 1
										end
										if k.Feed == true then
											if not k.Status then
												k.Cool = k.Cool + 1
												if k.Cool >= 20 then
													if not KILL then
														KILL = true
														SetEntityHealth(animal, 0)
														Wait(1500)
														DeleteEntity(animal)
														SetEntityInvincible(animal,false)
														table.remove(ANIMAL, _)
														Count = Count - 1
														KILL = false 
														k.Cool = 0
													end
												end
											end
										end
									end
								end
							end
						end
					end)
					CreateThread(function()
						while animal ~= nil do
							Wait(0)
							for _,k in pairs(ANIMAL) do
								if k.Animal == animal then
									if k.Give == false then
										if k.Hungry == 100 then
											k.Give = true
											k.Feed = false
										end
									end
								end
							end
						end
					end)
					CreateThread(function()
						while animal ~= nil do
							Wait(3000)
							for _,k in pairs(ANIMAL) do
								if k.Animal == animal then
									if k.Give == false then
										if k.Hungry >= BU.need then
											if k.Feed == false then
												k.Cool = 0
												for i=1, #BU.percent_feed, 1 do
													if k.Hungry == BU.percent_feed[i] then
														k.Feed = true
													end
												end
											end
										end
									end
								end
							end
						end
					end)
				end)
				Start = false
			end)
		else
			QBCore.Functions.Notify("Bạn đang chăm sóc cùng lúc "..Config.SoLuong_ChamSoc_ToiDa.." thú cưng không thể chăm sóc thêm", "warning")
		end
	end
end
--========================================================================================================================
CreateThread(function()
	while true do
		Busleep = 500
		if Count > 0 then
			Busleep = 0
			for i=1, #ANIMAL, 1 do
				local A = 1 / GetFrameTime()
				local B = GetPedBoneCoords(ANIMAL[i].Animal, 1.2844e4, 0, 0, 0) + vector3(0, 0, 1.1) + GetEntityVelocity(ANIMAL[i].Animal) / A
				if math.floor(#(GetGameplayCamCoords() - B)) < 20 and World3dToScreen2d(B.x, B.y, B.z) then
					SetDrawOrigin(B, false)
					if ANIMAL[i].Feed == false and ANIMAL[i].Give == false then
						DrawMarker(20, B.x, B.y, B.z - 0.35, 0, 0, 0, 0, 180, 0, 0.3, 0.3, 0.3, Config.Setting.marker.normal.r, Config.Setting.marker.normal.g, Config.Setting.marker.normal.b, Config.Setting.marker.intensive, false, true, 2, true, false, false)
						ClearDrawOrigin()
					end
					if ANIMAL[i].Feed == true and ANIMAL[i].Give == false then
						DrawMarker(20, B.x, B.y, B.z - 0.35, 0, 0, 0, 0, 180, 0, 0.3, 0.3, 0.3, Config.Setting.marker.feed.r, Config.Setting.marker.feed.g, Config.Setting.marker.feed.b, Config.Setting.marker.intensive, false, true, 2, true, false, false)
						ClearDrawOrigin()
					end
					if ANIMAL[i].Feed == false and ANIMAL[i].Give == true then
						DrawMarker(20, B.x, B.y, B.z - 0.35, 0, 0, 0, 0, 180, 0, 0.3, 0.3, 0.3, Config.Setting.marker.kill.r, Config.Setting.marker.kill.g, Config.Setting.marker.kill.b, Config.Setting.marker.intensive, false, true, 2, true, false, false)
						ClearDrawOrigin()
					end
				end
			end
		end
		Wait(Busleep) 
	end
end)

CreateThread(function()
	while true do
		local Busleep = 1000
		local check = true
		for i=1, #ANIMAL, 1 do

			local ped = PlayerPedId()
			local pCoords = GetEntityCoords(ped)
			local coords = GetEntityCoords(ANIMAL[i].Animal)
			local dist = #(pCoords - coords)
			if dist < Config.Setting.animal.distance.text then
				Busleep = 0
				if ANIMAL[i].Feed == false and ANIMAL[i].Give == false then
					local nCoords = GetEntityCoords(ANIMAL[i].Animal)
					DrawText3Ds(GetEntityCoords(ANIMAL[i].Animal), "~o~[TRƯỞNG THÀNH]\n"..ANIMAL[i].Hungry.."%")
					--DTeamFloatingHelp(GetEntityCoords(ANIMAL[i].Animal).x, GetEntityCoords(ANIMAL[i].Animal).y, GetEntityCoords(ANIMAL[i].Animal).z, '~q~PHÁT TRIỂN: ~o~'..ANIMAL[i].Hungry..'/100')
				end
				if ANIMAL[i].Feed == true and ANIMAL[i].Give == false then
					if Anti_Spam_ChoAn == false then
						-- DTeamFloatingHelp(GetEntityCoords(ANIMAL[i].Animal).x, GetEntityCoords(ANIMAL[i].Animal).y, GetEntityCoords(ANIMAL[i].Animal).z, 'Nhấn ~g~[E]~w~ để cho ăn')
						DrawText3Ds(GetEntityCoords(ANIMAL[i].Animal), "Nhấn ~g~[E]~w~ để cho ăn")
					else
						DrawText3Ds(GetEntityCoords(ANIMAL[i].Animal), "~o~Đang cho Corgi ăn")
					end
				end
				if ANIMAL[i].Feed == false and ANIMAL[i].Give == true then
					if Anti_Spam_ThuHoach == false then
						-- DTeamFloatingHelp(GetEntityCoords(ANIMAL[i].Animal).x, GetEntityCoords(ANIMAL[i].Animal).y, GetEntityCoords(ANIMAL[i].Animal).z, 'Nhấn ~g~[E]~w~ để thu hoạch')
						DrawText3Ds(GetEntityCoords(ANIMAL[i].Animal), "Nhấn ~g~[E]~w~ nhận Corgi trưởng thành")
					else
						DrawText3Ds(GetEntityCoords(ANIMAL[i].Animal), "~o~Đang nhận Corgi trưởng thành")
					end
				end
			end
			if dist < Config.Setting.animal.distance.press then
				Busleep = 0
				if ANIMAL[i].Feed == true and ANIMAL[i].Give == false then
					if IsControlJustReleased(0, 38) then
						--local busy = exports["progressbar"]:isDoingSomething()
						--if not busy then
							if Anti_Spam_ChoAn == false then
								if check then
									Anti_Spam_ChoAn = true
									check = false
									ANIMAL[i].Status = true
									QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
										if HasItem then
											exports["d-emote"]:EmoteCommandStart("bumbin", 0)
											QBCore.Functions.Progressbar("choan", "Đang cho ăn", 2000, false, false, {
												disableMovement = true,
												disableCarMovement = true,
												disableMouse = false,
												disableCombat = true,
											}, {}, {}, {}, function(status) -- Done   
												if not status then
													ANIMAL[i].Status = false
													ANIMAL[i].Feed = false
													QBCore.Functions.Notify("Cho ăn thành công", "success")
													exports["d-emote"]:EmoteCommandStart("c", 0)
													TriggerServerEvent("dt-chamsocthucung:server:RemoveItem", Config.ThucAn, 1)
													check = true
													Anti_Spam_ChoAn = false
												end
											end, function() -- Cancel
												Anti_Spam_ChoAn = false
												QBCore.Functions.Notify('Hủy thao tác cho ăn', 'error')
											end)
										else
											QBCore.Functions.Notify("Bạn không có thức ăn", "error")
											Anti_Spam_ChoAn = false
										end
									end,Config.ThucAn)
								end
							end
						--else
							--Anti_Spam_ChoAn = false
							--QBCore.Functions.Notify("Không thể thao tác lúc này!", "error")
						--end
					end
				end
				if ANIMAL[i].Feed == false and ANIMAL[i].Give == true then
					if IsControlJustReleased(0, 38) then
						--local busy = exports["progressbar"]:isDoingSomething()
						--if not busy then
							if Anti_Spam_ThuHoach == false then
								if check then
									check= false
									Anti_Spam_ThuHoach = true
									FreezeEntityPosition(ANIMAL[i].Animal, true)
									exports["d-emote"]:EmoteCommandStart("bumbin", 0)
									QBCore.Functions.Progressbar("thuhoach", "Đang nhận Heo", 3000, false, false, {
										disableMovement = true,
										disableCarMovement = true,
										disableMouse = false,
										disableCombat = true,
									}, {}, {}, {}, function(status) -- Done   
										if not status then
											Count = Count - 1
											for _, A in pairs(ANIMAL) do
												if A.Animal == ANIMAL[i].Animal then
													FreezeEntityPosition(ANIMAL[i].Animal, false)
													SetEntityInvincible(ANIMAL[i].Animal,false)
													--exports["dt-fixitem"]:ExecuteServerEvent("dt-chamsocthucung:server:Nhan_Corgi") -- Bật nếu sử dụng Fiveguard
													TriggerServerEvent("dt-chamsocthucung:server:Nhan_Corgi")
													DeleteEntity(ANIMAL[i].Animal)
													table.remove(ANIMAL, _)
													exports["d-emote"]:EmoteCommandStart("c", 0)
													check = true
													Anti_Spam_ThuHoach = false
													break
												end
											end
											if Count <= 0 then
												Corgi = false
											end
										end
									end, function() -- Cancel
										Anti_Spam_ThuHoach = false
										QBCore.Functions.Notify('Hủy thao tác nhận Heo', 'error')
									end)
								end
							end
						--else
						--	Anti_Spam_ThuHoach = false
						--	QBCore.Functions.Notify("Không thể thao tác lúc này!", "error")
						--end
					end
				end
			end
		end
		Wait(Busleep) 
	end
end)

CreateThread(function()
	for i =1,#Config.Feed, 1 do
		if Config.Feed[i].blips.enabled then
			local B = AddBlipForCoord(Config.Feed[i].coords.x, Config.Feed[i].coords.y, Config.Feed[i].coords.z)
			SetBlipSprite(B, Config.Feed[i].blips.sprite)
			SetBlipScale(B, Config.Feed[i].blips.scale)
			SetBlipColour(B, Config.Feed[i].blips.color)
			SetBlipAsShortRange(B, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(Config.Feed[i].blips.text)
			EndTextCommandSetBlipName(B)

			local blip_s = AddBlipForArea(Config.Feed[i].coords_2.x, Config.Feed[i].coords_2.y, Config.Feed[i].coords_2.z, 70.0, 70.0)        
			SetBlipAlpha(blip_s, 128)
			SetBlipAsShortRange(blip_s, true)
			SetBlipRotation(blip_s, 219.75)
			SetBlipColour(blip_s, 51)

		end
	end
	local blip = AddBlipForCoord(-3031.29, 92.34, 12.35) 
	SetBlipSprite(blip, 463)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, 1.0)
	SetBlipAsShortRange(blip, true)
	SetBlipColour(blip, 6)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("~g~[Nghề]~w~ GIAO THÚ CƯNG") 
    EndTextCommandSetBlipName(blip)
end)



function DrawText3Ds(coords, text)
	SetTextScale(0.30, 0.30)
	SetTextEntry("STRING")
	AddTextComponentString(""..text.."")
	SetTextCentre(true)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextOutline()
	SetDrawOrigin(coords.x, coords.y, coords.z + 0.5, 0)
	DrawText(0.0, 0.0)
	ClearDrawOrigin()
end

AddEventHandler("onResourceStop", function(resource)
	if resource == GetCurrentResourceName() then
		if ANIMAL ~= nil then
			for i = 1,#ANIMAL, 1 do
				DeleteEntity(ANIMAL[i].Animal)
				SetEntityInvincible(ANIMAL[i].Animal,false)
			end
		end
	end
end)

DTeamFloatingHelp = function(x,y,z, text)
    AddTextEntry('dt-chamsocthucung'..GetCurrentResourceName(), '<FONT face="TikTokText-Medium">'..text..'</FONT>')
    SetFloatingHelpTextWorldPosition(1, x,y,z)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    BeginTextCommandDisplayHelp('dt-chamsocthucung'..GetCurrentResourceName())
    EndTextCommandDisplayHelp(2, false, false, -1)
end
--======================================== CỬA HÀNG ========================================
RegisterNetEvent('dt-chamsocthucung:client:cua_hang', function()
	local ShopItems = {}
	ShopItems.label = "CỬA HÀNG CHĂM SÓC THÚ CƯNG"
	ShopItems.items = Config.Shop_ChamSocThuCung
	ShopItems.slots = #Config.Shop_ChamSocThuCung
	TriggerServerEvent("inventory:server:OpenInventory", "shop", "ChamSocThuCung", ShopItems)
end)
--======================================== Floating ========================================
CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local distance_ped = #(pos - vector3(Config.Pet_Shop.x, Config.Pet_Shop.y, Config.Pet_Shop.z))
        if distance_ped < 10.0 then
            DTeamFloatingHelp(Config.Pet_Shop.x, Config.Pet_Shop.y, Config.Pet_Shop.z+0.8, '~q~  CHĂM SÓC THÚ CƯNG~w~')
        end
        Wait(1)
    end
end)
--======================================== GIAO THÚ CƯNG ========================================
RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
    QBCore.Functions.TriggerCallback('dt-chamsocthucung:server:GetPrice', function(data)
        Client_Price = data
    end)
end)

RegisterNetEvent("dt-chamsocthucung:client:UpdatePrice", function(data)
    Client_Price = data
end)

RegisterNetEvent("dt-chamsocthucung:client:OpenMenu", function(key)
	-- LocalPlayer.state:set("inv_busy", true, true) -- Busy
    local MainMenu = {
        {
            header = Config.Main[key].name, 
            txt = Config.Main[key].description, 
            isMenuHeader = true,
        }
    }

    for k, v in pairs(Config.Main[key].market) do 
        MainMenu[#MainMenu+1] = {
            header = v.name,
            txt = v.description,
            params = {
                event = "dt-chamsocthucung:client:OpenMarket",
                args = v,
            }
        }
    end 



    MainMenu[#MainMenu+1] = {
        header = "⬅ Đóng",
        txt = "",
        params = {
            event = "qb-menu:client:closeMenu",
        }
    }

    exports['qb-menu']:openMenu(MainMenu)
end)

RegisterNetEvent("dt-chamsocthucung:client:OpenMarket", function(data)
	-- LocalPlayer.state:set("inv_busy", true, true) -- Busy
    local MainMenu = {
        {
            header = data.name, 
            txt = data.description, 
            isMenuHeader = true,
        }
    }

    for k, v in pairs(data.item) do

        if not Client_Price[v] then 
                print(v)
                QBCore.Functions.Notify("Đang cập nhật giá, vui lòng chờ một chút", "error")
            return
        end

        local average = Client_Price[v].price - Client_Price[v].old_price
        if average > 0 then 
            text = "<span style='color: rgb(0, 255, 0);'>[Tăng "..math.abs(average).."$]</span>"
        else
            text = "<span style='color: rgb(255,165,0);'>[Giảm "..math.abs(average).."$]</span>"
        end 
        MainMenu[#MainMenu+1] = {
            header = QBCore.Shared.Items[v]["label"],
            icon = v,
            txt = "Nhận được: "..Client_Price[v].price.."$<br>"..text.."",
            params = {
                event = "dt-chamsocthucung:client:SellAmount",
                args = v,
            }
        }
    end

    MainMenu[#MainMenu+1] = {
        header = "⬅ Đóng",
        txt = "",
        params = {
            event = "qb-menu:client:closeMenu",
        }
    }
    exports['qb-menu']:openMenu(MainMenu)
end)

RegisterNetEvent("dt-chamsocthucung:client:SellAmount", function(item)
	-- LocalPlayer.state:set("inv_busy", true, true) -- Busy
    local Input = exports['qb-input']:ShowInput({
        header = "Nhập số lượng "..QBCore.Shared.Items[item]["label"].." muốn giao",
        submitText = "GIAO",
        inputs = {
            {
                text = "Số lượng", -- text you want to be displayed as a place holder
                name = "amount", -- name of the input should be unique otherwise it might override
                type = "number", -- type of the input
                isRequired = false -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
            },
            
        },
    })
    if Input then
         
            if Input.amount ~= nil then  
                local amount  = tonumber(Input.amount)

                if amount > 0 then
					TriggerEvent("dt-lenhadmin:client:th_clearinv")
					-- exports["dt-fixitem"]:ExecuteServerEvent("dt-chamsocthucung:server:SellItem", item, amount, Client_Price[item].price) -- Bật nếu sử dụng Fiveguard
                    TriggerServerEvent("dt-chamsocthucung:server:SellItem", item, amount, Client_Price[item].price)
					-- LocalPlayer.state:set("inv_busy", false, true) -- Busy
                else 
					-- LocalPlayer.state:set("inv_busy", false, true) -- Busy
                    QBCore.Functions.Notify("Vui lòng nhập số lớn hơn 0")
                end 
            end 
         
    else 
		-- LocalPlayer.state:set("inv_busy", false, true) -- Busy
        QBCore.Functions.Notify("Vui lòng nhập số lượng")
    end 
end)

function KhoiTao_Ped_TC()
	CreatedPed_ShopTC = CreatePed(0, Hash_TC, Config.Pet_Shop_2.x, Config.Pet_Shop_2.y, Config.Pet_Shop_2.z -1, Config.Pet_Shop_2.w, false, true)
    FreezeEntityPosition(CreatedPed_ShopTC, true)
    SetEntityInvincible(CreatedPed_ShopTC, true)
    SetBlockingOfNonTemporaryEvents(CreatedPed_ShopTC, true)
end

CreateThread(function()
    Hash_TC = GetHashKey("u_m_m_streetart_01")
    RequestModel(Hash_TC)
    while not HasModelLoaded(Hash_TC) do
        Wait(1)
    end
    KhoiTao_Ped_TC()

    exports['qb-target']:AddBoxZone("cuahang_chamsocthucung", vector3(Config.Pet_Shop_2.x, Config.Pet_Shop_2.y, Config.Pet_Shop_2.z), 2, 2, {
        name = "cuahang_chamsocthucung",
        heading = 0,
        debugPoly = false,
    }, {
        options = {
            {
                type = "client",
                event = "dt-chamsocthucung:client:cua_hang",
                icon = "fas fa-store",
                label = 'Cửa hàng chăm sóc thú cưng'
            },
			{
                type = "client",
                event = "dt-chamsocthucung:client:fix_loi",
                icon = "fas fa-tools",
                label = 'Sửa lỗi chăm sóc thú cưng'
            },
        },
        distance = 2.5
    })
end)

RegisterNetEvent('dt-chamsocthucung:client:fix_loi', function()
	if Anti_Spam_ChoAn == true then
		Anti_Spam_ChoAn = false
		QBCore.Functions.Notify("Sửa lỗi cho ăn thành công", "success")
	end

	if Anti_Spam_ThuHoach == true then
		Anti_Spam_ThuHoach = false
		QBCore.Functions.Notify("Sửa lỗi thu hoạch thành công", "success")
	end
end)