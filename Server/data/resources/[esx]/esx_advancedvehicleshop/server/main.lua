ESX = nil
local categoriesaj, vehiclesaj = {}, {}
local categoriespj, vehiclespj = {}, {}
local categoriesa, vehiclesa = {}, {}
local categoriesb, vehiclesb = {}, {}
local categoriesc, vehiclesc = {}, {}
local categoriest, vehiclest = {}, {}
local categoriesv, vehiclesv = {}, {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
	local char = Config.PlateLetters
	char = char + Config.PlateNumbers
	if Config.PlateUseSpace then char = char + 1 end
end)

function RemoveOwnedVehicle(plate)
	MySQL.Async.execute('DELETE FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	})
end

MySQL.ready(function()
	if Config.UseAmbulanceShop then
		MySQL.Async.fetchAll('SELECT * FROM vs_ambulance_categories', {}, function(_categories)
			categoriesaj = _categories

			MySQL.Async.fetchAll('SELECT * FROM vs_ambulance', {}, function(_vehicles)
				vehiclesaj = _vehicles

				for k,v in ipairs(vehiclesaj) do
					for k2,v2 in ipairs(categoriesaj) do
						if v2.name == v.category then
							vehiclesaj[k].categoryLabel = v2.label
							break
						end
					end
				end
				
				TriggerClientEvent('esx_advancedvehicleshop:sendCategoriesAJ', -1, categoriesaj)
				TriggerClientEvent('esx_advancedvehicleshop:sendVehiclesAJ', -1, vehiclesaj)
			end)
		end)
	end

	if Config.UsePoliceShop then
		MySQL.Async.fetchAll('SELECT * FROM vs_police_categories', {}, function(_categories)
			categoriespj = _categories

			MySQL.Async.fetchAll('SELECT * FROM vs_police', {}, function(_vehicles)
				vehiclespj = _vehicles

				for k,v in ipairs(vehiclespj) do
					for k2,v2 in ipairs(categoriespj) do
						if v2.name == v.category then
							vehiclespj[k].categoryLabel = v2.label
							break
						end
					end
				end

				TriggerClientEvent('esx_advancedvehicleshop:sendCategoriesPJ', -1, categoriespj)
				TriggerClientEvent('esx_advancedvehicleshop:sendVehiclesPJ', -1, vehiclespj)
			end)
		end)
	end

	if Config.UseAircraftShop then
		MySQL.Async.fetchAll('SELECT * FROM vs_aircraft_categories', {}, function(_categories)
			categoriesa = _categories

			MySQL.Async.fetchAll('SELECT * FROM vs_aircrafts', {}, function(_vehicles)
				vehiclesa = _vehicles

				for k,v in ipairs(vehiclesa) do
					for k2,v2 in ipairs(categoriesa) do
						if v2.name == v.category then
							vehiclesa[k].categoryLabel = v2.label
							break
						end
					end
				end

				TriggerClientEvent('esx_advancedvehicleshop:sendCategoriesA', -1, categoriesa)
				TriggerClientEvent('esx_advancedvehicleshop:sendVehiclesA', -1, vehiclesa)
			end)
		end)
	end

	if Config.UseBoatShop then
		MySQL.Async.fetchAll('SELECT * FROM vs_boat_categories', {}, function(_categories)
			categoriesb = _categories

			MySQL.Async.fetchAll('SELECT * FROM vs_boats', {}, function(_vehicles)
				vehiclesb = _vehicles

				for k,v in ipairs(vehiclesb) do
					for k2,v2 in ipairs(categoriesb) do
						if v2.name == v.category then
							vehiclesb[k].categoryLabel = v2.label
							break
						end
					end
				end

				TriggerClientEvent('esx_advancedvehicleshop:sendCategoriesB', -1, categoriesb)
				TriggerClientEvent('esx_advancedvehicleshop:sendVehiclesB', -1, vehiclesb)
			end)
		end)
	end

	if Config.UseCarShop then
		MySQL.Async.fetchAll('SELECT * FROM vs_car_categories', {}, function(_categories)
			categoriesc = _categories

			MySQL.Async.fetchAll('SELECT * FROM vs_cars', {}, function(_vehicles)
				vehiclesc = _vehicles

				for k,v in ipairs(vehiclesc) do
					for k2,v2 in ipairs(categoriesc) do
						if v2.name == v.category then
							vehiclesc[k].categoryLabel = v2.label
							break
						end
					end
				end

				TriggerClientEvent('esx_advancedvehicleshop:sendCategoriesC', -1, categoriesc)
				TriggerClientEvent('esx_advancedvehicleshop:sendVehiclesC', -1, vehiclesc)
			end)
		end)
	end

	if Config.UseTruckShop then
		MySQL.Async.fetchAll('SELECT * FROM vs_truck_categories', {}, function(_categories)
			categoriest = _categories

			MySQL.Async.fetchAll('SELECT * FROM vs_trucks', {}, function(_vehicles)
				vehiclest = _vehicles

				for k,v in ipairs(vehiclest) do
					for k2,v2 in ipairs(categoriest) do
						if v2.name == v.category then
							vehiclest[k].categoryLabel = v2.label
							break
						end
					end
				end

				TriggerClientEvent('esx_advancedvehicleshop:sendCategoriesT', -1, categoriest)
				TriggerClientEvent('esx_advancedvehicleshop:sendVehiclesT', -1, vehiclest)
			end)
		end)
	end

	if Config.UseVIPShop then
		MySQL.Async.fetchAll('SELECT * FROM vs_vip_categories', {}, function(_categories)
			categoriesv = _categories

			MySQL.Async.fetchAll('SELECT * FROM vs_vips', {}, function(_vehicles)
				vehiclesv = _vehicles

				for k,v in ipairs(vehiclesv) do
					for k2,v2 in ipairs(categoriesv) do
						if v2.name == v.category then
							vehiclesv[k].categoryLabel = v2.label
							break
						end
					end
				end

				TriggerClientEvent('esx_advancedvehicleshop:sendCategoriesv', -1, categoriesv)
				TriggerClientEvent('esx_advancedvehicleshop:sendVehiclesv', -1, vehiclesv)
			end)
		end)
	end
end)

-- Ambulance Shop
ESX.RegisterServerCallback('esx_advancedvehicleshop:getCategoriesAJ', function(source, cb)
	cb(categoriesaj)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:getVehiclesAJ', function(source, cb)
	cb(vehiclesaj)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:buyVehicleAJ', function(source, cb, model, plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	local modelPrice

	for k,v in ipairs(vehiclesaj) do
		if model == v.model then
			modelPrice = v.price
			break
		end
	end

	if modelPrice and xPlayer.getMoney() >= modelPrice then
		xPlayer.removeMoney(modelPrice)

		if model == Config.AmbulanceHeli or model == Config.AmbulanceHeli2 then
			MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type, job) VALUES (@owner, @plate, @vehicle, @type, @job)', {
				['@owner'] = xPlayer.identifier,
				['@plate'] = plate,
				['@vehicle'] = json.encode({model = GetHashKey(model), plate = plate}),
				['@type'] = 'aircraft',
				['@job'] = 'ambulance',
			}, function(rowsChanged)
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '購買一輛救護車 車牌' .. plate})
				cb(true)
			end)
		else
			MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type, job) VALUES (@owner, @plate, @vehicle, @type, @job)', {
				['@owner'] = xPlayer.identifier,
				['@plate'] = plate,
				['@vehicle'] = json.encode({model = GetHashKey(model), plate = plate}),
				['@type'] = 'car',
				['@job'] = 'ambulance',
			}, function(rowsChanged)
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '購買一輛救護車 車牌' .. plate})
				cb(true)
			end)
		end
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:resellVehicleAJ', function(source, cb, plate, model)
	local xPlayer, resellPrice, vehicleName = ESX.GetPlayerFromId(source)

	-- calculate the resell price
	for i=1, #vehiclesaj, 1 do
		if GetHashKey(vehiclesaj[i].model) == model then
			resellPrice = ESX.Math.Round(vehiclesaj[i].price / 100 * Config.ResellPercentage)
			vehicleName = vehiclesaj[i].model
			break
		end
	end

	if not resellPrice then
		-- print(('[esx_advancedvehicleshop] [^3WARNING^7] %s attempted to sell an unknown vehicle!'):format(GetPlayerIdentifiers(source)[1]))
		cb(false)
	else
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = plate
		}, function(result)
			if result[1] then -- does the owner match?
				local vehicle = json.decode(result[1].vehicle)

				if vehicle.model == model then
					if vehicle.plate == plate then
						xPlayer.addMoney(resellPrice)
						RemoveOwnedVehicle(plate)

						cb(true)
					else
						-- print(('[esx_advancedvehicleshop] [^3WARNING^7] %s attempted to sell an vehicle with plate mismatch!'):format(xPlayer.identifier))
						cb(false)
					end
				else
					-- print(('[esx_advancedvehicleshop] [^3WARNING^7] %s attempted to sell an vehicle with model mismatch!'):format(xPlayer.identifier))
					cb(false)
				end
			else
				cb(false)
			end
		end)
	end
