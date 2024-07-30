local Translations = {
    notify = {
        ["hud_settings_loaded"] = "Đã tải cài đặt HUD",
        ["hud_restart"] = "HUD đang khởi động lại",
        ["hud_start"] = "HUD hiện đã bắt đầu!",
        ["hud_command_info"] = "Lệnh này đặt lại cài đặt HUD hiện tại của bạn",
        ["load_square_map"] = "Đang tải bản đồ vuông",
        ["loaded_square_map"] = "Bản đồ vuông đã được tải",
        ["load_circle_map"] = "Đang tải bản đồ tròn",
        ["loaded_circle_map"] = "Bản đồ tròn đã được tải",
        ["cinematic_on"] = "Chế độ điện ảnh đang bật",
        ["cinematic_off"] = "Chế độ điện ảnh đang tắt",
        ["engine_on"] = "Động cơ khởi động",
        ["engine_off"] = "Tắt động cơ",
        ["low_fuel"] = "Mức nhiên liệu thấp",
        ["access_denied"] = "Bạn không được ủy quyền",
        ["stress_gain"] = "Cảm thấy căng thẳng hơn",
        ["stress_removed"] = "Cảm thấy thư giãn hơn"
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
