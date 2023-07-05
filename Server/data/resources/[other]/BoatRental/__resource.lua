resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'FiveM Lua Menu Framework'

client_script { 
    'warmenu.lua',
    'BoatRental.lua',
    'utils.lua'
}

server_script { 
    'BoatRentServer.lua',
    '@mysql-async/lib/MySQL.lua'
}