ESX = nil
local HasAlreadyEnteredMarker = false
local LastZone, CurrentAction, CurrentActionMsg
local busy = false
local Keys = {
    ["ESC"] = 322,["F1"] = 288,["F2"] = 289,["F3"] = 170,["F5"] = 166,["F6"] = 167,["F7"] = 168,["F8"] = 169,["F9"] = 56,["F10"] = 57,["~"] = 243,["1"] = 157,
    ["2"] = 158,["3"] = 160,["4"] = 164,["5"] = 165,["6"] = 159,["7"] = 161,["8"] = 162,["9"] = 163,["-"] = 84,["="] = 83,["BACKSPACE"] = 177,["TAB"] = 37,["Q"] = 44,
    ["W"] = 32,["E"] = 38,["R"] = 45,["T"] = 245,["Y"] = 246,["U"] = 303,["P"] = 199,["["] = 39,["]"] = 40,["ENTER"] = 18,["CAPS"] = 137,["A"] = 34,["S"] = 8,
    ["D"] = 9,["F"] = 23,["G"] = 47,["H"] = 74,["K"] = 311,["L"] = 182,["LEFTSHIFT"] = 21,["Z"] = 20,["X"] = 73,["C"] = 26,["V"] = 0,["B"] = 29,["N"] = 249,["M"] = 244,
    [","] = 82,["."] = 81,["LEFTCTRL"] = 36,["LEFTALT"] = 19,["SPACE"] = 22,["RIGHTCTRL"] = 70,["HOME"] = 213,["PAGEUP"] = 10,["PAGEDOWN"] = 11,["DELETE"] = 178,["LEFT"] = 174,
    ["RIGHT"] = 175,["TOP"] = 27,["DOWN"] = 173,["NENTER"] = 201,["N4"] = 108,["N5"] = 60,["N6"] = 107,["N+"] = 96,["N-"] = 97,["N7"] = 117,["N8"] = 61,["N9"] = 118
}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(10)
    end

end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerCoords = GetEntityCoords(PlayerPedId())
		local isInMarker, letSleep, currentZone = false, true

		local distance = #(playerCoords - vector3(-83.6, 6234.52, 31.08))
		local distance2 = #(playerCoords - vector3(-102.04, 6206.2, 30.04))
		local distance3 = #(playerCoords - vector3(-595.8, -887.52, 24.56))

		if distance < 30 then
			letSleep = false

			DrawMarker(1, -83.6, 6234.52, 30.08, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.0, 3.0, 1.5, 30, 30, 250, 100, false, true, 2, false, nil, nil, false)
			

			if distance < 2.0 then
				isInMarker, currentZone = true, 'Wash'
			end
		end

		if distance2 < 30 then
			letSleep = false

			DrawMarker(1, -102.04, 6206.2, 30.04, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.0, 3.0, 1.5, 30, 30, 250, 100, false, true, 2, false, nil, nil, false)


			if distance2 < 2.0 then
				isInMarker, currentZone = true, 'Pack'
			end
		end

		if distance3 < 30 then
			letSleep = false

			DrawMarker(1, -595.8, -887.52, 24.56, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.0, 3.0, 1.5, 30, 30, 250, 100, false, true, 2, false, nil, nil, false)


			if distance3 < 2.0 then
				isInMarker, currentZone = true, 'Sell'
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker, LastZone = true, currentZone
			LastZone = currentZone
			TriggerEvent('meat:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('meat:hasExitedMarker', LastZone)
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

AddEventHandler('meat:hasEnteredMarker', function(zone)
	if zone == 'Wash' then
		CurrentAction = 'Wash'
		CurrentActionMsg = ('[~g~E~s~]清洗/切割肉品')
		CurrentActionData = {}
	elseif zone == 'Pack' then
		CurrentAction = 'Pack'
		CurrentActionMsg = ('[~g~E~s~]包裝肉品')
		CurrentActionData = {}
	elseif zone == 'Sell' then
		CurrentAction = 'Sell'
		CurrentActionMsg = ('[~g~E~s~]販售肉品')
		CurrentActionData = {}
	end
end)

-- Exited Marker
AddEventHandler('meat:hasExitedMarker', function()
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) then
				if CurrentAction == 'Wash' then
					TriggerServerEvent('meat:wash')
				elseif CurrentAction == 'Pack' then
					TriggerServerEvent('meat:pack')
				elseif CurrentAction == 'Sell' then
					TriggerServerEvent('meat:sell')
				end

				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('meat:fu')
AddEventHandler('meat:fu', function()
    Citizen.CreateThread(function()
        Citizen.Wait(0)
        busy = true
        while busy do
            Citizen.Wait(0)
            FreezeEntityPosition(PlayerPedId(), true)
        end
    end)
end)

RegisterNetEvent('meat:unfu')
AddEventHandler('meat:unfu', function()
    busy = false
    while true do
        Citizen.Wait(0)
        if busy == false then
            FreezeEntityPosition(PlayerPedId(), false)
        end
    end
end)

local blips = {
	{title = "打獵場",colour = 0,id = 442,x = -679.91, y = 5800.04,z = 17.33},
	{title = "肉品-包裝場",colour = 3,id = 233,x = -83.16,y = 6234.48,z = 30.08},
	{title = "肉品-販售處",colour = 3,id = 233,x = -595.8,y = -887.52,z = 25.56}
}

Citizen.CreateThread(function()

    for _, info in pairs(blips) do
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.blip, info.id)
        SetBlipDisplay(info.blip, 4)
        SetBlipScale(info.blip, 1.0)
        SetBlipColour(info.blip, info.colour)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(info.blip)
    end
end)