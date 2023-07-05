local fixing, turn = false, false
local zcoords, mcolor = 0.0, 0
local position = 0

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

Citizen.CreateThread(function()	
    while true do
		Citizen.Wait(5)	
		local playerPed = GetPlayerPed(-1)
		local pos = GetEntityCoords(playerPed, true)		
		for k,v in pairs(Config.Stations) do
			if not fixing then
				if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 100) then
					if IsPedInAnyVehicle(playerPed, false) then
						if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 5.0) then
							if PlayerData.job ~= nil and PlayerData.job.name == 'admin' then
								hintToDisplay('[~g~E~s~]免費修車')
								if IsControlJustPressed(0, 38) then
									local playerPed = GetPlayerPed(-1)
									local vehicle = GetVehiclePedIsIn(playerPed, false)
									fixing = false
									exports['mythic_notify']:DoHudText('inform', '維修完成')
									SetVehicleFixed(vehicle)
									SetVehicleDeformationFixed(vehicle)
								end
							elseif PlayerData.job ~= nil and PlayerData.job.name == 'mechanic' then
								local current = GetPlayersLastVehicle(GetPlayerPed(-1), true)
								local engineHealth = GetVehicleEngineHealth(current)
								local cost = math.floor((1000 - engineHealth)*5)
								local count = math.floor((1000 - engineHealth)/30)
								
								hintToDisplay('[~g~E~s~]修車~g~$' .. cost)
								if IsControlJustPressed(0, 38) then
									Fixcar(count)
									TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(PlayerId()), 'society_repair', '修車費', cost)
									TriggerServerEvent('esx_joblogs:AddInLog', "car", "repair", GetPlayerName(PlayerId()),cost)
								end
							elseif PlayerData.job ~= nil and PlayerData.job.name == 'police' then
								local current = GetPlayersLastVehicle(GetPlayerPed(-1), true)
								local engineHealth = GetVehicleEngineHealth(current)
								local cost = math.floor((1000 - engineHealth)*7)
								local count = math.floor((1000 - engineHealth)/30+10)
								if cost <= 1000 then
									cost = 1000
								end
								hintToDisplay('[~g~E~s~]修車~g~$' .. cost)
								if IsControlJustPressed(0, 38) then
									Fixcar(count)
									TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(PlayerId()), 'society_repair', '修車費', cost)
									TriggerServerEvent('esx_joblogs:AddInLog', "car", "repair", GetPlayerName(PlayerId()),cost)
								end
							else
								local current = GetPlayersLastVehicle(GetPlayerPed(-1), true)
								local engineHealth = GetVehicleEngineHealth(current)
								local cost = math.floor((1000 - engineHealth)*10)
								local count = math.floor((1000 - engineHealth)/30+10)
								if cost <= 1000 then
									cost = 1000
								end
								hintToDisplay('[~g~E~s~]修車~g~$' .. cost)
								if IsControlJustPressed(0, 38) then
									Fixcar(count)
									TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(PlayerId()), 'society_repair', '修車費', cost)
									TriggerServerEvent('esx_joblogs:AddInLog', "car", "repair", GetPlayerName(PlayerId()),cost)
								end
							end
						end
					end
				end
			end
		end
    end
end)

function Fixcar(counter)
	local playerPed = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(playerPed, false)
	fixing = true
	FreezeEntityPosition(vehicle, true)

	Citizen.CreateThread(function ()

		while counter > 0 do
			Citizen.Wait(0)
			hintToDisplay(('~INPUT_JUMP~ 維修 ~y~' .. counter))
			if IsControlJustPressed(0, 22) then
				counter = counter - 1
			end
		end

		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'car_repair', 0.3)
		exports['mythic_notify']:DoHudText('inform', '維修完成')
		fixing = false
		SetVehicleFixed(vehicle)
		SetVehicleDeformationFixed(vehicle)
		FreezeEntityPosition(vehicle, false)
		zcoords, mcolor, turn = 0.0, 0, false

	end)
end

Citizen.CreateThread(function()
	local currentGasBlip = 0

	while true do
		local coords = GetEntityCoords(PlayerPedId())
		local closest = 8000
		local closestCoords

		for _, Stations in pairs(Config.Stations) do
			local dstcheck = GetDistanceBetweenCoords(coords, Stations)

			if dstcheck < closest then
				closest = dstcheck
				closestCoords = Stations
			end
		end

		if DoesBlipExist(currentGasBlip) then
			RemoveBlip(currentGasBlip)
		end

		currentGasBlip = CreateBlip(closestCoords)

		Citizen.Wait(10000)
	end
end)

function CreateBlip(coords)
	local blip = AddBlipForCoord(coords)
	SetBlipSprite (blip, 446)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.8)
	SetBlipColour (blip, 53)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName('維修站')
	EndTextCommandSetBlipName(blip)
	return blip
end

function hintToDisplay(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
