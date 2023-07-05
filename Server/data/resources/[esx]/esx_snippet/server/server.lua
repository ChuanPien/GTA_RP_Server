ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded', function(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    MySQL.Async.fetchScalar("SELECT armour FROM users WHERE identifier = @identifier", { 
        ['@identifier'] = xPlayer.getIdentifier()
        }, function(data)
        if (data ~= nil) then
            TriggerClientEvent('LRP-Armour:Client:SetPlayerArmour', playerId, data)
        end
    end)
end)

RegisterServerEvent('LRP-Armour:Server:RefreshCurrentArmour')
AddEventHandler('LRP-Armour:Server:RefreshCurrentArmour', function(updateArmour)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.execute("UPDATE users SET armour = @armour WHERE identifier = @identifier", { 
        ['@identifier'] = xPlayer.getIdentifier(),
        ['@armour'] = tonumber(updateArmour)
    })
end)

--- jobchat
AddEventHandler('chatMessage', function(Source, Name, Msg)

    CancelEvent()

    local xPlayer = ESX.GetPlayerFromId(Source)
    job = xPlayer.job.name
    str = job:gsub("^%l", string.upper)

    if job == "admin" then
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div class="chat-message nonemergency"><b>{0} :</b> {1} </div>',
            args = { "🐦 管理員 | " .. xPlayer.name, Msg }
        })
    elseif job == "cozinheiro" then
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div class="chat-message nonemergency"><b>{0} :</b> {1} </div>',
            args = { "👨‍🍳 MILK HALL | " .. xPlayer.name, Msg }
        })
    elseif job == "police" then
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div class="chat-message"><b>{0}:</b> {1}</div>',
            args = { "🚔 警察 | " .. xPlayer.name, Msg }
        })
    elseif job == "ambulance" then
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div class="chat-message emergency"><b>{0} :</b> {1} </div>',
            args = { "🚑 醫護 | " .. xPlayer.name, Msg }
        })
    else
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div class="chat-message success"><b>{0} :</b> {1} </div>',
            args = { "市民 | " .. xPlayer.name, Msg }
        })
    end
end)