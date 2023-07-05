fx_version 'adamant'

game 'gta5'


server_scripts {
    'config.lua',
	'server/main.lua'
	
}

client_scripts {
    'config.lua',
	'client/main.lua'
}

ui_page "html/index.html"
files({
    'html/index.html',
    'html/index.js',
    'html/main.css'
})