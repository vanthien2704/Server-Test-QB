
QBCore = exports['qb-core']:GetCoreObject()
cachedData = {}
GLOBAL_COORDS = nil

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1500)
		local ped = PlayerPedId()
        GLOBAL_COORDS = GetEntityCoords(ped, true)
		if cachedData["ped"] ~= ped then
			cachedData["ped"] = ped
		end
	end
end)

-- Citizen.CreateThread(function()
--     modelHash_ThueThuyen = GetHashKey("u_m_m_bikehire_01")
--     RequestModel(modelHash_ThueThuyen)
--     while not HasModelLoaded(modelHash_ThueThuyen) do
--         Wait(1)
--     end
--     Create_ThueThuyen()
-- end)

-- function Create_ThueThuyen()
--     Created_Ped_ThueThuyen = CreatePed(0, modelHash_ThueThuyen, 2844.1494, -622.0343, 0.2433297, 281.63531, false, true)

--     FreezeEntityPosition(Created_Ped_ThueThuyen, true)
--     SetEntityInvincible(Created_Ped_ThueThuyen, true)
--     SetBlockingOfNonTemporaryEvents(Created_Ped_ThueThuyen, true)
--     TaskStartScenarioInPlace(Created_Ped_ThueThuyen, "WORLD_HUMAN_BINOCULARS", 0, true)
-- end

-- Citizen.CreateThread(function ()
--     exports['dt-target']:AddBoxZone("thuethuyen", vector3(2844.1494, -622.0343, 1.2433297), 2, 2, {
--         name = "thuethuyen",
--         heading = 0,
--         debugPoly = false,
--     }, {
--         options = {
--             {
--                 type = "Client",
--                 event = "dt-cauca:client:thuethuyen",
--                 icon = "fas fa-seedling",
--                 label = 'Trò chuyện'
--             },
--         },
--         distance = 2.5
--     })
-- end)

RegisterNetEvent('dt-cauca:client:thuethuyen')
AddEventHandler('dt-cauca:client:thuethuyen', function()
    Menu_ThueThuyen()
end)

function Menu_ThueThuyen()
    exports['qb-menu']:openMenu({
        {
            header = "THUÊ THUYỀN CÂU CÁ",
            isMenuHeader = true,
        },
        {
            id = 1,
            header = "Thuê thuyền câu cá",
            txt = "Giá thuê: 50.000$",
            params = {
                event = "dt-cauca:spawn_boat",
            }
        },
        -- {
        --     id = 2,
        --     header = "Bán cá",
        --     txt = "Bán những con cá câu được tại vùng nguy hiểm",
        --     params = {
        --         event = "",
        --     }
        -- },
        {
            id = 2,
            header = "Hẹn gặp lại dịp khác",
            txt = "",
            params = {
                event = "qb-menu:closeMenu",
            }
        },
    })
end

RegisterNetEvent('dt-cauca:spawn_boat')
AddEventHandler('dt-cauca:spawn_boat', function()
    QBCore.Functions.TriggerCallback('dt-cauca:server:HasMoney', function(HasMoney)
        if HasMoney then
            SpawnBoat()
        else
            exports['okokNotify']:Alert("HỆ THỐNG", "Bạn không đủ tiền để cọc thuê thuyền", 3000, 'error')
        end
    end)
end)

function SpawnBoat()
    local coords = Config.Location["vehicle"].coords
        QBCore.Functions.SpawnVehicle("frauscher16", function(veh)
            TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
            exports['qb-vehiclekeys']:SetVehicleKey(GetVehicleNumberPlateText(veh), true)
            SetEntityHeading(veh, coords.h)
            SetVehicleEngineOn(veh, true, true)
            Citizen.Wait(100)
            exports['east_gas_qb']:SetFuel(veh, 100.0)
            exports['okokNotify']:Alert("HỆ THỐNG", "Bạn đã cọc 50.000$. Tiền đặt cọc sẽ được trả lại khi bạn trả thuyền!", 5000, 'success')
        end, coords, true, true)
