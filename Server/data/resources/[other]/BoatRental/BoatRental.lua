ESX = nil
local rentalTimer = 30 --How often a player should be charged in Minutes
local isBeingCharged = false
local autoChargeAmount = 500 -- How much a player should be charged each time
local devMode = false
local count = 1
local PlayerData = {}

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

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  	PlayerData.job = job
end)

local Blip = AddBlipForCoord(-1615.8, 5266.72, 4.04)
SetBlipSprite(Blip, 455)
SetBlipDisplay(Blip, 4)
SetBlipScale(Blip, 1.0)
SetBlipColour(Blip, 20)
SetBlipAsShortRange(Blip, true)
BeginTextCommandSetBlipName("STRING")
AddTextComponentString("租船站")
EndTextCommandSetBlipName(Blip)

Citizen.CreateThread(function()

    while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
    end

	WarMenu.CreateMenu('carRental', '懶欣租船站')
	WarMenu.CreateSubMenu('carPicker', 'carRental', '租用船隻 | 1天(30分鐘)')
	WarMenu.CreateMenu('carReturn', '還船站')
	WarMenu.SetSubTitle('carReturn', '確認還船?')
	WarMenu.CreateMenu('arrestCheck', '租船站')

	while true do
		if WarMenu.IsMenuOpened('carPicker') then
			if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
				if WarMenu.Button('警用追獵快艇') then
					SpawnVehicle("predator")
					isBeingCharged = false
					WarMenu.CloseMenu()
				end
			end
			if WarMenu.Button('救生艇(2) | $500/天') then
				SpawnVehicle("dinghy2")
				isBeingCharged = true
				WarMenu.CloseMenu()
			elseif WarMenu.Button('救生艇(4) | $500/天') then
				SpawnVehicle("dinghy3")
				isBeingCharged = true
				WarMenu.CloseMenu()
			elseif WarMenu.Button('水上侯爵(4) | $500/天') then
				SpawnVehicle("marquis")
				isBeingCharged = true
				WarMenu.CloseMenu()
			elseif WarMenu.Button('烈陽號(4) | $500/天') then
				SpawnVehicle("tropic")
				isBeingCharged = true
				WarMenu.CloseMenu()
			elseif WarMenu.Button('極限快艇(2) | $1000/天') then
				SpawnVehicle("jetmax")
				isBeingCharged = true
				autoChargeAmount = 1000
				WarMenu.CloseMenu()
			elseif WarMenu.Button('思快樂艇(2) | $1000/天') then
				SpawnVehicle("squalo")
				isBeingCharged = true
				autoChargeAmount = 1000
				WarMenu.CloseMenu()
			elseif WarMenu.Button('飆速號(4) | $1000/天') then
				SpawnVehicle("speeder")
				isBeingCharged = true
				autoChargeAmount = 1000
				WarMenu.CloseMenu()
			elseif WarMenu.Button('公牛(4) | $1000/天') then
				SpawnVehicle("toro2")
				isBeingCharged = true
				autoChargeAmount = 1000
				WarMenu.CloseMenu()
			end
			WarMenu.Display()
		--Return car menu
		elseif WarMenu.IsMenuOpened('carReturn') then
			if WarMenu.Button('確認') then
				ReturnVehicle()
				WarMenu.CloseMenu()
			elseif WarMenu.Button('取消') then
				WarMenu.CloseMenu()
			end	
			WarMenu.Display()

		end
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		DrawMarker(1, -1615.8, 5266.72, 4.04, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.5, 0, 204, 0, 100, false, true, 2, false, false, false, false)
		DrawMarker(1, -1589.41, 5256.24, 0, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 5.0, 5.0, 1.5, 255, 0, 0, 100, false, true, 2, false, false, false, false)
	end
end)

Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)

		local coords = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker = false
		local isInReturnMarker = false

		if(GetDistanceBetweenCoords(coords, -1615.8, 5266.72, 4.04, true) < 1.75) then
			isInMarker = true
		end

		if(GetDistanceBetweenCoords(coords, -1589.41, 5256.24, 0, true) < 5) then
			isInReturnMarker = true
		end

		if (isInReturnMarker and not WarMenu.IsMenuOpened('carReturn')) then
			ESX.ShowHelpNotification('[~g~E~s~]還船')
			if IsControlJustReleased(0, 38) then
				StoreOwnedCarsMenu()
			end
		end

		if (not isInReturnMarker and not devMode and not isInMarker) then
			Citizen.Wait(100)
			WarMenu.CloseMenu()
		end

		if (isInMarker and not WarMenu.IsMenuOpened('carPicker')) then
			ESX.ShowHelpNotification('[~g~E~s~]租船')
			if IsControlJustReleased(0, 38) then
				if not isBeingCharged then
					WarMenu.OpenMenu('carPicker')
				else
					exports['mythic_notify']:DoHudText('inform', '請先歸還船隻')
				end
			end
		end

		if (not isInMarker and not devMode and not isInReturnMarker) then
			Citizen.Wait(100)
			WarMenu.CloseMenu()
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(rentalTimer*60*1000)
		if isBeingCharged == true then
			count = count + 1
			exports['mythic_notify']:DoHudText('inform', '30分鐘')
		end
	end
