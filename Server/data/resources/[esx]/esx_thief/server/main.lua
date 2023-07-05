ESX = nil
local Users = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_thief:getValue', function(source, cb, targetSID)
	if Users[targetSID] then
		cb(Users[targetSID])
	else
		cb({value = false, time = 0})
	end
end)

ESX.RegisterServerCallback('esx_thief:getOtherPlayerData', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)

	TriggerClientEvent('mythic_notify:client:SendAlert', target, { type = 'error', text = '背包被打開'})

	local data = {
		name = GetPlayerName(target),
		inventory = xPlayer.inventory,
		accounts = xPlayer.accounts,
		money = xPlayer.getMoney()
	}

	cb(data)
end)

RegisterServerEvent('esx_thief:stealPlayerItem')
AddEventHandler('esx_thief:stealPlayerItem', function(target, itemType, itemName, amount)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	

	if itemType == 'item_standard' then

		local label = sourceXPlayer.getInventoryItem(itemName).label
		local sourceItemCount = sourceXPlayer.getInventoryItem(itemName).count
		local targetItemCount = targetXPlayer.getInventoryItem(itemName).count

		if amount > 0 and targetItemCount >= amount then
				targetXPlayer.removeInventoryItem(itemName, amount)
				sourceXPlayer.addInventoryItem(itemName, amount)

				TriggerClientEvent('mythic_notify:client:SendAlert', sourceXPlayer.source, { type = 'success', text = ''.. amount .. label})
				TriggerClientEvent('mythic_notify:client:SendAlert', targetXPlayer.source, { type = 'error', text = ''.. amount .. label})
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', sourceXPlayer.source, { type = 'error', text = '數量錯誤'})
		end

	elseif itemType == 'item_money' then

		if amount > 0 and targetXPlayer.getAccount('money') >= amount then
			targetXPlayer.removeMoney(amount)
			sourceXPlayer.addMoney(amount)

			TriggerClientEvent('mythic_notify:client:SendAlert', sourceXPlayer.source, { type = 'success', text = '$' .. amount})
			TriggerClientEvent('mythic_notify:client:SendAlert', targetXPlayer.source, { type = 'error', text = '$' .. amount})
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', sourceXPlayer.source, { type = 'error', text = '數量錯誤'})
		end

	elseif itemType == 'item_account' then

		if amount > 0 and targetXPlayer.getAccount(itemName).money >= amount then
			targetXPlayer.removeAccountMoney(itemName, amount)
			sourceXPlayer.addAccountMoney(itemName, amount)

			TriggerClientEvent('mythic_notify:client:SendAlert', sourceXPlayer.source, { type = 'success', text = '$' .. amount})
			TriggerClientEvent('mythic_notify:client:SendAlert', targetXPlayer.source, { type = 'error', text = '$' .. amount})
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', sourceXPlayer.source, { type = 'error', text = '數量錯誤'})
		end

	end
end)

RegisterServerEvent('esx_thief:update')
AddEventHandler('esx_thief:update', function(bool)
	local _source = source
	Users[_source] = {value = bool, time = os.time()}
end)

RegisterServerEvent('esx_thief:getValue')
AddEventHandler('esx_thief:getValue', function(targetSID)
	local _source = source
	if Users[targetSID] then
		TriggerClientEvent('esx_thief:returnValue', _source, Users[targetSID])
	else
		TriggerClientEvent('esx_thief:returnValue', _source, Users[targetSID])
	end
end)