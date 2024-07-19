	
Config = {}

Config.Inventory = "lj-inventory" -- ox_inventory, LcInventory, default, other  --- กระเป๋า
Config.MaxWeed = 3 -- Có thể trồng bao nhiêu cỏ dại cùng một lúc??
Config.Harvest = 0.8 --Khi thu hoạch nên sử dụng nhiều liều lượng (ví dụ liều 1,2 100% sẽ thu được 12 cỏ trong vụ thu hoạch).
Config.Webhook = "https://discord.com/api/webhooks/1248302837021016167/hljSfnLojt0i-Xnlsfgd_yyHhsHJ6wSAuucsvEaMUXptv5e0JjGq0zjHcN2iHrLX6y9d" --  webhook 
Config.Blip = {
	Blip = true, 
	Alpha = true, 
	color = 25,
	sprite = 496,
	scale = 0.75,
}

Config.Coords = { --  trồng vòng tròn
	vector4(2293.5, 1533.4000244140625, 63.11999893188476, 70),
}
-- Đừng quên thêm các mục trong cấu hình vào máy chủ!
Config.Items = {
	["Seed"] = "lockpick", -- hạt giống
	["Water"] = "pistol_ammo", -- Nước
	["Fertilizer"] = "pistol_ammo", -- phân bón
	["Dust"] = "pistol_ammo", -- chất kích thích tăng trưởng
	["Weed"] = "weapon_cuockimcuong", -- Các mặt hàng đã nhận
}

Config.Give = {
	["Water"] = 10, -- Bạn cho bao nhiêu % nước?
	["Fertilizer"] = 10, -- Nên bón bao nhiêu % phân?
	["Dust"] = { --   chất kích thích tăng trưởng
		["Healt"] = 15, -- Nó sẽ tăng bao nhiêu?
		["Growth"] = 0
		}, 
}

Config.Wait = {
	["Check"] = 5, -- Kiểm tra vài giây một lần (thời gian này rất quan trọng vì nó quyết định sau khi tưới nước sẽ mất bao nhiêu giây để cây phát triển, v.v.)
	["Seed"] = 4, --Hoạt hình gieo hạt sẽ kéo dài bao nhiêu giây?
	["Harvest"] = 6, -- Hoạt ảnh thu hoạch sẽ kéo dài bao nhiêu giây?
}

Config.Langs = { ---- การตั้งค่าภาษา
	["Waiter"] = "Bạn không thể mở menu nhanh như vậy được, vui lòng đợi một chút nhé!",
	["Blip"] = "Cánh đồng cỏ dại",
	["MaxWeed"] = "Bạn không thể gieo nhiều hạt liên tiếp.",
	["Distance"] = "This is not a field!",
	["OpenWeed"] = "[E]- Xem trạng thái",
	["Harvest"] = "Thu hoạch thành công",
	["Harvest_eror"] = "Thu hoạch sớm quá vậy",
} 

Config.Props = {  --- การตั้งค่า prop 
	["Weed_Lvl1"] = "bkr_prop_weed_01_small_01c", 
	["Weed_Lvl2"] = "bkr_prop_weed_01_small_01b",
	["Weed_Lvl3"] = "bkr_prop_weed_01_small_01a", 
	["Weed_Lvl4"] = "bkr_prop_weed_med_01a", 
	["Weed_Lvl5"] = "bkr_prop_weed_lrg_01a", 
	["spatulamodel"] = "bkr_prop_coke_spatula_04",
}