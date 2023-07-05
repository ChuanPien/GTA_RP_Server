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

local blips = {
	{title = "漁獲-魚攤",x = -743.88, y = -1411.64, z = 4.0},
	{title = "漁獲-加工處",x = -1602.44, y = 5205.08, z = 3.32}
}

Citizen.CreateThread(function()
    for _, info in pairs(blips) do
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.blip, 68)
        SetBlipDisplay(info.blip, 4)
        SetBlipScale(info.blip, 1.0)
        SetBlipColour(info.blip, 49)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(info.blip)
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
			local playerCoords = GetEntityCoords(PlayerPedId())
			local isInMarker, letSleep, currentZone = false, true

			local distance = #(playerCoords - vector3(-1602.24, 5205.0, 4.32))
			local distance2 = #(playerCoords - vector3(-743.76, -1411.72, 5.0))
			local distance3 = #(playerCoords - vector3(-623.28, -233.24, 38.04))
			local distance4 = #(playerCoords - vector3(2820.8, -741.24, 2.04))
			local distance5 = #(playerCoords - vector3(-1607.36, 5202.92, 4.32))

			if distance < 40 then
				letSleep = false

				DrawMarker(1, -1602.24, 5205.0, 3.32, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.0, 3.0, 1.5, 120, 30, 120, 100, false, true, 2, false, nil, nil, false)
				

				if distance < 2.0 then
					isInMarker, currentZone = true, 'Pack'
				end
			end

			if distance2 < 30 then
				letSleep = false

				-- DrawMarker(1, -743.76, -1411.72, 4.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.0, 3.0, 1.5, 120, 30, 120, 100, false, true, 2, false, nil, nil, false)


				if distance2 < 2.0 then
					isInMarker, currentZone = true, 'Sell'
				end
			end

			if distance3 < 30 then
				letSleep = false

				-- DrawMarker(1, -623.28, -233.24, 37.04, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.0, 3.0, 1.5, 120, 30, 120, 100, false, true, 2, false, nil, nil, false)


				if distance3 < 2.0 then
					isInMarker, currentZone = true, 'Sell2'
				end
			end

			if distance4 < 30 then
				letSleep = false

				-- DrawMarker(1, 2820.8, -741.24, 1.04, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.0, 3.0, 1.5, 120, 30, 120, 100, false, true, 2, false, nil, nil, false)


				if distance4 < 2.0 then
					isInMarker, currentZone = true, 'Sell3'
				end
			end

			if distance5 < 30 then
				letSleep = false

				if distance5 < 1.0 then
					isInMarker, currentZone = true, 'Q'
				end
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker, LastZone = true, currentZone
				LastZone = currentZone
				TriggerEvent('fish:hasEnteredMarker', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('fish:hasExitedMarker', LastZone)
			end

			if letSleep then
				Citizen.Wait(500)
			end
		end
	end
end)

AddEventHandler('fish:hasEnteredMarker', function(zone)
	if zone == 'Pack' then
		CurrentAction = 'Pack'
		CurrentActionMsg = ('[~g~E~s~]加工漁獲')
		CurrentActionData = {}
	elseif zone == 'Sell' then
		CurrentAction = 'Sell'
		CurrentActionMsg = ('[~g~E~s~]販售魚獲')
		CurrentActionData = {}
	elseif zone == 'Sell2' then
		CurrentAction = 'Sell2'
		CurrentActionMsg = ('[~g~E~s~]販售珍珠')
		CurrentActionData = {}
	elseif zone == 'Sell3' then
		CurrentAction = 'Sell3'
		CurrentActionMsg = ('[~g~E~s~]販售保育類')
		CurrentActionData = {}
	elseif zone == 'Q' then
		CurrentAction = 'Q'
		CurrentActionMsg = ('[~g~E~s~]詢問')
		CurrentActionData = {}
	end
end)

