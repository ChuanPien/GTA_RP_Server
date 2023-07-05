local CurrentActionData, PlayerData, userProperties, this_Garage, BlipList, PrivateBlips, JobBlips = {}, {}, {}, {}, {}, {}, {}
local HasAlreadyEnteredMarker = false
local LastZone, CurrentAction, CurrentActionMsg
local WasInPound, WasinJPound = false, false
local where,store = '',''
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

RegisterNetEvent('esx_advancedgarage:getPropertiesC')
AddEventHandler('esx_advancedgarage:getPropertiesC', function(xPlayer)
	ESX.TriggerServerCallback('esx_advancedgarage:getOwnedProperties', function(properties)
		userProperties = properties
	end)
end)

local function has_value (tab, val)
	for index, value in ipairs(tab) do
		if value == val then
			return true
		end
	end
	return false
end

-- Start of Ambulance Code
function ListOwnedAmbulanceMenu()
	local elements = {}
	local spacer = ('<span style="color:Lavender;">%s</span>  -  <span style="color:Gold;">%s</span>  -  <span style="color:Aqua;">%s</span>  -  <span style="color:SpringGreen;">%s</span>'):format(_U('vehicle'), _U('plate'),'油量', _U('location'))
	table.insert(elements, {label = spacer, value = nil})


	ESX.TriggerServerCallback('esx_advancedgarage:getOwnedAmbulanceCars', function(ownedAmbulanceCars)
		if #ownedAmbulanceCars == 0 then
			exports['mythic_notify']:DoHudText('error', _U('garage_no_ambulance'))
			--ESX.ShowNotification(_U('garage_no_ambulance'))
		else
			for _,v in pairs(ownedAmbulanceCars) do
				local hashVehicule = v.vehicle.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				local plate = v.plate
				local fuel = v.fuel
				local labelvehicle
				local labelvehicle2 = ('<span style="color:Lavender;">%s</span> - <span style="color:Gold;">%s</span> - '):format(vehicleName, plate)

				if v.stored then
					if v.fuel > 50 then
						labelvehicle = labelvehicle2 .. ('<span style="color:Aqua;">%s&#37</span> - <span style="color:SpringGreen;">%s</span>'):format(fuel ,_U('loc_garage'))
					else
						labelvehicle = labelvehicle2 .. ('<span style="color:Red;">%s&#37</span> - <span style="color:SpringGreen;">%s</span>'):format(fuel ,_U('loc_garage'))
					end
				else
					labelvehicle = labelvehicle2 .. ('<span style="color:red;">%s</span>'):format(_U('loc_pound'))
				end

				table.insert(elements, {label = labelvehicle, value = v})
			end
		end

		table.insert(elements, {label = _U('spacer2'), value = nil})

		ESX.TriggerServerCallback('esx_advancedgarage:getOwnedAmbulanceAircrafts', function(ownedAmbulanceAircrafts)
			for _,v in pairs(ownedAmbulanceAircrafts) do
				local hashVehicule = v.vehicle.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				local plate = v.plate
				local labelvehicle
				local labelvehicle2 = ('<span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)

				if v.stored then
					labelvehicle = labelvehicle2 .. ('<span style="color:green;">%s</span>'):format(_U('loc_garage'))
				else
					labelvehicle = labelvehicle2 .. ('<span style="color:red;">%s</span>'):format(_U('loc_pound'))
				end

				table.insert(elements, {label = labelvehicle, value = v})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_owned_ambulance', {
				title = _U('garage_ambulance'),
				align = Config.MenuAlign,
				elements = elements
			}, function(data, menu)
				if data.current.value == nil then
				elseif data.current.value.vtype == 'aircraft' or data.current.value.vtype == 'helicopter' then
					if data.current.value.stored then
						menu.close()
						SpawnVehicle2(data.current.value.vehicle, data.current.value.plate,data.current.value.fuel,true)
					else
						exports['mythic_notify']:DoHudText('error', '不在車庫')
					end
				else
					if data.current.value.stored then
						menu.close()
						SpawnVehicle(data.current.value.vehicle, data.current.value.plate,data.current.value.fuel,true)
					else
						exports['mythic_notify']:DoHudText('error', '不在車庫')
					end
				end
			end, function(data, menu)
				menu.close()
			end)
		end)
	end)
end

function StoreOwnedAmbulanceMenu()
	local playerPed  = GetPlayerPed(-1)

	if IsPedInAnyVehicle(playerPed,  false) then
		local playerPed = GetPlayerPed(-1)
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		local current = GetPlayersLastVehicle(GetPlayerPed(-1), true)
		local engineHealth = GetVehicleEngineHealth(current)

		ESX.TriggerServerCallback('esx_advancedgarage:storeJobVehicle', function(valid)
			if valid then
				if engineHealth < 990 then
					if Config.UseDamageMult then
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.AmbulancePoundPrice*Config.DamageMult*5)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					else
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.AmbulancePoundPrice)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					end
				else
					StoreVehicle(vehicle, vehicleProps)
				end
			else
				exports['mythic_notify']:DoHudText('error', '無法停車')
			end
		end, vehicleProps)
	else
		errorexports['mythic_notify']:DoHudText('error', '需上車')
	end
end

function ReturnOwnedAmbulanceMenu()
	ESX.TriggerServerCallback('esx_advancedgarage:getOutOwnedAmbulanceCars', function(ownedAmbulanceCars)
		local elements = {}

		for _,v in pairs(ownedAmbulanceCars) do
			local hashVehicule = v.model
			local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
			local vehicleName = GetLabelText(aheadVehName)
			local plate = v.plate
			local labelvehicle
			local labelvehicle2 = ('<span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)

			labelvehicle = labelvehicle2 .. ('<span style="color:green;">%s</span>'):format(_U('return'))

			table.insert(elements, {label = labelvehicle, value = v})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'return_owned_ambulance', {
			title = _U('pound_ambulance', ESX.Math.GroupDigits(Config.AmbulancePoundPrice)),
			align = Config.MenuAlign,
			elements = elements
		}, function(data, menu)
			if data.current.value ~= nil then
				SpawnVehicle(data.current.value, data.current.value.plate,data.current.value.fuel,true)
				-- TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(PlayerId()), 'society_admin', '扣押費', 1000)
			end
		end, function(data, menu)
			menu.close()
			WasinJPound = true
		end)
	end)
