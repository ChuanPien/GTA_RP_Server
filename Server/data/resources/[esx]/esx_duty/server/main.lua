ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('duty:onoff')
AddEventHandler('duty:onoff', function(job)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade
    
    if job == 'police' then
        if xPlayer.hasWeapon('WEAPON_COMBATPISTOL') or xPlayer.hasWeapon('WEAPON_STUNGUN') or xPlayer.hasWeapon('WEAPON_NIGHTSTICK') or xPlayer.hasWeapon('WEAPON_PUMPSHOTGUN') then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '未存放槍枝'})
            else
            xPlayer.setJob('off' ..job, grade)
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '下班了'})
		    TriggerEvent('esx_joblogs:AddInLog', "police", "work", xPlayer.name,"下班")
        end
    elseif job == 'ambulance' then
        xPlayer.setJob('off' ..job, grade)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '下班了'})
    elseif job == 'offpolice' then
        xPlayer.setJob('police', grade)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '上班了'})
        TriggerEvent('esx_joblogs:AddInLog', "police", "work", xPlayer.name,"上班")
    elseif job == 'offambulance' then
        xPlayer.setJob('ambulance', grade)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '上班了'})
    end

end)