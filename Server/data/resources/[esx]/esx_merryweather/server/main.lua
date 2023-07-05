local rob = false
local robbers = {}
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_customrob:tooFar')
AddEventHandler('esx_customrob:tooFar', function()
	local _source = source
	local xPlayers = ESX.GetPlayers()
	rob = false

	if robbers[_source] then
		TriggerClientEvent('esx_customrob:tooFar', _source)
		robbers[_source] = nil
		TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'success', text = '太遠了'})
	end
end)

RegisterServerEvent('esx_customrob:robberyStarted')
AddEventHandler('esx_customrob:robberyStarted', function(currentStore)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()

	if Stores[currentStore] then
		local store = Stores[currentStore]

		if (os.time() - store.lastRobbed) < Config.TimerBeforeNewRob and store.lastRobbed ~= 0 then
			TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'error', text = '尚無貨物'})
			return
		end

		if not rob then
			rob = true

			TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'success', text = '呼叫成功'})
			TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'error', text = '$300000'})
			TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'inform', text = '防守這裡!'})
			TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'inform', text = '等待空投掉落!'})
			TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'inform', text = '拿到貨物前不要離開!'})
			TriggerClientEvent('esx_customrob:currentlyRobbing', _source, currentStore)
			TriggerClientEvent('esx_customrob:startTimer', _source)
			xPlayer.removeAccountMoney('black_money',300000)
		end
	end
end)

RegisterServerEvent('esx_customrob:giveitem')
AddEventHandler('esx_customrob:giveitem', function()
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)

	xPlayer.addInventoryItem("ironbox",1)
	TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'success', text = '鐵箱'})
	TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'inform', text = '快離開!'})
end)

ESX.RegisterServerCallback('esx_customrob:cheakmoney', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local money = xPlayer.getAccount('black_money').money

    if money >= 300000 then
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent('esx_customrob:note')
AddEventHandler('esx_customrob:note', function()
	local xPlayers = ESX.GetPlayers()
	for i = 1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name ~= 'police' and  xPlayer.job.name ~= 'ambulance' then
			if xPlayer.getInventoryItem('receiver').count >= 1 then
				TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = '空投警報',length = 5000 })
				break
			end
		end
	end
end)