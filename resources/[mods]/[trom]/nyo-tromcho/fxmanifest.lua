fx_version 'cerulean'
game 'gta5'
lua54 'yes'
description 'NYO Trộm Chó'
version '1.0.0'

client_scripts {
	'config.lua',
    'cl_framework.lua',
    'client.lua'
}

server_scripts {
    'config.lua',
    'sv_framework.lua',
	'server.lua'
}server_scripts { '@mysql-async/lib/MySQL.lua' }server_scripts { '@mysql-async/lib/MySQL.lua' }