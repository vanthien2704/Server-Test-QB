exports['qb-target']:AddBoxZone('lay_xe', vector3(337.13, -587.47, 74.17), 1.5, 1, {
    name = 'lay_xe',
    debugPoly = false,
    heading = -20,
}, {
    options = {
        {
            type = 'client',
            icon = 'fa fa-clipboard',
            label = 'Lấy trực thăng',
            action = function()
                local ped = PlayerPedId()
                local coords = Config.Locations['helicopter'][1]
                QBCore.Functions.TriggerCallback('QBCore:Server:SpawnVehicle', function(netId)
                    local veh = NetToVeh(netId)
                    SetVehicleNumberPlateText(veh, Lang:t('info.heli_plate') .. tostring(math.random(1000, 9999)))
                    SetEntityHeading(veh, coords.w)
                    SetVehicleLivery(veh, 1) -- Ambulance Livery
                    exports['LegacyFuel']:SetFuel(veh, 100.0)
                    TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                    TriggerEvent('vehiclekeys:client:SetOwner', QBCore.Functions.GetPlate(veh))
                    SetVehicleEngineOn(veh, true, true)
                end, Config.Helicopter, coords, true)
            end,
            job = 'ambulance'
        },
        {
            type = 'client',
            icon = 'fa fa-clipboard',
            label = 'Cất trực thăng',
            action = function()
                local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
                DeleteVehicle(vehicle)
            end,
            job = 'ambulance'
        }
    },
    distance = 1.5
})