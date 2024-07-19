RegisterNetEvent("nyo-tromcho:server:BanCho", function(Cho)
    local src = source 
    local Player = CoreName.Functions.GetPlayer(src)

    if Config.BanCho.LoaiTien == "tiensach" then 
        for k, v in pairs(Config.BanCho.GiaCho) do
            if  Cho == k then 
                Player.Functions.AddMoney("cash", Config.BanCho.GiaCho[k], "BanCho")
                TriggerClientEvent(''..Config.Framework..':Notify', src, "Đã bán chó thành công..", 'success')
            end
        end 
    else 
        if Config.Framework == "QBCore" then 
            for k, v in pairs(Config.BanCho.GiaCho) do 
                if Cho == k then 
                    local info = {}
                    info.worth = Config.BanCho.GiaCho[k]
                    TriggerClientEvent(''..Config.Framework..':Notify', src, "Đã bán chó thành công..", 'success')
                    TriggerClientEvent('inventory:client:ItemBox', source, CoreName.Shared.Items['markedbills'], "add")
                    Player.Functions.AddItem("markedbills", 1, false, info)
                end 
            end 
        else 
            for k, v in pairs(Config.BanCho.GiaCho) do 
                if Cho == k then 
                    TriggerClientEvent(''..Config.Framework..':Notify', src, "Đã bán chó thành công..", 'success')
                    TriggerClientEvent('pepe-inventory:client:ItemBox', src, CoreName.Shared.Items['money-roll'], "add")
                    Player.Functions.AddItem("money-roll", Config.BanCho.GiaCho[k])
                end 
            end 
        end 
    end 
end)