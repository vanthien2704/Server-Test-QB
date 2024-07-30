fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
game 'gta5'
lua54 'yes'

description 'nvt_suaxepolice'
author 'Nass#1411'
version '1.0.1'

shared_scripts { 'config.lua' }

server_scripts { 'bridge/**/server.lua', 'server/*.lua' }

client_scripts { 'bridge/**/client.lua', 'client/*.lua' }
