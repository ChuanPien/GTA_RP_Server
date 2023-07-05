fx_version 'adamant'

game 'gta5'

client_script {
  'client/client.lua',
  'config.lua'
}

server_script {
  'server/server.lua',
  'config.lua'
}

ui_page('html/ui.html')

files {
    'html/ui.html',
    'html/js/script.js',
    'html/css/style.css',
    'html/img/*.png'
}
