ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local activity = 0
local activitySource = 0
local cooldown = 0

RegisterServerEvent('esx_carthief1:pay')
AddEventHandler('esx_carthief1:pay', function(payment)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local ironbox = xPlayer.getInventoryItem('ironbox').count
	local box = math.random(20,30)
	local weed = xPlayer.getInventoryItem('weed_pooch').count
	local shark = xPlayer.getInventoryItem('shark').count
	local turtle = xPlayer.getInventoryItem('turtle').count
	local weeds = weed * math.random(7500,10000)
	local sharks = shark * math.random(75000,100000)
	local turtles = turtle * math.random(45000,65000)
	local finalpay = (weeds + sharks + turtles)

	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '秘密走私成功'})
	-- if ironbox == 0 then
		if weed ~= 0 then
			xPlayer.removeInventoryItem('weed_pooch', weed)
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = weed .. '包裝大麻'})
			TriggerEvent('esx_joblogs:AddInLog', "crime", "carthief", xPlayer.name,weed,'包裝大麻',weeds)
		end

		if shark ~= 0 then
			xPlayer.removeInventoryItem('shark', shark)
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = shark .. '鯊魚'})
			TriggerEvent('esx_joblogs:AddInLog', "crime", "carthief", xPlayer.name,shark,'鯊魚',sharks)
		end

		if turtle ~= 0 then
			xPlayer.removeInventoryItem('turtle', turtle)
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = turtle .. '海龜'})
			TriggerEvent('esx_joblogs:AddInLog', "crime", "carthief", xPlayer.name,turtle,'海龜',turtles)
		end

		TriggerClientEvent('esx_carthief1:boxnote',source)
		xPlayer.addAccountMoney('black_money',finalpay)
		xPlayer.addInventoryItem('box',box)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = box .. '紙箱'})
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '$' ..finalpay})
	-- else
		-- xPlayer.removeInventoryItem('ironbox', 1)
		-- xPlayer.addWeapon('weapon_assaultrifle', 60)
		-- TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '鐵箱'})
		-- TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '突擊步槍'})
		-- TriggerEvent('esx_joblogs:AddInLog', "crime", "carthief2", xPlayer.name,'鐵箱')
	-- end

	cooldown = Config.CooldownMinutes * 60 * 1000
end)

ESX.RegisterServerCallback('esx_carthief1:anycops',function(source, cb)
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
		TriggerEvent('esx_joblogs:AddInLog', "crime", "startcarthief", xPlayer.name .. '開始祕密走私')
	end
end)

ESX.RegisterServerCallback('esx_carthief1:isActive',function(source, cb)
  	cb(activity, cooldown)
end)

RegisterServerEvent('esx_carthief1:alertcops')
AddEventHandler('esx_carthief1:alertcops', function(cx,cy,cz)
	local source = source
	local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('esx_carthief1:setcopblip', xPlayers[i], cx,cy,cz)
		end
	end
end)

RegisterServerEvent('esx_carthief1:msg')
AddEventHandler('esx_carthief1:msg', function()
	TriggerClientEvent('chat:addMessage', -1, {
		template = '<div style="padding: 10px; margin: 10px; background-color: rgba(50, 50, 200, 1.0); border-radius: 25px;"><i class="fas fa-bell"style="font-size:15px"></i>{0}:{1}</font></i></b></div>',
		args = { "🚔 ^7警政署", '目前走活動進行中，請市民注意行車安全。若經警方勸導不離者，將帶回警局偵辦' }
	})
end)

RegisterServerEvent('esx_carthief1:stopalertcops')
AddEventHandler('esx_carthief1:stopalertcops', function()
	local source = source
	local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('esx_carthief1:removecopblip', xPlayers[i])
		end
	end
end)

AddEventHandler('playerDropped', function ()
	local _source = source
	if _source == activitySource then
		local xPlayers = ESX.GetPlayers()
		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			if xPlayer.job.name == 'police' then
				TriggerClientEvent('esx_carthief1:removecopblip', xPlayers[i])
			end
		end
		activity = 0
		activitySource = 0
	end
end)

AddEventHandler('onResourceStart', function(resource)
	while true do
		Wait(5000)
		if cooldown > 0 then
			cooldown = cooldown - 5000
		end
	end
end)

RegisterServerEvent('esx_carthief1:note')
AddEventHandler('esx_carthief1:note', function()
	local xPlayers = ESX.GetPlayers()
	for i = 1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.getInventoryItem('receiver').count >= 1 then
			TriggerClientEvent('esx_carthief1:setnotification', xPlayers[i])
			break
		end
	end
	activity = 1
	cooldown = Config.CooldownMinutes * 60 * 1000
end)