end
-- End of Ambulance Code

-- Start of Police Code
function ListOwnedPoliceMenu()
	local elements = {}
	local spacer = ('<span style="color:Lavender;">%s</span>  -  <span style="color:Gold;">%s</span>  -  <span style="color:Aqua;">%s</span>  -  <span style="color:SpringGreen;">%s</span>'):format(_U('vehicle'), _U('plate'),'油量', _U('location'))
	table.insert(elements, {label = spacer, value = nil})

	ESX.TriggerServerCallback('esx_advancedgarage:getOwnedPoliceCars', function(ownedPoliceCars)
		if #ownedPoliceCars == 0 then
			exports['mythic_notify']:DoHudText('error', '無車輛')
		else
			for _,v in pairs(ownedPoliceCars) do
				local hashVehicule = v.vehicle.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				local plate = v.plate
				local fuel = v.fuel
				local labelvehicle
				local labelvehicle2 = ('<span style="color:Lavender;">%s</span> - <span style="color:Gold;">%s</span> - '):format(vehicleName, plate)

				if v.stored then
					if v.fuel > 50 then
						labelvehicle = labelvehicle2 .. ('<span style="color:Aqua;">%s&#37</span> - <span style="color:SpringGreen;">%s</span>'):format(fuel ,_U('loc_garage'))
					else
						labelvehicle = labelvehicle2 .. ('<span style="color:Red;">%s&#37</span> - <span style="color:SpringGreen;">%s</span>'):format(fuel ,_U('loc_garage'))
					end
				else
					labelvehicle = labelvehicle2 .. ('<span style="color:red;">%s</span>'):format(_U('loc_pound'))
				end

				table.insert(elements, {label = labelvehicle, value = v})
			end
		end

		table.insert(elements, {label = _U('spacer2'), value = nil})

		ESX.TriggerServerCallback('esx_advancedgarage:getOwnedPoliceAircrafts', function(ownedPoliceAircrafts)
			for _,v in pairs(ownedPoliceAircrafts) do
				local hashVehicule = v.vehicle.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				local plate = v.plate
				local labelvehicle
				local labelvehicle2 = ('<span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)

				if v.stored then
					labelvehicle = labelvehicle2 .. ('<span style="color:green;">%s</span>'):format(_U('loc_garage'))
				else
					labelvehicle = labelvehicle2 .. ('<span style="color:red;">%s</span>'):format(_U('loc_pound'))
				end

				table.insert(elements, {label = labelvehicle, value = v})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_owned_police', {
				title = _U('garage_police'),
				align = Config.MenuAlign,
				elements = elements
			}, function(data, menu)
				if data.current.value == nil then
				elseif data.current.value.vtype == 'aircraft' or data.current.value.vtype == 'helicopter' then
					if data.current.value.stored then
						menu.close()
						SpawnVehicle2(data.current.value.vehicle, data.current.value.plate,data.current.value.fuel,true)
					else
						exports['mythic_notify']:DoHudText('error', '不在車庫')
					end
				else
					if data.current.value.stored then
						menu.close()
						SpawnVehicle(data.current.value.vehicle, data.current.value.plate,data.current.value.fuel,true)
					else
						exports['mythic_notify']:DoHudText('error', '不在車庫')
					end
				end
			end, function(data, menu)
				menu.close()
			end)
		end)
	end)
end

function StoreOwnedPoliceMenu()
	local playerPed  = GetPlayerPed(-1)

	if IsPedInAnyVehicle(playerPed,  false) then
		local playerPed = GetPlayerPed(-1)
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		local current = GetPlayersLastVehicle(GetPlayerPed(-1), true)
		local engineHealth = GetVehicleEngineHealth(current)

		ESX.TriggerServerCallback('esx_advancedgarage:storeJobVehicle', function(valid)
			if valid then
				if engineHealth < 990 then
					if Config.UseDamageMult then
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.PolicePoundPrice*Config.DamageMult*5)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					else
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.PolicePoundPrice)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					end
				else
					StoreVehicle(vehicle, vehicleProps)
				end
			else
				exports['mythic_notify']:DoHudText('error', '無法停車')
			end
		end, vehicleProps)
	else
		errorexports['mythic_notify']:DoHudText('error', '需上車')
	end
end

function ReturnOwnedPoliceMenu()
	ESX.TriggerServerCallback('esx_advancedgarage:getOutOwnedPoliceCars', function(ownedPoliceCars)
		local elements = {}

		for _,v in pairs(ownedPoliceCars) do
			local hashVehicule = v.model
			local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
			local vehicleName = GetLabelText(aheadVehName)
			local plate = v.plate
			local labelvehicle
			local labelvehicle2 = ('<span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)

			labelvehicle = labelvehicle2 .. ('<span style="color:green;">%s</span>'):format(_U('return'))

			table.insert(elements, {label = labelvehicle, value = v})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'return_owned_police', {
			title = _U('pound_police', ESX.Math.GroupDigits(Config.PolicePoundPrice)),
			align = Config.MenuAlign,
			elements = elements
		}, function(data, menu)
			if data.current.value ~= nil then
				SpawnVehicle(data.current.value, data.current.value.plate,data.current.value.fuel,true)
				-- TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(PlayerId()), 'society_admin', '扣押費', 1000)
			end
		end, function(data, menu)
			menu.close()
			WasinJPound = true
		end)
	end)
