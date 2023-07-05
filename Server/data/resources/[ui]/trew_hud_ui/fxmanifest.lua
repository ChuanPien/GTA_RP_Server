fx_version 'adamant'

game 'gta5'

description 'Trew HUD UI'

version '1.3.0'

ui_page 'html/ui.html'


files {
	'html/ui.html',
	'html/main.css',
	'html/app.js',

	'html/img/weapons/*.png',
	'html/img/*.png',


	
	'html/sounds/*.ogg',
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/es.lua',
	'config.lua',
	'client/client.lua',
	'client/hansolo.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/es.lua',
	'config.lua',
	'server/server.lua',
	'server/milleniumfalcon.lua'
}