-- Exited Marker
AddEventHandler('fish:hasExitedMarker', function()
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) then
				if CurrentAction == 'Pack' then
					Pack()
				elseif CurrentAction == 'Sell' then
					TriggerServerEvent('fish:Sell')
				elseif CurrentAction == 'Sell2' then
					TriggerServerEvent('fish:Sell2')
				elseif CurrentAction == 'Sell3' then
					TriggerServerEvent('fish:Sell3')
				elseif CurrentAction == 'Q' then
					Q()
				end

				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('fish:fu')
AddEventHandler('fish:fu', function()
    Citizen.CreateThread(function()
        Citizen.Wait(0)
        busy = true
        while busy do
            Citizen.Wait(0)
            FreezeEntityPosition(PlayerPedId(), true)
			DisableControlAction(0, 289, true)
        end
    end)
end)

RegisterNetEvent('fish:unfu')
AddEventHandler('fish:unfu', function()
    busy = false
    while true do
        Citizen.Wait(0)
        if busy == false then
            FreezeEntityPosition(PlayerPedId(), false)
        end
    end
end)

function Pack()
	if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), "fish", {
			title = ('漁獲加工處'),
			elements = {
				{label = ('鯛魚肉塊'),value = "fishmeat"},
				{label = ('蝦仁'),value = "shrimp"},
				-- {label = ('魚翅'),value = "sharkfin"},
				{label = ('海龜肉'),value = "turtlemeat"}
			}
		}, function(data, menu)
			Count(data.current.value)
		end, function(data, menu)
			menu.close()
		end)
	else
		exports['mythic_notify']:DoHudText('error', '請下車')
	end
end

function Count(type)
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'fish', {
			title = ('愈加工數量')
		}, function(data, menu)
		local amount = tonumber(data.value)
		if amount ~= nil then
			ESX.TriggerServerCallback('fish:count',function(vild)
				if vild == false then
					exports['mythic_notify']:DoHudText('error', '錯誤數量/物品')
					menu.close()
				else
					menu.close()
					TriggerServerEvent('fish:Pack',type ,amount)
					TriggerEvent("fish:fu")
				end
			end,type ,amount)
		else
			exports['mythic_notify']:DoHudText('error', '錯誤數量/物品')
			menu.close()
		end
	end, function(data, menu)
		menu.close()
	end)
end

function Q()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), "fish", {
		title = ('漁獲'),
		elements = {
			{label = ('釣魚竿'),value = "fishingrod"},
			{label = ('餌料口袋'),value = "autofish"},
			{label = ('近海漁獲'),value = "fish"},
			{label = ('遠洋漁獲'),value = "overfish"}
		}
	}, function(data, menu)
			if data.current.value == 'fishingrod' then
				ESX.ShowAdvancedNotification('老漁夫', '[釣魚竿]', '可以自己製作或跟他人購買，製作需要到~y~工作臺~s~，材料需要~b~切割木板/線/鐵鉤', 'CHAR_BOATSITE')
			elseif data.current.value == 'autofish' then
				ESX.ShowAdvancedNotification('老漁夫', '[餌料口袋]', '在釣魚時，[~g~N+~s~]口袋可~b~快速選擇餌料', 'CHAR_BOATSITE')
			elseif data.current.value == 'fish' then
				ESX.ShowAdvancedNotification('老漁夫', '[近海漁獲]', '~g~鯛魚/沙丁魚/鯖魚/蝦子/龍蝦/章魚\n~r~海龜', 'CHAR_BOATSITE')
			elseif data.current.value == 'overfish' then
				ESX.ShowAdvancedNotification('老漁夫', '[遠洋漁獲]', '~g~鯛魚/沙丁魚/鯖魚/白帶魚/大口黑鱸/龍膽石斑/黃鰭鮪魚/蝦子/龍蝦/章魚/~r~海龜/鯊魚', 'CHAR_BOATSITE')
			end
		end, function(data, menu)
			menu.close()
	end)
end
