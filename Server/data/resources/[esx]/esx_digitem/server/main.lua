ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_dig:checkTool', function(source, cb, needTool)
	local xPlayer = ESX.GetPlayerFromId(source)
	local toolQuantity = xPlayer.getInventoryItem(needTool).count
	if toolQuantity > 0 then
		cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('esx_dig:startDig')
AddEventHandler('esx_dig:startDig', function(breakToolPercent, ItemsTable, toolLabel, needTool)
	local ranItem = math.random(1, #ItemsTable)
	local digItem = ItemsTable[ranItem]
	local xPlayer = ESX.GetPlayerFromId(source)

	local ranBreak = math.random(1, 20)
	if ranBreak <= breakToolPercent then
		xPlayer.removeInventoryItem(needTool, 1)
		TriggerClientEvent('esx_digitem:sound',source)
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = '工具損毀'})
	end

	if digItem[2] == 1 then
		local chance = math.random(0,2)
		local count = math.random(1,3)
		local soil = math.random(2,4)
		if chance == 0 then
			xPlayer.addInventoryItem(digItem[1], count)
			TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = count .. digItem[3]})
		else
			xPlayer.addInventoryItem('soil', soil)
			TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = soil .. '泥土'})
		end

	elseif digItem[2] == 2 then
		local count = math.random(0,10)
		if count >= 3 then
			xPlayer.addInventoryItem(digItem[1], 1)
			TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = '1' .. digItem[3]})
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = '空'})
		end
	end
end)
