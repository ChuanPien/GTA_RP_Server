ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Make sure all Vehicles are Stored on restart
MySQL.ready(function()
	if Config.ParkVehicles then
		ParkVehicles()
	end
end)

function ParkVehicles()
	MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = true WHERE `stored` = @stored', {
		['@stored'] = false
	}, function(rowsChanged)
	end)
end

-- Start of Ambulance Code
ESX.RegisterServerCallback('esx_advancedgarage:getOwnedAmbulanceCars', function(source, cb)
	local ownedAmbulanceCars = {}
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE Type = @Type AND job = @job', { -- job = NULL
		['@Type'] = 'car',
		['@job'] = 'ambulance'
	}, function(data)
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(ownedAmbulanceCars, {vehicle = vehicle, stored = v.stored, plate = v.plate,fuel = v.fuel})
		end
		cb(ownedAmbulanceCars)
	end)
end)

ESX.RegisterServerCallback('esx_advancedgarage:getOwnedAmbulanceAircrafts', function(source, cb)
	local ownedAmbulanceAircrafts = {}
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE Type = @Type AND job = @job', { -- job = NULL
		['@Type'] = 'aircraft',
		['@job'] = 'ambulance'
	}, function(data)
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(ownedAmbulanceAircrafts, {vehicle = vehicle, stored = v.stored, plate = v.plate,fuel = v.fuel, vtype = 'aircraft'})
		end
		cb(ownedAmbulanceAircrafts)
	end)
end)

ESX.RegisterServerCallback('esx_advancedgarage:getOutOwnedAmbulanceCars', function(source, cb)
	local ownedAmbulanceCars = {}
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE job = @job AND `stored` = @stored', {
		['@job'] = 'ambulance',
		['@stored'] = false
	}, function(data) 
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(ownedAmbulanceCars, vehicle)
		end
		cb(ownedAmbulanceCars)
	end)
end)
-- End of Ambulance Code

-- Start of Police Code
ESX.RegisterServerCallback('esx_advancedgarage:getOwnedPoliceCars', function(source, cb)
	local ownedPoliceCars = {}
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE Type = @Type AND job = @job', { -- job = NULL
		['@Type'] = 'car',
		['@job'] = 'police'
	}, function(data)
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(ownedPoliceCars, {vehicle = vehicle, stored = v.stored, plate = v.plate,fuel = v.fuel})
		end
		cb(ownedPoliceCars)
	end)
end)

ESX.RegisterServerCallback('esx_advancedgarage:getOwnedPoliceAircrafts', function(source, cb)
	local ownedPoliceAircrafts = {}
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE Type = @Type AND job = @job', { -- job = NULL
		['@Type'] = 'aircraft',
		['@job'] = 'police'
	}, function(data)
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(ownedPoliceAircrafts, {vehicle = vehicle, stored = v.stored, plate = v.plate,fuel = v.fuel, vtype = 'aircraft'})
		end
		cb(ownedPoliceAircrafts)
	end)
end)

ESX.RegisterServerCallback('esx_advancedgarage:getOutOwnedPoliceCars', function(source, cb)
	local ownedPoliceCars = {}
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE job = @job AND `stored` = @stored', {
		['@job'] = 'police',
		['@stored'] = false
	}, function(data) 
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(ownedPoliceCars, vehicle)
		end
		cb(ownedPoliceCars)
	end)
end)
-- End of Police Code

-- Start of Aircraft Code
ESX.RegisterServerCallback('esx_advancedgarage:getOwnedAircrafts', function(source, cb)
	local ownedAircrafts = {}
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND Type = @Type AND job = @job', { -- job = NULL
		['@owner'] = xPlayer.identifier,
		['@Type'] = 'aircraft',
		['@job'] = 'civ'
	}, function(data)
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(ownedAircrafts, {vehicle = vehicle, stored = v.stored, plate = v.plate,fuel = v.fuel})
		end
		cb(ownedAircrafts)
	end)
end)

ESX.RegisterServerCallback('esx_advancedgarage:getOutOwnedAircrafts', function(source, cb)
	local ownedAircrafts = {}
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND Type = @Type AND job = @job AND `stored` = @stored', { -- job = NULL
		['@owner'] = xPlayer.identifier,
		['@Type'] = 'aircraft',
		['@job'] = 'civ',
		['@stored'] = false
	}, function(data) 
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(ownedAircrafts, vehicle)
		end
		cb(ownedAircrafts)
	end)
end)
-- End of Aircraft Code

-- Start of Boat Code
ESX.RegisterServerCallback('esx_advancedgarage:getOwnedBoats', function(source, cb)
	local ownedBoats = {}
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND Type = @Type AND job = @job', { -- job = NULL
		['@owner'] = xPlayer.identifier,
		['@Type'] = 'boat',
		['@job'] = 'civ'
	}, function(data)
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(ownedBoats, {vehicle = vehicle, stored = v.stored, plate = v.plate,fuel = v.fuel})
		end
		cb(ownedBoats)
	end)
