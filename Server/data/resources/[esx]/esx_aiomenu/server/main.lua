ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_aiomenu:showID')
AddEventHandler('esx_aiomenu:showID', function(ID, targetID)
    local identifier = ESX.GetPlayerFromId(ID).identifier
    local _source 	 = ESX.GetPlayerFromId(targetID).source
    local sexVariable = '男性'
    
    MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = @identifier",
    {
        ['@identifier'] = identifier
    }, function(result)
        if result[1] ~= nil then
            if result[1]['sex'] == 'f' then
                sexVariable = '女性'
            end
			
            local data = {
                name = result[1]['firstname'] .. ' ' .. result[1]['lastname'],
                dob = result[1]['dateofbirth'],
                sex = sexVariable,
				height = result[1]['height'] .. '公分'
            }

            TriggerClientEvent('esx_aiomenu:showID', _source, data) 
        else
            local data = {
                name = 'Nil',
                dob = 'Nil',
                sex = 'Nil',
                height = 'Nil'
            }

            TriggerClientEvent('esx_aiomenu:showID', _source, data)
        end
    end)     
end)
