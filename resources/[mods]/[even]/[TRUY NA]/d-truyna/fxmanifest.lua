fx_version 'cerulean'
games { 'gta5' }
-- author 'author'
version '1.0'
client_scripts {
  'config.lua',
  'core/core_cl.lua'
}

server_scripts {
  'config.lua',
  'core/core_sv.lua'
}

ui_page 'ui/index.html'
files {
  'ui/**'
  -- 'data/**.json'
}
