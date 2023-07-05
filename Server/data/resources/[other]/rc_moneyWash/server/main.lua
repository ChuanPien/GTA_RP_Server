ESX = nil
local percent = math.random(15,30)
local cops = 80
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('rc_moneyWash:getPlayerStats', function(source, cb)
    local xPlayers = ESX.GetPlayers()
    local xPlayer = ESX.GetPlayerFromId(source)
    local blackmoney = xPlayer.getAccount('black_money').money

    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            cops = cops + 20
        end
    end

    cb(blackmoney, percent, cops)
end)

RegisterNetEvent("rc_moneyWash:successEvent")
AddEventHandler("rc_moneyWash:successEvent", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local blackmoney = xPlayer.getAccount('black_money').money
    local cost = blackmoney * (percent/100)
    local finalpay = (blackmoney * (cops/100)) - cost

    xPlayer.addMoney(finalpay)
    xPlayer.removeAccountMoney('black_money', blackmoney)
    TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, '~y~黑錢商', '[洗錢資訊]', '~r~黑錢 $' .. blackmoney .. '\n~y~手續費(' .. percent .. '%) $-' .. cost .. '\n~b~風險(' .. cops .. '%) $' .. (blackmoney * (cops/100)) - blackmoney .. '\n~g~現金(含以上) $' .. finalpay, 'CHAR_LESTER_DEATHWISH')
end)