end)

-- Police Shop
ESX.RegisterServerCallback('esx_advancedvehicleshop:getCategoriesPJ', function(source, cb)
	cb(categoriespj)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:getVehiclesPJ', function(source, cb)
	cb(vehiclespj)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:buyVehiclePJ', function(source, cb, model, plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	local modelPrice

	for k,v in ipairs(vehiclespj) do
		if model == v.model then
			modelPrice = v.price
			break
		end
	end

	if modelPrice and xPlayer.getMoney() >= modelPrice then
		xPlayer.removeMoney(modelPrice)

		if model == Config.PoliceHeli then
			MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type, job) VALUES (@owner, @plate, @vehicle, @type, @job)', {
				['@owner'] = xPlayer.identifier,
				['@plate'] = plate,
				['@vehicle'] = json.encode({model = GetHashKey(model), plate = plate}),
				['@type'] = 'aircraft',
				['@job'] = 'police'
			}, function(rowsChanged)
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '購買一輛警車 車牌' .. plate})
				cb(true)
			end)
		else
			MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type, job) VALUES (@owner, @plate, @vehicle, @type, @job)', {
				['@owner'] = xPlayer.identifier,
				['@plate'] = plate,
				['@vehicle'] = json.encode({model = GetHashKey(model), plate = plate}),
				['@type'] = 'car',
				['@job'] = 'police'
			}, function(rowsChanged)
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '購買一輛警車 車牌' .. plate})
				cb(true)
			end)
		end
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:resellVehiclePJ', function(source, cb, plate, model)
	local xPlayer, resellPrice, vehicleName = ESX.GetPlayerFromId(source)

	-- calculate the resell price
	for i=1, #vehiclespj, 1 do
		if GetHashKey(vehiclespj[i].model) == model then
			resellPrice = ESX.Math.Round(vehiclespj[i].price / 100 * Config.ResellPercentage)
			vehicleName = vehiclespj[i].model
			break
		end
	end

	if not resellPrice then
		cb(false)
	else
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = plate
		}, function(result)
			if result[1] then -- does the owner match?
				local vehicle = json.decode(result[1].vehicle)

				if vehicle.model == model then
					if vehicle.plate == plate then
						xPlayer.addMoney(resellPrice)
						RemoveOwnedVehicle(plate)

						cb(true)
					else
						cb(false)
					end
				else
					cb(false)
				end
			else
				cb(false)
			end
		end)
	end
