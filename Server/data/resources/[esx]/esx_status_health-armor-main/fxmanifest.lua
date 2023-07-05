fx_version 'adamant'
games { 'gta5' }

author 'Musiker15'
description 'ESX Status - Health & Armor | Status will be saved in Databse and restore after Relog'
version '1.0'

shared_script {
	'config.lua'
}

client_scripts {
	'client.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	--'@oxmysql/lib/MySQL.lua',
	'server.lua'
}

dependencies {
	'mysql-async',
	--'oxmysql',
	'es_extended'
}