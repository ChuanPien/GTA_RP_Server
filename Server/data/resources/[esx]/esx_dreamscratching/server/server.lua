ESX = nil
local players = {}
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local totalSumChance = 0
for k,v in pairs(Config.Prices) do
    totalSumChance = totalSumChance + v[1]
end

ESX.RegisterUsableItem('scratch_ticket', function(source)
    TriggerEvent("esx_dreamscratching:handler", source)
end)

RegisterNetEvent("esx_dreamscratching:handler")
AddEventHandler("esx_dreamscratching:handler", function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    local count = xPlayer.getInventoryItem('scratch_ticket').count
    if count >= 1 then
        xPlayer.removeInventoryItem('scratch_ticket', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '刮刮卡'})
    end

    TriggerClientEvent("esx_dreamscratching:startScratchingEmote", _source)

     local tempsrc = tonumber(_source)
     local randomNumber = math.random(1, totalSumChance)
     local add = 0
     for item,values in pairs(Config.Prices) do
        local chance = values[1]
        local price = values[2]

        if randomNumber > add and randomNumber <= add + chance then
            TriggerClientEvent("esx_dreamscratching:nuiOpenCard", _source, price)
            players[tempsrc] = price
            return price
        end
        add = add + chance
    end
end)

RegisterNetEvent("esx_dreamscratching:deposit")
AddEventHandler("esx_dreamscratching:deposit", function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    amount = tonumber(amount)

    if amount == nil or amount < 0 then
        return
    else
        local tempsrc = tonumber(_source)
        if players[tempsrc] == amount then
            xPlayer.addMoney(amount)
            return
        end
        return
    end
end)