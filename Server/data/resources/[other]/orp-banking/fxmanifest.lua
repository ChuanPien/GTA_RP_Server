fx_version 'adamant'

game 'gta5'

client_script('client.lua')

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server.lua'
}

ui_page('html/index.html')

files {
    'html/index.html',
    'html/script.js',
    'html/style.css',
    'html/img/*.png'
}