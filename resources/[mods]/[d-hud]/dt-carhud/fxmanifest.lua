-- client_script '@Xo.Brain/Shared/xGuardPlayer.lua'
-- server_script '@Xo.Brain/Shared/xGuardServer.lua'
fx_version "adamant"
game "gta5"
ui_page 'Interface/Interface.html'
client_script {
	'Secure.lua',
	'Source/Include.lua',
	'Source/Client.lua',
}
server_scripts {
	'Secure.lua',
	'Source/Include.lua',
}
files {
	'Interface/Interface.html',
	'Interface/Dynamic.css',
	'Interface/custom.css',
	'Interface/Function.js',
	'Interface/Sound/*.ogg',
	'Interface/img/*.png',
	'Interface/img/*.svg',
	'Interface/digital-7.ttf',
}