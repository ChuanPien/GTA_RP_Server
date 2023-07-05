ESX = nil
local playersHealing, deadPlayers = {}, {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'ambulance', _U('alert_ambulance'), true, true)

TriggerEvent('esx_society:registerSociety', 'ambulance', 'Ambulance', 'society_ambulance', 'society_ambulance', 'society_ambulance', {type = 'public'})

RegisterNetEvent('esx_ambulancejob:revive')
AddEventHandler('esx_ambulancejob:revive', function(playerId)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer and xPlayer.job.name == 'ambulance' then
		local xTarget = ESX.GetPlayerFromId(playerId)

		if xTarget then
			if deadPlayers[playerId] then
				TriggerEvent('esx_joblogs:AddInLog',"ambulance" ,"revive" ,xPlayer.name, xTarget.name)
				xTarget.triggerEvent('esx_ambulancejob:revive')
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = '無須急救'})
			end
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = '無市民'})
		end
	end
end)

RegisterNetEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	deadPlayers[source] = 'dead'
	TriggerClientEvent('esx_ambulancejob:setDeadPlayers', -1, deadPlayers)
end)

RegisterNetEvent('esx_ambulancejob:onPlayerDistress')
AddEventHandler('esx_ambulancejob:onPlayerDistress', function()
	if deadPlayers[source] then
		deadPlayers[source] = 'distress'
		TriggerClientEvent('esx_ambulancejob:setDeadPlayers', -1, deadPlayers)
	end
end)

RegisterNetEvent('esx:onPlayerSpawn')
AddEventHandler('esx:onPlayerSpawn', function()
	if deadPlayers[source] then
		deadPlayers[source] = nil
		TriggerClientEvent('esx_ambulancejob:setDeadPlayers', -1, deadPlayers)
	end
end)

AddEventHandler('esx:playerDropped', function(playerId, reason)
	if deadPlayers[playerId] then
		deadPlayers[playerId] = nil
		TriggerClientEvent('esx_ambulancejob:setDeadPlayers', -1, deadPlayers)
	end
end)

RegisterNetEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(target, type)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerClientEvent('esx_ambulancejob:heal', target, type)
end)

RegisterNetEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('esx_ambulancejob:putInVehicle', target)
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	local ems = 0

	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'ambulance' then
			ems = ems + 1
		end
	end

	if ems >= 1 then
		if xPlayer.getMoney() > 0 then
			money = xPlayer.getMoney()
			xPlayer.removeMoney(xPlayer.getMoney())
			TriggerEvent('esx_joblogs:AddInLog', "ambulance", "drm", xPlayer.name,money .. "現金")
		end

		if xPlayer.getAccount('black_money').money > 0 then
			money = xPlayer.getAccount('black_money').money
			xPlayer.setAccountMoney('black_money', 0)
			TriggerEvent('esx_joblogs:AddInLog', "ambulance", "drm", xPlayer.name,money.. "黑錢")
		end

		for i=1, #xPlayer.inventory, 1 do
			if xPlayer.inventory[i].count > 0 then
				xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
				TriggerEvent('esx_joblogs:AddInLog', "ambulance", "dri", xPlayer.name,xPlayer.inventory[i].count,xPlayer.inventory[i].label)
				Wait(500)
			end
		end

		local playerLoadout = {}
		for i=1, #xPlayer.loadout, 1 do
			xPlayer.removeWeapon(xPlayer.loadout[i].name)
			TriggerEvent('esx_joblogs:AddInLog', "ambulance", "drw", xPlayer.name,xPlayer.loadout[i].label)
			Wait(500)
		end
	end
	cb()
end)

ESX.RegisterServerCallback('esx_ambulancejob:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count

	cb(quantity)
end)

function getPriceFromHash(vehicleHash, jobGrade, type)
	local vehicles = Config.AuthorizedVehicles[type][jobGrade]

	for k,v in ipairs(vehicles) do
		if GetHashKey(v.model) == vehicleHash then
			return v.price
		end
	end

	return 0
end

RegisterNetEvent('esx_ambulancejob:removeItem')
AddEventHandler('esx_ambulancejob:removeItem', function(item)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem(item, 1)

	if item == 'bandage' then
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '繃帶'})
	elseif item == 'medikit' then
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '醫療包'})
	end
end)

RegisterNetEvent('esx_ambulancejob:giveItem')
AddEventHandler('esx_ambulancejob:giveItem', function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'ambulance' then
		return
	elseif (itemName ~= 'medikit' and itemName ~= 'bandage') then
		return
	end

	if xPlayer.canCarryItem(itemName, amount) then
		xPlayer.addInventoryItem(itemName, amount)
		TriggerEvent('esx_joblogs:AddInLog',"ambulance" ,"getitem" ,xPlayer.name, amount, ESX.GetItemLabel(itemName))
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = '過重'})
	end
end)

ESX.RegisterCommand('r', 'admin', function(xPlayer, args, showError)
	args.playerId.triggerEvent('esx_ambulancejob:revive')
end, true, {help = _U('revive_help'), validate = true, arguments = {
	{name = 'playerId', help = 'The player id', type = 'player'}
}})

ESX.RegisterUsableItem('medikit', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('medikit', 1)

		playersHealing[source] = true
		TriggerClientEvent('esx_ambulancejob:useItem', source, 'medikit')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterUsableItem('bandage', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('bandage', 1)

		playersHealing[source] = true
		TriggerClientEvent('esx_ambulancejob:useItem', source, 'bandage')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:getDeathStatus', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchScalar('SELECT is_dead FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(isDead)
				
		if isDead then
			-- print(('[esx_ambulancejob] [^2INFO^7] "%s" attempted combat logging'):format(xPlayer.identifier))
		end

		cb(isDead)
	end)
end)

RegisterNetEvent('esx_ambulancejob:setDeathStatus')
AddEventHandler('esx_ambulancejob:setDeathStatus', function(isDead)
	local xPlayer = ESX.GetPlayerFromId(source)

	if type(isDead) == 'boolean' then
		MySQL.Sync.execute('UPDATE users SET is_dead = @isDead WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier,
			['@isDead'] = isDead
		})
	end
end)

RegisterServerEvent('esx_ambulance:requestCPR')
AddEventHandler('esx_ambulance:requestCPR', function(target, playerheading, playerCoords, playerlocation)
    -- print(target)
    TriggerClientEvent("CUSTOM_esx_ambulance:playCPR", target, playerheading, playerCoords, playerlocation)
end)

AddEventHandler('playerDropped', function()
	-- Save the source in case we lose it (which happens a lot)
	local playerId = source

	-- Did the player ever join?
	if playerId then
		local xPlayer = ESX.GetPlayerFromId(playerId)

		-- Is it worth telling all clients to refresh?
		if xPlayer and xPlayer.job.name == 'ambulance' then
			Citizen.Wait(0)
			TriggerClientEvent('esx_ambulancejob:updateBlip', -1)
		end
	end
end)

RegisterNetEvent('esx_ambulancejob:spawned')
AddEventHandler('esx_ambulancejob:spawned', function()
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if xPlayer and xPlayer.job.name == 'ambulance' then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_ambulancejob:updateBlip', -1)
	end
end)

RegisterNetEvent('esx_ambulancejob:forceBlip')
AddEventHandler('esx_ambulancejob:forceBlip', function()
	TriggerClientEvent('esx_ambulancejob:updateBlip', -1)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_ambulancejob:updateBlip', -1)
	end
end)
