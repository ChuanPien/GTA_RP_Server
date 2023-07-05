local Keys = {
    ["ESC"] = 322,
    ["F1"] = 288,
    ["F2"] = 289,
    ["F3"] = 170,
    ["F5"] = 166,
    ["F6"] = 167,
    ["F7"] = 168,
    ["F8"] = 169,
    ["F9"] = 56,
    ["F10"] = 57,
    ["~"] = 243,
    ["1"] = 157,
    ["2"] = 158,
    ["3"] = 160,
    ["4"] = 164,
    ["5"] = 165,
    ["6"] = 159,
    ["7"] = 161,
    ["8"] = 162,
    ["9"] = 163,
    ["-"] = 84,
    ["="] = 83,
    ["BACKSPACE"] = 177,
    ["TAB"] = 37,
    ["Q"] = 44,
    ["W"] = 32,
    ["E"] = 38,
    ["R"] = 45,
    ["T"] = 245,
    ["Y"] = 246,
    ["U"] = 303,
    ["P"] = 199,
    ["["] = 39,
    ["]"] = 40,
    ["ENTER"] = 18,
    ["CAPS"] = 137,
    ["A"] = 34,
    ["S"] = 8,
    ["D"] = 9,
    ["F"] = 23,
    ["G"] = 47,
    ["H"] = 74,
    ["K"] = 311,
    ["L"] = 182,
    ["LEFTSHIFT"] = 21,
    ["Z"] = 20,
    ["X"] = 73,
    ["C"] = 26,
    ["V"] = 0,
    ["B"] = 29,
    ["N"] = 249,
    ["M"] = 244,
    [","] = 82,
    ["."] = 81,
    ["LEFTCTRL"] = 36,
    ["LEFTALT"] = 19,
    ["SPACE"] = 22,
    ["RIGHTCTRL"] = 70,
    ["HOME"] = 213,
    ["PAGEUP"] = 10,
    ["PAGEDOWN"] = 11,
    ["DELETE"] = 178,
    ["LEFT"] = 174,
    ["RIGHT"] = 175,
    ["TOP"] = 27,
    ["DOWN"] = 173,
    ["NENTER"] = 201,
    ["N4"] = 108,
    ["N5"] = 60,
    ["N6"] = 107,
    ["N+"] = 96,
    ["N-"] = 97,
    ["N7"] = 117,
    ["N8"] = 61,
    ["N9"] = 118
}

ESX = nil

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


local HasAlreadyEnteredMarker = false
local LastZone, CurrentAction, CurrentActionMsg

local AnimalPositions = {{
    x = -770.59,
    y = 5925.96,
    z = 20.78
}, {
    x = -792.68,
    y = 5814.85,
    z = 14.86
}, {
    x = -736.33,
    y = 5845.18,
    z = 19.57
}, {
    x = -702.17,
    y = 5995.31,
    z = 13.41
}, {
    x = -631.42,
    y = 5960.73,
    z = 18.0
}, {
    x = -565.24,
    y = 5917.97,
    z = 30.79
}, {
    x = -538.86,
    y = 5856.76,
    z = 33.21
}}

