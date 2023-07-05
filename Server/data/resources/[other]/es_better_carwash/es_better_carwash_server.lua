ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('es_better_carwash:checkMoney')
AddEventHandler('es_better_carwash:checkMoney', function(price)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	price = tonumber(price)
	if price < xPlayer.getMoney() then
        TriggerClientEvent('es_better_carwash:success', _source)
        xPlayer.removeMoney(price)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '現金不足 $' .. price})
    end
end)
