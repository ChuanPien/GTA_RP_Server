ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function GetProperty(name)
	for i=1, #Config.Properties, 1 do
		if Config.Properties[i].name == name then
			return Config.Properties[i]
		end
	end
end

function SetPropertyOwned(name, price, rented, owner)
	MySQL.Async.execute('INSERT INTO owned_properties (name, price, rented, owner) VALUES (@name, @price, @rented, @owner)', {
		['@name']   = name,
		['@price']  = price,
		['@rented'] = (rented and 1 or 0),
		['@owner']  = owner
	}, function(rowsChanged)
		local xPlayer = ESX.GetPlayerFromIdentifier(owner)

		if xPlayer then
			TriggerClientEvent('esx_property:setPropertyOwned', xPlayer.source, name, true, rented)

			if rented then
				xPlayer.showNotification(_U('rent_for', ESX.Math.GroupDigits(price)))
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = '購入房產'})
				TriggerEvent('esx_joblogs:AddInLog', "house", "buyh", xPlayer.name,name)
			end
		end
	end)
end

function RemoveOwnedProperty(name, owner, noPay)
	MySQL.Async.fetchAll('SELECT id, rented, price FROM owned_properties WHERE name = @name AND owner = @owner', {
		['@name']  = name,
		['@owner'] = owner
	}, function(result)
		if result[1] then
			MySQL.Async.execute('DELETE FROM owned_properties WHERE id = @id', {
				['@id'] = result[1].id
			}, function(rowsChanged)
				local xPlayer = ESX.GetPlayerFromIdentifier(owner)

				if xPlayer then
					xPlayer.triggerEvent('esx_property:setPropertyOwned', name, false)

					if not noPay then
						if result[1].rented == 1 then
							TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = '售出房產'})
						else
							local sellPrice = ESX.Math.Round(result[1].price / Config.SellModifier)

							TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = '售出房產'})
							xPlayer.addAccountMoney('bank', sellPrice)
							TriggerEvent('esx_joblogs:AddInLog', "house", "sellh", xPlayer.name,name)
						end
					end
				end
			end)
		end
	end)
end

MySQL.ready(function()
	Citizen.Wait(1500)

	MySQL.Async.fetchAll('SELECT * FROM properties', {}, function(properties)

		for i=1, #properties, 1 do
			local entering  = nil
			local exit      = nil
			local inside    = nil
			local outside   = nil
			local isSingle  = nil
			local isRoom    = nil
			local isGateway = nil
			local roomMenu  = nil

			if properties[i].entering then
				entering = json.decode(properties[i].entering)
			end

			if properties[i].exit then
				exit = json.decode(properties[i].exit)
			end

			if properties[i].inside then
				inside = json.decode(properties[i].inside)
			end

			if properties[i].outside then
				outside = json.decode(properties[i].outside)
			end

			if properties[i].is_single == 0 then
				isSingle = false
			else
				isSingle = true
			end

			if properties[i].is_room == 0 then
				isRoom = false
			else
				isRoom = true
			end

			if properties[i].is_gateway == 0 then
				isGateway = false
			else
				isGateway = true
			end

			if properties[i].room_menu then
				roomMenu = json.decode(properties[i].room_menu)
			end

			table.insert(Config.Properties, {
				name      = properties[i].name,
				label     = properties[i].label,
				entering  = entering,
				exit      = exit,
				inside    = inside,
				outside   = outside,
				ipls      = json.decode(properties[i].ipls),
				gateway   = properties[i].gateway,
				isSingle  = isSingle,
				isRoom    = isRoom,
				isGateway = isGateway,
				roomMenu  = roomMenu,
				price     = properties[i].price
			})
		end

		TriggerClientEvent('esx_property:sendProperties', -1, Config.Properties)
	end)
end)

ESX.RegisterServerCallback('esx_property:getProperties', function(source, cb)
	cb(Config.Properties)
end)

AddEventHandler('esx_ownedproperty:getOwnedProperties', function(cb)
	MySQL.Async.fetchAll('SELECT * FROM owned_properties', {}, function(result)
		local properties = {}

		for i=1, #result, 1 do
			table.insert(properties, {
				id     = result[i].id,
				name   = result[i].name,
				label  = GetProperty(result[i].name).label,
				price  = result[i].price,
				rented = (result[i].rented == 1 and true or false),
				owner  = result[i].owner
			})
		end

		cb(properties)
	end)
end)