local AnimalsInSession = {}
local OnGoingHuntSession = false
local type = nil

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
        if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
            local playerCoords = GetEntityCoords(PlayerPedId())
            local isInMarker, letSleep, currentZone = false, true
            local distance = #(playerCoords - vector3(-679.91, 5800.04, 17.15))
            local distance2 = #(playerCoords - vector3(-682.56, 5801.2, 17.15))
            local distance3 = #(playerCoords - vector3(-677.29, 5798.86, 17.15))

            if OnGoingHuntSession == false then
                if distance < 20 then
                    letSleep = false
                    DrawMarker(1, -679.91, 5800.04, 16.15, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 30, 30, 250, 100, false, true, 2, false, false,false, false)

                    if distance < 1.5 then
                        isInMarker, currentZone = true, 'start'
                    end
                end
            end

            if distance2 < 20 then
                letSleep = false
                DrawMarker(1, -682.56, 5801.2, 16.15, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 30, 30, 250, 100, false, true, 2, false, false,false, false)

                if distance2 < 1.5 then
                    isInMarker, currentZone = true, 'end'
                end
            end

            -- if distance3 < 20 then
            --     letSleep = false
            --     DrawMarker(1, -677.21, 5799.22, 16.15, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 0, 250, 0, 100, false, true, 2, false, false,false, false)

            --     if distance3 < 1.5 then
            --         isInMarker, currentZone = true, 'rent'
            --     end
            -- end

            if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
                HasAlreadyEnteredMarker, LastZone = true, currentZone
                LastZone = currentZone
                TriggerEvent('shafat-henhunting:hasEnteredMarker', currentZone)
            end

            if not isInMarker and HasAlreadyEnteredMarker then
                HasAlreadyEnteredMarker = false
                TriggerEvent('shafat-henhunting:hasExitedMarker', LastZone)
            end

            if letSleep then
                Citizen.Wait(500)
            end
        end
	end
end)

-- Entered Marker
AddEventHandler('shafat-henhunting:hasEnteredMarker', function(zone)
	if zone == 'start' then
		CurrentAction = 'start'
		CurrentActionMsg = ('[~g~E~s~]開始打獵')
		CurrentActionData = {}
	elseif zone == 'end' then
		CurrentAction = 'end'
		CurrentActionMsg = ('[~g~E~s~]結束打獵')
		CurrentActionData = {}
	elseif zone == 'rent' then
		CurrentAction = 'rent'
		CurrentActionMsg = ('[~g~E~s~]借用打獵車')
		CurrentActionData = {}
	end
end)

-- Exited Marker
AddEventHandler('shafat-henhunting:hasExitedMarker', function()
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) then

				if CurrentAction == 'start' then
				    StartHunting()
				elseif CurrentAction == 'end' then
                    EndHunting()
                elseif CurrentAction == 'rent' then
                    HuntingCarMenu()
				end

				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)

function StartHunting()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), "henhunting", {
        title = ('打獵場'),
        elements = {{label = ('雞'),value = 'hen' },
                    {label = ('牛'),value = 'cow' },
                    {label = ('鹿'),value = 'deer'},
                    {label = ('山豬'),value = 'boar'}}
        }, function(data, menu)
            menu.close()
        StartHuntingSession(data.current.value)
    end)
end

function EndHunting()
    OnGoingHuntSession = false
    type = nil
    RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_KNIFE"), true, true)
    RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_MUSKET"), true, true)
    exports['mythic_notify']:DoHudText('error', '小刀')
    exports['mythic_notify']:DoHudText('error', '老式火槍')

    for index, value in pairs(AnimalsInSession) do
        if DoesEntityExist(value.id) then
            DeleteEntity(value.id)
        end
    end
    exports['mythic_notify']:DoHudText('inform', '結束打獵')
end

function HuntingCarMenu()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), "car1", {
        title = ('租車'),
        elements = {{label = ('大型越野車'),value = "hog"},
                    {label = ('小型越野車'),value = "outlaw"}}
        }, function(data, menu)
        menu.close()
        HuntingCar(data.current.value)
    end)
end

