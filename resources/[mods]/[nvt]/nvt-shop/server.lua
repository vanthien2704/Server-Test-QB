local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('payitem', function(target, type, data)  
    local Player = QBCore.Functions.GetPlayer(source)
      local money = Player.Functions.GetMoney("cash")

      local banks = Player.Functions.GetMoney("bank")
        if type == 'cash' then 
          if tonumber(money) >= data.price then 
              
              Player.Functions.RemoveMoney("cash",data.price)
              Player.Functions.AddItem(data.item.Name, data.count);
              TriggerClientEvent('QBCore:Notify', source, 'Bạn đã mua '..data.count..' '..data.item.label..' !', 'success') 
            else
                TriggerClientEvent('QBCore:Notify', source, 'Bạn không đủ tiền mặt!', 'error') 
            end
        else
          if tonumber(banks) >= data.price then 

            Player.Functions.RemoveMoney("bank",data.price)
            Player.Functions.AddItem(data.item.Name, data.count);
            TriggerClientEvent('QBCore:Notify', source, 'Bạn đã mua '..data.count..' '..data.item.label..' !', 'success') 
            else
                TriggerClientEvent('QBCore:Notify', source, 'Bạn không đủ tiền trong ngân hàng!', 'error') 
            end
        end

end)

    