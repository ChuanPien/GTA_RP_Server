ESX = nil

local rentalTimer = 5 --How often a player should be charged in Minutes
local isBeingCharged = false
local autoChargeAmount = 0 -- How much a player should be charged each time
local devMode = false
local count = 1

pickupStation = {
	vector3(-1058.88, -2719.0, 12.76),
	vector3(-1570.16, 5158.52, 18.72),
	vector3(352.2, -624.0, 28.36),
	vector3(-703.12, 5790.0, 16.52),

}
dropoffStation = {
	vector3(-1039.12, -2678.4, 12.84),
	vector3(-61.88, -1117.04, 25.44),
	vector3(-1570.96, 5152.68, 18.92),
	vector3(346.48, -620.88, 28.28),
	vector3(-706.88, 5785.0, 16.32),

}

point = {
	vector3(-1040.44, -2664.88, 13.84),
	vector3(384.0, -630.2, 28.8),
	vector3(-1577.44, 5157.48, 19.88),
	vector3(-728.12, 5809.0, 17.44)
}

Citizen.CreateThread(function()

    while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
    end

	WarMenu.CreateMenu('carRental', '懶欣租車站')
	WarMenu.CreateSubMenu('closeMenu', 'carRental', 'Are you sure?')
	WarMenu.CreateSubMenu('carPicker', 'carRental', '租自用車 | 1天(5分鐘)')
	WarMenu.CreateSubMenu('carPicker1', 'carRental', '租商用車 | 1天(10分鐘)')
	WarMenu.CreateSubMenu('carInsurance', 'carRental', '是否購買租車保險? | $500')
	WarMenu.CreateMenu('carReturn', '還車站')
	WarMenu.SetSubTitle('carReturn', '確認還車?')
	WarMenu.CreateMenu('arrestCheck', '租車站')

	while true do
		if WarMenu.IsMenuOpened('carRental') then
			if WarMenu.MenuButton('租自用車', 'carPicker') then
			elseif WarMenu.MenuButton('租商用車', 'carPicker1') then
			end
			WarMenu.SetSubTitle('carRental', '歡迎光臨-懶欣車行')
			WarMenu.Display()

		elseif WarMenu.IsMenuOpened('carPicker') then
			if WarMenu.Button('阿斯波 | $200/天') then
				SpawnVehicle("asbo")
				autoChargeAmount = 200
				isBeingCharged = true
				WarMenu.CloseMenu()
			elseif WarMenu.Button('Club | $200/天') then
				SpawnVehicle("club")
				autoChargeAmount = 200
				isBeingCharged = true
				WarMenu.CloseMenu()
			elseif WarMenu.Button('海致 | $200/天') then
				SpawnVehicle("asea")
				autoChargeAmount = 200
				isBeingCharged = true
				WarMenu.CloseMenu()
			elseif WarMenu.Button('費甲歐 | $100/天') then
				SpawnVehicle("faggio2")
				autoChargeAmount = 100
				isBeingCharged = true
				WarMenu.CloseMenu()
			end
			WarMenu.Display()

		elseif WarMenu.IsMenuOpened('carPicker1') then
			if WarMenu.Button('猛騾 | $500/天') then
				SpawnVehicle("mule")
				rentalTimer = 10
				autoChargeAmount = 500
				isBeingCharged = true
				WarMenu.CloseMenu()
			elseif WarMenu.Button('班森 | $500/天') then
				SpawnVehicle("benson")
				rentalTimer = 10
				autoChargeAmount = 500
				isBeingCharged = true
				WarMenu.CloseMenu()
			elseif WarMenu.Button('跑德 | $500/天') then
				SpawnVehicle("pounder")
				rentalTimer = 10
				autoChargeAmount = 500
				isBeingCharged = true
				WarMenu.CloseMenu()
			elseif WarMenu.Button('屌客 | $500/天') then
				SpawnVehicle("burrito3")
				rentalTimer = 10
				autoChargeAmount = 500
				isBeingCharged = true
				WarMenu.CloseMenu()
			elseif WarMenu.Button('小馬 | $500/天') then
				SpawnVehicle("pony2")
				rentalTimer = 10
				autoChargeAmount = 500
				isBeingCharged = true
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
	local blip1 = 0
	local blip2 = 0

	while true do
		local coords = GetEntityCoords(PlayerPedId())
		local closest = 10000
		local closestCoords1
		local closestCoords2

		for _, blip1 in pairs(pickupStation) do
			local dstcheck = GetDistanceBetweenCoords(coords, blip1)

			if dstcheck < closest then
				closest = dstcheck
				closestCoords1 = blip1
			end
		end

		for _, blip2 in pairs(dropoffStation) do
			local dstcheck = GetDistanceBetweenCoords(coords, blip2)

			if dstcheck < closest then
				closest = dstcheck
				closestCoords2 = blip2
			end
		end

		if DoesBlipExist(blip1) then
			RemoveBlip(blip1)
		end

		if DoesBlipExist(blip2) then
			RemoveBlip(blip2)
		end

		blip1 = CreateBlip1(closestCoords1)
		blip2 = CreateBlip2(closestCoords2)

		Citizen.Wait(10000)
	end
end)