function HuntingCar(hcar)
    ESX.Game.SpawnVehicle(hcar, Config.car.Spawner, Config.car.Heading, function(hcar)
        SetVehRadioStation(hcar, "OFF")
        SetVehicleFixed(hcar)
        SetVehicleDeformationFixed(hcar)
        SetVehicleUndriveable(hcar, false)
        SetVehicleEngineOn(hcar, true, true)
        SetVehicleDirtLevel(hcar)
        SetVehicleNumberPlateText(hcar, "Hunting")
        TaskWarpPedIntoVehicle(PlayerPedId(), hcar, -1)

        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(0)
                local plyCoords = GetEntityCoords(PlayerPedId())
                local distance = GetDistanceBetweenCoords(plyCoords, -663.85, 5797.85, 16.15, true)
                if distance < 40.0 then
                    DrawMarker(1, -663.85, 5797.85, 16.15, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0, 1.5, 255, 0, 0, 100, false, true, 2, false, false,false, false)
                    if distance < 3.0 then
                        DisplayHelpText('[~g~E~s~]歸還打獵車')
                        if IsControlJustReleased(0, Keys['E']) then
                            if IsPedInAnyVehicle(GetPlayerPed(-1)) then
                                if  IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true),GetHashKey("outlaw")) or
                                    IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey("hog")) then
                                    DeleteVehicle(hcar)
                                    exports['mythic_notify']:DoHudText('success', '成功歸還')
                                else
                                    exports['mythic_notify']:DoHudText('error', '限歸還打獵車')
                                end
                            else
                                exports['mythic_notify']:DoHudText('error', '請上車')
                            end
                        end
                    end
                end
            end
        end)
    end)
end

