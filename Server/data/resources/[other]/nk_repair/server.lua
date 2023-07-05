local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('fixkit', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
		
	TriggerClientEvent('nk_repair:MenuRipara', source)
end)

RegisterServerEvent('nk_repair:RimuoviItem')
AddEventHandler('nk_repair:RimuoviItem', function(ped, coords, veh)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('fixkit', 1)
	TriggerClientEvent('nk_repair:MettiCrick', _source, ped, coords, veh)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '修車中...'})
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '1修車包'})
end)