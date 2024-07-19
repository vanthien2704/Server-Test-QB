fx_version 'cerulean'
game 'gta5'
description 'pi-tiengiatoc'
version '2.2.0'
shared_scripts {
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
    'locales/*.lua',
    'config.lua'
}
client_script 'client.lua'
server_script 'server.lua'
ui_page 'html/index.html'
files {
    'html/*',
    'html/index.html',
    'html/moneyhud.css',
    'html/moneyhud.js',
}
lua54 'yes'
