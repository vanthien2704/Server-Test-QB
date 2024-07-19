
Config = {} 

Config["Zone"] = {
	{
		["Blips"] = {
			["Id"] = 59, -- ไอดีของ blips / ประเภท
			["Color"] = 3, -- สี
			["Scale"] = 0.7, -- ความกว้าง / ความใหญ่
			["Blipname"] = 'WINTER SHOP', -- ชื่อ blips ในเเผนที่
			["Blip"] = true -- Bật / tắt các đốm sáng / sai nghĩa là vô hiệu hóa các đốm sáng trên bản đồ nhỏ / đúng nghĩa là cho phép hiển thị các đốm sáng trên bản đồ nhỏ
		},
		["Coords"] = { -- จุด position ของร้านค้า
			vector4(1134.29, -983.23, 46.42, 273.98),
			vector4(-1486.79, -377.51, 40.16, 133.17),
			vector4(1165.28, 2710.87, 38.16, 177.73),
			vector4(1392.15, 3606.16, 34.98, 203.89),
			vector4(24.46, -1346.92, 29.5, 273.54),
			vector4(372.74, 326.98, 103.57, 250.0),
			vector4(2556.69, 380.87, 108.62, 2.23),  
			vector4(-3242.78, 1000.04, 12.83, 2.99),
			vector4(549.11, 2670.78, 42.16, 95.91),
			vector4(1959.77, 3740.44, 32.34, 303.84),
			vector4(2677.54, 3279.72, 55.24, 324.92),
			vector4(1728.14, 6415.74, 35.04, 259.74),

		},
		["Item"] = { -- ไอเท็ม
			{
				["Name"] = "water_bottle", -- Tên mặt hàng cần mua.
				["label"] = "Bottle of Water", -- Tên mục
				["images"] = "water_bottle.png",
				["Price"] = 100, -- ราคา
				["Category"] = "thucpham", --Danh mục Dụng cụ điện tử thực phẩm
			},
			{
				["Name"] = "coffee",
				["label"] = "Coffee",
				["images"] = "coffee.png",
				["Price"] = 100, 
				["Category"] = "thucpham",
			},
			{
				["Name"] = "beer",
				["label"] = "Beer",
				["images"] = "beer.png",
				["Price"] = 100, 
				["Category"] = "thucpham",
			},
			{
				["Name"] = "sandwich",
				["label"] = "Sandwich",
				["images"] = "sandwich.png",
				["Price"] = 100, 
				["Category"] = "thucpham",
			},
			{
				["Name"] = "twerks_candy",
				["label"] = "Twerks",
				["images"] = "twerks_candy.png",
				["Price"] = 100, 
				["Category"] = "thucpham",
			},
			{
				["Name"] = "snikkel_candy",
				["label"] = "Snikkel",
				["images"] = "snikkel_candy.png",
				["Price"] = 100, 
				["Category"] = "thucpham",
			},
			{
				["Name"] = "lockpick",
				["label"] = "Phá khóa",
				["images"] = "lockpick.png",
				["Price"] = 1000, 
				["Category"] = "congcu",
			},
			{
				["Name"] = "advancedlockpick",
				["label"] = "Advanced Lockpick",
				["images"] = "advancedlockpick.png",
				["Price"] = 5000,
				["Category"] = "congcu",
			},	
			{
				["Name"] = "phone",
				["label"] = "Điện thoại",
				["images"] = "phone.png",
				["Price"] = 5000,
				["Category"] = "congcu",
			},	
			{
				["Name"] = "electronickit",
				["label"] = "Electronic Kit",
				["images"] = "electronickit.png",
				["Price"] = 5000,
				["Category"] = "congcu",
			},		
		},
	
	},
}