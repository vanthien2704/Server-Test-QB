fx_version 'cerulean'
game 'gta5'
lua54 'yes'
client_script 'client/main.lua'

files{
    'ui/*.css',
    'ui/*.js',
    'ui/*.ttf',
    'ui/*.html',
}

ui_page 'ui/index.html'

escrow_ignore{
    'client/main.lua'
}
dependency '/assetpacks'