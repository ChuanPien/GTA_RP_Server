fx_version 'adamant'

game 'gta5'

client_script 'client/main.lua'

server_script 'server/main.lua'

ui_page('client/html/index.html')

files({
    'client/html/index.html',
    'client/html/sounds/*.ogg',
    'audio/sfx/resident/*.awc',
    'audio/sfx/weapons_player/*.awc'
})
  
data_file 'AUDIO_WAVEPACK' 'audio/sfx/resident'
data_file 'AUDIO_WAVEPACK' 'audio/sfx/weapons_player'
