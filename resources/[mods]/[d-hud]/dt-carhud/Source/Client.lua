

local timeText = ""
local locationText = ""
local position, heading, zoneNameFull, locationText
local seatbeltIsOn = false

Citizen.CreateThread(function()
    local currSpeed = 0.0
    local prevVelocity = {x = 0.0, y = 0.0, z = 0.0}
    local inveh = false
    local hasBelt = false
    local hasCruise = false
    local cruiseIsOn = false
    
    while true do
        Citizen.Wait(0)
        local player = PlayerPedId()
        if IsPedInAnyVehicle(player, false) then
            local vehicle = GetVehiclePedIsIn(player, false)
            local vehicleClass = GetVehicleClass(vehicle)
            local engineHealth = GetVehicleEngineHealth(vehicle)
            local isDriver = (GetPedInVehicleSeat(vehicle, -1) == player)       
            if vehicleClass ~= 13 then
                if not inveh then
                    inveh = true
                    
                    hasBelt = isVehicleClassHasBelt(vehicleClass)
                    Citizen.CreateThread(function()
                        while inveh do
                            Citizen.Wait(0)
                            if IsControlJustReleased(0, Dynamic.Setting.Input) and hasBelt then
                                seatbeltIsOn = not seatbeltIsOn
                                
                                if seatbeltIsOn then
                                    TriggerEvent("Sound", Dynamic.Setting.AddName, Dynamic.Setting.Volume)
                                else
                                    TriggerEvent("Sound", Dynamic.Setting.RemoveName, Dynamic.Setting.Volume)
                                end
                            end
                            
                            local prevSpeed = currSpeed
                            currSpeed = GetEntitySpeed(vehicle)
                            
                            if (not seatbeltIsOn or not hasBelt) then
                                local vehIsMovingFwd = GetEntitySpeedVector(vehicle, true).y > 1.0
                                local vehAcc = (prevSpeed - currSpeed) / GetFrameTime()
                                if (vehIsMovingFwd and
                                    (prevSpeed > (Dynamic.Setting.EjectSpeed / 2.237)) and
                                    (vehAcc > (Dynamic.Setting.EjectAccel * 9.81))) then
                                    SetEntityCoords(player, position.x, position.y, position.z - 0.47, true, true, true)
                                    SetEntityVelocity(player, prevVelocity.x, prevVelocity.y, prevVelocity.z)
                                    Citizen.Wait(1)
                                    SetPedToRagdoll(player, 1000, 1000, 0, 0, 0, 0)
                                else
                                    prevVelocity = GetEntityVelocity(vehicle)
                                end
                            else
                                DisableControlAction(0, 75)
                            end
                            -- khoa toc do 
                            -- if isDriver then
                            --     if IsControlJustReleased(0, Dynamic.Setting.cruiseInput) then
                            --         cruiseIsOn = not cruiseIsOn
                            --         cruiseSpeed = currSpeed
                            --     end

                            --     local maxSpeed = cruiseIsOn and cruiseSpeed or GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
                            --     SetEntityMaxSpeed(vehicle, maxSpeed)
                            -- else
                            --     cruiseIsOn = false
                            -- end
                            -- SetPedConfigFlag(player, 32, true)
                        end
                    end)
                end


                if not hasBelt then
                    seatbeltIsOn = false
                end

                local speed = GetEntitySpeed(vehicle) * 3.6 -- KMH
                local fuel = GetVehicleFuelLevel(vehicle)
                local gear = GetVehicleCurrentGear(vehicle)
                local carname = GetVehicleNumberPlateText(vehicle)
                local vhealth = GetVehicleEngineHealth(vehicle)

                
                local wheel1 = IsVehicleTyreBurst(vehicle,0)
                local wheel11 = GetTyreHealth(vehicle,0)
                local wheel2 = IsVehicleTyreBurst(vehicle,1)
                local wheel12 = GetTyreHealth(vehicle,1)
                local wheel3 = IsVehicleTyreBurst(vehicle,4)
                local wheel13 = GetTyreHealth(vehicle,4)
                local wheel4 = IsVehicleTyreBurst(vehicle,5)
                local wheel14 = GetTyreHealth(vehicle,5)
                        
                if (wheel1 == 1 and wheel11 < 1) then
                    wheel1status = 'die'
                elseif(wheel1 == 1 and wheel11 < 351) then
                    wheel1status = 'acc'
                elseif(wheel1 ~= 1) then
                    wheel1status = 'som'
                end
        
                if (wheel2 == 1 and wheel12 < 1) then
                    wheel2status = 'die'
                elseif(wheel2 == 1 and wheel12 < 351) then
                    wheel2status = 'acc'
                elseif(wheel2 ~= 1) then
                    wheel2status = 'som'
                end
        
                if (wheel3 == 1 and wheel13 < 1) then
                    wheel3status = 'die'
                elseif(wheel3 == 1 and wheel13 < 351) then
                    wheel3status = 'acc'
                elseif(wheel3 ~= 1 ) then
                    wheel3status = 'som'
                end
        
                if (wheel4 == 1 and wheel14 < 1) then
                    wheel4status = 'die'
                elseif(wheel4 == 1 and wheel14 < 351) then
                    wheel4status = 'acc'
                elseif(wheel4 ~= 1) then
                    wheel4status = 'som'
                end
                
                position = GetEntityCoords(player)
                streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(position.x, position.y, position.z));
                heading = Dynamic.Directions[math.floor((GetEntityHeading(player) + 22.5) / 45.0)]
                locationText = heading
                locationText = (streetName == "" or streetName == nil) and (streetName) or (locationText .. streetName);

                    local RPM = GetVehicleCurrentRpm(vehicle)
                        if not GetIsVehicleEngineRunning(vehicle) then RPM = 0 end
                        if RPM > 0.2 then
                            RPM = RPM * 100
                            RPM = RPM + math.random(-2, 2)
                            RPM = RPM / 100
                        end
                    RPM = RPM*7000
                    
                    local l1, l2, l3 = GetVehicleLightsState(vehicle)
                    local vclass = GetVehicleClass(vehicle)
                    local mm = nil

                    if vclass == 8  then
                        mm = "motor"   
                    elseif  vclass == 13  then
                        mm = "bike"  
                    elseif  vclass == 14  then
                        mm = "boat"
                    elseif vclass == 15 or vclass == 16 then
                        mm = "helicopter"
                    else 
                        mm = "car"
                    end


                
                    triggerNui({
                        message = "show",
                        clear = true,
                        speed = speed,
                        gear = gear,
                        fuel = fuel,
                        class = class ,
                        w1 = wheel1status,
                        w2 = wheel2status,
                        w3 = wheel3status,
                        w4 = wheel4status,
                        vehicleClass = vehicleClass,
                        scale = Dynamic.Setting.Scale,
                        streetName = locationText,
                        engineHealth = engineHealth/10,
                        light = getLight(l2, l3),
                        rpm = round(RPM / 1000),
						rpmPercent = round(RPM / 75),
                        SpeedLimit = cruiseIsOn,
                        health = vhealth/10,
                        carname = carname ,
                        class = mm,
                        hasBelt = hasBelt,
                        beltOn = seatbeltIsOn,
                    })
                
            end
        else
            inveh = false
            seatbeltIsOn = false
            triggerNui({message = "hide", clear = true})
        end
        Citizen.Wait(300)
    
    end
