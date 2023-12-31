ESX = nil
local shopItems = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

MySQL.ready(function()

	MySQL.Async.fetchAll('SELECT * FROM weashops', {}, function(result)
		for i=1, #result, 1 do
			if shopItems[result[i].zone] == nil then
				shopItems[result[i].zone] = {}
			end

			table.insert(shopItems[result[i].zone], {
				item  = result[i].item,
				price = result[i].price,
				label = ESX.GetWeaponLabel(result[i].item),
				imglink = result[i].imglink
			})
		end

		TriggerClientEvent('esx_weaponshop:sendShop', -1, shopItems)
	end)

end)

ESX.RegisterServerCallback('esx_weaponshop:getShop', function(source, cb)
	cb(shopItems)
end)

ESX.RegisterServerCallback('esx_weaponshop:buyLicense', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= Config.LicensePrice then
		xPlayer.removeMoney(Config.LicensePrice)

		TriggerEvent('esx_license:addLicense', source, 'weapon', function()
			cb(true)
		end)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = '現金不足', length = 2500, style = { ['background-color'] = '#2f5c73', ['color'] = '#FFFFFF' } })
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_weaponshop:buyWeapon', function(source, cb, weaponName, zone)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = GetPrice(weaponName, zone)

	if price == 0 then
		cb(false)
	else
		if xPlayer.hasWeapon(weaponName) then
			TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = '已經擁有此武器', length = 2500, style = { ['background-color'] = '#2f5c73', ['color'] = '#FFFFFF' } })
			cb(false)
		else
			if zone == 'BlackWeashop' then
				if xPlayer.getAccount('black_money').money >= price then
					xPlayer.removeAccountMoney('black_money', price)
					xPlayer.addWeapon(weaponName, 42)
					TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = '$' ..price, length = 2500, style = { ['background-color'] = '#2f5c73', ['color'] = '#FFFFFF' } })
					TriggerEvent('esx_joblogs:AddInLog', "weapon", "buyw", xPlayer.name, ESX.GetWeaponLabel(weaponName),price)
					cb(true)
				else
					TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = '黑錢不足', length = 2500, style = { ['background-color'] = '#2f5c73', ['color'] = '#FFFFFF' } })
					cb(false)
				end
			else
				if xPlayer.getMoney() >= price then
					xPlayer.removeMoney(price)
					xPlayer.addWeapon(weaponName, 42)
					TriggerEvent('esx_joblogs:AddInLog', "weapon", "buyw", xPlayer.name, ESX.GetWeaponLabel(weaponName),price)
					cb(true)
				else
					TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = '現金不足', length = 2500, style = { ['background-color'] = '#2f5c73', ['color'] = '#FFFFFF' } })
					cb(false)
				end
			end
		end
	end
end)

function GetPrice(weaponName, zone)
	local price = MySQL.Sync.fetchScalar('SELECT price FROM weashops WHERE zone = @zone AND item = @item', {
		['@zone'] = zone,
		['@item'] = weaponName
	})

	if price then
		return price
	else
		return 0
	end
end