end
-- End of Police Code

-- Start of Aircraft Code
function ListOwnedAircraftsMenu()
	local elements = {}
	local spacer = ('<span style="color:Lavender;">%s</span>  -  <span style="color:Gold;">%s</span>  -  <span style="color:Aqua;">%s</span>  -  <span style="color:SpringGreen;">%s</span>'):format(_U('vehicle'), _U('plate'),'油量', _U('location'))
	table.insert(elements, {label = spacer, value = nil})

	ESX.TriggerServerCallback('esx_advancedgarage:getOwnedAircrafts', function(ownedAircrafts)
		if #ownedAircrafts == 0 then
			exports['mythic_notify']:DoHudText('error', '無飛機')
		else
			for _,v in pairs(ownedAircrafts) do
				local hashVehicule = v.vehicle.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				local plate = v.plate
				local fuel = v.fuel
				local labelvehicle
				local labelvehicle2 = ('<span style="color:Lavender;">%s</span> - <span style="color:Gold;">%s</span> - '):format(vehicleName, plate)

				if v.stored then
					if v.fuel > 50 then
						labelvehicle = labelvehicle2 .. ('<span style="color:Aqua;">%s&#37</span> - <span style="color:SpringGreen;">%s</span>'):format(fuel ,_U('loc_garage'))
					else
						labelvehicle = labelvehicle2 .. ('<span style="color:Red;">%s&#37</span> - <span style="color:SpringGreen;">%s</span>'):format(fuel ,_U('loc_garage'))
					end
				else
					labelvehicle = labelvehicle2 .. ('<span style="color:red;">%s</span>'):format(_U('loc_pound'))
				end

				table.insert(elements, {label = labelvehicle, value = v})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_owned_aircraft', {
			title = _U('garage_aircrafts'),
			align = Config.MenuAlign,
			elements = elements
		}, function(data, menu)
			if data.current.value == nil then
			else
				if data.current.value.stored then
					menu.close()
					SpawnVehicle(data.current.value.vehicle, data.current.value.plate,data.current.value.fuel)
				else
					exports['mythic_notify']:DoHudText('error', '不在車庫')
				end
			end
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function StoreOwnedAircraftsMenu()
	local playerPed  = GetPlayerPed(-1)

	if IsPedInAnyVehicle(playerPed,  false) then
		local playerPed = GetPlayerPed(-1)
		local coords = GetEntityCoords(playerPed)
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		local current = GetPlayersLastVehicle(GetPlayerPed(-1), true)
		local engineHealth = GetVehicleEngineHealth(current)
		local plate = vehicleProps.plate

		ESX.TriggerServerCallback('esx_advancedgarage:storeVehicle', function(valid)
			if valid then
				if engineHealth < 990 then
					if Config.UseDamageMult then
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.AircraftPoundPrice*Config.DamageMult)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					else
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.AircraftPoundPrice)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					end
				else
					StoreVehicle(vehicle, vehicleProps)
				end	
			else
				exports['mythic_notify']:DoHudText('error', '無法停入')
			end
		end, vehicleProps)
	else
		errorexports['mythic_notify']:DoHudText('error', '需上車')
	end
end

function ReturnOwnedAircraftsMenu()
	ESX.TriggerServerCallback('esx_advancedgarage:getOutOwnedAircrafts', function(ownedAircrafts)
		local elements = {}

		if Config.ShowVehicleLocation == false and Config.ShowSpacers then
			local spacer = ('<span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span>'):format(_U('plate'), _U('vehicle'))
			table.insert(elements, {label = spacer, value = nil})
		end

		for _,v in pairs(ownedAircrafts) do
			local hashVehicule = v.model
			local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
			local vehicleName = GetLabelText(aheadVehName)
			local plate = v.plate
			local labelvehicle
			local labelvehicle2 = ('<span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)

			labelvehicle = labelvehicle2 .. ('<span style="color:green;">%s</span>'):format(_U('return'))

			table.insert(elements, {label = labelvehicle, value = v})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'return_owned_aircraft', {
			title = _U('pound_aircrafts', ESX.Math.GroupDigits(Config.AircraftPoundPrice)),
			align = Config.MenuAlign,
			elements = elements
		}, function(data, menu)
			if data.current.value ~= nil then
				SpawnVehicle(data.current.value, data.current.value.plate,data.current.value.fuel)
				TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(PlayerId()), 'society_admin', '飛機扣押費', 10000)
			end
		end, function(data, menu)
			menu.close()
			WasInPound = true
		end)
	end)
end
-- End of Aircraft Code

