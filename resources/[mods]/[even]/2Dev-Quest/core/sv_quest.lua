CheckTime = function()
    SetTimeout(1000, function()
        local a = os.date('%H:%M:%S', os.time())   
        for i=1, #Config.TimeReset, 1 do
            local b = Config.TimeReset[i][1]..':00'
            if a == b then  
                t[1](e.cl["ClearQuestState"], source)
            end
        end 
        CheckTime()   
	end)
end
if Config.EnableReset then
    CheckTime()
end

RegisEvent(true, e.sv["QuestRewards"], function(a)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    for k, v in pairs(Config.Quest[a].Reward) do 
        if v.type == 'money' or v.type == 'black_money' then
            xPlayer.Functions.AddMoney(v.type, v.quantity)
        else
            TriggerClientEvent('nvt-nhiemvu:hoanthanh',src, a)
            xPlayer.Functions.AddItem(v.name, v.quantity)
        end
    end
end)

RegisEvent(true, e.sv["ResetQuestID"], function(a)
    local src = source
    t[1](e.cl["ResetQuestID"], src, a, Config.Quest[a].Count)
end)



RegisterServerEvent('nvt-nhiemvu:hoanthanh', function(id_nhiemvu)
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	local citizenid = xPlayer.PlayerData.citizenid
    MySQL.Async.execute('INSERT INTO nhiemvu (citizenid, id_nhiemvu) VALUES (@citizenid, @id_nhiemvu)', {
                ['@citizenid'] = citizenid,
                ['@id_nhiemvu'] = id_nhiemvu,
            }, function(rowsChanged)
                if rowsChanged > 0 then
                    -- print(...citizenid...' đã hoàn thành nhiệm vụ '...id_nhiemvu... )
                end
            end)
end)

RegisterServerEvent('nvt-nhiemvu:kiemtra', function(id_nhiemvu)
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	local citizenid = xPlayer.PlayerData.citizenid
    MySQL.Async.fetchScalar('SELECT COUNT(*) FROM nhiemvu WHERE citizenid = @citizenid AND id_nhiemvu = @id_nhiemvu', {
        ['@citizenid'] = citizenid,
        ['@id_nhiemvu'] = id_nhiemvu,
    }, function(count)
        if count > 0 then
            TriggerClientEvent('nvt-nhiemvu:nhannhiemvu',src, id_nhiemvu, false)
        else
            TriggerClientEvent('nvt-nhiemvu:nhannhiemvu',src, id_nhiemvu, true)
        end
    end)
end)

