ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local activity = 0
local activitySource = 0
local cooldown = 0

RegisterServerEvent('esx_carthief:pay')
AddEventHandler('esx_carthief:pay', function(payment)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()
	local num = math.random(1,3)

	if num == 1 then
		xPlayer.addInventoryItem('laptop_h', 1)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '走私成功'})
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '筆記型電腦'})
		TriggerEvent('esx_joblogs:AddInLog', "crime", "carthief", xPlayer.name,'筆記型電腦')
	elseif num == 2 then
		local count = math.random(1,2)
		xPlayer.addInventoryItem('thermal_charge', count)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '走私成功'})
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = count .. '鋁熱炸藥'})
		TriggerEvent('esx_joblogs:AddInLog', "crime", "carthief", xPlayer.name,count .. '鋁熱炸藥')
	elseif num == 3 then
		local count = math.random(15,20)
		xPlayer.addInventoryItem('weed_pooch', count)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '走私成功'})
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = count .. '包裝大麻'})
		TriggerEvent('esx_joblogs:AddInLog', "crime", "carthief", xPlayer.name,count .. '包裝大麻')
	end

	cooldown = Config.CooldownMinutes * 60000
end)

ESX.RegisterServerCallback('esx_carthief:anycops',function(source, cb)
	local anycops = 0
	local playerList = ESX.GetPlayers()
	for i=1, #playerList, 1 do
		local _source = playerList[i]
		local xPlayer = ESX.GetPlayerFromId(_source)
		local playerjob = xPlayer.job.name
		if playerjob == 'police' then
			anycops = anycops + 1
		end
	end
	cb(anycops)
	local xPlayer = ESX.GetPlayerFromId(source)
	if anycops >= Config.CopsRequired then
		TriggerClientEvent('chat:addMessage', -1, {
            template = '<div style="padding: 10px; margin: 10px; background-color: rgba(50, 50, 200, 1.0); border-radius: 25px;"><i class="fas fa-bell"style="font-size:15px"></i>{0}:{1}</font></i></b></div>',
            args = { "🚔 ^7警政署", '目前走活動進行中，請市民注意行車安全。若經警方勸導不離者，將帶回警局偵辦' }
		})
		TriggerEvent('esx_joblogs:AddInLog', "crime", "startcarthief", xPlayer.name .. '開始走私')
	end
end)

ESX.RegisterServerCallback('esx_carthief:isActive',function(source, cb)
  cb(activity, cooldown)
end)

RegisterServerEvent('esx_carthief:registerActivity')
AddEventHandler('esx_carthief:registerActivity', function(value)
	activity = value
	if value == 1 then
		activitySource = source
		--Send notification to cops
		local xPlayers = ESX.GetPlayers()
		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			if xPlayer.job.name == 'police' then
				TriggerClientEvent('esx_carthief:setcopnotification', xPlayers[i])
			end
		end
	else
		activitySource = 0
	end
end)

RegisterServerEvent('esx_carthief:alertcops')
AddEventHandler('esx_carthief:alertcops', function(cx,cy,cz)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('esx_carthief:setcopblip', xPlayers[i], cx,cy,cz)
		end
	end
end)

RegisterServerEvent('esx_carthief:stopalertcops')
AddEventHandler('esx_carthief:stopalertcops', function()
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('esx_carthief:removecopblip', xPlayers[i])
		end
	end
	cooldown = (Config.CooldownMinutes / 2) * 60000
end)

AddEventHandler('playerDropped', function ()
	local _source = source
	if _source == activitySource then
		--Remove blip for all cops
		local xPlayers = ESX.GetPlayers()
		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			if xPlayer.job.name == 'police' then
				TriggerClientEvent('esx_carthief:removecopblip', xPlayers[i])
			end
		end
		--Set activity to 0
		activity = 0
		activitySource = 0
	end
end)

--Cooldown manager
AddEventHandler('onResourceStart', function(resource)
	while true do
		Wait(5000)
		if cooldown > 0 then
			cooldown = cooldown - 5000
		end
	end
end)