end)

function isVehicleClassHasBelt(class)
    if (not class or class == nil) then return false end
    
    local hasBelt = Dynamic.BeltClass[class]
    if (not hasBelt or hasBelt == nil) then return false end
    
    return hasBelt
end

function round(x)
	return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
end

getLight = function(n, n2)
	if n == 0 then
		return n2
	else
		return n
	end
end



AddEventHandler('Sound', function(soundFile, soundVolume)
    -- debug('ONE', 'Sound', soundFile, soundVolume)
    triggerNui({
        Class = 'playSound',
        FileName = soundFile,
        Volume = soundVolume
    })
end)

RegisterCommand('+engine', function()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if vehicle == 0 or GetPedInVehicleSeat(vehicle, -1) ~= PlayerPedId() then return end
    if GetIsVehicleEngineRunning(vehicle) then
        TriggerEvent('QBCore:Notify', "[TẮT] Động cơ", "error")
    else
        TriggerEvent('QBCore:Notify', "[BẬT] Động cơ", "success")
    end
    SetVehicleEngineOn(vehicle, not GetIsVehicleEngineRunning(vehicle), false, true)
end)

RegisterKeyMapping("+engine", "<FONT size='20'><FONT face='BarlowCR'>BẬT/TẮT ĐỘNG CƠ</FONT></FONT>", "keyboard", "G")
