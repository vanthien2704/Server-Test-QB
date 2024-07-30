local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("edit_names", function(source, item)
	local src = source
	TriggerClientEvent('qb-names:changeNumber', src)
end)

RegisterServerEvent('qb-names:useSimCard', function(firstname, lastname)
	local src = source
	TriggerClientEvent('qb-names:startNumChange', src, firstname, lastname)
end)

RegisterServerEvent('qb-names:savenames', function(firstname, lastname)
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	local Item = xPlayer.Functions.GetItemByName("edit_names")
	if Item then
		local charinfo = xPlayer.PlayerData.charinfo
		local citizenid = xPlayer.PlayerData.citizenid
		charinfo.citizenid = citizenid
		charinfo.firstname = firstname
		charinfo.lastname = lastname
		xPlayer.Functions.SetPlayerData("charinfo", charinfo)
		xPlayer.Functions.RemoveItem("edit_names", 1)
		xPlayer.Functions.RemoveItem("id_card", 1)
		TriggerClientEvent('QBCore:Notify', src, 'Name Change: | ' .. firstname .. ' ' .. lastname)
		xPlayer.Functions.AddItem("id_card", 1, nil, charinfo)
	else
		TriggerClientEvent('QBCore:Notify', src, "don't try to do that", 'error')
	end
end)
