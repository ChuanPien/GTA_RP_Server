local rob = false
local robbers = {}
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_holdup:tooFar')
AddEventHandler('esx_holdup:tooFar', function(currentStore)
	local _source = source
	local xPlayers = ESX.GetPlayers()
	rob = false

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('esx_holdup:killBlip', xPlayers[i])
		end
	end

	if robbers[_source] then
		TriggerClientEvent('esx_holdup:tooFar', _source)
		robbers[_source] = nil
		TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = '搶劫失敗'})
		-- TriggerClientEvent('esx:showNotification', _source, _U('robbery_cancelled_at', Stores[currentStore].nameOfStore))
	end
end)

RegisterServerEvent('esx_holdup:robberyStarted')
AddEventHandler('esx_holdup:robberyStarted', function(currentStore)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()

	if Stores[currentStore] then
		local store = Stores[currentStore]

		if (os.time() - store.lastRobbed) < Config.TimerBeforeNewRob and store.lastRobbed ~= 0 then
			TriggerClientEvent('mythic_notify:client:SendAlert', xPlayers.source, { type = 'inform', text = '補鈔中'})
			return
		end

		local cops = 0
		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			if xPlayer.job.name == 'police' then
				cops = cops + 1
			end
		end

		if not rob then
			if cops >= Config.PoliceNumberRequired then
				rob = true

				for i=1, #xPlayers, 1 do
					local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
					if xPlayer.job.name == 'police' then
						TriggerClientEvent('esx_holdup:setBlip', xPlayers[i], Stores[currentStore].position)
					end
				end

				TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = '開始搶劫'})
				TriggerClientEvent('chat:addMessage', -1, {
					template = '<div style="padding: 10px; margin: 10px; background-color: rgba(50, 50, 200, 1.0); border-radius: 25px;"><i class="fas fa-bell"style="font-size:15px"></i>{0}:{1}</font></i></b></div>',
					args = { "🚔 ^7警政署", '目前搶劫' .. store.nameOfStore .. '進行中，市民請勿靠近。若經警方勸導不離者，將帶回警局偵辦' }
				})
				data = {dispatchCode = 'holdup', caller = _U('caller_local'), coords = Stores[currentStore].position, netId = NetworkGetNetworkIdFromEntity(playerPed), length = 10000}
				TriggerEvent('wf-alerts:svNotify',data)

				TriggerClientEvent('esx_holdup:currentlyRobbing', _source, currentStore)
				TriggerClientEvent('esx_holdup:startTimer', _source)
				
				Stores[currentStore].lastRobbed = os.time()
				robbers[_source] = currentStore

				SetTimeout(store.secondsRemaining * 1000, function()
					if robbers[_source] then
						rob = false
						if xPlayer then
							TriggerClientEvent('esx_holdup:robberyComplete', _source, store.reward)

							if Config.GiveBlackMoney then
								xPlayer.addAccountMoney('black_money', store.reward)
								TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = '$' ..store.reward})
								TriggerEvent('esx_joblogs:AddInLog', "crime", "hold", xPlayer.name,store.reward,store.nameOfStore)
							else
								xPlayer.addMoney(store.reward)
							end
							
							local xPlayers, xPlayer = ESX.GetPlayers(), nil
							for i=1, #xPlayers, 1 do
								xPlayer = ESX.GetPlayerFromId(xPlayers[i])

								if xPlayer.job.name == 'police' then
									TriggerClientEvent('esx_holdup:killBlip', xPlayers[i])
								end
							end
						end
					end
				end)
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = '警察不足'})
			end
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = '搶劫進行中'})
		end
	end
end)
