fx_version 'bodacious'
games { 'gta5' }
author 'Winter Town'
client_script "client.lua"
server_script "server.lua"

ui_page {
	'html/index.html'
}

shared_script {
	'shared.lua'
}
files {
	'html/css/*.css',
	'html/js/*.js',
	'html/index.html'
}