function CreateBlip1(coord1)
	local blip1 = AddBlipForCoord(coord1)
	SetBlipSprite(blip1, 85)
	SetBlipDisplay(blip1, 4)
	SetBlipScale(blip1, 1.0)
	SetBlipColour(blip1, 2)

	SetBlipAsShortRange(blip1, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("租車站")
	EndTextCommandSetBlipName(blip1)

	return blip1
end

function CreateBlip2(coord2)
	local blip2 = AddBlipForCoord(coord2)
	SetBlipSprite(blip2, 85)
	SetBlipDisplay(blip2, 4)
	SetBlipScale(blip2, 0.60)
	SetBlipColour(blip2, 1)

	SetBlipAsShortRange(blip2, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("還車站")
	EndTextCommandSetBlipName(blip2)

	return blip2
end

--Draw markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		for _, v in pairs(pickupStation) do
			DrawMarker(1, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.5, 0, 204, 0, 100, false, true, 2, false, false, false, false)
		end
		for _, v in pairs(dropoffStation) do
			DrawMarker(1, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0, 1.5, 255, 0, 0, 100, false, true, 2, false, false, false, false)
		end
	end
end)

--Check to see if player is in marker
Citizen.CreateThread(function()
	while true do
		local HasAlreadyEnteredMarker = false
		Citizen.Wait(0)

		local coords = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker = false
		local isInReturnMarker = false

		for _, v in pairs(pickupStation) do
			if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.75) then
				isInMarker = true
			end
		end

		for _, v in pairs(dropoffStation) do
			if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 2.75) then
				isInReturnMarker = true
			end
		end

		if (isInReturnMarker and not WarMenu.IsMenuOpened('carReturn')) then
			ESX.ShowHelpNotification('[~g~E~s~]還車')
			if IsControlJustReleased(0, 38) then
				StoreOwnedCarsMenu()
			end
		end

		if (not isInReturnMarker and not devMode and not isInMarker) then
			Citizen.Wait(100)
			WarMenu.CloseMenu()
		end

		if (isInMarker and not WarMenu.IsMenuOpened('carRental') and not WarMenu.IsMenuOpened('carPicker') and not WarMenu.IsMenuOpened('carPicker1') and not WarMenu.IsMenuOpened('closeMenu') and not WarMenu.IsMenuOpened('carInsurance') and not WarMenu.IsMenuOpened('arrestCheck')) then
			ESX.ShowHelpNotification('[~g~E~s~]租車')
			if IsControlJustReleased(0, 38) then
				if not isBeingCharged then
					WarMenu.OpenMenu('carRental')
				else
					exports['mythic_notify']:DoHudText('inform', '請先還車')
				end
			end
		end

		if (not isInMarker and not devMode and not isInReturnMarker) then
			Citizen.Wait(100)
			WarMenu.CloseMenu()
		end
	end
end)

function StoreOwnedCarsMenu()
	local playerPed  = GetPlayerPed(-1)

	if IsPedInAnyVehicle(playerPed,  false) then
		local playerPed = GetPlayerPed(-1)
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		local current = GetPlayersLastVehicle(GetPlayerPed(-1), true)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		local engineHealth = GetVehicleEngineHealth(current)
		local plate = vehicleProps.plate

		ESX.TriggerServerCallback('carrent:storeVehicle', function(valid)
			if valid == true then
				if engineHealth < 990 then
					local apprasial = math.floor((1000 - engineHealth)/1000*5000)
					RepairVehicle(apprasial)
				else
					ReturnVehicle()
				end
			else
				exports['mythic_notify']:DoHudText('error', '限租任車')
			end
		end, plate)
	else
		exports['mythic_notify']:DoHudText('error', '需上車')
		Citizen.Wait(10000)
	end
end

--Auto charge player every 5 minutes
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(rentalTimer*60*1000)
		if isBeingCharged == true then
			count = count + 1
			exports['mythic_notify']:DoHudText('inform', rentalTimer .. '分鐘')
		end
	end
end)

function RepairVehicle(apprasial)
	ESX.UI.Menu.CloseAll()
	
	exports['mythic_notify']:DoHudText('inform', '需維修 $' .. apprasial)
	local elements = {
		{label = ('取消'), value = 'no'},
		{label = ('確定 [$'..apprasial..']'), value = 'yes'}
	}

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'delete_menu', {
		title = ('維修付款確認'),
		align = 'top-left',
		elements = elements
	}, function(data, menu)
		menu.close()

		if data.current.value == 'yes' then
			TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(PlayerId()), 'society_carrent', '修車費', apprasial)
			ReturnVehicle()
		elseif data.current.value == 'no' then
		end
	end, function(data, menu)
		menu.close()
	end)
end

--Spawn vehicle function
function SpawnVehicle(request)
	Citizen.Wait(0)
	local closestCoords
	local hash = GetHashKey(request)
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 100

	for _, point in pairs(point) do
		local dstcheck = GetDistanceBetweenCoords(coords, point)

		if dstcheck < closest then
			closest = dstcheck
			closestCoords = point
		end
	end

	while not HasModelLoaded(hash) do
		RequestModel(hash)
		Citizen.Wait(0)
	end

	RequestModel(hash)

	local vehicle = CreateVehicle(hash, closestCoords.x,closestCoords.y,closestCoords.z, 0, true, false)
	local generatedPlate = GeneratePlate()

	SetVehicleDoorsLocked(vehicle, 1)
	SetVehicleNumberPlateText(vehicle, generatedPlate)
	TaskWarpPedIntoVehicle(GetPlayerPed(-1),vehicle,-1)

	TriggerServerEvent('carrent:buyVehicleV',generatedPlate)
end

function ReturnVehicle()
	isBeingCharged = false
	exports['mythic_notify']:DoHudText('success', '已歸還')
	local currentVehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
	SetEntityAsMissionEntity(currentVehicle, true, true)
	local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
	SetEntityCoords(GetPlayerPed(-1), x - 2, y, z)
	DeleteVehicle(currentVehicle)
	TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(PlayerId()), 'society_carrent', '租車費 | ' .. count * 30 .. '分鐘', autoChargeAmount * count)
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
					ESX.TriggerServerCallback('carrent:isVehicleOwner', function(owner)
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
