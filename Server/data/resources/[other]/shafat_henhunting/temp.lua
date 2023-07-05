
RegisterServerEvent('fishing:startSelling')
AddEventHandler('fishing:startSelling', function(item)

	local _source = source

	local xPlayer  = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()
	local price = 0
	local final = 0
	local amount = 0

	CopsConnected = 1

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			CopsConnected = CopsConnected + 0.2
		end
	end

	if item == "fish" then
		local fish = xPlayer.getInventoryItem('fish').count
		local polvo = xPlayer.getInventoryItem('polvo').count
		local lobster = xPlayer.getInventoryItem('lobster').count
		local turtlebait = xPlayer.getInventoryItem('turtlebait').count
		local oyster2 = xPlayer.getInventoryItem('oyster2').count

		if fish > 0 then
			if fish > 10 then
				amount = math.random(1, 10)
			else
				amount = fish
			end
			xPlayer.removeInventoryItem('fish',amount)
			price = math.random(50, 100)
			final = price * amount
			xPlayer.addMoney(final)
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = amount .. '魚$' ..final})
		end

		if turtlebait > 0 then
			if turtlebait > 10 then
				amount = math.random(1, 10)
			else
				amount = turtlebait
			end
			xPlayer.removeInventoryItem('turtlebait',amount)
			price = math.random(100, 150)
			final = price * amount
			xPlayer.addMoney(final)
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = amount .. '蝦$' ..final})
			TriggerEvent('esx_addoninventory:getSharedInventory', 'society_cozinheiro', function(inventory)
				inventory.addItem('turtlebait', amount)
			end)
		end

		if oyster2 > 0 then
			if oyster2 > 10 then
				amount = math.random(1, 10)
			else
				amount = oyster2
			end
			xPlayer.removeInventoryItem('oyster2',amount)
			price = math.random(500, 700)
			final = price * amount
			xPlayer.addMoney(final)
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = amount .. '牡蠣肉$' ..final})
			TriggerEvent('esx_addoninventory:getSharedInventory', 'society_cozinheiro', function(inventory)
				inventory.addItem('oyster2', amount)
			end)
		end

		if polvo > 0 then
			if polvo > 10 then
				amount = math.random(1, 10)
			else
				amount = polvo
			end
			xPlayer.removeInventoryItem('polvo',amount)
			price = math.random(750, 950)
			final = price * amount
			xPlayer.addMoney(final)
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = amount .. '生章魚$' ..final})
			TriggerEvent('esx_addoninventory:getSharedInventory', 'society_cozinheiro', function(inventory)
				inventory.addItem('polvo', amount)
			end)
		end

		if lobster > 0 then
			if lobster > 10 then
				amount = math.random(1, 10)
			else
				amount = lobster
			end
			xPlayer.removeInventoryItem('lobster',amount)
			price = math.random(850, 1200)
			final = price * amount
			xPlayer.addMoney(final)
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = amount .. '龍蝦$' ..final})
			TriggerEvent('esx_addoninventory:getSharedInventory', 'society_cozinheiro', function(inventory)
				inventory.addItem('lobster', amount)
			end)
		end
	end

	if item == "pearl" then
		local FishQuantity = xPlayer.getInventoryItem('pearl').count

		if FishQuantity <= 0 then
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '數量不足'})		
		else
			xPlayer.removeInventoryItem('pearl', 1)
			price = math.random(5000, 7500)

			xPlayer.addMoney(price)
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '珍珠$' ..price})
		end
	end

	if item == "turtle" then
		local FishQuantity = xPlayer.getInventoryItem('turtle').count

		if FishQuantity <= 0 then
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '數量不足'})		
		else   
			xPlayer.removeInventoryItem('turtle', 1)
			price = math.random(Config.TurtlePrice.a, Config.TurtlePrice.b)
			final = price * CopsConnected

			xPlayer.addAccountMoney('black_money', final)
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '1隻海龜'})
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '$' ..final})
		end
	end

	if item == "shark" then
		local FishQuantity = xPlayer.getInventoryItem('shark').count

		if FishQuantity <= 0 then
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '數量不足'})
		else
			xPlayer.removeInventoryItem('shark', 1)
			price = math.random(Config.SharkPrice.a, Config.SharkPrice.b)
			final = price * CopsConnected

			xPlayer.addAccountMoney('black_money', final)
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '1隻鯊魚'})
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '$' ..final})

		end
	end
end)

RegisterServerEvent("fish:crafting")
AddEventHandler("fish:crafting", function(item)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local num = 0

	if item == "fishmeat" then
		if xPlayer.getInventoryItem("fish").count > 0 then
			num = math.random(2,5)
			xPlayer.removeInventoryItem("fish",1)
			xPlayer.addInventoryItem("fishmeat",num)
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '1條魚'})
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = num .. '魚肉塊'})
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '無生魚'})
		end
	elseif item == "shrimp" then
		if xPlayer.getInventoryItem("turtlebait").count > 0 then
			xPlayer.removeInventoryItem("turtlebait",1)
			xPlayer.addInventoryItem("shrimp",1)
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '1隻蝦'})
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '1隻蝦仁'})
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '無蝦'})
		end
	elseif item == "turtlemeat" then
		if xPlayer.getInventoryItem("turtle").count > 0 then
			num = math.random(2,4)
			xPlayer.removeInventoryItem("turtle",1)
			xPlayer.addInventoryItem("turtlemeat",num)
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '1隻海龜'})
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = num .. '海龜肉'})
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '無海龜'})
		end
	else
		if xPlayer.getInventoryItem("shark").count > 0 then
			num = math.random(1,3)
			xPlayer.removeInventoryItem("shark",1)
			xPlayer.addInventoryItem("sharkfin",num)
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '1隻鯊魚'})
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = num .. '魚翅'})
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '無鯊魚'})
		end
	end
end)