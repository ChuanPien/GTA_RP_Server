ESX = nil
searching = false
cachedDumpsters = {}
local HasAlreadyEnteredMarker = false
local LastZone, CurrentAction, CurrentActionMsg

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

local blip = AddBlipForCoord(388.2, -874.44, 29.28)

SetBlipSprite(blip, 409)
SetBlipDisplay(blip, 4)
SetBlipScale(blip, 0.8)
SetBlipColour(blip, 48)
SetBlipAsShortRange(blip, true)
BeginTextCommandSetBlipName("STRING")
AddTextComponentString("回收場")
EndTextCommandSetBlipName(blip)

Citizen["CreateThread"](function()
    while true do
        local sleepThread = 750
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        if searching then
            DisableControls()
        end -- Prevent cancel the animation and walk away
        for i = 1, #Config["Dumpsters"] do
            local entity = GetClosestObjectOfType(playerCoords, 1.0, GetHashKey(Config["Dumpsters"][i]), false, false,false)
            local entityCoords = GetEntityCoords(entity)

            if DoesEntityExist(entity) then
                sleepThread = 5
                if IsControlJustReleased(0, 38) then
                    if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
                        if not cachedDumpsters[entity] then
                            Search(entity)
                        else
                            exports['mythic_notify']:DoHudText('error', '已撿過')
                        end
                    else
                        exports['mythic_notify']:DoHudText('error', '請下車')
                    end
                end
                DrawText3D(entityCoords + vector3(0.0, 0.0, 1.5), Strings["Search"])
                break
            end
        end

        Citizen["Wait"](sleepThread)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
            local playerCoords = GetEntityCoords(PlayerPedId())
            local isInMarker, letSleep, currentZone = false, true

            local distance = #(playerCoords - vector3(388.03, -874.86, 29.29))

            if distance <= 5.0 then
                letSleep = 5

                if distance <= 1.5 then
                    isInMarker, currentZone = true, 'Sell'
                end
            end

            if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
                HasAlreadyEnteredMarker, LastZone = true, currentZone
                LastZone = currentZone
                TriggerEvent('baz:hasEnteredMarker', currentZone)
            end

            if not isInMarker and HasAlreadyEnteredMarker then
                HasAlreadyEnteredMarker = false
                TriggerEvent('baz:hasExitedMarker', LastZone)
            end

            if letSleep then
                Citizen.Wait(500)
            end
        end
    end
end)

AddEventHandler('baz:hasEnteredMarker', function(zone)
	if zone == 'Sell' then
		CurrentAction = 'Sell'
		CurrentActionMsg = ('[~g~E~s~]販售回收')
		CurrentActionData = {}
	end
end)

-- Exited Marker
AddEventHandler('baz:hasExitedMarker', function()
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) then
				if CurrentAction == 'Sell' then
					Sell()
				end

				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)

DrawText3D = function(coords, text)
    SetDrawOrigin(coords)
    SetTextScale(0.35, 0.35)
    SetTextFont(0)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(0.0, 0.0)
    DrawRect(0.0, 0.0125, 0.015 + text:gsub("~.-~", ""):len() / 370, 0.03, 45, 45, 45, 0)
    ClearDrawOrigin()
end

Search = function(entity)
    searching = true
    cachedDumpsters[entity] = true
    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
    Citizen.Wait(10000)
    TriggerServerEvent("esx-ecobottles:retrieveBottle")
    searching = false
    ClearPedTasks(PlayerPedId())
end

DisableControls = function()
    DisableControlAction(0, 73) -- X (Handsup)
    DisableControlAction(0, 323) -- X (Reset)
    DisableControlAction(0, 288) -- F1 (Phone)
    DisableControlAction(0, 289) -- F2 (Inventory)
    DisableControlAction(0, 170) -- F3 (Menu)
    DisableControlAction(0, 166) -- F5 (Menu)
    DisableControlAction(0, 167) -- F6 (Menu)
    DisableControlAction(0, 20) -- Z
end

function Sell()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), "Sell", {
		elements = {
			{label = ('紙杯'),value = "paperbottle"},
			{label = ('鐵罐'),value = "tincan"},
			{label = ('厚紙板'),value = "cardboard"},
			{label = ('玻璃罐'),value = "glassjar"},
			{label = ('筆記本'),value = "notepad"},
			{label = ('寶特瓶'),value = "bottle"}
		}
	}, function(data, menu)
        TriggerServerEvent('baz:sell',data.current.value)
    end, function(data, menu)
		menu.close()
	end)
end