ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('es:addCommand', 'toggleui', function()
end, { help = _U('toggleui') })

RegisterServerEvent('trew_hud_ui:getServerInfo')
AddEventHandler('trew_hud_ui:getServerInfo', function()

	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local job

	if xPlayer ~= nil then
		if xPlayer.job.label == xPlayer.job.grade_label then
			job = xPlayer.job.grade_label
		else
			job = xPlayer.job.label .. ': ' .. xPlayer.job.grade_label
		end

		local info = {
			job = job,
			money = xPlayer.getMoney(),
			bankMoney = xPlayer.getAccount('bank').money,
			blackMoney = xPlayer.getAccount('black_money').money
		}

		TriggerClientEvent('trew_hud_ui:setInfo', source, info)
	end
end)

RegisterServerEvent('trew_hud_ui:syncCarLights')
AddEventHandler('trew_hud_ui:syncCarLights', function(status)
	TriggerClientEvent('trew_hud_ui:syncCarLights', -1, source, status)
end)

RegisterServerEvent('trew_hud_ui:addMileage')
AddEventHandler('trew_hud_ui:addMileage', function(vehPlate, km)
    local src = source
    local identifier = ESX.GetPlayerFromId(src).identifier
	local plate = vehPlate
	local newKM = km

    MySQL.Async.execute('UPDATE veh_km SET km = @kms WHERE carplate = @plate', {['@plate'] = plate, ['@kms'] = newKM})
end)

ESX.RegisterServerCallback('trew_hud_ui:getMileage', function(source, cb, plate)

	local xPlayer = ESX.GetPlayerFromId(source)
	local vehPlate = plate
	MySQL.Async.fetchAll(
		'SELECT * FROM veh_km WHERE carplate = @plate',
		{
			['@plate'] = vehPlate
		},
		function(result)

			local found = false

			for i=1, #result, 1 do

				local vehicleProps = result[i].carplate

				if vehicleProps == vehPlate then
					KMSend = result[i].km
					found = true
					break
				end

			end

			if found then
				cb(KMSend)
			else
				cb(0)
				MySQL.Async.execute('INSERT INTO veh_km (carplate) VALUES (@carplate)',{['@carplate'] = plate})
				Wait(2000)
			end

		end
	)

end)