-- Start of Boat Code
function ListOwnedBoatsMenu()
	local elements = {}
	local spacer = ('<span style="color:Lavender;">%s</span>  -  <span style="color:Gold;">%s</span>  -  <span style="color:Aqua;">%s</span>  -  <span style="color:SpringGreen;">%s</span>'):format(_U('vehicle'), _U('plate'),'油量', _U('location'))
	table.insert(elements, {label = spacer, value = nil})


	ESX.TriggerServerCallback('esx_advancedgarage:getOwnedBoats', function(ownedBoats)
		for _,v in pairs(ownedBoats) do
			local hashVehicule = v.vehicle.model
			local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
			local vehicleName = GetLabelText(aheadVehName)
			local plate = v.plate
			local fuel = v.fuel
			local labelvehicle
			local labelvehicle2 = ('<span style="color:Lavender;">%s</span> - <span style="color:Gold;">%s</span> - '):format(vehicleName, plate)

			if v.stored then
				if v.fuel > 50 then
					labelvehicle = labelvehicle2 .. ('<span style="color:Aqua;">%s&#37</span> - <span style="color:SpringGreen;">%s</span>'):format(fuel ,_U('loc_garage'))
				else
					labelvehicle = labelvehicle2 .. ('<span style="color:Red;">%s&#37</span> - <span style="color:SpringGreen;">%s</span>'):format(fuel ,_U('loc_garage'))
				end
			else
				labelvehicle = labelvehicle2 .. ('<span style="color:red;">%s</span>'):format(_U('loc_pound'))
			end

			table.insert(elements, {label = labelvehicle, value = v})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_owned_boat', {
			title = _U('garage_boats'),
			align = Config.MenuAlign,
			elements = elements
		}, function(data, menu)
			if data.current.value == nil then
			else
				if data.current.value.stored then
					menu.close()
					SpawnVehicle(data.current.value.vehicle, data.current.value.plate,data.current.value.fuel)
				else
					exports['mythic_notify']:DoHudText('error', '不在車庫')
				end
			end
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function StoreOwnedBoatsMenu()
	local playerPed  = GetPlayerPed(-1)

	if IsPedInAnyVehicle(playerPed,  false) then
		local playerPed = GetPlayerPed(-1)
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		local current = GetPlayersLastVehicle(GetPlayerPed(-1), true)
		local engineHealth = GetVehicleEngineHealth(current)

		ESX.TriggerServerCallback('esx_advancedgarage:storeVehicle', function(valid)
			if valid then
				if engineHealth < 990 then
					if Config.UseDamageMult then
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.BoatPoundPrice*Config.DamageMult)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					else
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.BoatPoundPrice)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					end
				else
					StoreVehicle(vehicle, vehicleProps)
				end
			else
				exports['mythic_notify']:DoHudText('error', '無法停入')
			end
		end, vehicleProps)
	else
		errorexports['mythic_notify']:DoHudText('error', '需上車')
	end
end

function ReturnOwnedBoatsMenu()
	ESX.TriggerServerCallback('esx_advancedgarage:getOutOwnedBoats', function(ownedBoats)
		local elements = {}


		for _,v in pairs(ownedBoats) do
			local hashVehicule = v.model
			local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
			local vehicleName = GetLabelText(aheadVehName)
			local plate = v.plate
			local labelvehicle
			local labelvehicle2 = ('<span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)

			labelvehicle = labelvehicle2 .. ('<span style="color:green;">%s</span>'):format(_U('return'))

			table.insert(elements, {label = labelvehicle, value = v})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'return_owned_boat', {
			title = _U('pound_boats', ESX.Math.GroupDigits(Config.BoatPoundPrice)),
			align = Config.MenuAlign,
			elements = elements
		}, function(data, menu)
			if data.current.value ~= nil then
				SpawnVehicle(data.current.value, data.current.value.plate,data.current.value.fuel)
				TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(PlayerId()), 'society_admin', '船隻扣押費', 5000)
			end
		end, function(data, menu)
			menu.close()
			WasInPound = true
		end)
	end)
end
-- End of Boat Code

-- Start of Car Code
function ListOwnedCarsMenu()
	local elements = {}
	local spacer = ('<span style="color:Lavender;">%s</span>  -  <span style="color:Gold;">%s</span>  -  <span style="color:Aqua;">%s</span>  -  <span style="color:SpringGreen;">%s</span>'):format(_U('vehicle'), _U('plate'),'油量', _U('location'))
	table.insert(elements, {label = spacer, value = nil})

	ESX.TriggerServerCallback('esx_advancedgarage:getOwnedCars', function(ownedCars)
		if #ownedCars == 0 then
			exports['mythic_notify']:DoHudText('error', '車庫無車輛')
		else
			for _,v in pairs(ownedCars) do
				local hashVehicule = v.vehicle.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				local plate = v.plate
				local fuel = v.fuel
				local labelvehicle
				local labelvehicle2 = ('<span style="color:Lavender;">%s</span> - <span style="color:Gold;">%s</span> - '):format(vehicleName, plate)

				if v.stored then
					if v.fuel > 50 then
						labelvehicle = labelvehicle2 .. ('<span style="color:Aqua;">%s&#37</span> - <span style="color:SpringGreen;">%s</span>'):format(fuel ,_U('loc_garage'))
					else
						labelvehicle = labelvehicle2 .. ('<span style="color:Red;">%s&#37</span> - <span style="color:SpringGreen;">%s</span>'):format(fuel ,_U('loc_garage'))
					end
				else
					labelvehicle = labelvehicle2 .. ('<span style="color:red;">%s</span>'):format(_U('loc_pound'))
				end

				table.insert(elements, {label = labelvehicle, value = v})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_owned_car', {
			title = _U('garage_cars'),
			align = Config.MenuAlign,
			elements = elements
		}, function(data, menu)
			if data.current.value == nil then
			else
				if data.current.value.stored then
					menu.close()
					SpawnVehicle(data.current.value.vehicle, data.current.value.plate,data.current.value.fuel)
				else
					exports['mythic_notify']:DoHudText('error', '不在車庫')
				end
			end
		end, function(data, menu)
			menu.close()
		end)
	end,where)
end

function StoreOwnedCarsMenu()
	local playerPed  = GetPlayerPed(-1)

	if IsPedInAnyVehicle(playerPed,  false) then
		local playerPed = GetPlayerPed(-1)
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		local current = GetPlayersLastVehicle(GetPlayerPed(-1), true)
		local engineHealth = GetVehicleEngineHealth(current)

		ESX.TriggerServerCallback('esx_advancedgarage:storeVehicle', function(valid)
			if valid then
				if engineHealth < 999 then
					if Config.UseDamageMult then
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.CarPoundPrice*Config.DamageMult)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					else
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.CarPoundPrice)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					end
				else
					StoreVehicle(vehicle, vehicleProps)
				end
			else
				exports['mythic_notify']:DoHudText('error', '無法停入')
			end
		end, vehicleProps)
	else
		exports['mythic_notify']:DoHudText('error', '需上車')
	end
end

