local defaultPrice80 = 2000 -- THIS IS THE DEFAULT PRICE WITHOUT EXTRA COST FOR 80 ZONES
local defaultPrice140 = 3500 -- THIS IS THE DEFAULT PRICE WITHOUT EXTRA COST FOR 120 ZONES

local extraZonePrice10 = 500 -- THIS IS THE EXTRA COST IF 10 KM/H ABOVE LIMIT (REQUIRES "useBilling" to be set to true)
local extraZonePrice20 = 1000 -- THIS IS THE EXTRA COST IF 20 KM/H ABOVE LIMIT (REQUIRES "useBilling" to be set to true)
local extraZonePrice30 = 1500 -- THIS IS THE EXTRA COST IF 30 KM/H ABOVE LIMIT (REQUIRES "useBilling" to be set to true)
local extraZonePrice50 = 2000 -- THIS IS THE EXTRA COST IF 30 KM/H ABOVE LIMIT (REQUIRES "useBilling" to be set to true)
-- ABOVE IS YOUR SETTINGS, CHANGE THEM TO WHATEVER YOU'D LIKE & MORE SETTINGS WILL COME IN THE FUTURE!  --

ESX = nil
local hasBeenCaught = true
local finalBillingPrice = 0;
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

function hintToDisplay(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

-- BLIP FOR SPEEDCAMERAS
local blips = {
    -- {title="測速照相(80KM/H)", colour=1, id=1,x = 1495.25,y = 2743.75,z = 37.87},
    -- {title="測速照相(80KM/H)", colour=1, id=1,x = -1482.85,y = 1592.94,z = 109.31},
    -- {title="測速照相(80KM/H)", colour=1, id=1,x = 1258.2006,y = 789.4199,z = 103.2190},
    -- {title="測速照相(80KM/H)", colour=1, id=1,x = 2394.76, y = 3929.08, z = 35.6},
	-- {title="測速照相(80KM/H)", colour=1, id=1,x = 266.84, y = 1156.0, z = 222.88},
	-- {title="測速照相(120KM/H)", colour=1, id=1, x = 1752.6, y = -870.36, z = 71.0}, -- 120KM/H ZONE
	-- {title="測速照相(120KM/H)", colour=1, id=1, x = 2442.2006, y = -134.6004, z = 88.7765}, -- 120KM/H ZONE
	-- {title="測速照相(120KM/H)", colour=1, id=1, x = 2164.24, y = 2714.88, z = 48.04}, -- 120KM/H ZONE
	-- {title="測速照相(120KM/H)", colour=1, id=1, x = -2659.72,y = -72.01,z = 17.12}, -- 120KM/H ZONE
	-- {title="測速照相(120KM/H)", colour=1, id=1, x = -2656.4,y = 2646.23,z = 15.68}, -- 120KM/H ZONE
	-- {title="測速照相(120KM/H)", colour=1, id=1, x = 2707.54,y = 4759.42,z = 43.36}, -- 120KM/H ZONE
	-- {title="測速照相(120KM/H)", colour=1, id=1, x = -1031.16, y = 5359.56, z = 42.8}, -- 120KM/H ZONE
	-- {title="測速照相(120KM/H)", colour=1, id=1, x = -396.94,y = -514.44,z = 25.12}, -- 120KM/H ZONE
	-- {title="測速照相(120KM/H)", colour=1, id=1, x = 1529.05,y = 884.37,z = 77.25} -- 120KM/H ZONE
}

Citizen.CreateThread(function()
	for _, info in pairs(blips) do
		if useBlips == true then
			info.blip = AddBlipForCoord(info.x, info.y, info.z)
			SetBlipSprite(info.blip, info.id)
			SetBlipDisplay(info.blip, 4)
			SetBlipScale(info.blip, 0.5)
			SetBlipColour(info.blip, info.colour)
			SetBlipAsShortRange(info.blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(info.title)
			EndTextCommandSetBlipName(info.blip)
		end
	end
end)

-- AREAS
local note80 = {
	{x = 1123.2, y = 546.32, z = 96.64},
	{x = 1289.64, y = 1173.76, z = 106.2},
	{x = 244.88, y = 1248.76, z = 231.68},
	{x = 315.24, y = 1073.92, z = 213.28},
	{x = -1484.52, y = 1484.88, z = 116.24},
	{x = -1501.52, y = 1749.36, z = 89.76},
	{x = 1393.88, y = 2687.12, z = 37.12},
	{x = 1567.6, y = 2802.4, z = 37.88},
	{x = 2292.68, y = 3844.68, z = 34.0},
	{x = 2454.24, y = 4025.32, z = 36.8},
	{x = 724.72, y = -2669.6, z = 10.88},
	{x = 741.16, y = -2879.36, z = 5.28},
	{x = 336.52, y = -295.76, z = 53.12},
	{x = 206.4, y = -352.64, z = 43.32},
	{x = 307.32, y = -472.96, z = 42.6},
	{x = 417.44, y = -379.32, z = 46.28},
	{x = -657.52, y = -664.96, z = 30.96},
	{x = -433.24, y = -645.92, z = 30.92},
	{x = -506.28, y = -762.4, z = 31.08}
}

local note140 = {
	{x = 1197.48, y = 479.64, z = 81.36},
	{x = 1644.72, y = 1222.88, z = 84.84},
	{x = 2015.48, y = 2568.68, z = 54.36},
	{x = 2341.36, y = 2870.08, z = 40.36},
	{x = 2769.44, y = 4553.88, z = 46.04},
	{x = 2647.6, y = 4966.96, z = 44.52},
	{x = -844.32, y = 5462.52, z = 33.76},
	{x = -1182.28, y = 5248.92, z = 52.2},
	{x = -2673.56, y = 2451.8, z = 16.44},
	{x = -2640.04, y = 2836.16, z = 16.44},
	{x = -2831.84, y = 47.36, z = 14.32},
	{x = -2437.44, y = -225.76, z = 16.24},
	{x = -610.6, y = -534.28, z = 25.04},
	{x = -609.28, y = -522.04, z = 25.04},
	{x = -170.64, y = -492.2, z = 28.0},
	{x = -171.72, y = -504.4, z = 27.92},
	{x = 1582.96, y = -986.52, z = 60.04},
	{x = 1920.0, y = -735.96, z = 86.04}

}

local Speedcamera80Zone = {
    {x = 1495.25,y = 2743.75,z = 37.87},
    {x = -1482.85,y = 1592.94,z = 109.31},
    {x = 1258.2006,y = 789.4199,z = 103.2190},
    {x = 2394.76, y = 3929.08, z = 35.6},
	{x = 266.84, y = 1156.0, z = 222.88},
	{x = 730.76, y = -2764.48, z = 6.52},
	{x = 311.56, y = -386.44, z = 44.52},
	{x = -545.96, y = -657.68, z = 32.52}
}

local Speedcamera140Zone = {
	{ x = 1752.6, y = -870.36, z = 71.0},
	{ x = 2164.24, y = 2714.88, z = 48.04},
	{ x = -2659.72,y = -72.01,z = 17.12},
	{ x = -2656.4,y = 2646.23,z = 15.68},
	{ x = 2707.54,y = 4759.42,z = 43.36},
	{ x = -1031.16, y = 5359.56, z = 42.8},
	{ x = -396.94,y = -514.44,z = 25.12},
	{ x = 1529.05,y = 884.37,z = 77.25}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		local playerPed = GetPlayerPed(-1)
		local playerCar = GetVehiclePedIsIn(playerPed, false)
		if IsPedInAnyVehicle(playerPed, false) then
			if (GetPedInVehicleSeat(playerCar, -1) == playerPed) then 
				if PlayerData.job ~= nil and PlayerData.job.name ~= 'admin' then
					for k in pairs(note80) do
						local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
						local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, note80[k].x, note80[k].y, note80[k].z)

						if dist <= 8.0 then
							exports['mythic_notify']:DoCustomHudText('inform', "前方100M測速照相 限速80KM/H",4000)
							Citizen.Wait(10000)
						end
					end

					for k in pairs(note140) do
						local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
						local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, note140[k].x, note140[k].y, note140[k].z)

						if dist <= 8.0 then
							exports['mythic_notify']:DoCustomHudText('inform', "前方200M測速照相 限速140KM/H",4000)
							Citizen.Wait(10000)
						end
					end
				end
			end
		end
	end
end)

