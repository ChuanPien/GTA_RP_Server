local Config = {}
Config.Cooldown = 0
Config.BlipTime = 10
Config.DisableAllMessages = true
Config.ChatSuggestions = false
Config.Reminder = false
Config.VehicleAutoTune = true
Config.AutoTuneVehicles = {
	"police",
	"police2",
	"police3",
	"pdcharger",
	"pdcvpi",
	"pdfpiu",
	"pdimpala",
	"polmav",
}

local Panic = {}
Panic.Cooling = 0
Panic.Tuned = false
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
		Citizen.Wait(0)local playerped = GetPlayerPed(-1)

		if IsControlJustPressed(0, 246) then
			if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
				if IsPedInAnyVehicle(playerped, false) then
					local Officer = {}
					Officer.Ped = PlayerPedId()
					Officer.Coords = GetEntityCoords(Officer.Ped)
					TriggerServerEvent("Police-Panic:NewPanic", Officer)
					Panic.Cooling = Config.Cooldown
				end
			end
		end
	end
end)

RegisterNetEvent("Pass-Alarm:Return:NewPanic")
AddEventHandler("Pass-Alarm:Return:NewPanic", function(source, Officer)

	if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
		SendNUIMessage({
			PayloadType	= "Panic",
			Payload		= source
		})

		Citizen.CreateThread(function()
			local Blip = AddBlipForRadius(Officer.Coords.x, Officer.Coords.y, Officer.Coords.z, 50.0)
			SetBlipRoute(Blip, true)
			Citizen.CreateThread(function()
				while Blip do
					SetBlipRouteColour(Blip, 1)
					Citizen.Wait(150)
					SetBlipRouteColour(Blip, 6)
					Citizen.Wait(150)
					SetBlipRouteColour(Blip, 35)
					Citizen.Wait(150)
					SetBlipRouteColour(Blip, 6)
				end
			end)
			SetBlipColour(Blip, 1)
			SetBlipAlpha(Blip, 60)
			SetBlipFlashes(Blip, true)
			SetBlipFlashInterval(Blip, 200)

			Citizen.Wait(Config.BlipTime * 1000)

			RemoveBlip(Blip)
			Blip = nil
		end)
	end
end)
