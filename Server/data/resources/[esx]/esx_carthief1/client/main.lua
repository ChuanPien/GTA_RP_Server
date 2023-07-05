ESX = nil
local PlayerData = {}
local currentZone = ''
local LastZone = ''
local CurrentAction = nil
local CurrentActionMsg = ''
local CurrentActionData = {}

local alldeliveries = {}
local randomdelivery = 1
local isTaken = 0
local CopNote = 0
local isDelivered = 0
local car = 0
local copblip
local deliveryblip

local timer = 600
local Maxtimer = 60

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

-- Add all deliveries to the table
Citizen.CreateThread(function()
    local deliveryids = 1
    for k, v in pairs(Config.Delivery) do
        table.insert(alldeliveries, {
            id = deliveryids,
            posx = v.Pos.x,
            posy = v.Pos.y,
            posz = v.Pos.z,
            payment = v.Payment,
            car = v.Cars
        })
        deliveryids = deliveryids + 1
    end
end)

function SpawnCar()
    ESX.TriggerServerCallback('esx_carthief1:isActive', function(isActive, cooldown)
        if cooldown <= 0 then
            if isActive == 0 then
                ESX.TriggerServerCallback('esx_carthief1:anycops', function(anycops)
                    if anycops >= Config.CopsRequired then

                        exports['mythic_notify']:DoHudText('error', '秘密走私開始')
                        ESX.ShowAdvancedNotification('秘密走私', 0, '~y~送貨到這，會給你合理報酬的', 'CHAR_DETONATEPHONE')
                        ESX.ShowAdvancedNotification('秘密走私', 0, '~r~時速 >= 70 / 碰撞 將觸發警報', 'CHAR_DETONATEPHONE')
                        TriggerServerEvent('esx_carthief1:note')

                        -- Get a random delivery point
                        randomdelivery = math.random(1, #alldeliveries)

                        -- Delete vehicles around the area (not sure if it works)
                        ClearAreaOfVehicles(Config.VehicleSpawnPoint.Pos.x, Config.VehicleSpawnPoint.Pos.y, Config.VehicleSpawnPoint.Pos.z, 195.16, false, false, false, false, false)

                        -- Delete old vehicle and remove the old blip (or nothing if there's no old delivery)
                        SetEntityAsNoLongerNeeded(car)
                        DeleteVehicle(car)
                        RemoveBlip(deliveryblip)

                        -- Get random car
                        randomcar = math.random(1, #alldeliveries[randomdelivery].car)

                        -- Spawn Car
                        local vehiclehash = GetHashKey(alldeliveries[randomdelivery].car[randomcar])
                        RequestModel(vehiclehash)
                        while not HasModelLoaded(vehiclehash) do
                            RequestModel(vehiclehash)
                            Citizen.Wait(1)
                        end

                        car = CreateVehicle(vehiclehash, Config.VehicleSpawnPoint.Pos.x, Config.VehicleSpawnPoint.Pos.y, Config.VehicleSpawnPoint.Pos.z, 195.16, true, false)
                        SetEntityAsMissionEntity(car, true, true)

                        -- Teleport player in car
                        TaskWarpPedIntoVehicle(GetPlayerPed(-1), car, -1)

                        -- Set delivery blip
                        deliveryblip = AddBlipForCoord(alldeliveries[randomdelivery].posx,alldeliveries[randomdelivery].posy, alldeliveries[randomdelivery].posz)
                        SetBlipSprite(deliveryblip, 1)
                        SetBlipDisplay(deliveryblip, 4)
                        SetBlipScale(deliveryblip, 1.0)
                        SetBlipColour(deliveryblip, 5)
                        SetBlipAsShortRange(deliveryblip, true)
                        BeginTextCommandSetBlipName("STRING")
                        AddTextComponentString("交車點")
                        EndTextCommandSetBlipName(deliveryblip)

                        SetBlipRoute(deliveryblip, true)
						isTaken = 1
						isDelivered = 0
                        CopNote = 0
                    else
                        exports['mythic_notify']:DoHudText('error', ('警察不足'))
                    end
                end)
            else
                exports['mythic_notify']:DoHudText('error', ('走私中'))
            end
        else
            exports['mythic_notify']:DoHudText('error', '尚無車輛')
        end
    end)
end

function FinishDelivery()
    if (GetVehiclePedIsIn(GetPlayerPed(-1), false) == car) and GetEntitySpeed(car) < 10 then

        SetEntityAsNoLongerNeeded(car)
        DeleteEntity(car)

        RemoveBlip(deliveryblip)

        local finalpayment = alldeliveries[randomdelivery].payment
        TriggerServerEvent('esx_carthief1:pay', finalpayment)

        isTaken = 0
        CopNote = 0
        isDelivered = 1

        TriggerServerEvent('esx_carthief1:stopalertcops')

    else
        TriggerEvent('esx:showNotification', _U('car_provided_rule'))
    end
end

function AbortDelivery()

    RemoveBlip(deliveryblip)

    isTaken = 0
    CopNote = 0
    isDelivered = 1

    TriggerServerEvent('esx_carthief1:stopalertcops')

    Wait(30000)
    SetEntityAsNoLongerNeeded(car)
    DeleteEntity(car)
end

Citizen.CreateThread(function()
    while true do
        Wait(30000)
        if isTaken == 1 and isDelivered == 0 and not (GetVehiclePedIsIn(GetPlayerPed(-1), false) == car) then
            exports['mythic_notify']:DoHudText('note', '回到車上 50s')
            Wait(50000)
            if isTaken == 1 and isDelivered == 0 and not (GetVehiclePedIsIn(GetPlayerPed(-1), false) == car) then
                exports['mythic_notify']:DoHudText('error', '回到車上 10s')
                Wait(10000)
                exports['mythic_notify']:DoHudText('error', _U('mission_failed'))
                AbortDelivery()
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
		Wait(0)

        if isTaken == 1 and isDelivered == 0 and CopNote == 0 then
			local playerPed    = PlayerPedId()
			local vehicle      = GetVehiclePedIsIn(playerPed, false)
            local coords       = GetEntityCoords(GetPlayerPed(-1))
			local speed        = GetEntitySpeed(vehicle) * 3.6
			local engineHealth = GetVehicleEngineHealth(vehicle)

			if speed >= 70 or engineHealth <= 800 then
                TriggerServerEvent('esx_carthief1:alertcops', coords.x, coords.y, coords.z)
				exports['mythic_notify']:DoHudText('error', '警方警報已觸發')
                CopNote = 1
                data = {dispatchCode = 'carthief', caller = _U('caller_local'), coords = coords, netId = NetworkGetNetworkIdFromEntity(playerPed), length = 10000}
                TriggerServerEvent('wf-alerts:svNotify',data)
            end
        end

        Citizen.CreateThread(function()
            while isTaken == 1 and isDelivered == 0 and CopNote == 0 and timer > 0 do
                Citizen.Wait(0)
                DrawTxt(0.66, 1.40, 1.0, 1.0, 0.4, '~y~警方GPS屏蔽倒數~r~' .. timer .. '~y~秒', 255, 255, 255, 255)
                DisableControlAction(0,158)
            end
            while timer == 0 and Maxtimer > 0 and isTaken == 1 and isDelivered == 0 do
                Citizen.Wait(0)
                DrawTxt(0.66, 1.40, 1.0, 1.0, 0.4, '~y~交易剩餘時間~r~' .. Maxtimer .. '~y~秒', 255, 255, 255, 255)
            end
        end)

        if isTaken == 1 and isDelivered == 0 then
            Citizen.Wait(1000)

            if timer > 0 then
                timer = timer - 1
            end

            if timer == 0 and Maxtimer > 0 then
                Maxtimer = Maxtimer - 1
            end

            if Maxtimer <= 0 then
                AbortDelivery()
                ESX.ShowAdvancedNotification('秘密走私', 0, '~r~真沒用!取消交易!', 'CHAR_HUMANDEFAULT')
            end
            if timer <= 0 and CopNote == 0 then
                local coords = GetEntityCoords(GetPlayerPed(-1))
                exports['mythic_notify']:DoHudText('error', '警方警報已觸發')
                ESX.ShowAdvancedNotification('秘密走私', 0, '~r~開快點!位置暴露了!', 'CHAR_HUMANDEFAULT')
                CopNote = 1
                data = {dispatchCode = 'carthief', caller = _U('caller_local'), coords = coords, netId = NetworkGetNetworkIdFromEntity(playerPed), length = 10000}
                TriggerServerEvent('wf-alerts:svNotify',data)
                TriggerServerEvent('esx_carthief1:msg')
            end
        end
    end
end)

-- Send location
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.BlipUpdateTime)
        if CopNote == 1 and IsPedInAnyVehicle(GetPlayerPed(-1)) then
            local coords = GetEntityCoords(GetPlayerPed(-1))
            TriggerServerEvent('esx_carthief1:alertcops', coords.x, coords.y, coords.z)
        elseif CopNote == 1 and not IsPedInAnyVehicle(GetPlayerPed(-1)) then
            TriggerServerEvent('esx_carthief1:stopalertcops')
        end
    end
end)

RegisterNetEvent('esx_carthief1:setnotification')
AddEventHandler('esx_carthief1:setnotification', function()
    ESX.ShowAdvancedNotification('接收器', 0, '有市民正在進行走私活動', 'CHAR_DETONATEPHONE')
end)

RegisterNetEvent('esx_carthief1:boxnote')
AddEventHandler('esx_carthief1:boxnote', function()
    ESX.ShowAdvancedNotification('收購商', 0, '這些~g~紙箱~s~我留著也是垃圾，幫我丟掉吧', 'CHAR_HUMANDEFAULT')
end)

RegisterNetEvent('esx_carthief1:removecopblip')
AddEventHandler('esx_carthief1:removecopblip', function()
    RemoveBlip(copblip)
end)

RegisterNetEvent('esx_carthief1:setcopblip')
AddEventHandler('esx_carthief1:setcopblip', function(cx, cy, cz)
    RemoveBlip(copblip)
    copblip = AddBlipForCoord(cx, cy, cz)
    SetBlipSprite(copblip, 161)
    SetBlipScale(copblipy, 1.5)
    SetBlipColour(copblip, 8)
    PulseBlip(copblip)
end)

AddEventHandler('esx_carthief1:hasEnteredMarker', function(zone)
    if LastZone == 'menucarthief' then
        CurrentAction = 'carthief_menu'
        CurrentActionMsg = _U('steal_a_car')
        CurrentActionData = {
            zone = zone
        }
    elseif LastZone == 'cardelivered' then
        CurrentAction = 'cardelivered_menu'
        CurrentActionMsg = _U('drop_car_off')
        CurrentActionData = {
            zone = zone
        }
    end
end)

AddEventHandler('esx_carthief1:hasExitedMarker', function(zone)
    CurrentAction = nil
    ESX.UI.Menu.CloseAll()
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
    while true do
        Wait(0)
        local coords = GetEntityCoords(GetPlayerPed(-1))
        local isInMarker = false
        local currentZone = nil

        if (GetDistanceBetweenCoords(coords, Config.Zones.VehicleSpawner.Pos.x, Config.Zones.VehicleSpawner.Pos.y,
            Config.Zones.VehicleSpawner.Pos.z, true) < 1.5) then
            isInMarker = true
            currentZone = 'menucarthief'
            LastZone = 'menucarthief'
        end

        if isTaken == 1 and
            (GetDistanceBetweenCoords(coords, alldeliveries[randomdelivery].posx, alldeliveries[randomdelivery].posy,
                alldeliveries[randomdelivery].posz, true) < 3) then
            isInMarker = true
            currentZone = 'cardelivered'
            LastZone = 'cardelivered'
        end

        if isInMarker and not HasAlreadyEnteredMarker then
            HasAlreadyEnteredMarker = true
            TriggerEvent('esx_carthief1:hasEnteredMarker', currentZone)
        end
        if not isInMarker and HasAlreadyEnteredMarker then
            HasAlreadyEnteredMarker = false
            TriggerEvent('esx_carthief1:hasExitedMarker', LastZone)
        end
    end
end)

-- Key Controls
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if CurrentAction ~= nil then
            SetTextComponentFormat('STRING')
            AddTextComponentString(CurrentActionMsg)
            DisplayHelpTextFromStringLabel(0, 0, 1, -1)
            if IsControlJustReleased(0, 38) then
                if CurrentAction == 'carthief_menu' then
                    SpawnCar()
                elseif CurrentAction == 'cardelivered_menu' then
                    FinishDelivery()
                end
                CurrentAction = nil
            end
        end
    end
end)

-- Display markers
Citizen.CreateThread(function()
    while true do
        Wait(0)
        local coords = GetEntityCoords(GetPlayerPed(-1))

        for k, v in pairs(Config.Zones) do
            if (v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
                DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z,
                    v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
            end
        end

    end
end)

-- Display markers for delivery place
Citizen.CreateThread(function()
    while true do
        Wait(0)
        if isTaken == 1 and isDelivered == 0 then
            local coords = GetEntityCoords(GetPlayerPed(-1))
            v = alldeliveries[randomdelivery]
            if (GetDistanceBetweenCoords(coords, v.posx, v.posy, v.posz, true) < Config.DrawDistance) then
                DrawMarker(1, v.posx, v.posy, v.posz, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 5.0, 5.0, 1.0, 204, 204, 0, 100,
                    false, false, 2, false, false, false, false)
            end
        end
    end
end)

function DrawTxt(x,y, width, height, scale, text, r,g,b,a, outline)
	SetTextFont(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropshadow(0, 0, 0, 0,255)
	SetTextDropShadow()
	if outline then SetTextOutline() end

	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(x - width/2, y - height/2 + 0.005)
end