function ReturnOwnedCarsMenu()
	ESX.TriggerServerCallback('esx_advancedgarage:getOutOwnedCars', function(ownedCars)
		local elements = {}

		for _,v in pairs(ownedCars) do
			local hashVehicule = v.model
			local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
			local vehicleName = GetLabelText(aheadVehName)
			local plate = v.plate
			local labelvehicle
			local labelvehicle2 = ('<span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)

			labelvehicle = labelvehicle2 .. ('<span style="color:green;">%s</span>'):format(_U('return'))

			table.insert(elements, {label = labelvehicle, value = v})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'return_owned_car', {
			title = _U('pound_cars', ESX.Math.GroupDigits(Config.CarPoundPrice)),
			align = Config.MenuAlign,
			elements = elements
		}, function(data, menu)
			if data.current.value ~= nil then
				SpawnVehicle(data.current.value, data.current.value.plate,data.current.value.fuel)
				TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(PlayerId()), 'society_admin', '車輛扣押費', 5000)
			end
		end, function(data, menu)
			menu.close()
			WasInPound = true
		end)
	end)
end
-- End of Car Code

-- Repair Vehicles
function RepairVehicle(apprasial, vehicle, vehicleProps)
	ESX.UI.Menu.CloseAll()

	exports['mythic_notify']:DoHudText('inform', '需維修 $' .. apprasial)
	local elements = {
		{label = ('取消'), value = 'no'},
		{label = ('確定 [$'..apprasial..']'), value = 'yes'}
	}

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'delete_menu', {
		title = _U('damaged_vehicle'),
		align = Config.MenuAlign,
		elements = elements
	}, function(data, menu)
		menu.close()

		if data.current.value == 'yes' then
			vehicleProps.bodyHealth = 1000.0
			vehicleProps.engineHealth = 1000
			StoreVehicle(vehicle, vehicleProps)
			TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(PlayerId()), 'society_repair', '修車費', apprasial)
			TriggerServerEvent('esx_joblogs:AddInLog', "car", "grepair", GetPlayerName(PlayerId()),apprasial)
		elseif data.current.value == 'no' then
		end
	end, function(data, menu)
		menu.close()
	end)
end

function StoreVehicle(vehicle, vehicleProps)
	local currentFuel = exports['LegacyFuel']:GetFuel(vehicle)
	ESX.Game.DeleteVehicle(vehicle)
	TriggerServerEvent('esx_advancedgarage:setVehicleFuel', vehicleProps.plate, currentFuel)
	TriggerServerEvent('esx_advancedgarage:setVehicleloc', vehicleProps.plate, store)
	TriggerServerEvent('esx_advancedgarage:setVehicleState', vehicleProps.plate, true)
	TriggerServerEvent('esx_joblogs:AddInLog', "car", "cari", GetPlayerName(PlayerId()),GetLabelText(GetDisplayNameFromVehicleModel(vehicleProps.model)),vehicleProps.plate)
end

-- Spawn Vehicles
function SpawnVehicle(vehicle, plate, fuel, job)
	ESX.Game.SpawnVehicle(vehicle.model, this_Garage.Spawner, this_Garage.Heading, function(callback_vehicle)
		ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
		SetVehRadioStation(callback_vehicle, "OFF")
		SetVehicleFixed(callback_vehicle)
		SetVehicleDeformationFixed(callback_vehicle)
		SetVehicleUndriveable(callback_vehicle, false)
		SetVehicleEngineOn(callback_vehicle, true, true)
		SetVehicleDirtLevel(callback_vehicle)
		TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
		exports['LegacyFuel']:SetFuel(callback_vehicle, fuel)
	end)
	TriggerServerEvent('esx_joblogs:AddInLog', "car", "caro", GetPlayerName(PlayerId()),GetLabelText(GetDisplayNameFromVehicleModel(vehicle.model)),plate)
	TriggerServerEvent('esx_advancedgarage:setVehicleState', plate, false)
	if job then
		TriggerServerEvent('esx_advancedgarage:setVehicleowner', plate)
	end
end

function SpawnVehicle2(vehicle, plate, fuel, job)
	ESX.Game.SpawnVehicle(vehicle.model, this_Garage.Spawner2, this_Garage.Heading2, function(callback_vehicle)
		ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
		SetVehRadioStation(callback_vehicle, "OFF")
		SetVehicleFixed(callback_vehicle)
		SetVehicleDeformationFixed(callback_vehicle)
		SetVehicleUndriveable(callback_vehicle, false)
		SetVehicleEngineOn(callback_vehicle, true, true)
		SetVehicleDirtLevel(callback_vehicle)
		TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
		exports['LegacyFuel']:SetFuel(callback_vehicle, fuel)
	end)
	TriggerServerEvent('esx_joblogs:AddInLog', "car", "caro", GetPlayerName(PlayerId()),GetLabelText(GetDisplayNameFromVehicleModel(vehicle.model)),plate)
	TriggerServerEvent('esx_advancedgarage:setVehicleState', plate, false)
	if job then
		TriggerServerEvent('esx_advancedgarage:setVehicleowner', plate)
	end
end