end)

ESX.RegisterServerCallback('esx_advancedgarage:getOutOwnedBoats', function(source, cb)
	local ownedBoats = {}
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND Type = @Type AND job = @job AND `stored` = @stored', { -- job = NULL
		['@owner'] = xPlayer.identifier,
		['@Type'] = 'boat',
		['@job'] = 'civ',
		['@stored'] = false
	}, function(data)
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(ownedBoats, vehicle)
		end
		cb(ownedBoats)
	end)
end)
-- End of Boat Code

-- Start of Car Code
ESX.RegisterServerCallback('esx_advancedgarage:getOwnedCars', function(source, cb, where)
	local ownedCars = {}
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND Type = @Type AND job = @job AND garage = @garage', { -- job = NULL
		['@owner'] = xPlayer.identifier,
		['@Type'] = 'car',
		['@job'] = 'civ',
		['@garage'] = where
	}, function(data)
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(ownedCars, {vehicle = vehicle, stored = v.stored, plate = v.plate,fuel = v.fuel})
		end
		cb(ownedCars)
	end)
end)

ESX.RegisterServerCallback('esx_advancedgarage:getOutOwnedCars', function(source, cb)
	local ownedCars = {}
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND Type = @Type AND job = @job AND `stored` = @stored', { -- job = NULL
		['@owner'] = xPlayer.identifier,
		['@Type'] = 'car',
		['@job'] = 'civ',
		['@stored'] = false
	}, function(data) 
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(ownedCars, vehicle)
		end
		cb(ownedCars)
	end)
end)
-- End of Car Code

-- Store Vehicles
ESX.RegisterServerCallback('esx_advancedgarage:storeJobVehicle', function (source, cb, vehicleProps)
	local ownedCars = {}
	local vehplate = vehicleProps.plate:match("^%s*(.-)%s*$")
	local vehiclemodel = vehicleProps.model
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE @plate = plate', {
		['@plate'] = vehicleProps.plate
	}, function (result)
		if result[1] ~= nil then
			local originalvehprops = json.decode(result[1].vehicle)
			if originalvehprops.model == vehiclemodel then
				MySQL.Async.execute('UPDATE owned_vehicles SET owner = @owner AND vehicle = @vehicle WHERE plate = @plate', {
					['@owner'] = 0,
					['@vehicle'] = json.encode(vehicleProps),
					['@plate'] = vehicleProps.plate
				}, function (rowsChanged)
					cb(true)
				end)
			else
				cb(false)
			end
		else
			cb(false)
		end
	end)
end)

ESX.RegisterServerCallback('esx_advancedgarage:storeVehicle', function (source, cb, vehicleProps)
	local ownedCars = {}
	local vehplate = vehicleProps.plate:match("^%s*(.-)%s*$")
	local vehiclemodel = vehicleProps.model
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
		['@owner'] = xPlayer.identifier,
		['@plate'] = vehicleProps.plate
	}, function (result)
		if result[1] ~= nil then
			local originalvehprops = json.decode(result[1].vehicle)
			if originalvehprops.model == vehiclemodel then
				MySQL.Async.execute('UPDATE owned_vehicles SET vehicle = @vehicle WHERE owner = @owner AND plate = @plate', {
					['@owner'] = xPlayer.identifier,
					['@vehicle'] = json.encode(vehicleProps),
					['@plate'] = vehicleProps.plate
				}, function (rowsChanged)
					cb(true)
				end)
			else
				cb(false)
			end
		else
			cb(false)
		end
	end)
end)

RegisterServerEvent('esx_advancedgarage:setVehicleState')
AddEventHandler('esx_advancedgarage:setVehicleState', function(plate, state)
	MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = @stored WHERE plate = @plate', {
		['@stored'] = state,
		['@plate'] = plate
	}, function()
	end)
end)

-- Set Fuel Level
RegisterServerEvent('esx_advancedgarage:setVehicleFuel')
AddEventHandler('esx_advancedgarage:setVehicleFuel', function(plate, fuel)
	MySQL.Async.execute('UPDATE owned_vehicles SET fuel = @fuel WHERE plate = @plate', {
		['@fuel'] = fuel,
		['@plate'] = plate
	}, function()
	end)
end)

RegisterServerEvent('esx_advancedgarage:setVehicleloc')
AddEventHandler('esx_advancedgarage:setVehicleloc', function(plate, store)
	MySQL.Async.execute('UPDATE owned_vehicles SET garage = @garage WHERE plate = @plate', {
		['@garage'] = store,
		['@plate'] = plate
	}, function()
	end)
end)

RegisterServerEvent('esx_advancedgarage:setVehicleowner')
AddEventHandler('esx_advancedgarage:setVehicleowner', function(plate)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE owned_vehicles SET owner = @owner WHERE plate = @plate', {
		['@owner'] = xPlayer.identifier,
		['@plate'] = plate
	}, function()
	end)
end)