end)

-- Aircraft Shop
ESX.RegisterServerCallback('esx_advancedvehicleshop:getCategoriesA', function(source, cb)
	cb(categoriesa)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:getVehiclesA', function(source, cb)
	cb(vehiclesa)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:buyVehicleA', function(source, cb, model, plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	local modelPrice

	for k,v in ipairs(vehiclesa) do
		if model == v.model then
			modelPrice = v.price
			break
		end
	end

	if modelPrice and xPlayer.getMoney() >= modelPrice then
		xPlayer.removeMoney(modelPrice)

		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type) VALUES (@owner, @plate, @vehicle, @type)', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = plate,
			['@vehicle'] = json.encode({model = GetHashKey(model), plate = plate}),
			['@type'] = 'aircraft'
		}, function(rowsChanged)
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '購買一架飛機 車牌' .. plate})
			cb(true)
		end)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:resellVehicleA', function(source, cb, plate, model)
	local xPlayer, resellPrice, vehicleName = ESX.GetPlayerFromId(source)

	-- calculate the resell price
	for i=1, #vehiclesa, 1 do
		if GetHashKey(vehiclesa[i].model) == model then
			resellPrice = ESX.Math.Round(vehiclesa[i].price / 100 * Config.ResellPercentage)
			vehicleName = vehiclesa[i].model
			break
		end
	end

	if not resellPrice then
		-- print(('[esx_advancedvehicleshop] [^3WARNING^7] %s attempted to sell an unknown vehicle!'):format(GetPlayerIdentifiers(source)[1]))
		cb(false)
	else
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = plate
		}, function(result)
			if result[1] then -- does the owner match?
				local vehicle = json.decode(result[1].vehicle)

				if vehicle.model == model then
					if vehicle.plate == plate then
						xPlayer.addMoney(resellPrice)
						RemoveOwnedVehicle(plate)

						cb(true)
					else
						cb(false)
					end
				else
					cb(false)
				end
			else
				cb(false)
			end
		end)
	end
