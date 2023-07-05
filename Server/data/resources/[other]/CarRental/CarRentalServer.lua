ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    TriggerEvent('carrent:cheakcar')
end)

RegisterServerEvent('carrent:cheakcar')
AddEventHandler('carrent:cheakcar', function()
	MySQL.Async.fetchAll('SELECT * FROM car_rent', {}, function (result)
		for i=1, #result, 1 do
			MySQL.Async.execute('INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)', {
				['@identifier'] = result[i].owner,
				['@sender'] = result[i].owner,
				['@target_type'] = 'society',
				['@target'] = 'society_carrent',
				['@label'] = '車輛逾期租任費',
				['@amount'] = 50000
			}, function()
			end)
			MySQL.Sync.execute('DELETE FROM car_rent WHERE id = @id',
			{
				['@id'] = result[i].id
			})
		end
	end)
end)

ESX.RegisterServerCallback('carrent:isPlateTaken', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT 1 FROM car_rent WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		cb(result[1] ~= nil)
	end)
end)

RegisterServerEvent('carrent:buyVehicleV')
AddEventHandler('carrent:buyVehicleV', function(plate)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('INSERT INTO car_rent (owner, plate) VALUES (@owner, @plate)', {
		['@owner'] = xPlayer.identifier,
		['@plate'] = plate
	}, function(rowsChanged)
	end)
	TriggerEvent('esx_joblogs:AddInLog', "rent", "rentc", xPlayer.name)
end)

ESX.RegisterServerCallback('carrent:isVehicleOwner', function(source, cb, plate)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT owner FROM car_rent WHERE owner = @owner AND plate = @plate', {
		['@owner'] = xPlayer.identifier,
		['@plate'] = plate
	}, function(result)
		if result[1] then
			cb(result[1].owner == xPlayer.identifier)
		else
			cb(false)
		end
	end)
end)

ESX.RegisterServerCallback('carrent:storeVehicle', function (source, cb, plate)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM car_rent WHERE owner = @owner AND plate = @plate', {
		['@owner'] = xPlayer.identifier,
		['@plate'] = plate
	}, function (result)
		if result[1] ~= nil then
			cb(true)
			MySQL.Async.execute('DELETE FROM car_rent WHERE plate = @plate', {
				['@plate'] = plate
			})
		else
			cb(false)
		end
	end)
end)
