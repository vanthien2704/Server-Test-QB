
fx_version 'cerulean'
games { 'gta5' }

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}

lua54 'yes'