end)

-- Boat Shop
ESX.RegisterServerCallback('esx_advancedvehicleshop:getCategoriesB', function(source, cb)
	cb(categoriesb)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:getVehiclesB', function(source, cb)
	cb(vehiclesb)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:buyVehicleB', function(source, cb, model, plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	local modelPrice

	for k,v in ipairs(vehiclesb) do
		if model == v.model then
			modelPrice = v.price
			break
		end
	end

	if modelPrice and xPlayer.getMoney() >= modelPrice then
		xPlayer.removeMoney(modelPrice)

		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type) VALUES (@owner, @plate, @vehicle, @type)', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = plate,
			['@vehicle'] = json.encode({model = GetHashKey(model), plate = plate}),
			['@type'] = 'boat'
		}, function(rowsChanged)
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '購買一艘船機 車牌' .. plate})
			cb(true)
		end)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:resellVehicleB', function(source, cb, plate, model)
	local xPlayer, resellPrice, vehicleName = ESX.GetPlayerFromId(source)

	-- calculate the resell price
	for i=1, #vehiclesb, 1 do
		if GetHashKey(vehiclesb[i].model) == model then
			resellPrice = ESX.Math.Round(vehiclesb[i].price / 100 * Config.ResellPercentage)
			vehicleName = vehiclesb[i].model
			break
		end
	end

	if not resellPrice then
		-- print(('[esx_advancedvehicleshop] [^3WARNING^7] %s attempted to sell an unknown vehicle!'):format(GetPlayerIdentifiers(source)[1]))
		cb(false)
	else
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = plate
		}, function(result)
			if result[1] then -- does the owner match?
				local vehicle = json.decode(result[1].vehicle)

				if vehicle.model == model then
					if vehicle.plate == plate then
						xPlayer.addMoney(resellPrice)
						RemoveOwnedVehicle(plate)

						cb(true)
					else
						-- print(('[esx_advancedvehicleshop] [^3WARNING^7] %s attempted to sell an vehicle with plate mismatch!'):format(xPlayer.identifier))
						cb(false)
					end
				else
					-- print(('[esx_advancedvehicleshop] [^3WARNING^7] %s attempted to sell an vehicle with model mismatch!'):format(xPlayer.identifier))
					cb(false)
				end
			else
				cb(false)
			end
		end)
	end
end)