AddEventHandler('esx_property:setPropertyOwned', function(name, price, rented, owner)
	SetPropertyOwned(name, price, rented, owner)
end)

AddEventHandler('esx_property:removeOwnedProperty', function(name, owner)
	RemoveOwnedProperty(name, owner)
end)

RegisterNetEvent('esx_property:rentProperty')
AddEventHandler('esx_property:rentProperty', function(propertyName)
	local xPlayer  = ESX.GetPlayerFromId(source)
	local property = GetProperty(propertyName)
	local rent     = ESX.Math.Round(property.price / Config.RentModifier)

	SetPropertyOwned(propertyName, rent, true, xPlayer.identifier)
end)

RegisterNetEvent('esx_property:buyProperty')
AddEventHandler('esx_property:buyProperty', function(propertyName)
	local xPlayer  = ESX.GetPlayerFromId(source)
	local property = GetProperty(propertyName)

	if property.price <= xPlayer.getMoney() then
		xPlayer.removeMoney(property.price)
		SetPropertyOwned(propertyName, property.price, false, xPlayer.identifier)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = '現金不足'})
	end
end)

RegisterNetEvent('esx_property:removeOwnedProperty')
AddEventHandler('esx_property:removeOwnedProperty', function(propertyName)
	local xPlayer = ESX.GetPlayerFromId(source)
	RemoveOwnedProperty(propertyName, xPlayer.identifier)
end)

AddEventHandler('esx_property:removeOwnedPropertyIdentifier', function(propertyName, identifier)
	RemoveOwnedProperty(propertyName, identifier)
end)

RegisterNetEvent('esx_property:saveLastProperty')
AddEventHandler('esx_property:saveLastProperty', function(property)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE users SET last_property = @last_property WHERE identifier = @identifier', {
		['@last_property'] = property,
		['@identifier']    = xPlayer.identifier
	})
end)

RegisterNetEvent('esx_property:deleteLastProperty')
AddEventHandler('esx_property:deleteLastProperty', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE users SET last_property = NULL WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	})
end)

RegisterNetEvent('esx_property:getItem')
AddEventHandler('esx_property:getItem', function(owner, type, item, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayerOwner = ESX.GetPlayerFromIdentifier(owner)

	if type == 'item_standard' then
		TriggerEvent('esx_addoninventory:getInventory', 'property', xPlayerOwner.identifier, function(inventory)
			local inventoryItem = inventory.getItem(item)

			-- is there enough in the property?
			if count > 0 and inventoryItem.count >= count then
				-- can the player carry the said amount of x item?
				if xPlayer.canCarryItem(item, count) then
					inventory.removeItem(item, count)
					xPlayer.addInventoryItem(item, count)
					TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = count .. inventoryItem.label})
					TriggerEvent('esx_joblogs:AddInLog', "house", "geti", xPlayer.name,count,inventoryItem.label)
				else
					TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = '過重'})
				end
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = '數量錯誤'})
			end
		end)
	elseif type == 'item_account' then
		TriggerEvent('esx_addonaccount:getAccount', 'property_' .. item, xPlayerOwner.identifier, function(account)
			if account.money >= count then
				account.removeMoney(count)
				xPlayer.addAccountMoney(item, count)
				TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = '$' .. count})
				TriggerEvent('esx_joblogs:AddInLog', "house", "getm", xPlayer.name,count)
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = '數量錯誤'})
			end
		end)
	elseif type == 'item_weapon' then
		TriggerEvent('esx_datastore:getDataStore', 'property', xPlayerOwner.identifier, function(store)
			local storeWeapons = store.get('weapons') or {}
			local weaponName   = nil
			local ammo         = nil

			for i=1, #storeWeapons, 1 do
				if storeWeapons[i].name == item then
					weaponName = storeWeapons[i].name
					ammo       = storeWeapons[i].ammo

					table.remove(storeWeapons, i)
					break
				end
			end

			store.set('weapons', storeWeapons)
			xPlayer.addWeapon(weaponName, ammo)
			TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = ESX.GetWeaponLabel(weaponName)})
			TriggerEvent('esx_joblogs:AddInLog', "house", "getw", xPlayer.name,ESX.GetWeaponLabel(weaponName),ammo)
		end)
	end
end)

