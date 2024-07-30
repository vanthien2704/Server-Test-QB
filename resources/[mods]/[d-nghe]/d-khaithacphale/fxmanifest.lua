fx_version 'cerulean'
game 'gta5'

Author 'Trương Vô Kỵ'
description 'script bắt cua by Trương Vô Kỵ'

shared_script{
	'config.lua',
}

client_scripts {
	'@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/ComboZone.lua',
	'client/client.lua',
	'client/function.lua',
}
server_scripts {
	'server/main.lua',
}

lua54 'yes'server_scripts { '@mysql-async/lib/MySQL.lua' }