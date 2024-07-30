RegisterCommand("getCarClass", function(source, args, rawCommand)
    local playerPed = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if vehicle then
        local vehicleClass = GetVehicleClass(vehicle)
        print("Vehicle class: " .. vehicleClass)
    else
        print("You are not in a vehicle.")
    end
end, false)
