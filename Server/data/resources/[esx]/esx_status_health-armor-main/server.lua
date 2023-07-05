local ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_armor:getDBArmor')
AddEventHandler('esx_armor:getDBArmor', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if Config.Debug then
        print(src) -- Player ID
        print(xPlayer) -- table:
    end

    MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", { 
        ['@identifier'] = xPlayer.identifier
        }, function(data)
        if data[1] then
            if Config.Debug then
                print('Health: ' .. data[1].health)
                print('Armor: ' .. data[1].armour)
            end
            TriggerClientEvent('esx_armor:setJoinArmor', src, data[1].health, data[1].armour)
        else 
            if Config.Debug then
                print('data not found')
            end
        end
    end)
end)

RegisterServerEvent('esx_armor:refreshArmour')
AddEventHandler('esx_armor:refreshArmour', function(updateHealth, updateArmour)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.execute("UPDATE users SET armour = @armour, health = @health WHERE identifier = @identifier", { 
        ['@identifier'] = xPlayer.identifier,
        ['@armour'] = tonumber(updateArmour),
        ['@health'] = tonumber(updateHealth)
    })

    if Config.Debug then
        print('Update Status')
    end
end)

---- GitHub Updater ----
function GetCurrentVersion()
	return GetResourceMetadata( GetCurrentResourceName(), "version" )
end

local CurrentVersion = GetCurrentVersion()
local resourceName = "^4["..GetCurrentResourceName().."]^0"

if Config.VersionChecker then
	PerformHttpRequest('https://raw.githubusercontent.com/Musiker15/esx_status_health-armor/main/VERSION', function(Error, NewestVersion, Header)
		print("###############################")
    	if CurrentVersion == NewestVersion then
	    	print(resourceName .. '^2 ✓ Resource is Up to Date^0 - ^5Current Version: ^2' .. CurrentVersion .. '^0')
    	elseif CurrentVersion ~= NewestVersion then
        	print(resourceName .. '^1 ✗ Resource Outdated. Please Update!^0 - ^5Current Version: ^1' .. CurrentVersion .. '^0')
	    	print('^5Newest Version: ^2' .. NewestVersion .. '^0 - ^6Download here: ^9https://github.com/Musiker15/esx_status_health-armor/releases/tag/v'.. NewestVersion .. '^0')
    	end
		print("###############################")
	end)
else
	print("###############################")
	print(resourceName .. '^2 ✓ Resource loaded^0')
	print("###############################")
end