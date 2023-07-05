ESX = nil
local Vehicles

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_lscustom:buyMod')
AddEventHandler('esx_lscustom:buyMod', function(price,vehname,vehplate)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	price = tonumber(price)

	if price < xPlayer.getMoney() then
		TriggerClientEvent('esx_lscustom:installMod', _source)
		xPlayer.removeMoney(price)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '花費$' .. price})
	else
		TriggerClientEvent('esx_lscustom:cancelInstallMod', _source)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '現金不足'})
	end
end)

RegisterServerEvent('esx_lscustom:refreshOwnedVehicle')
AddEventHandler('esx_lscustom:refreshOwnedVehicle', function(vehicleProps)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT vehicle FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = vehicleProps.plate
	}, function(result)
		if result[1] then
			local vehicle = json.decode(result[1].vehicle)

			if vehicleProps.model == vehicle.model then
				MySQL.Async.execute('UPDATE owned_vehicles SET vehicle = @vehicle WHERE plate = @plate', {
					['@plate'] = vehicleProps.plate,
					['@vehicle'] = json.encode(vehicleProps)
				})
			end
		end
	end)
end)

ESX.RegisterServerCallback('esx_lscustom:getVehiclesPrices', function(source, cb)
	if not Vehicles then
		MySQL.Async.fetchAll('SELECT model, price FROM vs_ambulance UNION SELECT model, price FROM vs_police UNION SELECT model, price FROM vs_aircrafts UNION SELECT model, price FROM vs_boats UNION SELECT model, price FROM vs_cars UNION SELECT model;', {}, function(result)
			local vehicles = {}

			for i=1, #result, 1 do
				table.insert(vehicles, {
					model = result[i].model,
					price = result[i].price
				})
			end

			Vehicles = vehicles
			cb(Vehicles)
		end)
	else
		cb(Vehicles)
	end
end)