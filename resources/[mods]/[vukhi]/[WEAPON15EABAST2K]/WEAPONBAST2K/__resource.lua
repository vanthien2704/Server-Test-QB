resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'BAST2K_WEAPON'

name 'UPDATER V1 15MODEL'

version '1.1.2'

client_scripts {
  "config.lua",
  'client/main.lua'
}

server_scripts {
'	config.lua',
    'server/main.lua'
}


files {
	'contentunlocks.meta',
	'loadouts.meta',
	'weaponanimations.meta',
	'weaponarchetypes.meta',
	'weapons.meta',

}

data_file 'WEAPONINFO_FILE' 'weapons.meta'
data_file 'WEAPON_METADATA_FILE' 'weaponarchetypes.meta'
data_file 'WEAPON_ANIMATIONS_FILE' 'weaponanimations.meta'
data_file 'CONTENT_UNLOCKING_META_FILE' 'contentunlocks.meta'
data_file 'LOADOUTS_FILE' 'loadouts.meta'
