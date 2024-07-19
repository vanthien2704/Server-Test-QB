fx_version 'cerulean'
games { 'gta5' }
author 'DTEAM Developer'
shared_scripts {
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
    'locales/*.lua',
    'config.lua'
}
client_script 'client.lua'
server_script 'server.lua'
lua54 'yes'
use_fxv2_oal 'yes'
ui_page "html/index.html"
files {
    "html/*"
}