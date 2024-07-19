-- NC PROTECT

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_scripts {  

  'config.lua',
  'client.lua',
}

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'config.lua',   
  'server.lua',
}

ui_page "html/index.html"

files ({
	'html/index.html',
	'html/js/script.js',
	'html/css/style.css',
	'html/css/contextMenu.min.css',
	'html/js/jquery.min.js',
  'html/icon/*.png',
  'html/js/script.js',
  'html/**',
  'html/js/materialize.min.js',
})