-- Car Shop
ESX.RegisterServerCallback('esx_advancedvehicleshop:getCategoriesC', function(source, cb)
	cb(categoriesc)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:getVehiclesC', function(source, cb)
	cb(vehiclesc)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:buyVehicleC', function(source, cb, model, plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	local modelPrice

	for k,v in ipairs(vehiclesc) do
		if model == v.model then
			modelPrice = v.price
			break
		end
	end

	if modelPrice and xPlayer.getMoney() >= modelPrice then
		xPlayer.removeMoney(modelPrice)

		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type) VALUES (@owner, @plate, @vehicle, @type)', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = plate,
			['@vehicle'] = json.encode({model = GetHashKey(model), plate = plate}),
			['@type'] = 'car'
		}, function(rowsChanged)
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '購買一輛車 車牌' .. plate})
			cb(true)
		end)
		TriggerEvent('esx_addonaccount:getSharedAccount', 'society_vehicleshop', function(account)
			account.addMoney(modelPrice)
		end)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:resellVehicleC', function(source, cb, plate, model)
	local xPlayer, resellPrice, vehicleName = ESX.GetPlayerFromId(source)

	-- calculate the resell price
	for i=1, #vehiclesc, 1 do
		if GetHashKey(vehiclesc[i].model) == model then
			resellPrice = ESX.Math.Round(vehiclesc[i].price / 100 * Config.ResellPercentage)
			vehicleName = vehiclesc[i].model
			break
		end
	end

	if not resellPrice then
		-- print(('[esx_advancedvehicleshop] [^3WARNING^7] %s attempted to sell an unknown vehicle!'):format(GetPlayerIdentifiers(source)[1]))
		cb(false)
	else
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = plate
		}, function(result)
			if result[1] then -- does the owner match?
				local vehicle = json.decode(result[1].vehicle)

				if vehicle.model == model then
					if vehicle.plate == plate then
						xPlayer.addMoney(resellPrice)
						RemoveOwnedVehicle(plate)
						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_vehicleshop', function(account)
							account.removeMoney(resellPrice)
						end)
						cb(true)
					else
						-- print(('[esx_advancedvehicleshop] [^3WARNING^7] %s attempted to sell an vehicle with plate mismatch!'):format(xPlayer.identifier))
						cb(false)
					end
				else
					-- print(('[esx_advancedvehicleshop] [^3WARNING^7] %s attempted to sell an vehicle with model mismatch!'):format(xPlayer.identifier))
					cb(false)
				end
			else
				cb(false)
			end
		end)
	end
end)

-- Truck Shop
ESX.RegisterServerCallback('esx_advancedvehicleshop:getCategoriesT', function(source, cb)
	cb(categoriest)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:getVehiclesT', function(source, cb)
	cb(vehiclest)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:buyVehicleT', function(source, cb, model, plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	local modelPrice

	for k,v in ipairs(vehiclest) do
		if model == v.model then
			modelPrice = v.price
			break
		end
	end

	if modelPrice and xPlayer.getMoney() >= modelPrice then
		xPlayer.removeMoney(modelPrice)

		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type) VALUES (@owner, @plate, @vehicle, @type)', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = plate,
			['@vehicle'] = json.encode({model = GetHashKey(model), plate = plate}),
			['@type'] = 'car'
		}, function(rowsChanged)
			xPlayer.showNotification(_U('truck_belongs', plate))
			cb(true)
		end)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:resellVehicleT', function(source, cb, plate, model)
	local xPlayer, resellPrice, vehicleName = ESX.GetPlayerFromId(source)

	-- calculate the resell price
	for i=1, #vehiclest, 1 do
		if GetHashKey(vehiclest[i].model) == model then
			resellPrice = ESX.Math.Round(vehiclest[i].price / 100 * Config.ResellPercentage)
			vehicleName = vehiclest[i].model
			break
		end
	end

	if not resellPrice then
		print(('[esx_advancedvehicleshop] [^3WARNING^7] %s attempted to sell an unknown vehicle!'):format(GetPlayerIdentifiers(source)[1]))
		cb(false)
	else
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = plate
		}, function(result)
			if result[1] then -- does the owner match?
				local vehicle = json.decode(result[1].vehicle)

				if vehicle.model == model then
					if vehicle.plate == plate then
						xPlayer.addMoney(resellPrice)
						RemoveOwnedVehicle(plate)

						cb(true)
					else
						print(('[esx_advancedvehicleshop] [^3WARNING^7] %s attempted to sell an vehicle with plate mismatch!'):format(xPlayer.identifier))
						cb(false)
					end
				else
					print(('[esx_advancedvehicleshop] [^3WARNING^7] %s attempted to sell an vehicle with model mismatch!'):format(xPlayer.identifier))
					cb(false)
				end
			else
				cb(false)
			end
		end)
	end
