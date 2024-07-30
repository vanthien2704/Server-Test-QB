fx_version 'cerulean'
games {'gta5'}

author 'no Evil'
description 'Xe cảnh sát UPD'
version '1.0.0'

files {
  'audioconfig/npolchar_game.dat151.rel',
  'audioconfig/npolchar_sounds.dat54.rel',
  'sfx/dlc_npolchar/npolchar.awc',
  'sfx/dlc_npolchar/npolchar_npc.awc',
  'sfx/dlc_npolchar/npolchar2.awc',
  'sfx/dlc_npolchar/npolchar2_npc.awc',

  'audioconfig/ecoboostv6_game.dat151.rel',
  'audioconfig/ecoboostv6_sounds.dat54.rel',
  'sfx/dlc_ecoboostv6/ecoboostv6.awc',
  'sfx/dlc_ecoboostv6/ecoboostv6_npc.awc',

  'audioconfig/cvpiv8_game.dat151.rel',
  'audioconfig/cvpiv8_sounds.dat54.rel',
  'sfx/dlc_cvpiv8/cvpiv8.awc',
  'sfx/dlc_cvpiv8/cvpiv8_npc.awc',

  'audioconfig/hemisound_game.dat151.rel',
	'audioconfig/hemisound_sounds.dat54.rel',
	'sfx/dlc_hemisound/hemisound.awc',
	'sfx/dlc_hemisound/hemisound_npc.awc',

  'audioconfig/fordvoodoo_game.dat151.rel',
  'audioconfig/fordvoodoo_sounds.dat54.rel',
  'sfx/dlc_fordvoodoo/fordvoodoo.awc',
  'sfx/dlc_fordvoodoo/fordvoodoo_npc.awc',


 'vehiclelayouts.meta',
  'handling.meta',
  'vehicles.meta',
  'carcols.meta',
  'carvariations.meta',
--  'additional/weapon_dish.meta',


}

data_file 'AUDIO_GAMEDATA' 'audioconfig/npolchar_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audioconfig/npolchar_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_npolchar'

data_file 'AUDIO_GAMEDATA' 'audioconfig/ecoboostv6_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audioconfig/ecoboostv6_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_ecoboostv6'

data_file 'AUDIO_GAMEDATA' 'audioconfig/cvpiv8_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audioconfig/cvpiv8_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_cvpiv8'

data_file 'AUDIO_GAMEDATA' 'audioconfig/hemisound_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audioconfig/hemisound_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_hemisound'

data_file 'AUDIO_GAMEDATA' 'audioconfig/fordvoodoo_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audioconfig/fordvoodoo_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_fordvoodoo'

data_file 'VEHICLE_LAYOUTS_FILE' 'vehiclelayouts.meta'
data_file 'HANDLING_FILE' 'handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'vehicles.meta'
data_file 'CARCOLS_FILE' 'carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'carvariations.meta'


data_file 'VEHICLE_LAYOUTS_FILE' 'vehiclelayouts.meta'
data_file 'HANDLING_FILE' 'handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'vehicles.meta'
data_file 'CARCOLS_FILE' 'carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'carvariations.meta'


client_script {
    'vehicle_names.lua'
}