local rob = false
local robbers = {}
PlayersCrafting    = {}
local CopsConnected  = 0
local alljewels  = 0
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

function CountCops()

	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0
	coppay = 1

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			CopsConnected = CopsConnected + 1
			coppay = coppay + 0.5
		end
	end

	SetTimeout(1 * 1000, CountCops)
end

CountCops()

RegisterServerEvent('esx_vangelico_robbery:toofar')
AddEventHandler('esx_vangelico_robbery:toofar', function(robb)
	local source = source
	local xPlayers = ESX.GetPlayers()
	rob = false

	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		 if xPlayer.job.name == 'police' then
			TriggerClientEvent('esx_vangelico_robbery:killblip', xPlayers[i])
		end
	end

	if(robbers[source])then
		TriggerClientEvent('esx_vangelico_robbery:toofarlocal', source)
		robbers[source] = nil
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '搶劫失敗'})
	end
	
	TriggerEvent('esx_joblogs:AddInLog', "crime", "jewels", xPlayer.name,alljewels)
end)

RegisterServerEvent('esx_vangelico_robbery:endrob')
AddEventHandler('esx_vangelico_robbery:endrob', function(robb)
	local source = source
	local xPlayers = ESX.GetPlayers()
	rob = false

	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' then
			TriggerClientEvent('esx_vangelico_robbery:killblip', xPlayers[i])
		end
	end

	if(robbers[source])then
		TriggerClientEvent('esx_vangelico_robbery:robberycomplete', source)
		robbers[source] = nil
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '搶劫成功'})
	end

	TriggerEvent('esx_joblogs:AddInLog', "crime", "jewels", xPlayer.name,alljewels)
end)

RegisterServerEvent('esx_vangelico_robbery:rob')
AddEventHandler('esx_vangelico_robbery:rob', function(robb)

	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()

	if Stores[robb] then

		local store = Stores[robb]

		if (os.time() - store.lastrobbed) < Config.SecBetwNextRob and store.lastrobbed ~= 0 then

            TriggerClientEvent('esx_vangelico_robbery:togliblip', source)
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '補貨中'})
			return
		end

		if rob == false then

			rob = true
			for i=1, #xPlayers, 1 do
				local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
				if xPlayer.job.name == 'police' then
					TriggerClientEvent('esx_vangelico_robbery:setblip', xPlayers[i], Stores[robb].position)
				end
			end
			TriggerClientEvent('chat:addMessage', -1, {
				template = '<div style="padding: 10px; margin: 10px; background-color: rgba(50, 50, 200, 1.0); border-radius: 25px;"><i class="fas fa-bell"style="font-size:15px"></i>{0}:{1}</font></i></b></div>',
				args = { "🚔 ^7警政署", '目前珠寶搶劫進行中，市民請勿靠近。若經警方勸導不離者，將帶回警局偵辦' }
			})
			TriggerClientEvent('esx_vangelico_robbery:currentlyrobbing', source, robb)
            CancelEvent()
			Stores[robb].lastrobbed = os.time()
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = '搶劫進行中'})
		end
	end
end)

RegisterServerEvent('esx_vangelico_robbery:gioielli')
AddEventHandler('esx_vangelico_robbery:gioielli', function()

	local xPlayer = ESX.GetPlayerFromId(source)
	local count = math.random(Config.MinJewels, Config.MaxJewels)

	xPlayer.addInventoryItem('jewels', count)
	alljewels = alljewels + count
end)

RegisterServerEvent('esx_vangelico_robbery:laptop')
AddEventHandler('esx_vangelico_robbery:laptop', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('laptop_h', 1)
end)

RegisterServerEvent('lester:sellgold')
AddEventHandler('lester:sellgold', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	gold = xPlayer.getInventoryItem('gold_bar').count
	total = gold * math.random(25000,30000)

	if gold ~= 0 then
		xPlayer.removeInventoryItem('gold_bar',gold)
		xPlayer.addMoney(total)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = gold .. '個'})
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '$' .. total})
		TriggerEvent('esx_joblogs:AddInLog', "crime", "sellgold", xPlayer.name,gold,total)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '無黃金'})
	end

end)

RegisterServerEvent('lester:vendita')
AddEventHandler('lester:vendita', function()

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	local jewel = xPlayer.getInventoryItem('jewels').count
	local dia_box = xPlayer.getInventoryItem('dia_box').count
	local jewels = jewel * math.random(15000,25000)
	local dia_boxs = dia_box * math.random(35000,50000)

	if jewels ~= 0 then
		xPlayer.removeInventoryItem('jewels',jewels)
		xPlayer.addMoney(jewels)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = jewel .. '個'})
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '$' .. jewels})
		TriggerEvent('esx_joblogs:AddInLog', "crime", "selljewels", xPlayer.name,jewel,jewels)
	elseif dia_box ~= 0 then
		xPlayer.removeInventoryItem('dia_box',jewels)
		xPlayer.addMoney(dia_boxs)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = dia_box .. '個'})
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '$' .. dia_boxs})
		TriggerEvent('esx_joblogs:AddInLog', "crime", "selldia", xPlayer.name,dia_box,dia_boxs)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '無物品'})
	end

end)

ESX.RegisterServerCallback('esx_vangelico_robbery:conteggio', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb(CopsConnected)
end)

ESX.RegisterServerCallback('esx_vangelico_robbery:looptop', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	looptop = xPlayer.getInventoryItem('laptop_h').count
	cb(looptop)
end)
