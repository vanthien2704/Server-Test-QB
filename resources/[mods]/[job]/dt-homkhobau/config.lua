-------------------------------
---------- CASE#2506 ----------
-------------------------------
Config = {}
Config.DivingZone1 = vector3(1726.83, -3034.76, -54.38) -- Diving location 1
Config.DivingZone2 = vector3(3171.64, -354.78, -25.58) -- Diving location 2
Config.DivingZone3 = vector3(-944.87, 6555.7, -30.97) -- Diving location 3
Config.DivingZone4 = vector3(3420.32, 6335.72, -62.15) -- Diving location 4
Config.CrateSearchTime = 10000 -- Time in (ms) to search supply and tobacco crates
Config.CrateSearchItem = 'lockpick' -- Item needed to search supply and tobacco crates, change this to whatever you want
Config.JewellerySearchTime = math.random(5500,9000) -- Time in (ms) to search crates
Config.JewellerySearchItem = 'lockpick' -- Item needed to search jewellery crates
Config.MedicalSearchTime = math.random(5500,9000) -- Time in (ms) to search crates
Config.MedicalSearchItem = 'medickeycard' -- Item needed to search medical crates
Config.AntiqueSearchTime = math.random(5500,9000) -- Time in (ms) to search antique boxes
Config.AntiqueSearchItem = 'advancedlockpick' -- Item needed to search antique boxes
Config.JewelleryBagOpenTime = math.random(3500,6000) -- Time in (ms) to search crates
-- [[ Config.DocumentTubeOpenTime = math.random(3500,6000) ]] -- Time in (ms) to search crates
Config.Blips = {
	{title="~y~[CÔNG VIỆC]~w~ HÒM KHO BÁU", colour = 36, id = 587, x = 1726.83, y = -3034.76, z = -54.38},
	{title="~y~[CÔNG VIỆC]~w~ HÒM KHO BÁU", colour = 36, id = 587, x = 3171.64, y = -354.78, z = -25.58},
	{title="~y~[CÔNG VIỆC]~w~ HÒM KHO BÁU", colour = 36, id = 587, x = -944.87, y = 6555.70, z = -30.97},
	{title="~y~[CÔNG VIỆC]~w~ HÒM KHO BÁU", colour = 36, id = 587, x = 3420.32, y = 6335.72, z = -62.15},
}
-- -- Shared items that could be in either the supply & tobacco crates **PLEASE MAKE SURE TO REMOVE ANY ITEMS NOT IN YOUR CITY**
-- Config.SharedItems = {
--     -- QBCore items
--     'iron',
--     'steel',
-- }
-- High roll items for supply crate **PLEASE MAKE SURE TO REMOVE ANY ITEMS NOT IN YOUR CITY**
Config.SupplyCrateReward = {
    -- QBCore items
    'binh_co',
    'chen_co',
}
-- -- High roll items for tobacco crate **PLEASE MAKE SURE TO REMOVE ANY ITEMS NOT IN YOUR CITY**
-- Config.TobaccoCrateReward = {
--     -- QBCore items
--     'lockpick',
--     'cokebaggy',
--     'crack_baggy',
--     'meth',
-- }
-- -- Regular roll items for medical crate **PLEASE MAKE SURE TO REMOVE ANY ITEMS NOT IN YOUR CITY**
-- Config.MedicalCrateItems = {
--     -- QBCore items
--     --'bandage',
--     'lockpick',
--     'cokebaggy',
--     'crack_baggy',
--     'meth',
--     --'oxy',
-- }
-- -- High roll items for medical crate **PLEASE MAKE SURE TO REMOVE ANY ITEMS NOT IN YOUR CITY**
-- Config.MedicalCrateReward = {
--     -- QBCore items
--     'lockpick',
--     'cokebaggy',
--     'crack_baggy',
--     'meth',

-- }
-- -- Regular roll items for jewellery crate **PLEASE MAKE SURE TO REMOVE ANY ITEMS NOT IN YOUR CITY**
-- Config.JewelleryCrateItems = {
--     -- QBCore items
--     'goldchain',
--     'rolex',  
-- }
-- -- High roll items for jewellery crate **PLEASE MAKE SURE TO REMOVE ANY ITEMS NOT IN YOUR CITY**
-- Config.JewelleryCrateReward = {
--     -- QBCore items
--     '10kgoldchain',
--     'diamond',
--     'diamond_ring',
-- }
-- -- Regular roll items for antique box crate **PLEASE MAKE SURE TO REMOVE ANY ITEMS NOT IN YOUR CITY**
-- Config.AntiqueBoxItems = {
--     -- QBCore items
--     'electronickit',
--     -- CTRP items
--     'jewellerybag', -- **THIS IS NEEDED FOR THE SCRIPT TO WORK CORRECTLY! INFORMATION IS IN THE README.MD**
-- }
-- -- High roll items for antique box crate **PLEASE MAKE SURE TO REMOVE ANY ITEMS NOT IN YOUR CITY**
-- Config.AntiqueBoxReward = {
--     -- QBCore items
--     'ironoxide',
--     'aluminumoxide',
--     -- CTRP items
--     --'documenttube', -- **THIS IS NEEDED FOR THE SCRIPT TO WORK CORRECTLY! INFORMATION IS IN THE README.MD**
-- }
-- -- Regular roll items for jewellery bag **PLEASE MAKE SURE TO REMOVE ANY ITEMS NOT IN YOUR CITY**
-- Config.JewelleryBagItems = {
--     -- QBCore items
--     'diamond',
--     'goldchain',
-- }
-- -- High roll items for jewellery bag **PLEASE MAKE SURE TO REMOVE ANY ITEMS NOT IN YOUR CITY**
-- Config.JewelleryBagReward ={
--     -- QBCore items
--     'diamond_ring',
--     '10kgoldchain',
-- }
-- Regular roll items for document tube **PLEASE MAKE SURE TO REMOVE ANY ITEMS NOT IN YOUR CITY**
--[[ Config.DocumentTubeItems = {
    -- QBCore items
    'cryptostick',
    'lockpick',
    'electronickit',
    'ruineddocuments', -- **JUNK ITEM THIS IS NOT NEEDED FOR THE SCRIPT, YOU CAN REMOVE OR USE! INFORMATION IS IN THE README.MD**
    'inactivekeycard', -- **JUNK ITEM THIS IS NOT NEEDED FOR THE SCRIPT, YOU CAN REMOVE OR USE! INFORMATION IS IN THE README.MD**
}
-- High roll items for document tube **PLEASE MAKE SURE TO REMOVE ANY ITEMS NOT IN YOUR CITY**
Config.DocumentTubeReward = {
    -- QBCore items
    'advancedlockpick',
    'trojan_usb',
} ]]
Config.Lang = {
    -- Multiuse
    ['noinvent'] = 'Túi đồ của bạn đã đầy', -- Notification
    ['outrange'] = 'Khoảng cách quá xa', -- Notification
    ['emptycrate'] = 'Chúc bạn may mắn lần sau', -- Notification
    ['foundcrate'] = 'Hình như tìm thấy thứ gì đó', -- Notification
    ['foundcratereward'] = 'Tìm thấy gì đó rất thú vị', -- Notification
    ['nocrowbar'] = 'Cần [Xà beng] để mở hòm này', -- Notification
    ['brokelockpick'] = 'Tự nhiên cái Lockpick gãy làm đôi! Xui ghê', -- Notification

    -- Supply crates    
    ['searchsupply'] = 'ĐANG MỞ HÒM', -- Progress bar

    -- Tobacco crates
    ['searchtobacco'] = 'ĐANG MỞ HÒM', -- Progress bar

    -- Jewellery crates
    ['nolockpick'] = 'Cần [Bộ phá khóa] để mở hòm này', -- Notification
    ['searchjewellery'] = 'ĐANG MỞ HÒM', -- Progress bar

    -- Medical crates
    ['hackfailed'] = 'Hack dễ vậy mà cũng thất bại được', -- Notification
    ['hacksuccess'] = 'Trình cao hack cái thành công liền', -- Notification
    ['nomedickey'] = 'Cần [Thẻ khóa y tế] để mở hòm này',
    ['failedmedical'] = 'Không sao! Thất bại là mẹ thành công', -- Notification
    ['searchmedical'] = 'ĐANG MỞ HÒM', -- Progress bar

    -- Antique Box
    ['noadvlockpick'] = 'Cần [Bộ phá khóa nâng cao] để mở hòm này', -- Notification
    ['failedbox'] = 'Không sao! Thất bại là mẹ thành công', -- Notification
    ['searchantique'] = 'ĐANG MỞ HÒM', -- Progress bar

    -- Jewellery bag
    ['emptybag'] = 'Ăn gì đen dữ thần', -- Notification
    ['foundjewels'] = 'Trời trời! Tìm thấy cái gì đó kìa', -- Notification
    ['openjewel'] = 'ĐANG MỞ TÚI TRANG SỨC', -- Progress bar

    -- Document tube
    ['emptytube'] = 'Không có gì', -- Notification
    ['founddocs'] = 'Trời trời! Tìm thấy cái gì đó kìa', -- Notification
    ['founddocsreward'] = 'Tìm thấy gì đó rất thú vị', -- Notification
    ['opendoctube'] = 'ĐANG MỞ HÒM', -- Progress bar
}