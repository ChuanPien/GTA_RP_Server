Key = 38 -- E

vehicleWashStation = {
	vec(26.5906,  -1392.0261,  27.3634),
	vec(167.1034,  -1719.4704,  27.2916),
	vec(-74.5693,  6427.8715,  29.4400),
	vec(-699.6325,  -932.7043,  17.0139),
	vec(1362.5385, 3592.1274, 33.9211),
	vec(234.64, -751.8, 34.72)
}
Citizen.CreateThread(function()
	local currentGasBlip = 0

	while true do
		local coords = GetEntityCoords(PlayerPedId())
		local closest = 8000
		local closestCoords

		for _, vehicleWashStation in pairs(vehicleWashStation) do
			local dstcheck = GetDistanceBetweenCoords(coords, vehicleWashStation)

			if dstcheck < closest then
				closest = dstcheck
				closestCoords = vehicleWashStation
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
	SetBlipSprite(blip, 100)
	SetBlipColour(blip, 1)
	SetBlipScale(blip, 1.0)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName("洗車站")
	EndTextCommandSetBlipName(blip)
	return blip
end

local timer2 = false
local mycie = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

function es_better_carwash_DrawSubtitleTimed(m_text, showtime)
	SetTextEntry_2('STRING')
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end

function es_better_carwash_DrawNotification(m_text)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(m_text)
	DrawNotification(true, false)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedSittingInAnyVehicle(PlayerPedId()) then 
			for i = 1, #vehicleWashStation do
				garageCoords2 = vehicleWashStation[i]
				if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), garageCoords2[1], garageCoords2[2], garageCoords2[3], true ) < 5 then
					if mycie == false then
						hintToDisplay('[~g~E~s~]洗車~g~$500')
						if IsControlJustPressed(1, Key) then
							TriggerServerEvent('es_better_carwash:checkMoney',500)
						end
					end
				end
			end	
		end
	end
end)

RegisterNetEvent('es_better_carwash:success')
AddEventHandler('es_better_carwash:success', function()
	local car = GetVehiclePedIsUsing(PlayerPedId())
	local coords = GetEntityCoords(PlayerPedId())
	FreezeEntityPosition(car, true)
	mycie = true
	if not HasNamedPtfxAssetLoaded("core") then
		RequestNamedPtfxAsset("core")
		while not HasNamedPtfxAssetLoaded("core") do
			Wait(1)
		end
	end
	UseParticleFxAssetNextCall("core")
	particles  = StartParticleFxLoopedAtCoord("ent_amb_waterfall_splash_p", coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
	UseParticleFxAssetNextCall("core")
	particles2  = StartParticleFxLoopedAtCoord("ent_amb_waterfall_splash_p", coords.x + 2, coords.y, coords.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
	Citizen.CreateThread(function()
		local counter = 0
		
		counter = GetVehicleDirtLevel(car) * 2

		while counter > 0 do
			Citizen.Wait(0)
			hintToDisplay(' ~INPUT_JUMP~ 清潔 ~y~' .. math.floor(counter))
			if IsControlJustPressed(0, 22) then
				counter = counter - 1
			end
		end
		WashDecalsFromVehicle(car, 1.0)
		SetVehicleDirtLevel(car)
		FreezeEntityPosition(car, false)
		exports['mythic_notify']:DoHudText('success', '已清潔')
		StopParticleFxLooped(particles, 0)
		StopParticleFxLooped(particles2, 0)
		mycie = false
    end)
end)

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end

function hintToDisplay(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
