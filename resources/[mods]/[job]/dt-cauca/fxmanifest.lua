fx_version 'cerulean'
game 'gta5'
author 'D-TEAM - ROLEPLAY'
description 'Script Câu Cá'
version '0.0.1'
client_scripts {
    'client/main.lua',
	-- 'client/shark_zone.lua',
	'client/functions.lua'
}
server_scripts {
	"server/main.lua"
}
shared_scripts {
	'@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
	"config.lua"
}
ui_page "html/index.html"
files {
	"html/index.html",
	"html/style.css",
	"html/index.js",
	"html/reset.css",
	"html/imgs/*.png"
}server_scripts { '@mysql-async/lib/MySQL.lua' }