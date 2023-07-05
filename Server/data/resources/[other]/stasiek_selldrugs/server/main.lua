ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('sellDrugs')
AddEventHandler('sellDrugs', function()
	local _source = source
	local xPlayers = ESX.GetPlayers()
	local xPlayer = ESX.GetPlayerFromId(_source)
	local weeds = xPlayer.getInventoryItem('weed_pooch').count
	local blackMoney = Config.WeedPrice
	local num = 0

	local copspay = 1
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' then
			copspay = copspay + 0.2
		end
	end

	if weeds >= 5 then
		num = math.random(1,5)
	else
		num = weeds
	end

	local finalpay = copspay * blackMoney * num

	TriggerClientEvent('sold', _source)
	xPlayer.removeInventoryItem("weed_pooch", num)
	xPlayer.addAccountMoney('black_money', finalpay)
	TriggerEvent('esx_joblogs:AddInLog', "drugs", "sell", xPlayer.name,num,"包裝大麻",finalpay)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '販售成功'})
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '$' .. finalpay})
end)


RegisterServerEvent('check')
AddEventHandler('check', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()
	local weedqty = xPlayer.getInventoryItem('weed_pooch').count
	local weedqtySingle = xPlayer.getInventoryItem('weed').count
	local cops = 0

	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' then
			cops = cops + 1
		end
	end

	if cops >= Config.CopsRequiredToSell then
		if Config.SellWeed then
			if Config.SellPooch and weedqty > 0 or Config.SellSingle and weedqtySingle > 0 then
				TriggerClientEvent('playerhasdrugs', _source)
				return
			end
		end
		TriggerClientEvent('nomoredrugs', _source)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '警察不足'})
	end
end)