-- Entered Marker
AddEventHandler('esx_advancedgarage:hasEnteredMarker', function(zone)
	if zone == 'ambulance_garage_point' then
		CurrentAction = 'ambulance_garage_point'
		CurrentActionMsg = ('[~g~E~s~]醫用車庫')
		CurrentActionData = {}
	elseif zone == 'ambulance_store_point' then
		CurrentAction = 'ambulance_store_point'
		CurrentActionMsg = _U('press_to_delete')
		CurrentActionData = {}
	elseif zone == 'ambulance_pound_point' then
		CurrentAction = 'ambulance_pound_point'
		CurrentActionMsg = _U('press_to_impound')
		CurrentActionData = {}
	elseif zone == 'police_garage_point' then
		CurrentAction = 'police_garage_point'
		CurrentActionMsg = ('[~g~E~s~]警用車庫')
		CurrentActionData = {}
	elseif zone == 'police_store_point' then
		CurrentAction = 'police_store_point'
		CurrentActionMsg = _U('press_to_delete')
		CurrentActionData = {}
	elseif zone == 'police_pound_point' then
		CurrentAction = 'police_pound_point'
		CurrentActionMsg = _U('press_to_impound')
		CurrentActionData = {}
	elseif zone == 'gangster_garage_point' then
		CurrentAction = 'gangster_garage_point'
		CurrentActionMsg = _U('press_to_enter')
		CurrentActionData = {}
	elseif zone == 'gangster_store_point' then
		CurrentAction = 'gangster_store_point'
		CurrentActionMsg = _U('press_to_delete')
		CurrentActionData = {}
	elseif zone == 'gangster_pound_point' then
		CurrentAction = 'gangster_pound_point'
		CurrentActionMsg = _U('press_to_impound')
		CurrentActionData = {}
	elseif zone == 'aircraft_garage_point' then
		CurrentAction = 'aircraft_garage_point'
		CurrentActionMsg = ('[~g~E~s~]機庫')
		CurrentActionData = {}
	elseif zone == 'aircraft_store_point' then
		CurrentAction = 'aircraft_store_point'
		CurrentActionMsg = _U('press_to_delete')
		CurrentActionData = {}
	elseif zone == 'aircraft_pound_point' then
		CurrentAction = 'aircraft_pound_point'
		CurrentActionMsg = _U('press_to_impound')
		CurrentActionData = {}
	elseif zone == 'boat_garage_point' then
		CurrentAction = 'boat_garage_point'
		CurrentActionMsg = ('[~g~E~s~]船屋')
		CurrentActionData = {}
	elseif zone == 'boat_store_point' then
		CurrentAction = 'boat_store_point'
		CurrentActionMsg = _U('press_to_delete')
		CurrentActionData = {}
	elseif zone == 'boat_pound_point' then
		CurrentAction = 'boat_pound_point'
		CurrentActionMsg = _U('press_to_impound')
		CurrentActionData = {}
	elseif zone == 'car_garage_point' then
		CurrentAction = 'car_garage_point'
		CurrentActionMsg = _U('press_to_enter')
		CurrentActionData = {}
	elseif zone == 'car_store_point' then
		CurrentAction = 'car_store_point'
		CurrentActionMsg = _U('press_to_delete')
		CurrentActionData = {}
	elseif zone == 'car_pound_point' then
		CurrentAction = 'car_pound_point'
		CurrentActionMsg = _U('press_to_impound')
		CurrentActionData = {}
	end
end)

-- Exited Marker
AddEventHandler('esx_advancedgarage:hasExitedMarker', function()
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

-- Resource Stop
AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		ESX.UI.Menu.CloseAll()
	end
end)

