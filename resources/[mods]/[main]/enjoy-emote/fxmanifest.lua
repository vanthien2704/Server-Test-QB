fx_version 'adamant'

game 'gta5'

description 'Enjoy Emotes (DPEMOTE MODIFIER)'

client_scripts {
    'config.lua',
	'core/list.lua',
    'core/function.lua',
    'core/client.lua',
}

server_scripts {
	'core/server.lua',
}

ui_page 'dist/index.html'

files {
	'dist/css/*.css',
	'dist/js/*.js',
	'dist/index.html',
}