RegisterNetEvent('esx_property:putItem')
AddEventHandler('esx_property:putItem', function(owner, type, item, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayerOwner = ESX.GetPlayerFromIdentifier(owner)

	if type == 'item_standard' then
		local playerItemCount = xPlayer.getInventoryItem(item).count

		if playerItemCount >= count and count > 0 then
			TriggerEvent('esx_addoninventory:getInventory', 'property', xPlayerOwner.identifier, function(inventory)
				xPlayer.removeInventoryItem(item, count)
				inventory.addItem(item, count)
				TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = count .. inventory.getItem(item).label})
				TriggerEvent('esx_joblogs:AddInLog', "house", "pulli", xPlayer.name,count,inventory.getItem(item).label)
			end)
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = '數量錯誤'})
		end
	elseif type == 'item_account' then
		if xPlayer.getAccount(item).money >= count and count > 0 then
			xPlayer.removeAccountMoney(item, count)
			TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = '$' .. count})
			TriggerEvent('esx_joblogs:AddInLog', "house", "pullm", xPlayer.name,count)
			TriggerEvent('esx_addonaccount:getAccount', 'property_' .. item, xPlayerOwner.identifier, function(account)
				account.addMoney(count)
			end)
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = '數量錯誤'})
		end
	elseif type == 'item_weapon' then
		if xPlayer.hasWeapon(item) then
			xPlayer.removeWeapon(item)

			TriggerEvent('esx_datastore:getDataStore', 'property', xPlayerOwner.identifier, function(store)
				local storeWeapons = store.get('weapons') or {}

				table.insert(storeWeapons, {
					name = item,
					ammo = count
				})

				store.set('weapons', storeWeapons)
			end)
			TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = count .. ESX.GetWeaponLabel(item)})
			TriggerEvent('esx_joblogs:AddInLog', "house", "pullw", xPlayer.name,ESX.GetWeaponLabel(item),count)
		end
	end
end)

ESX.RegisterServerCallback('esx_property:getOwnedProperties', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT name, rented FROM owned_properties WHERE owner = @owner', {
		['@owner'] = xPlayer.identifier
	}, function(result)
		cb(result)
	end)
end)

ESX.RegisterServerCallback('esx_property:getLastProperty', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT last_property FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(users)
		cb(users[1].last_property)
	end)
end)

ESX.RegisterServerCallback('esx_property:getPropertyInventory', function(source, cb, owner)
	local xPlayer    = ESX.GetPlayerFromIdentifier(owner)
    local blackMoney = 0
    local money = 0
    local items      = {}
    local weapons    = {}

    TriggerEvent('esx_addonaccount:getAccount', 'property_black_money', xPlayer.identifier, function(account)
        blackMoney = account.money
    end)

    TriggerEvent('esx_addonaccount:getAccount', 'property_money', xPlayer.identifier, function(account)
        money = account.money
    end)

    TriggerEvent('esx_addoninventory:getInventory', 'property', xPlayer.identifier, function(inventory)
        items = inventory.items
    end)

    TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
        weapons = store.get('weapons') or {}
    end)

    cb({
        blackMoney = blackMoney,
        items      = items,
        money = money,
        weapons    = weapons
    })
end)

ESX.RegisterServerCallback('esx_property:getPlayerInventory', function(source, cb)
    local xPlayer    = ESX.GetPlayerFromId(source)
    local blackMoney = xPlayer.getAccount('black_money').money
    local money = xPlayer.getAccount('money').money
    local items      = xPlayer.inventory

    cb({
        blackMoney = blackMoney,
        items      = items,
        money = money,
        weapons    = xPlayer.getLoadout()
    })
end)

ESX.RegisterServerCallback('esx_property:getPlayerDressing', function(source, cb)
	local xPlayer  = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		local count  = store.count('dressing')
		local labels = {}

		for i=1, count, 1 do
			local entry = store.get('dressing', i)
			table.insert(labels, entry.label)
		end

		cb(labels)
	end)
end)

ESX.RegisterServerCallback('esx_property:getPlayerOutfit', function(source, cb, num)
	local xPlayer  = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		local outfit = store.get('dressing', num)
		cb(outfit.skin)
	end)
end)

RegisterNetEvent('esx_property:removeOutfit')
AddEventHandler('esx_property:removeOutfit', function(label)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		local dressing = store.get('dressing') or {}

		table.remove(dressing, label)
		store.set('dressing', dressing)
	end)
end)
