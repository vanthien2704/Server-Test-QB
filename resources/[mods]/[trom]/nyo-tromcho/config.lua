Config = {}
Config.Debug = true -- BẬT CÁI NÀY LÊN ĐỂ CHECK XEM CHÓ CÓ SPAWN KHÔNG

--[[ THÔNG TIN MUA HÀNG ]]--
Config.Username = "d4nny.w" -- DON'T CHANGE
Config.License = "uMGpBkki" -- KEY ĐƯỢC CUNG CẤP
Config.Framework = "QBCore" -- Sài QBus thì ghi QBCore, PEPE thì ghi Framework
Config.Pepev6 = false -- Nếu bạn dùng Pepev6 thì điền true


--[[ CHUNG ]]--
Config.ToaDo = vector3(-278.11, -1616.54, 31.85) -- TỌA ĐỘ MÀ CHÓ SẼ XUẤT HIỆN
Config.Peds = {"a_c_husky", "a_c_poodle", "a_c_pug", "a_c_retriever", "a_c_rottweiler", "a_c_shepherd", "a_c_westy"} -- LOẠI CHÓ SẼ XUẤT HIỆN https://docs.fivem.net/docs/game-references/ped-models/#animals
Config.MaxSpawn = 5 -- MỖI NGƯỜI CHƠI SẼ XUẤT HIỆN NHIỀU NHẤT 5 CON
Config.PhamVi = 100.0 -- NHỚ LÀ SỐ THẬP PHÂN
Config.VatPham = "lockpick" -- VẬT PHẨM CẦN ĐỂ BẮT CHÓ
Config.ChoCan = true -- CÓ CHO CHÓ CẮN HAY KHÔNG
Config.ChanceChoCan = 10 -- TỈ LỆ BỊ CHÓ CẮN (TỪ 1 TỚI 10)
Config.MauBiCan = 10 -- MÁU MẤT KHI BỊ CẮN

--[[ THỜI GIAN XUẤT HIỆN ]] -- 
Config.CopRequired = 0 -- CẢNH SÁT YÊU CẦU
Config.MinTime = 18 -- XUẤT HIỆN TỪ 18H
Config.MaxTime = 22 -- TỚI 22H


--[[ BIỂU TƯỢNG TRÊN BẢN ĐỒ ]]--
Config.HienBlip = true -- HIỆN ICON TRÊN BẢN ĐỒ
Config.Title = "~r~ [NGHỀ BẨN]~w~ BẮT CHÓ" -- TÊN ICON 
Config.Icon = 362 -- https://docs.fivem.net/docs/game-references/blips/
Config.Scale = 0.5 -- ĐỘ LỚN (0 < n < 1)
Config.Colour = 7 -- MÀU https://docs.fivem.net/docs/game-references/blips/ (CUỐI TRANG SẼ CÓ BẢNG MÀU)
Config.Alpha = 255 -- ĐỘ MỜ (từ 0 tới 255)
--[[ VÒNG TO ]]--
Config.BigColour = 0.5 -- MÀU https://docs.fivem.net/docs/game-references/blips/ (CUỐI TRANG SẼ CÓ BẢNG MÀU)
Config.BigAlpha = 50 -- ĐỘ MỜ (từ 0 tới 255)

--[[ PHƯƠNG TIỆN - BẮT CHÓ Ở KHOẢNG CÁCH XA ]]--
Config.PhuongTien = {}
Config.PhuongTien.Allow = true -- CHO PHÉP BẮT CHÓ BẰNG PHƯƠNG TIỆN HAY KHÔNG
Config.PhuongTien.Xe = "exciter" -- PHƯƠNG TIỆN ĐƯỢC SỬ DỤNG (CHỈ MÔ TÔ)
Config.PhuongTien.Distance = 4 -- KHOẢNG CÁCH CÓ THỂ BẮT CHÓ Ở XA
Config.PhuongTien.VatPham = "thonglong" -- VẬT PHẨM CẦN DÙNG KHI BẮT BẰNG PHƯƠNG TIỆN

--[[ BÁO CẢNH SÁT ]] -- 
Config.BCS = {}
Config.BCS.Enable = false -- CÓ BÁO CẢNH SÁT HAY KHÔNG
Config.BCS.Chance = 10 -- TỈ LỆ BÁO CẢNH SÁT (TỪ 1 TỚI 10)
Config.BCS.Event = "" -- LIÊN HỆ ĐỂ ĐƯỢC SETUP

--[[ THANH SKILLBAR ]]--
Config.Skillbar = {}
Config.Skillbar.Type = "qb-skillbar" -- qb-skillbar, pepe-skillbar
Config.Skillbar.Tocdo = math.random(1500, 3000) -- SỐ CÀNG NHỎ TỐC ĐỘ SẼ CÀNG NHANH
Config.Skillbar.Solan = 4 -- SỐ LẦN LẶP LẠI


--[[ BÁN CHÓ ]]--
Config.BanCho = {}
Config.BanCho.NPC = "a_m_m_hillbilly_02"
Config.BanCho.ViTri = vector4(188.9946, -851.800, 31.166, 20.07)
Config.BanCho.TenIcon = "Bán Chó"
Config.BanCho.Icon = 23
Config.BanCho.MauIcon = 1
Config.BanCho.HienBlip = false
Config.BanCho.LoaiTien = "tienban" -- tiensach, tienban 
Config.BanCho.GiaCho = { -- GIÁ CHÓ
    ["a_c_husky"] = 2,
    ["a_c_poodle"] = 3,
    ["a_c_pug"] = 4, 
    ["a_c_retriever"] = 5, 
    ["a_c_rottweiler"] = 6, 
    ["a_c_shepherd"] = 7, 
    ["a_c_westy"] = 8
}
