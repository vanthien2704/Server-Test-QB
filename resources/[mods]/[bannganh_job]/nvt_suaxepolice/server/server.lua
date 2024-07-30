RegisterServerEvent('nvt_suaxepolice:triggerServerSync')
AddEventHandler('nvt_suaxepolice:triggerServerSync', function(repairCost, mech, veh, engine)
    if Config.chargeForRepair then
        RemoveMoney(source, "money", repairCost)
    end
    Wait(200)
    TriggerClientEvent('nvt_suaxepolice:triggerClientSyncAnim', -1, mech, veh, engine)
    
end)

if Config.checkForOnlineMechanic then
    RegisterCallback("nvt_suaxepolice:checkForMechanics", function(source, cb)
        local Players = GetPlayers()
        local count = 0
        for i=1, #Players, 1 do
            if getJob(Players[i]) == "mechanic" then
                count = count +1
            end
        end
        cb(count)
    end)
end
