ESX = nil

TriggerEvent("esx:getSharedObject", function(response)
    ESX = response
end)

RegisterServerEvent("esx-ecobottles:retrieveBottle")
AddEventHandler("esx-ecobottles:retrieveBottle", function()
    local xPlayer = ESX.GetPlayerFromId(source)

    math.randomseed(os.time())
    local count = math.random(1,3)
    local item = math.random(0,100)

    if item == 100 then
        xPlayer.addInventoryItem("spider", 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '蜘蛛爬到了你的手上'})
    elseif item == 99 then
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '空的'})
    elseif item <= 98 and item >= 93 then
        xPlayer.addInventoryItem("paperbottle", 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '紙杯'})
    elseif item <= 92 and item >= 65 then
        local count = math.random(3,6)
        xPlayer.addInventoryItem("cardboard", count)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = count .. '厚紙板'})
    elseif item <= 64 and item >= 55 then
        xPlayer.addInventoryItem("tincan", count)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = count .. '鐵罐'})
    elseif item <= 54 and item >= 45 then
        xPlayer.addInventoryItem("glassjar", count)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = count .. '玻璃罐'})
    elseif item <= 44 and item >= 35 then
        xPlayer.addInventoryItem("notepad",1)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '筆記本'})
    elseif item <= 34 and item >= 10 then
        xPlayer.addInventoryItem("bottle", count)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = count .. '寶特瓶'})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '空的'})
    end
end)

RegisterServerEvent("baz:sell")
AddEventHandler("baz:sell", function(type)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = xPlayer.getInventoryItem(type).count
    local count = math.random(50,100)

    if item > 0 then
        local money = count * item
        xPlayer.removeInventoryItem(type, item)
        xPlayer.addMoney(money)

        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = item .. ESX.GetItemLabel(type) .. '$' .. money})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = '空'})
    end
end)