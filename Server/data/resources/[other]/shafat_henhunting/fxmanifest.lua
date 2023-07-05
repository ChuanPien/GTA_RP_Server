fx_version 'adamant'

game 'gta5'

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'server/main.lua',
  'server/meat.lua',
  'config.lua'
}

client_scripts {
  'client/main.lua',
  'client/meat.lua',
  'config.lua'
}