function StartHuntingSession(type)

    OnGoingHuntSession = true

    GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_MUSKET"), 40, true, false)
    GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_KNIFE"), 20, true, false)
    exports['mythic_notify']:DoHudText('success', '小刀')
    exports['mythic_notify']:DoHudText('success', '老式火槍')
    ESX.ShowAdvancedNotification('懶欣打獵場', '打獵教官', '切記!小刀及獵槍不要拿去犯罪，記得歸還阿!', 'CHAR_JOSEF',1)


    Citizen.CreateThread(function()
        type = type
        if type == 'hen' then
            LoadModel('a_c_hen')
            for index, value in pairs(AnimalPositions) do

                local Animal = CreatePed(80, GetHashKey('a_c_hen'), value.x, value.y, value.z, 0.0, true, false)
                TaskWanderStandard(Animal, true, true)
                SetEntityAsMissionEntity(Animal, true, true)
                -- Blips

                local AnimalBlip = AddBlipForEntity(Animal)
                SetBlipSprite(AnimalBlip, 153)
                SetBlipColour(AnimalBlip, 1)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString('雞')
                EndTextCommandSetBlipName(AnimalBlip)

                table.insert(AnimalsInSession, {
                    id = Animal,
                    x = value.x,
                    y = value.y,
                    z = value.z,
                    Blipid = AnimalBlip
                })
            end
        elseif type == 'cow' then
            LoadModel('a_c_cow')
            for index, value in pairs(AnimalPositions) do

                local Animal = CreatePed(80, GetHashKey('a_c_cow'), value.x, value.y, value.z, 0.0, true, false)
                TaskWanderStandard(Animal, true, true)
                SetEntityAsMissionEntity(Animal, true, true)
                -- Blips

                local AnimalBlip = AddBlipForEntity(Animal)
                SetBlipSprite(AnimalBlip, 153)
                SetBlipColour(AnimalBlip, 1)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString('牛')
                EndTextCommandSetBlipName(AnimalBlip)

                table.insert(AnimalsInSession, {
                    id = Animal,
                    x = value.x,
                    y = value.y,
                    z = value.z,
                    Blipid = AnimalBlip
                })
            end
        elseif type == 'deer' then
            LoadModel('a_c_deer')
            for index, value in pairs(AnimalPositions) do

                local Animal = CreatePed(80, GetHashKey('a_c_deer'), value.x, value.y, value.z, 0.0, true, false)
                TaskWanderStandard(Animal, true, true)
                SetEntityAsMissionEntity(Animal, true, true)
                -- Blips

                local AnimalBlip = AddBlipForEntity(Animal)
                SetBlipSprite(AnimalBlip, 153)
                SetBlipColour(AnimalBlip, 1)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString('鹿')
                EndTextCommandSetBlipName(AnimalBlip)

                table.insert(AnimalsInSession, {
                    id = Animal,
                    x = value.x,
                    y = value.y,
                    z = value.z,
                    Blipid = AnimalBlip
                })
            end
        else
            LoadModel('a_c_boar')
            for index, value in pairs(AnimalPositions) do

                local Animal = CreatePed(80, GetHashKey('a_c_boar'), value.x, value.y, value.z, 0.0, true, false)
                TaskWanderStandard(Animal, true, true)
                SetEntityAsMissionEntity(Animal, true, true)
                -- Blips

                local AnimalBlip = AddBlipForEntity(Animal)
                SetBlipSprite(AnimalBlip, 153)
                SetBlipColour(AnimalBlip, 1)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString('山豬')
                EndTextCommandSetBlipName(AnimalBlip)

                table.insert(AnimalsInSession, {
                    id = Animal,
                    x = value.x,
                    y = value.y,
                    z = value.z,
                    Blipid = AnimalBlip
                })
            end
        end

        while OnGoingHuntSession do
            local sleep = 500
            for index, value in ipairs(AnimalsInSession) do
                if DoesEntityExist(value.id) then
                    local playerPed = PlayerPedId()
                    local AnimalCoords = GetEntityCoords(value.id)
                    local PlyCoords = GetEntityCoords(PlayerPedId())
                    local AnimalHealth = GetEntityHealth(value.id)

                    local PlyToAnimal = GetDistanceBetweenCoords(PlyCoords, AnimalCoords, true)

                    if type == 'cow' then
                        if AnimalHealth > 0 then
                            if PlyToAnimal < 2.0 then
                                sleep = 5
                                DisplayHelpText("[~g~F~s~]擠奶")
                                if IsControlJustReleased(0, Keys['F']) then
                                    if DoesEntityExist(value.id) then
                                        ESX.TriggerServerCallback('shafat-henhunting:bottle', function(vild)
                                            if vild == true then
                                                TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
                                                Citizen.Wait(10000)
                                                TriggerServerEvent('shafat-henhunting:milk')
                                                ClearPedTasks(PlayerPedId())
                                            else
                                                exports['mythic_notify']:DoHudText('error', '無玻璃罐')
                                            end
                                        end)
                                    end
                                end
                            end
                        end
                    end

                    if AnimalHealth <= 0 then
                        SetBlipColour(value.Blipid, 3)
                        if PlyToAnimal < 2.0 then
                            sleep = 5
                            DisplayHelpText("[~g~E~s~]割肉")

                            if IsControlJustReleased(0, Keys['E']) then
                                if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_KNIFE') then
                                    if DoesEntityExist(value.id) then
                                        table.remove(AnimalsInSession, index)
                                        RequestAnimDict("amb@medic@standing@kneel@base")
                                        while (not TaskStartScenarioInPlace(PlayerPedId(), "base", 0, true)) do
                                            Citizen.Wait(0)
                                        end
                                        TaskPlayAnim(PlayerPedId(),"amb@medic@standing@kneel@base","base",8.0, -8.0, -1, 1, 0, 0, 0, 0)
                                        RequestAnimDict("anim@gangops@facility@servers@bodysearch@")
                                        while (not TaskStartScenarioInPlace(PlayerPedId(), "player_search", 0, true)) do
                                            Citizen.Wait(0)
                                        end
                                        TaskPlayAnim(PlayerPedId(),"anim@gangops@facility@servers@bodysearch@","player_search",8.0, -8.0, -1, 48, 0, 0, 0, 0)
                                        exports['mythic_notify']:DoCustomHudText('inform', '採集中...',5000)
                                        Citizen.Wait(5000)
                                        ClearPedTasksImmediately(PlayerPedId())
                                        DeleteEntity(value.id)
                                        TriggerServerEvent('shafat-henhunting:reward', type)
                                    end
                                else
                                    exports['mythic_notify']:DoHudText('error', '需持小刀')
                                end
                            end

                        end
                    end
                end
            end
            Citizen.Wait(sleep)
        end
    end)
end

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end
end

function LoadModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(10)
    end
end

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
