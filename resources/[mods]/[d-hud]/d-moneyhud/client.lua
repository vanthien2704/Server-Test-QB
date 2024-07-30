
local QBCore = exports['qb-core']:GetCoreObject()

Citizen.CreateThread(function()
  
    while true do 
        if LocalPlayer.state.isLoggedIn then
            QBCore.Functions.TriggerCallback("d-moneyhud:getaccount", function(result)

                if result ~= nil then

                    SendNUIMessage({
                    
                        action = 'show';
                        cash = math.floor(result.cash);
                        bank = math.floor(result.bank);
                      })

                end

            end)
        else
            SendNUIMessage({
                action = 'hide'
            })
        end

        Wait(1000)

    end
end)