end)

function StoreOwnedCarsMenu()
	local playerPed  = GetPlayerPed(-1)

	if IsPedInAnyVehicle(playerPed,  false) then
		local playerPed = GetPlayerPed(-1)
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		local plate = vehicleProps.plate

		ESX.TriggerServerCallback('boatrent:storeVehicle', function(valid)
			if valid == true then
				ReturnVehicle()
			else
				exports['mythic_notify']:DoHudText('error', '限租任船隻')
			end
		end, plate)
	else
		exports['mythic_notify']:DoHudText('error', '需上船')
		Citizen.Wait(10000)
	end
end

function SpawnVehicle(request)
	local hash = GetHashKey(request)
	RequestModel(hash)

	while not HasModelLoaded(hash) do
		RequestModel(hash)
		Citizen.Wait(0)
	end

	local vehicle = CreateVehicle(hash,-1590.08, 5259.0, 0, 22.36, true, false)
	local generatedPlate = GeneratePlate()

	SetVehicleDoorsLocked(vehicle, 1)
	SetVehicleNumberPlateText(vehicle, generatedPlate)
	TaskWarpPedIntoVehicle(GetPlayerPed(-1),vehicle,-1)

	TriggerServerEvent('boatrent:buyVehicleV',generatedPlate)
end

function ReturnVehicle()
	isBeingCharged = false
	exports['mythic_notify']:DoHudText('success', '已歸還')
	local currentVehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
	SetEntityAsMissionEntity(currentVehicle, true, true)
	local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
	SetEntityCoords(GetPlayerPed(-1), x - 2, y, z)
	DeleteVehicle(currentVehicle)
	TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(PlayerId()), 'society_carrent', '租船費 | ' .. count * 30 .. '分鐘', autoChargeAmount * count)
end

--------------------------------------------------------------------

Citizen.CreateThread(function()
	local dict = "anim@mp_player_intmenu@key_fob@"
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(0)
	end
	while true do
		Citizen.Wait(0)
		if (IsControlJustPressed(1, 303)) then
			local coords = GetEntityCoords(GetPlayerPed(-1))
			local hasAlreadyLocked = false
			cars = ESX.Game.GetVehiclesInArea(coords, 30)
			local carstrie = {}
			local cars_dist = {}
			if #cars ~= 0 then
				for j=1, #cars, 1 do
					local coordscar = GetEntityCoords(cars[j])
					local distance = Vdist(coordscar.x, coordscar.y, coordscar.z, coords.x, coords.y, coords.z)
					table.insert(cars_dist, {cars[j], distance})
				end
				for k=1, #cars_dist, 1 do
					local z = -1
					local distance, car = 999
					for l=1, #cars_dist, 1 do
						if cars_dist[l][2] < distance then
							distance = cars_dist[l][2]
							car = cars_dist[l][1]
							z = l
						end
					end
					if z ~= -1 then
						table.remove(cars_dist, z)
						table.insert(carstrie, car)
					end
				end
				for i=1, #carstrie, 1 do
					local plate = ESX.Math.Trim(GetVehicleNumberPlateText(carstrie[i]))
					ESX.TriggerServerCallback('boatrent:isVehicleOwner', function(owner)
						if owner and hasAlreadyLocked ~= true then
							local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(carstrie[i]))
							vehicleLabel = GetLabelText(vehicleLabel)
							local lock = GetVehicleDoorLockStatus(carstrie[i])
							if lock == 1 or lock == 0 then
								TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'carlock', 0.1)
								SetVehicleDoorShut(carstrie[i], 0, false)
								SetVehicleDoorShut(carstrie[i], 1, false)
								SetVehicleDoorShut(carstrie[i], 2, false)
								SetVehicleDoorShut(carstrie[i], 3, false)
								SetVehicleDoorsLocked(carstrie[i], 2)
								exports['mythic_notify']:DoHudText('error', '上鎖' .. vehicleLabel)
								if not IsPedInAnyVehicle(PlayerPedId(), true) then
									TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
								end
								SetVehicleLights(carstrie[i], 2)
								Citizen.Wait(150)
								SetVehicleLights(carstrie[i], 0)
								Citizen.Wait(150)
								SetVehicleLights(carstrie[i], 2)
								Citizen.Wait(150)
								SetVehicleLights(carstrie[i], 0)
								hasAlreadyLocked = true
							elseif lock == 2 then
								SetVehicleDoorsLocked(carstrie[i], 1)
								TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'carlock', 0.1)
								exports['mythic_notify']:DoHudText('success', '解鎖' .. vehicleLabel)
								if not IsPedInAnyVehicle(PlayerPedId(), true) then
									TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
								end
								SetVehicleLights(carstrie[i], 2)
								Citizen.Wait(150)
								SetVehicleLights(carstrie[i], 0)
								Citizen.Wait(150)
								SetVehicleLights(carstrie[i], 2)
								Citizen.Wait(150)
								SetVehicleLights(carstrie[i], 0)
								hasAlreadyLocked = true
							end
						end
					end, plate)
				end
			end
		end
	end
end)
