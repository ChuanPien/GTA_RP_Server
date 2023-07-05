ESX = nil
local selling = false
local secondsRemaining
local sold = false
local playerHasDrugs = false
local pedIsTryingToSellDrugs = false
local PlayerData		= {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if selling then
			if secondsRemaining > 0 then
				secondsRemaining = secondsRemaining - 1
				Citizen.Wait(1000)
			end
		end
	end
end)

currentped = nil
Citizen.CreateThread(function()
	while true do
		Wait(10)
		local player = GetPlayerPed(-1)
		local pid = PlayerPedId()
  		local playerloc = GetEntityCoords(player, 0)
		local handle, ped = FindFirstPed()
		local success
		repeat
		    success, ped = FindNextPed(handle)
		   	local pos = GetEntityCoords(ped)
	 		local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
			local distanceFromCity = GetDistanceBetweenCoords(Config.CityPoint.x, Config.CityPoint.y, Config.CityPoint.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
			if IsPedInAnyVehicle(GetPlayerPed(-1)) == false then
				if DoesEntityExist(ped)then
					if IsPedDeadOrDying(ped) == false then
						if IsPedInAnyVehicle(ped) == false then
							local pedType = GetPedType(ped)
							if pedType ~= 28 and IsPedAPlayer(ped) == false then
								currentped = pos
								if distance <= 3 and ped  ~= GetPlayerPed(-1) and ped ~= oldped and IsControlJustPressed(1, 38) then
									if distanceFromCity < Config.DistanceFromCity then
										TriggerServerEvent('check')
										if playerHasDrugs and sold == false and selling == false then
											local random = math.random(1, Config.PedRejectPercent)
											if random == Config.PedRejectPercent then
												exports['mythic_notify']:DoHudText('error', '販售失敗')
												oldped = ped
												data = {dispatchCode = 'drugs', caller = ('drugs'), coords = {x = pos.x, y = pos.y, z = pos.z}, netId = NetworkGetNetworkIdFromEntity(playerPed), length = 10000}
                        						TriggerServerEvent('wf-alerts:svNotify',data)
												TriggerEvent("sold")
											else
												SetEntityAsMissionEntity(ped)
												ClearPedTasks(ped)
												FreezeEntityPosition(ped,true)
												oldped = ped
												TaskStandStill(ped, 9)
												pos1 = GetEntityCoords(ped)
												TriggerEvent("sellingdrugs")
												exports['mythic_notify']:DoCustomHudText('inform', '討價還價中...',(Config.TimeToSell-1)*1000)
												RequestAnimDict("misscarsteal4@actor")
												while (not TaskStartScenarioInPlace(PlayerPedId(), "actor_berating_loop", 0, true)) do
													Citizen.Wait(0)
												end
												TaskPlayAnim(PlayerPedId(),"misscarsteal4@actor","actor_berating_loop",2.0, 2.0, 0.3, 120, 0, 0, 0, 0)
											end
										end
									end
								end
							end
						end
					end
				end
			end
		until not success

		EndFindPed(handle)
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(100)
		if selling then
			local player = GetPlayerPed(-1)
  			local playerloc = GetEntityCoords(player, 0)
			local distance = GetDistanceBetweenCoords(pos1.x, pos1.y, pos1.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
			local pid = PlayerPedId()
			--TOO FAR
			if distance > 5 then
				exports['mythic_notify']:DoHudText('error', '離買家太遠')
				selling = false
				SetEntityAsMissionEntity(oldped)
				SetPedAsNoLongerNeeded(oldped)
				FreezeEntityPosition(oldped,false)
			end
			--SUCCESS
			if secondsRemaining <= 1 then
				selling = false
				SetEntityAsMissionEntity(oldped)
				SetPedAsNoLongerNeeded(oldped)
				FreezeEntityPosition(oldped,false)
				ClearPedTasks(PlayerPedId())
				StopAnimTask(pid, "misscarsteal4@actor","actor_berating_loop", 1.0)
				playerHasDrugs = false
				sold = false
				TriggerServerEvent('sellDrugs')
			end
		end
	end
end)

RegisterNetEvent('sellingdrugs')
AddEventHandler('sellingdrugs', function()
	secondsRemaining = Config.TimeToSell
	selling = true
end)

RegisterNetEvent('sold')
AddEventHandler('sold', function()
	sold = false
	selling = false
	secondsRemaining = 0
end)

--Info that you dont have drugs
RegisterNetEvent('nomoredrugs')
AddEventHandler('nomoredrugs', function()
	exports['mythic_notify']:DoHudText('error', '毒品不足')
	playerHasDrugs = false
	sold = false
	selling = false
	secondsRemaining = 0
end)

--Show help notification ("PRESS E...")
RegisterNetEvent('playerhasdrugs')
AddEventHandler('playerhasdrugs', function()
	ESX.ShowHelpNotification(_U('input'))
	playerHasDrugs = true
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerCoords = GetEntityCoords(PlayerPedId())
		local isInMarker, letSleep, currentZone = false, true

		local distance = #(playerCoords - vector3(2221.4, 5614.56, 53.92))

		if distance < 30 then
			letSleep = false

			if distance < 2 then
				isInMarker, currentZone = true, 'Q'
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker, LastZone = true, currentZone
			LastZone = currentZone
			TriggerEvent('drug:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('drug:hasExitedMarker', LastZone)
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

AddEventHandler('drug:hasEnteredMarker', function(zone)
	if zone == 'Q' then
		CurrentAction = 'Q'
		CurrentActionMsg = ('[~g~E~s~]詢問')
		CurrentActionData = {}
	end
end)

AddEventHandler('drug:hasExitedMarker', function()
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) then
				if CurrentAction == 'Q' then
					Q()
				end

				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)

function Q()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), "drug", {
		title = ('想問點啥呢'),
		elements = {
			{label = ('大麻種子'),value = "seed"},
			{label = ('種植大麻'),value = "weed"},
			{label = ('種植技巧'),value = "skil"},
			{label = ('包裝大麻'),value = "pooch"},
			{label = ('販售通路'),value = "sell"},
		}
	}, function(data, menu)
		if data.current.value == 'seed' then
			ESX.ShowAdvancedNotification('老農夫', '[大麻種子]', '哦!你需要嗎?我~r~旁邊有種一點，你可以採一點去', 'CHAR_HUMANDEFAULT')
		elseif data.current.value == 'weed' then
			ESX.ShowAdvancedNotification('老農夫', '[種植大麻]', '唉 我這邊的土不太適合種，~b~MARLOWE VINEYARD~s~ 後面的土質比我這更好', 'CHAR_HUMANDEFAULT')
		elseif data.current.value == 'skil' then
			ESX.ShowAdvancedNotification('老農夫', '[種植技巧-~y~水、養份]', '~b~水跟養份~s~使用一次都是~y~增加50%~s~，且~y~皆需要維持在60%以上~s~\n~b~品質~g~增加', 'CHAR_HUMANDEFAULT')
			ESX.ShowAdvancedNotification('老農夫', '[種植技巧-~y~品質、成熟度]', '~b~品質~s~需要維持在~y~20%以上~s~\n~b~成熟度才~g~增加', 'CHAR_HUMANDEFAULT')
			ESX.ShowAdvancedNotification('老農夫', '[種植技巧-~y~品質、成熟度]', '如果~b~品質~s~在~y~20%以下~s~\n~b~成熟度~r~不增加', 'CHAR_HUMANDEFAULT')
		elseif data.current.value == 'pooch' then
			ESX.ShowAdvancedNotification('老農夫', '[包裝大麻]', '之前我在~b~破爛木屋~s~包裝時，經常聽到~b~賣包裝木材~s~的大貨車經過', 'CHAR_HUMANDEFAULT')
		elseif data.current.value == 'sell' then
			ESX.ShowAdvancedNotification('老農夫', '[販售通路]', '齁齁 這個有很種~b~多方法~s~呢\n可以直接找~y~買家~s~或幫忙~y~送貨~s~到定點', 'CHAR_HUMANDEFAULT')
		 end
		end, function(data, menu)
		menu.close()
	end)
end