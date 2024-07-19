Config = {}

Config._ResetTime = 120 -- Tính theo phút
Config.ThucAn = "thucan"
Config.PhanThuong = "corgi"
Config.SoLuong = 1
Config.SoLuong_ChamSoc_ToiDa = 5
Config.Pet_Shop =  vector4(-1893.07, -864.44, 7.86, 304.04)
Config.Pet_Shop_2 = vector4(-1893.07, -864.44, 7.86, 304.04)

Config.Feed = {
	{
		ped = "a_c_pig",
		coords =  vector3(-1875.48, -817.56, 3.09)   ,
		coords_2 =  vector3(-1875.48, -817.56, 3.09) ,
		range = 10,
		text = "~r~KHU VỰC CHĂM SÓC THÚ CƯNG",
		percent_feed = {math.random(10, 20), math.random(30, 40) , math.random(50, 60) , math.random(70, 90)},
		need = 10, -- THỜI GIAN ĐÓI
		time_need = 10 * 1000 , -- THỜI GIAN TĂNG PHÁT TRIỂN
		blips = {
			enabled = true,
			sprite = 463,
			scale = 1.0,
			color = 3,
			text = "~g~[Nghề] ~w~ CHĂM SÓC THÚ CƯNG",
		},
		item = {
			use = "lockpick",
		},
	},
}

Config.Setting = {
	marker = {
		intensive = 70,
		normal = {r = 0, g = 255, b = 85},
		feed = {r = 255, g = 247, b = 0},
		kill = {r = 255, g = 0, b = 0},
	},
	animal = {
		distance = {
			text = 5,
			press = 1.2,
		},
	},
}

Config.Shop_ChamSocThuCung = {
	[1] = {
		name = "corgi_con",
		price = 200,
		amount = 5000,
		type = "item",
		slot = 1,
	},
	[2] = {
		name = "thucan",
		price = 20,
		amount = 5000,
		type = "item",
		slot = 2,
	},

}

Config.Locations_s = {
    ["ViTri"] = vector3(-1908.48, -876.38, 7.86) -- VÙNG CÔNG VIỆC
}

Config.Price = {
    ["corgi"] = {
        price = 1750,
        min_price = 1700,
        max_price = 1800,
    }, 
}

Config.Main = {
    [1] = {
        name = "CỬA HÀNG THÚ CƯNG",
        description = "Bạn muốn giao lại thú cưng ?",
        coords =  vector4(-3031.29, 92.34, 12.35, 317.89),
        model = "u_m_m_streetart_01",
        market = {
            [1] = {
                name = "🐕‍🦺 Đồng ý", 
                description = "Giao lại Corgi cho cửa hàng",
                item = {
                    "corgi",
                }
            }
        }
    }
}