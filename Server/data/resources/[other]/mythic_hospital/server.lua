local beds = {
    { x = 307.72, y = -581.76, z = 44.2, h = 160.0, taken = false, model = 1631638868 },
    { x = 311.04, y = -582.96, z = 44.2, h = 160.0, taken = false, model = 1631638868 },
    { x = 314.48, y = -584.2, z = 44.2, h = 160.0, taken = false, model = 1631638868 },
    { x = 317.68, y = -585.36, z = 44.2, h = 160.0, taken = false, model = 1631638868 },
    { x = 322.6, y = -587.16, z = 44.2, h = 160.0, taken = false, model = 1631638868 },
    { x = 309.36, y = -577.36, z = 44.2, h = 340.0, taken = false, model = 1631638868 },
    { x = 313.92, y = -579.04, z = 44.2, h = 340.0, taken = false, model = 1631638868 },
    { x = 324.28, y = -582.8, z = 44.2, h = 340.0, taken = false, model = 1631638868 },
    { x = 319.4, y = -581.04, z = 44.2, h = 340.0, taken = false, model = 1631638868 },
}

local bedsTaken = {}
local injuryBasePrice = 100
ESX             = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('playerDropped', function()
    if bedsTaken[source] ~= nil then
        beds[bedsTaken[source]].taken = false
    end
end)

AddEventHandler('playerDropped', function()
    if bedsTaken[source] ~= nil then
        beds[bedsTaken[source]].taken = false
    end
end)

RegisterServerEvent('mythic_hospital:server:RequestBed')
AddEventHandler('mythic_hospital:server:RequestBed', function()
    for k, v in pairs(beds) do
        if not v.taken then
            v.taken = true
            bedsTaken[source] = k
            TriggerClientEvent('mythic_hospital:client:SendToBed', source, k, v)
            return
        end
    end

    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '無空床' })
end)

RegisterServerEvent('mythic_hospital:server:RPRequestBed')
AddEventHandler('mythic_hospital:server:RPRequestBed', function(plyCoords)
    local foundbed = false
    for k, v in pairs(beds) do
        local distance = #(vector3(v.x, v.y, v.z) - plyCoords)
        if distance < 3.0 then
            if not v.taken then
                v.taken = true
                foundbed = true
                TriggerClientEvent('mythic_hospital:client:RPSendToBed', source, k, v)
                return
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '已佔用' })
            end
        end
    end

    if not foundbed then
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '附近無病床' })
    end
end)

RegisterServerEvent('mythic_hospital:server:LeaveBed')
AddEventHandler('mythic_hospital:server:LeaveBed', function(id)
    beds[id].taken = false
end)

ESX.RegisterServerCallback('mythic_hospital',function (source, cb)
	local xPlayers = ESX.GetPlayers()
	local ems = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'ambulance' then
			ems = ems + 1
		end
	end

    if ems >= 1 then
        cb(true)
    else
        cb(false)
    end
end)