local QBCore = exports["qb-core"]:GetCoreObject()
RegisterCommand('testskill', function()
    exports['meteo-skillbar']:Start(40, 3, function(result)
        if result then
            print("Success")
        else
            print("Failed")
        end
    end)
end)
RegisterNetEvent('d-khaithac:server:reward')
AddEventHandler('d-khaithac:server:reward', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player ~= nil then
        Player.Functions.AddItem("cuabien", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["cuabien"], "add", 1)
        
        -- Log the item catching activity
        TriggerEvent('qb-log:server:CreateLog', 'nghe_khaithac', '**KHAI THÁC THẠCH ANH**', 'blue', 
            '\n- Tên nhân vật: `'..Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname..
            '`\n- ID hiện tại: `'..src..
            '`\n- ĐÃ NHẬN ĐƯỢC: ' .. QBCore.Shared.Items["cuabien"].label, false)
        
        -- Notify the player of the successful catch
        TriggerClientEvent('bkNotify:Alert', src, "HỆ THỐNG!", "MAY MẮN NHẬN ĐƯỢC: 1x "..QBCore.Shared.Items["cuabien"].label, 3500, 'success')
        
        -- Update quest progress
        TriggerClientEvent("UpdateQuest", src, "quest_cabbage", 1)
    end
end)


RegisterNetEvent('d-khaithac:sv:khaithac', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local soluong = 1
	if Player ~= nil then
		if Player.Functions.RemoveItem("cuabien", 1) then
			TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["cuabien"], "remove", 1)
			Player.Functions.AddItem("cuanuong", 1)
			TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["cuanuong"], "add", 1)
			TriggerEvent('qb-log:server:CreateLog', 'nghe_khaithac', '**MÀI THẠCH ANH**', 'red', 
            '\n- Tên nhân vật: `'..Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname..
            '`\n- ID hiện tại: `'..src..
            '`\n- ĐÃ NHẬN ĐƯỢC: ' .. QBCore.Shared.Items["cuanuong"].label, false)
			TriggerClientEvent('bkNotify:Alert', src, "HỆ THỐNG!", "MÀI THÀNH CÔNG VÀ NHẬN ĐƯỢC : 1x "..QBCore.Shared.Items["cuanuong"].label, 3500, 'success')
		else
			TriggerClientEvent('bkNotify:Alert', src, "HỆ THỐNG!", "BẠN KHÔNG CÓ ĐỦ 1x: "..QBCore.Shared.Items["cuabien"].label.." ĐỂ MÀI", 3500, 'success')
		end
	end
end)