end)

-- VIP Shop
ESX.RegisterServerCallback('esx_advancedvehicleshop:getCategoriesV', function(source, cb)
	cb(categoriesv)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:getVehiclesV', function(source, cb)
	cb(vehiclesv)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:buyVehicleV', function(source, cb, model, plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	local modelPrice

	for k,v in ipairs(vehiclesv) do
		if model == v.model then
			modelPrice = v.price
			break
		end
	end

	if modelPrice and xPlayer.getMoney() >= modelPrice then
		xPlayer.removeMoney(modelPrice)

		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type) VALUES (@owner, @plate, @vehicle, @type)', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = plate,
			['@vehicle'] = json.encode({model = GetHashKey(model), plate = plate}),
			['@type'] = 'car'
		}, function(rowsChanged)
			xPlayer.showNotification(_U('vip_belongs', plate))
			cb(true)
		end)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:resellVehicleV', function(source, cb, plate, model)
	local xPlayer, resellPrice, vehicleName = ESX.GetPlayerFromId(source)

	-- calculate the resell price
	for i=1, #vehiclesv, 1 do
		if GetHashKey(vehiclesv[i].model) == model then
			resellPrice = ESX.Math.Round(vehiclesv[i].price / 100 * Config.ResellPercentage)
			vehicleName = vehiclesv[i].model
			break
		end
	end

	if not resellPrice then
		-- print(('[esx_advancedvehicleshop] [^3WARNING^7] %s attempted to sell an unknown vehicle!'):format(GetPlayerIdentifiers(source)[1]))
		cb(false)
	else
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = plate
		}, function(result)
			if result[1] then -- does the owner match?
				local vehicle = json.decode(result[1].vehicle)

				if vehicle.model == model then
					if vehicle.plate == plate then
						xPlayer.addMoney(resellPrice)
						RemoveOwnedVehicle(plate)

						cb(true)
					else
						-- print(('[esx_advancedvehicleshop] [^3WARNING^7] %s attempted to sell an vehicle with plate mismatch!'):format(xPlayer.identifier))
						cb(false)
					end
				else
					-- print(('[esx_advancedvehicleshop] [^3WARNING^7] %s attempted to sell an vehicle with model mismatch!'):format(xPlayer.identifier))
					cb(false)
				end
			else
				cb(false)
			end
		end)
	end
end)

-- Shared
ESX.RegisterServerCallback('esx_advancedvehicleshop:isPlateTaken', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT 1 FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		cb(result[1] ~= nil)
	end)
end)

ESX.RegisterServerCallback('esx_advancedvehicleshop:retrieveJobVehicles', function(source, cb, type)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND type = @type AND job = @job', {
		['@owner'] = xPlayer.identifier,
		['@type'] = type,
		['@job'] = xPlayer.job.name
	}, function(result)
		cb(result)
	end)
end)

RegisterNetEvent('esx_advancedvehicleshop:setJobVehicleState')
AddEventHandler('esx_advancedvehicleshop:setJobVehicleState', function(plate, state)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = @stored WHERE plate = @plate AND job = @job', {
		['@stored'] = state,
		['@plate'] = plate,
		['@job'] = xPlayer.job.name
	}, function(rowsChanged)
		if rowsChanged == 0 then
			-- print(('[esx_advancedvehicleshop] [^3WARNING^7] %s exploited the garage!'):format(xPlayer.identifier))
		end
	end)
end)
