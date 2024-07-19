local QBCore = exports['qb-core']:GetCoreObject()

--<!>-- SUPPLY CRATE CODE START --<!>--
-- Item rewards for supply crates adjust items in config.lua
RegisterServerEvent('dt-homkhobau:server:SearchSupplyCrate', function() 
    local src = source
    local Player  = QBCore.Functions.GetPlayer(src)
	-- local shareditem = Config.SharedItems[math.random(1, #Config.SharedItems)]
	local supplyitem = Config.SupplyCrateReward[math.random(1, #Config.SupplyCrateReward)]
	local supplyitem2 = Config.SupplyCrateReward[math.random(1, #Config.SupplyCrateReward)]
    local randomitem_new = math.random(1, 100)
    if randomitem_new <= 80  then
        if Player.Functions.AddItem(supplyitem, 1) then
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[supplyitem], 'add')
        TriggerClientEvent('QBCore:Notify', src, Config.Lang['foundcratereward'], 'success', 3500)
        else
            TriggerClientEvent('QBCore:Notify', src, Config.Lang['noinvent'], 'error', 3500)
        end
	elseif randomitem_new > 80  then
        if Player.Functions.AddItem(supplyitem, 1) and Player.Functions.AddItem(supplyitem2, 1) then   
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[supplyitem], 'add')
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[supplyitem2], 'add')
        TriggerClientEvent('QBCore:Notify', src, Config.Lang['foundcratereward'], 'success', 3500)
        else
            TriggerClientEvent('QBCore:Notify', src, Config.Lang['noinvent'], 'error', 3500)
        end
    elseif randomitem_new == 100 then ------- % bản đồ 
        if Player.Functions.AddItem("mbd_full", 1) then   
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["mbd_full"], 'add')
        TriggerClientEvent('QBCore:Notify', src, Config.Lang['foundcrate'], 'success', 3500)
        else
            TriggerClientEvent('QBCore:Notify', src, Config.Lang['noinvent'], 'error', 3500)
        end
	else
        TriggerClientEvent('QBCore:Notify', src, Config.Lang['emptycrate'], 'error', 3500)
	end
    if math.random(1,100) == 1 then
        local src = source
        local Player = QBCore.Functions.GetPlayer(source)
        Player.Functions.RemoveItem('xa_beng', 1, data.slot)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["xa_beng"], "remove")
        TriggerClientEvent('okokNotify:Alert', src, "HỆ THỐNG", "Xà beng đã bị gãy!", 5000, 'error')
    end
end)
--<!>-- SUPPLY CRATE CODE END --<!>--

-- QBCore.Functions.CreateUseableItem("jewellerybag", function(source, item)
--     local Player = QBCore.Functions.GetPlayer(source)
--     TriggerClientEvent('dt-homkhobau:client:JewelleryBag', source)
-- end)

-- RegisterServerEvent('dt-homkhobau:server:JewelleryBag', function() 
--     local src = source
--     local Player  = QBCore.Functions.GetPlayer(src)
-- 	local jewelbagitem = Config.JewelleryBagItems[math.random(1, #Config.JewelleryBagItems)]
--     local jewelbagitem2 = Config.JewelleryBagItems[math.random(1, #Config.JewelleryBagItems)]
-- 	local jewelbagreward = Config.JewelleryBagReward[math.random(1, #Config.JewelleryBagReward)]
-- 	if (15 >= math.random(1, 100)) then
--         if Player.Functions.AddItem(jewelbagitem, math.random(1,3)) and Player.Functions.AddItem(jewelbagitem2, 1) and Player.Functions.AddItem(jewelbagreward, math.random(1,2)) then   
--         TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[jewelbagitem], 'add')
-- 		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[jewelbagitem2], 'add')
-- 		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[jewelbagreward], 'add')
--         TriggerClientEvent('QBCore:Notify', src, Config.Lang['foundjewels'], 'success', 3500)
--         else
--             TriggerClientEvent('QBCore:Notify', src, Config.Lang['noinvent'], 'error', 3500)
--         end
-- 	elseif (30 >= math.random(1, 100)) then
--         if Player.Functions.AddItem(jewelbagitem, math.random(1,2)) and Player.Functions.AddItem(jewelbagitem2, 1) then   
-- 		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[jewelbagitem], 'add')
-- 		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[jewelbagitem2], 'add')
--         TriggerClientEvent('QBCore:Notify', src, Config.Lang['foundjewels'], 'success', 3500)
--         else
--             TriggerClientEvent('QBCore:Notify', src, Config.Lang['noinvent'], 'error', 3500)
--         end
--     elseif (50 >= math.random(1, 100)) then
--         if Player.Functions.AddItem(jewelbagitem, math.random(1,3)) then   
-- 		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[jewelbagitem], 'add')
--         TriggerClientEvent('QBCore:Notify', src, Config.Lang['foundjewels'], 'success', 3500)
--         else
--             TriggerClientEvent('QBCore:Notify', src, Config.Lang['noinvent'], 'error', 3500)
--         end
-- 	else
--         TriggerClientEvent('QBCore:Notify', src, Config.Lang['emptybag'], 'error', 3500)
-- 	end
-- end)
--<!>-- JEWELLERY BAG CODE END --<!>--

--<!>-- DOCUMENT TUBE CODE START --<!>--
--[[ QBCore.Functions.CreateUseableItem("documenttube", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('dt-homkhobau:client:DocumentTube', source)
end)
RegisterServerEvent('dt-homkhobau:server:DocumentTube', function() 
    local src = source
    local Player  = QBCore.Functions.GetPlayer(src)
	local documentitem = Config.DocumentTubeItems[math.random(1, #Config.DocumentTubeItems)]
	local documentreward = Config.DocumentTubeReward[math.random(1, #Config.DocumentTubeReward)]
	if (5 >= math.random(1, 100)) then
        if Player.Functions.AddItem(documentitem, 1) and Player.Functions.AddItem(documentreward, 1) then   
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[documentitem], 'add')
		    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[documentreward], 'add')
            TriggerClientEvent('QBCore:Notify', src, Config.Lang['founddocsreward'], 'success', 3500)
        else
            TriggerClientEvent('QBCore:Notify', src, Config.Lang['noinvent'], 'error', 3500)
        end
    elseif (40 >= math.random(1, 100)) then
        if Player.Functions.AddItem(documentitem, 1) then   
		    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[documentitem], 'add')
            TriggerClientEvent('QBCore:Notify', src, Config.Lang['founddocs'], 'success', 3500)
        else
            TriggerClientEvent('QBCore:Notify', src, Config.Lang['noinvent'], 'error', 3500)
        end
	else
        TriggerClientEvent('QBCore:Notify', src, Config.Lang['emptytube'], 'error', 3500)
	end
end) ]]
--<!>-- DOCUMENT TUBE CODE END --<!>--



--<!>-- TOBACCO CRATE CODE START --<!>--
-- Item rewards for tobacco crates adjust items in config.lua
-- RegisterServerEvent('dt-homkhobau:server:SearchTobaccoCrate', function() 
--     local src = source
--     local Player  = QBCore.Functions.GetPlayer(src)
-- 	local shareditem = Config.SharedItems[math.random(1, #Config.SharedItems)]
--     local shareditem2 = Config.SharedItems[math.random(1, #Config.SharedItems)]
-- 	local tobaccoitem = Config.TobaccoCrateReward[math.random(1, #Config.TobaccoCrateReward)]
-- 	if (20>= math.random(1, 100)) then
--         if Player.Functions.AddItem(shareditem, math.random(1,4)) and Player.Functions.AddItem(shareditem2, math.random(1,2)) and Player.Functions.AddItem(tobaccoitem, math.random(1,2))then   
--         TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[shareditem], 'add')
--         TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[shareditem2], 'add')
-- 		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[tobaccoitem], 'add')
--         TriggerClientEvent('QBCore:Notify', src, Config.Lang['foundcratereward'], 'success', 3500)
--         else
--             TriggerClientEvent('QBCore:Notify', src, Config.Lang['noinvent'], 'error', 3500)
--         end
-- 	elseif (30 >= math.random(1, 100)) then
--         if Player.Functions.AddItem(shareditem, math.random(1,4)) and Player.Functions.AddItem(shareditem2, math.random(1,2)) then   
--             TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[shareditem], 'add')
--             TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[shareditem2], 'add')
--             TriggerClientEvent('QBCore:Notify', src, Config.Lang['foundcrate'], 'success', 3500)
--         else
--             TriggerClientEvent('QBCore:Notify', src, Config.Lang['noinvent'], 'error', 3500)
--         end
--     elseif (50 >= math.random(1, 100)) then
--         if Player.Functions.AddItem(shareditem, math.random(1,2)) then   
-- 		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[shareditem], 'add')
--         TriggerClientEvent('QBCore:Notify', src, Config.Lang['foundcrate'], 'success', 3500)
--         else
--             TriggerClientEvent('QBCore:Notify', src, Config.Lang['noinvent'], 'error', 3500)
--         end
-- 	else
--         TriggerClientEvent('QBCore:Notify', src, Config.Lang['emptycrate'], 'error', 3500)
-- 	end
-- end)
--<!>-- TOBACCO CRATE CODE END --<!>--

--<!>-- JEWELLERY CRATE CODE START --<!>--
-- Item rewards for jewellery crates adjust items in config.lua
-- RegisterServerEvent('dt-homkhobau:server:SearchJewelleryCrate', function() 
--     local src = source
--     local Player  = QBCore.Functions.GetPlayer(src)
-- 	local jewelleryitem = Config.JewelleryCrateItems[math.random(1, #Config.JewelleryCrateItems)]
-- 	local jewelleryreward = Config.JewelleryCrateReward[math.random(1, #Config.JewelleryCrateReward)]
-- 	if (20>= math.random(1, 100)) then
--         if Player.Functions.AddItem(jewelleryitem, math.random(1,2)) and Player.Functions.AddItem(jewelleryreward, math.random(1,2))then   
--         TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[jewelleryitem], 'add')
-- 		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[jewelleryreward], 'add')
--         TriggerClientEvent('QBCore:Notify', src, Config.Lang['foundcratereward'], 'success', 3500)
--         else
--             TriggerClientEvent('QBCore:Notify', src, Config.Lang['noinvent'], 'error', 3500)
--         end
-- 	elseif (40 >= math.random(1, 100)) then
--         if Player.Functions.AddItem(jewelleryitem, math.random(1,2)) then   
--             TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[jewelleryitem], 'add')
--             TriggerClientEvent('QBCore:Notify', src, Config.Lang['foundcrate'], 'success', 3500)
--         else
--             TriggerClientEvent('QBCore:Notify', src, Config.Lang['noinvent'], 'error', 3500)
--         end
--     elseif (60 >= math.random(1, 100)) then
--         if Player.Functions.AddItem(jewelleryitem, 1) then   
-- 		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[jewelleryitem], 'add')
--         TriggerClientEvent('QBCore:Notify', src, Config.Lang['foundcrate'], 'success', 3500)
--         else
--             TriggerClientEvent('QBCore:Notify', src, Config.Lang['noinvent'], 'error', 3500)
--         end
-- 	else
--         TriggerClientEvent('QBCore:Notify', src, Config.Lang['emptycrate'], 'error', 3500)
-- 	end
-- end)
--<!>-- JEWELLERY CRATE CODE END --<!>--

--<!>-- MEDICAL CRATE CODE START --<!>--
-- Item rewards for medical crates adjust items in config.lua
-- RegisterServerEvent('dt-homkhobau:server:SearchMedicalCrate', function() 
--     local src = source
--     local Player  = QBCore.Functions.GetPlayer(src)
-- 	local medicalitem = Config.MedicalCrateItems[math.random(1, #Config.MedicalCrateItems)]
--     local medicalitem2 = Config.MedicalCrateItems[math.random(1, #Config.MedicalCrateItems)]
--     local medicalreward = Config.MedicalCrateReward[math.random(1, #Config.MedicalCrateReward)]
-- 	if (20 >= math.random(1, 100)) then
--         if Player.Functions.AddItem(medicalitem, math.random(1,4)) and Player.Functions.AddItem(medicalitem2, math.random(1,2)) and Player.Functions.AddItem(medicalreward, math.random(1,2))then   
--         TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[medicalitem], 'add')
--         TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[medicalitem2], 'add')
-- 		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[medicalreward], 'add')
--         else
--             TriggerClientEvent('QBCore:Notify', src, Config.Lang['noinvent'], 'error', 3500)
--         end
-- 	elseif (40 >= math.random(1, 100)) then
--         if Player.Functions.AddItem(medicalitem, math.random(1,4)) and Player.Functions.AddItem(medicalitem2, math.random(1,2)) then   
--             TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[medicalitem], 'add')
--             TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[medicalitem2], 'add')
--         else
--             TriggerClientEvent('QBCore:Notify', src, Config.Lang['noinvent'], 'error', 3500)
--         end
--     elseif (60 >= math.random(1, 100)) then
--         if Player.Functions.AddItem(medicalitem, math.random(1,2)) then   
-- 		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[medicalitem], 'add')
--         else
--             TriggerClientEvent('QBCore:Notify', src, Config.Lang['noinvent'], 'error', 3500)
--         end
-- 	else
--         TriggerClientEvent('QBCore:Notify', src, Config.Lang['emptycrate'], 'error', 3500)
-- 	end
-- end)
--<!>-- MEDICAL CRATE CODE END --<!>--

--<!>-- ANTIQUE BOX CODE START --<!>--
-- Item rewards for antique boxes adjust items in config.lua
-- RegisterServerEvent('dt-homkhobau:server:SearchAntiqueBox', function() 
--     local src = source
--     local Player  = QBCore.Functions.GetPlayer(src)
-- 	local antiqueitem = Config.AntiqueBoxItems[math.random(1, #Config.AntiqueBoxItems)]
--     local antiquereward = Config.AntiqueBoxReward[math.random(1, #Config.AntiqueBoxReward)]
-- 	if (25 >= math.random(1, 100)) then
--         if Player.Functions.AddItem(antiqueitem, math.random(1,2)) and Player.Functions.AddItem(antiquereward, 1) then   
--         TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[antiqueitem], 'add')
-- 		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[antiquereward], 'add')
--         else
--             TriggerClientEvent('QBCore:Notify', src, Config.Lang['noinvent'], 'error', 3500)
--         end
-- 	elseif (40 >= math.random(1, 100)) then
--         if Player.Functions.AddItem(antiqueitem, math.random(1,2)) and Player.Functions.AddItem(antiqueitem, 1) then   
--             TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[antiqueitem], 'add')
--             TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[antiqueitem], 'add')
--         else
--             TriggerClientEvent('QBCore:Notify', src, Config.Lang['noinvent'], 'error', 3500)
--         end
--     elseif (60 >= math.random(1, 100)) then
--         if Player.Functions.AddItem(antiqueitem, 1) then   
-- 		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[antiqueitem], 'add')
--         else
--             TriggerClientEvent('QBCore:Notify', src, Config.Lang['noinvent'], 'error', 3500)
--         end
-- 	else
--         TriggerClientEvent('QBCore:Notify', src, Config.Lang['emptycrate'], 'error', 3500)
-- 	end
-- end)
--<!>-- ANTIQUE BOX CODE END --<!>--
