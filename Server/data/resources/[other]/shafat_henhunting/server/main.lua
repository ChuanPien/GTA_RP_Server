ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('shafat-henhunting:reward')
AddEventHandler('shafat-henhunting:reward', function(type)
    local xPlayer = ESX.GetPlayerFromId(source)
    local num = math.random(1,2)

    if type == 'hen' then
        xPlayer.addInventoryItem('chicken_block', 1)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '1雞肉'})
    elseif type == 'cow' then
        xPlayer.addInventoryItem('meat_block', num)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = num.. '牛肉'})
    elseif type == 'deer' then
        xPlayer.addInventoryItem('venison_block', num)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = num.. '鹿肉'})
    else
        xPlayer.addInventoryItem('pork_block', num)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = num.. '豬肉'})
    end

end)

function sendNotification(xsource, message, messageType, messageTimeout)
    TriggerClientEvent('notification', xsource, message)
end

RegisterServerEvent('shafat-henhunting:milk')
AddEventHandler('shafat-henhunting:milk', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.addInventoryItem('milk',1)
    xPlayer.removeInventoryItem('glassjar',1)
    TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = '1牛奶'})
    TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = '1玻璃罐'})
end)

ESX.RegisterServerCallback('shafat-henhunting:bottle', function( source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getInventoryItem('glassjar').count >= 1 then
        cb(true)
    else
        cb(false)
    end
end)