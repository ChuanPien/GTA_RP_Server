ESX = nil

local waterCoolers = {-742198632, -1691644768}
local colaCoolers = {992069095, -654402915, 1114264700}
local IsAnimated = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if not IsAnimated then
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)

            for i = 1, #colaCoolers do
                local colaCooler = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0, colaCoolers[i], false, false, false)
                local colaCoolerrPos = GetEntityCoords(colaCooler)
                local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, colaCoolerrPos.x, colaCoolerrPos.y, colaCoolerrPos.z, true)

                if dist < 1.0 then
                    local loc = vector3(colaCoolerrPos.x, colaCoolerrPos.y, colaCoolerrPos.z + 1.0)
                    
                    ESX.Game.Utils.DrawText3D(loc, '[~g~E~w~]投幣$250', 0.7)
                    if IsControlJustReleased(0, 38) then
                        TriggerServerEvent('esx_tgo_watercoolers:getcola')
                    end
                end
            end

            for i = 1, #waterCoolers do
                local watercooler = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0, waterCoolers[i], false, false, false)
                local waterCoolerPos = GetEntityCoords(watercooler)
                local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, waterCoolerPos.x, waterCoolerPos.y, waterCoolerPos.z, true)

                if dist < 2.0 then
                    local loc = vector3(waterCoolerPos.x, waterCoolerPos.y, waterCoolerPos.z + 1.0)
                    
                    ESX.Game.Utils.DrawText3D(loc, '[~g~E~w~]喝水', 0.7)
                    if IsControlJustReleased(0, 38) then
                        TriggerServerEvent('esx_tgo_watercoolers:refillThirst')
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('esx_tgo_watercoolers:point')
AddEventHandler('esx_tgo_watercoolers:point', function()
    if not IsAnimated then
        IsAnimated = true

        Citizen.CreateThread(function()
            local playerPed = PlayerPedId()
            local x,y,z = table.unpack(GetEntityCoords(playerPed))
            local boneIndex = GetPedBoneIndex(playerPed, 18905)
                    
            ESX.Streaming.RequestAnimDict('gestures@f@standing@casual', function()
                TaskPlayAnim(playerPed, 'gestures@f@standing@casual', 'gesture_point', 1.0, -1.0, 2000, 0, 1, true, true, true)

                Citizen.Wait(1500)
                IsAnimated = false
                ClearPedSecondaryTask(playerPed)
            end)
        end)
    end
end)

RegisterNetEvent('esx_tgo_watercoolers:onDrink')
AddEventHandler('esx_tgo_watercoolers:onDrink', function(prop_name)
    if not IsAnimated then
        prop_name = prop_name or 'prop_cs_paper_cup'
        IsAnimated = true

        Citizen.CreateThread(function()
            local playerPed = PlayerPedId()
            local x,y,z = table.unpack(GetEntityCoords(playerPed))
            local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
            local boneIndex = GetPedBoneIndex(playerPed, 18905)
            AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.008, 0.03, 240.0, -60.0, 0.0, true, true, false, true, 1, true)
                    
            ESX.Streaming.RequestAnimDict('mp_player_intdrink', function()
                TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)

                Citizen.Wait(3000)
                IsAnimated = false
                ClearPedSecondaryTask(playerPed)
                DeleteObject(prop)
            end)
        end)
    end
end)