end

function BringBackCar()
    local veh = GetVehiclePedIsIn(PlayerPedId())
    DeleteVehicle(veh)
    SetEntityCoords(GetPlayerPed(-1), Config.Locations['Main']['X'], Config.Locations['Main']['Y'], Config.Locations['Main']['Z'])
end

RegisterNetEvent("dt-cauca:tryToFish")
AddEventHandler("dt-cauca:tryToFish", function(types)
	TryToFish(types) 
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    StopProgress()
end)

function StopProgress()

end

prog = 0

RegisterNUICallback("sellFish", function(data)
print(data.items["name"])
QBCore.Functions.TriggerCallback("QBCore:HasItemAmount",function(cb)
        if cb then
            TriggerServerEvent('dt-cauca:sellFish', data.items["name"], data.items["amount"])
            else
            QBCore.Functions.Notify('Bạn không có đủ cá để bán', 'error')
        end
    end, data.items["name"], data.items["amount"])
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(10)
    if pressG then
        DisableControlAction(0,24,true) -- disable attack
    end
	if not pressG then
	 Citizen.Wait(1000)
	end
  end
end)

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(2843.7048, -623.6155, 1.2919999)
	SetBlipSprite(blip, 356)
	SetBlipDisplay(blip, 2)
	SetBlipScale(blip, 1.0)
	SetBlipAsShortRange(blip, true)
	SetBlipColour(blip, 49)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("~o~[CÔNG VIỆC]~w~ CÂU CÁ")
    EndTextCommandSetBlipName(blip)
end)

-- Citizen.CreateThread(function()
--     while true do
--         local ped = PlayerPedId()
--         local pos = GetEntityCoords(ped)
--         local InVehicle = IsPedInAnyVehicle(PlayerPedId(), false)
--         local distance_ped = #(pos - vector3(2844.1494, -622.0343, 1.2433297))
--         local distance = #(pos - vector3(Config.Location["vehicle"].coords.x, Config.Location["vehicle"].coords.y, Config.Location["vehicle"].coords.z))
--                 if distance < 30.0 then
--                     DrawMarker(21, Config.Location["vehicle"].coords.x, Config.Location["vehicle"].coords.y, Config.Location["vehicle"].coords.z+1.5, 0.0, 0.0, 0.0, 180.0, 0.0, 0.0, 1.6, 1.6, 1.6, 28, 149, 255, 100, true, true, 2, false, false, false, false)
--                     DrawText3D(Config.Location["vehicle"].coords.x, Config.Location["vehicle"].coords.y, Config.Location["vehicle"].coords.z+3.0, "Trả thuyền tại đây")
--                     if distance < 10 then
--                         if InVehicle then
--                             DrawText3D(Config.Location["vehicle"].coords.x, Config.Location["vehicle"].coords.y, Config.Location["vehicle"].coords.z, "~g~[E]~w~ - Trả thuyền")
--                             if IsControlJustReleased(0, 38) then
--                                 QBCore.Functions.TriggerCallback('dt-cauca:server:CheckBail', function(CheckBail)
--                                     if CheckBail then
--                                         BringBackCar()
--                                         exports['okokNotify']:Alert("HỆ THỐNG", "Bạn nhận lại được 50.000$ tiền cọc", 3000, 'success')
--                                     else
--                                         exports['okokNotify']:Alert("HỆ THỐNG", "Bạn không có khoản đặt cọc nào được thanh toán cho chiếc thuyền này", 3000, 'error')
--                                     end
--                                 end)
--                             end
--                         end
--                     end
--                 end
--                 if distance_ped < 50.0 then
--                     DrawText3D(2844.1494, -622.0343, 2.5433297, "~g~THUÊ THUYỀN CÂU CÁ~w~")
--                 end
--         Citizen.Wait(1)
--     end
-- end)

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end