-- ZONES
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

		if PlayerData.job ~= nil and PlayerData.job.name ~= 'admin' then

		-- 80 zone
		for k in pairs(Speedcamera80Zone) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Speedcamera80Zone[k].x, Speedcamera80Zone[k].y, Speedcamera80Zone[k].z)

            if dist <= 30.0 then
				local playerPed = GetPlayerPed(-1)
				local playerCar = GetVehiclePedIsIn(playerPed, false)
				local veh = GetVehiclePedIsIn(playerPed)
				local SpeedKM = GetEntitySpeed(playerPed)*3.6
				local maxSpeed = 85.0 -- THIS IS THE MAX SPEED IN KM/H

				if SpeedKM > maxSpeed then
					if IsPedInAnyVehicle(playerPed, false) then
						if (GetPedInVehicleSeat(playerCar, -1) == playerPed) then
							if hasBeenCaught == false then
								if GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE" then
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE2" then
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE3" then
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "pdimpala" then
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "pdfpiu" then
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "pdcvpi" then
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "pdcharger" then
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "lsfdfpiu" then
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "AMBULAN" then
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "emsnspeedo" then
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "polmav" then
								-- VEHICLES ABOVE ARE BLACKLISTED
								else
									-- FLASHING EFFECT (START)
									SetNuiFocus(false,false)
    								SendNUIMessage({type = 'openSpeedcamera'})
									TriggerServerEvent("InteractSound_SV:PlayOnSource", "speedcamera", 0.5)
									Citizen.Wait(200)
									SendNUIMessage({type = 'closeSpeedcamera'})
									-- FLASHING EFFECT (END)
									if SpeedKM >= maxSpeed + 50 then
										finalBillingPrice = defaultPrice80 + extraZonePrice50
									elseif SpeedKM >= maxSpeed + 30 then
										finalBillingPrice = defaultPrice80 + extraZonePrice30
									elseif SpeedKM >= maxSpeed + 20 then
										finalBillingPrice = defaultPrice80 + extraZonePrice20
									elseif SpeedKM >= maxSpeed + 10 then
										finalBillingPrice = defaultPrice80 + extraZonePrice10
									else
										finalBillingPrice = defaultPrice80
									end

									exports['mythic_notify']:DoHudText('error', math.floor(SpeedKM) .. "KM/H超速")
									TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(PlayerId()), 'society_police_2', '測速系統(80KM/H) - 你的時速:' .. math.floor(SpeedKM) .. ' KM/H - ', finalBillingPrice)
									TriggerServerEvent('esx_joblogs:AddInLog', 'speedtest', 'speedtest', GetPlayerName(PlayerId()), math.floor(SpeedKM), finalBillingPrice)
									hasBeenCaught = true
									Citizen.Wait(5000) -- This is here to make sure the player won't get fined over and over again by the same camera!
								end
							end
						end
					end

					hasBeenCaught = false
				else
					if IsPedInAnyVehicle(playerPed, false) then
						if (GetPedInVehicleSeat(playerCar, -1) == playerPed) then
							exports['mythic_notify']:DoHudText('inform', "測速結束")
						end
					end
					Citizen.Wait(10000)
				end
            end
        end

		-- 120 zone
		for k in pairs(Speedcamera140Zone) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Speedcamera140Zone[k].x, Speedcamera140Zone[k].y, Speedcamera140Zone[k].z)

            if dist <= 30.0 then
				local playerPed = GetPlayerPed(-1)
				local playerCar = GetVehiclePedIsIn(playerPed, false)
				local veh = GetVehiclePedIsIn(playerPed)
				local SpeedKM = GetEntitySpeed(playerPed)*3.6
				local maxSpeed = 145.0 -- THIS IS THE MAX SPEED IN KM/H

				if SpeedKM > maxSpeed then
					if IsPedInAnyVehicle(playerPed, false) then
						if (GetPedInVehicleSeat(playerCar, -1) == playerPed) then
							if hasBeenCaught == false then
								if GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE" then
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE2" then
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE3" then
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "pdimpala" then
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "pdfpiu" then
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "pdcvpi" then
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "pdcharger" then
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "lsfdfpiu" then
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "AMBULAN" then
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "emsnspeedo" then
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "polmav" then
								else
									-- FLASHING EFFECT (START)
									SetNuiFocus(false,false)
    								SendNUIMessage({type = 'openSpeedcamera'})
									TriggerServerEvent("InteractSound_SV:PlayOnSource", "speedcamera", 0.5)
									Citizen.Wait(200)
									SendNUIMessage({type = 'closeSpeedcamera'})
									-- FLASHING EFFECT (END)

									if SpeedKM >= maxSpeed + 50 then
										finalBillingPrice = defaultPrice140 + extraZonePrice50
									elseif SpeedKM >= maxSpeed + 30 then
										finalBillingPrice = defaultPrice140 + extraZonePrice30
									elseif SpeedKM >= maxSpeed + 20 then
										finalBillingPrice = defaultPrice140 + extraZonePrice20
									elseif SpeedKM >= maxSpeed + 10 then
										finalBillingPrice = defaultPrice140 + extraZonePrice10
									else
										finalBillingPrice = defaultPrice140
									end

									exports['mythic_notify']:DoHudText('error', math.floor(SpeedKM) .. "KM/H超速")
									TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(PlayerId()), 'society_police_2', '測速系統(140KM/H) - 你的時速:' .. math.floor(SpeedKM) .. 'KM/H - ', finalBillingPrice)
									TriggerServerEvent('esx_joblogs:AddInLog', 'speedtest', 'speedtest', GetPlayerName(PlayerId()), math.floor(SpeedKM), finalBillingPrice)

									hasBeenCaught = true
									Citizen.Wait(5000) -- This is here to make sure the player won't get fined over and over again by the same camera!
								end
							end
						end
					end
					hasBeenCaught = false
				else
					if IsPedInAnyVehicle(playerPed, false) then
						if (GetPedInVehicleSeat(playerCar, -1) == playerPed) then
							exports['mythic_notify']:DoHudText('inform', "測速結束")
						end
					end
					Citizen.Wait(10000)
				end
            end
        end
	end
end
end)

RegisterNetEvent('esx_speedcamera:openGUI')
AddEventHandler('esx_speedcamera:openGUI', function()
    SetNuiFocus(false,false)
    SendNUIMessage({type = 'openSpeedcamera'})
end)

RegisterNetEvent('esx_speedcamera:closeGUI')
AddEventHandler('esx_speedcamera:closeGUI', function()
    SendNUIMessage({type = 'closeSpeedcamera'})
end)