-- Enter / Exit marker events & Draw Markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerCoords = GetEntityCoords(PlayerPedId())
		local isInMarker, letSleep, currentZone = false, true

		if Config.UseAmbulanceGarages then
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
				for k,v in pairs(Config.AmbulanceGarages) do
					local distance = #(playerCoords - v.Marker)
					local distance2 = #(playerCoords - v.Deleter)
					local distance3 = #(playerCoords - v.Deleter2)

					if distance < Config.DrawDistance then
						letSleep = false

						if Config.PointMarker.Type ~= -1 then
							DrawMarker(Config.PointMarker.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.PointMarker.x, Config.PointMarker.y, Config.PointMarker.z, Config.PointMarker.r, Config.PointMarker.g, Config.PointMarker.b, 100, false, true, 2, false, nil, nil, false)
						end

						if distance < Config.PointMarker.x then
							isInMarker, this_Garage, currentZone,where = true, v, 'ambulance_garage_point',v.garage
						end
					end

					if distance2 < Config.DrawDistance then
						letSleep = false

						if Config.DeleteMarker.Type ~= -1 then
							DrawMarker(Config.DeleteMarker.Type, v.Deleter, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.DeleteMarker.x, Config.DeleteMarker.y, Config.DeleteMarker.z, Config.DeleteMarker.r, Config.DeleteMarker.g, Config.DeleteMarker.b, 100, false, true, 2, false, nil, nil, false)
						end

						if distance2 < Config.DeleteMarker.x then
							isInMarker, this_Garage, currentZone,store = true, v, 'ambulance_store_point',v.garage
						end
					end

					if distance3 < Config.DrawDistance then
						letSleep = false

						if Config.DeleteMarker.Type ~= -1 then
							DrawMarker(Config.DeleteMarker.Type, v.Deleter2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 10.0, 10.0, Config.DeleteMarker.z + 1.0, Config.DeleteMarker.r, Config.DeleteMarker.g, Config.DeleteMarker.b, 100, false, true, 2, false, nil, nil, false)
						end

						if distance3 < Config.DeleteMarker.x then
							isInMarker, this_Garage, currentZone,store = true, v, 'ambulance_store_point',v.garage
						end
					end
				end
			end
		end

		if Config.UseAmbulancePounds then
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
				for k,v in pairs(Config.AmbulancePounds) do
					local distance = #(playerCoords - v.Marker)

					if distance < Config.DrawDistance then
						letSleep = false

						if Config.JPoundMarker.Type ~= -1 then
							DrawMarker(Config.JPoundMarker.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.JPoundMarker.x, Config.JPoundMarker.y, Config.JPoundMarker.z, Config.JPoundMarker.r, Config.JPoundMarker.g, Config.JPoundMarker.b, 100, false, true, 2, false, nil, nil, false)
						end

						if distance < Config.JPoundMarker.x then
							isInMarker, this_Garage, currentZone = true, v, 'ambulance_pound_point'
						end
					end
				end
			end
		end

		if Config.UsePoliceGarages then
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
				for k,v in pairs(Config.PoliceGarages) do
					local distance = #(playerCoords - v.Marker)
					local distance2 = #(playerCoords - v.Deleter)
					local distance3 = #(playerCoords - v.Deleter2)

					if distance < Config.DrawDistance then
						letSleep = false

						if Config.PointMarker.Type ~= -1 then
							DrawMarker(Config.PointMarker.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.PointMarker.x, Config.PointMarker.y, Config.PointMarker.z, Config.PointMarker.r, Config.PointMarker.g, Config.PointMarker.b, 100, false, true, 2, false, nil, nil, false)
						end

						if distance < Config.PointMarker.x then
							isInMarker, this_Garage, currentZone,where = true, v, 'police_garage_point',v.garage
						end
					end

					if distance2 < Config.DrawDistance then
						letSleep = false

						if Config.DeleteMarker.Type ~= -1 then
							DrawMarker(Config.DeleteMarker.Type, v.Deleter, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.DeleteMarker.x, Config.DeleteMarker.y, Config.DeleteMarker.z, Config.DeleteMarker.r, Config.DeleteMarker.g, Config.DeleteMarker.b, 100, false, true, 2, false, nil, nil, false)
						end

						if distance2 < Config.DeleteMarker.x then
							isInMarker, this_Garage, currentZone,store = true, v, 'police_store_point',v.garage
						end
					end

					if distance3 < Config.DrawDistance then
						letSleep = false

						if Config.DeleteMarker.Type ~= -1 then
							DrawMarker(Config.DeleteMarker.Type, v.Deleter2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 10.0, 10.0, Config.DeleteMarker.z + 1, Config.DeleteMarker.r, Config.DeleteMarker.g, Config.DeleteMarker.b, 100, false, true, 2, false, nil, nil, false)
						end

						if distance3 < Config.DeleteMarker.x then
							isInMarker, this_Garage, currentZone,store = true, v, 'police_store_point',v.garage
						end
					end
				end
			end
		end

		if Config.UsePolicePounds then
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
				for k,v in pairs(Config.PolicePounds) do
					local distance = #(playerCoords - v.Marker)

					if distance < Config.DrawDistance then
						letSleep = false

						if Config.JPoundMarker.Type ~= -1 then
							DrawMarker(Config.JPoundMarker.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.JPoundMarker.x, Config.JPoundMarker.y, Config.JPoundMarker.z, Config.JPoundMarker.r, Config.JPoundMarker.g, Config.JPoundMarker.b, 100, false, true, 2, false, nil, nil, false)
						end

						if distance < Config.JPoundMarker.x then
							isInMarker, this_Garage, currentZone = true, v, 'police_pound_point'
						end
					end
				end
			end
		end
		
		if Config.UseAircraftGarages then
			for k,v in pairs(Config.AircraftGarages) do
				local distance = #(playerCoords - v.Marker)
				local distance2 = #(playerCoords - v.Deleter)

				if distance < Config.DrawDistance then
					letSleep = false

					if Config.PointMarker.Type ~= -1 then
						DrawMarker(Config.PointMarker.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.PointMarker.x, Config.PointMarker.y, Config.PointMarker.z, Config.PointMarker.r, Config.PointMarker.g, Config.PointMarker.b, 100, false, true, 2, false, nil, nil, false)
					end

					if distance < Config.PointMarker.x then
						isInMarker, this_Garage, currentZone = true, v, 'aircraft_garage_point'
					end
				end

				if distance2 < Config.DrawDistance then
					letSleep = false

					if Config.DeleteMarker.Type ~= -1 then
						DrawMarker(Config.DeleteMarker.Type, v.Deleter, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 20.0, 20.0, 2.0, Config.DeleteMarker.r, Config.DeleteMarker.g, Config.DeleteMarker.b, 100, false, true, 2, false, nil, nil, false)
					end

					if distance2 < 10 then
						isInMarker, this_Garage, currentZone = true, v, 'aircraft_store_point'
					end
				end
			end

			for k,v in pairs(Config.AircraftPounds) do
				local distance = #(playerCoords - v.Marker)

				if distance < Config.DrawDistance then
					letSleep = false

					if Config.PoundMarker.Type ~= -1 then
						DrawMarker(Config.PoundMarker.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.PoundMarker.x, Config.PoundMarker.y, Config.PoundMarker.z, Config.PoundMarker.r, Config.PoundMarker.g, Config.PoundMarker.b, 100, false, true, 2, false, nil, nil, false)
					end

					if distance < Config.PoundMarker.x then
						isInMarker, this_Garage, currentZone = true, v, 'aircraft_pound_point'
					end
				end
			end
		end

		if Config.UseBoatGarages then
			for k,v in pairs(Config.BoatGarages) do
				local distance = #(playerCoords - v.Marker)
				local distance2 = #(playerCoords - v.Deleter)

				if distance < Config.DrawDistance then
					letSleep = false

					if Config.PointMarker.Type ~= -1 then
						DrawMarker(Config.PointMarker.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.PointMarker.x, Config.PointMarker.y, Config.PointMarker.z, Config.PointMarker.r, Config.PointMarker.g, Config.PointMarker.b, 100, false, true, 2, false, nil, nil, false)
					end

					if distance < Config.PointMarker.x then
						isInMarker, this_Garage, currentZone = true, v, 'boat_garage_point'
					end
				end

				if distance2 < Config.DrawDistance then
					letSleep = false

					if Config.DeleteMarker.Type ~= -1 then
						DrawMarker(Config.DeleteMarker.Type, v.Deleter, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.DeleteMarker.x, Config.DeleteMarker.y, Config.DeleteMarker.z, Config.DeleteMarker.r, Config.DeleteMarker.g, Config.DeleteMarker.b, 100, false, true, 2, false, nil, nil, false)
					end

					if distance2 < Config.DeleteMarker.x then
						isInMarker, this_Garage, currentZone = true, v, 'boat_store_point'
					end
				end
			end

			for k,v in pairs(Config.BoatPounds) do
				local distance = #(playerCoords - v.Marker)

				if distance < Config.DrawDistance then
					letSleep = false

					if Config.PoundMarker.Type ~= -1 then
						DrawMarker(Config.PoundMarker.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.PoundMarker.x, Config.PoundMarker.y, Config.PoundMarker.z, Config.PoundMarker.r, Config.PoundMarker.g, Config.PoundMarker.b, 100, false, true, 2, false, nil, nil, false)
					end

					if distance < Config.PoundMarker.x then
						isInMarker, this_Garage, currentZone = true, v, 'boat_pound_point'
					end
				end
			end
		end

		if Config.UseCarGarages then
			for k,v in pairs(Config.CarGarages) do
				local distance = #(playerCoords - v.Marker)
				local distance2 = #(playerCoords - v.Deleter)

				if distance < Config.DrawDistance then
					letSleep = false

					if Config.PointMarker.Type ~= -1 then
						DrawMarker(Config.PointMarker.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.PointMarker.x, Config.PointMarker.y, Config.PointMarker.z, Config.PointMarker.r, Config.PointMarker.g, Config.PointMarker.b, 100, false, true, 2, false, nil, nil, false)
					end

					if distance < Config.PointMarker.x then
						isInMarker, this_Garage, currentZone, where = true, v, 'car_garage_point',v.garage
					end
				end

				if distance2 < Config.DrawDistance then
					letSleep = false

					if Config.DeleteMarker.Type ~= -1 then
						DrawMarker(Config.DeleteMarker.Type, v.Deleter, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.DeleteMarker.x, Config.DeleteMarker.y, Config.DeleteMarker.z, Config.DeleteMarker.r, Config.DeleteMarker.g, Config.DeleteMarker.b, 100, false, true, 2, false, nil, nil, false)
					end

					if distance2 < Config.DeleteMarker.x then
						isInMarker, this_Garage, currentZone, store = true, v, 'car_store_point',v.garage
					end
				end
			end

			for k,v in pairs(Config.CarPounds) do
				local distance = #(playerCoords - v.Marker)

				if distance < Config.DrawDistance then
					letSleep = false

					if Config.PoundMarker.Type ~= -1 then
						DrawMarker(Config.PoundMarker.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.PoundMarker.x, Config.PoundMarker.y, Config.PoundMarker.z, Config.PoundMarker.r, Config.PoundMarker.g, Config.PoundMarker.b, 100, false, true, 2, false, nil, nil, false)
					end

					if distance < Config.PoundMarker.x then
						isInMarker, this_Garage, currentZone = true, v, 'car_pound_point'
					end
				end
			end
		end

		if Config.UsePrivateCarGarages then
			for k,v in pairs(Config.PrivateCarGarages) do
				if not v.Private or has_value(userProperties, v.Private) then
					local distance = #(playerCoords - v.Marker)
					local distance2 = #(playerCoords - v.Deleter)

					if distance < Config.DrawDistance then
						letSleep = false

						if Config.PointMarker.Type ~= -1 then
							DrawMarker(Config.PointMarker.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.PointMarker.x, Config.PointMarker.y, Config.PointMarker.z, Config.PointMarker.r, Config.PointMarker.g, Config.PointMarker.b, 100, false, true, 2, false, nil, nil, false)
						end

						if distance < Config.PointMarker.x then
							isInMarker, this_Garage, currentZone = true, v, 'car_garage_point'
						end
					end

					if distance2 < Config.DrawDistance then
						letSleep = false

						if Config.DeleteMarker.Type ~= -1 then
							DrawMarker(Config.DeleteMarker.Type, v.Deleter, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.DeleteMarker.x, Config.DeleteMarker.y, Config.DeleteMarker.z, Config.DeleteMarker.r, Config.DeleteMarker.g, Config.DeleteMarker.b, 100, false, true, 2, false, nil, nil, false)
						end

						if distance2 < Config.DeleteMarker.x then
							isInMarker, this_Garage, currentZone = true, v, 'car_store_point'
						end
					end
				end
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker, LastZone = true, currentZone
			LastZone = currentZone
			TriggerEvent('esx_advancedgarage:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_advancedgarage:hasExitedMarker', LastZone)
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) then
				if CurrentAction == 'ambulance_garage_point' then
					ListOwnedAmbulanceMenu()
				elseif CurrentAction == 'ambulance_store_point' then
					StoreOwnedAmbulanceMenu()
				elseif CurrentAction == 'ambulance_pound_point' then
					ReturnOwnedAmbulanceMenu()
				elseif CurrentAction == 'police_garage_point' then
					ListOwnedPoliceMenu()
				elseif CurrentAction == 'police_store_point' then
					StoreOwnedPoliceMenu()
				elseif CurrentAction == 'police_pound_point' then
					ReturnOwnedPoliceMenu()
				elseif CurrentAction == 'aircraft_garage_point' then
					ListOwnedAircraftsMenu()
				elseif CurrentAction == 'aircraft_store_point' then
					StoreOwnedAircraftsMenu()
				elseif CurrentAction == 'aircraft_pound_point' then
					ReturnOwnedAircraftsMenu()
				elseif CurrentAction == 'boat_garage_point' then
					ListOwnedBoatsMenu()
				elseif CurrentAction == 'boat_store_point' then
					StoreOwnedBoatsMenu()
				elseif CurrentAction == 'boat_pound_point' then
					ReturnOwnedBoatsMenu()
				elseif CurrentAction == 'car_garage_point' then
					ListOwnedCarsMenu()
				elseif CurrentAction == 'car_store_point' then
					StoreOwnedCarsMenu()
				elseif CurrentAction == 'car_pound_point' then
					ReturnOwnedCarsMenu()
				end

				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)
