ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_tgo_watercoolers:refillThirst')
AddEventHandler('esx_tgo_watercoolers:refillThirst', function()
	
	local xPlayer = ESX.GetPlayerFromId(source)
	local bottle = xPlayer.getInventoryItem('paperbottle').count

	if bottle ~= 0 then
		TriggerClientEvent('esx_status:add', source, 'thirst', 1000)
		local a = math.random(1,10)
		if a <= 3 then
			xPlayer.removeInventoryItem('paperbottle', 1)
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '紙杯'})
		end
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '喝水'})
			TriggerClientEvent('esx_tgo_watercoolers:onDrink', source)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '需要紙杯'})
	end
end)

ESX.RegisterUsableItem('paperwater', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local a = math.random(1,10)

	xPlayer.removeInventoryItem('paperwater', 1)
	xPlayer.addInventoryItem('paperbottle', 1)
	TriggerClientEvent('esx_status:add', source, 'thirst', 1000)
	TriggerClientEvent('esx_tgo_watercoolers:onDrink', source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '裝水紙杯'})

	if a <= 3 then
		xPlayer.removeInventoryItem('paperbottle', 1)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '紙杯'})
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '紙杯'})
	end
end)

RegisterServerEvent('esx_tgo_watercoolers:getcola')
AddEventHandler('esx_tgo_watercoolers:getcola', function()
	
	local xPlayer = ESX.GetPlayerFromId(source)
	local money = xPlayer.getMoney()
	local mun = math.random(0,5)
	local item = nil

	if mun == 0 then
		item = "cola"
	elseif mun == 1 then
		item = "drpepper"
	elseif mun == 2 then
		item = "fanta"
	elseif mun == 3 then
		item = "heysong"
	elseif mun == 4 then
		item = "pepsi"
	else
		item = "sprite"
	end

	if money >= 250 then
		TriggerClientEvent('esx_tgo_watercoolers:point', source)
		xPlayer.removeMoney(250)
		xPlayer.addInventoryItem(item, 1)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = ESX.GetItemLabel(item)})
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '$250'})
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '現金不足'})
	end
end)