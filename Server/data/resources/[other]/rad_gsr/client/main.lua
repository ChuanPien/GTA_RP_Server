ESX = nil
local hasShot = false
local ignoreShooting = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        ped = PlayerPedId()
        if IsPedShooting(ped) then
            local currentWeapon = GetSelectedPedWeapon(ped)
            for _,k in pairs(Config.weaponChecklist) do
                if currentWeapon == k then
                    ignoreShooting = true
                    break
                end
            end
            
            if not ignoreShooting then
                TriggerServerEvent('GSR:SetGSR', timer)
                hasShot = true
                ignoreShooting = false
                Citizen.Wait(Config.gsrUpdate)
            end
			ignoreShooting = false
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(2000)
        if Config.waterClean and hasShot then
            ped = PlayerPedId()
            if IsEntityInWater(ped) then
                exports['mythic_notify']:DoHudText('inform', '硝煙味即將去除')
				Wait(100)
				-- TriggerEvent("mythic_progbar:client:progress", {
        		-- 	name = "washing_gsr",
        		-- 	duration = Config.waterCleanTime,
        		-- 	label = "Washing Off GSR",
        		-- 	useWhileDead = false,
        		-- 	canCancel = true,
        		-- 	controlDisables = {
            	-- 		disableMovement = false,
            	-- 		disableCarMovement = false,
            	-- 		disableMouse = false,
            	-- 		disableCombat = false,
        		-- 	},
    			-- }, function(status)
        			if not status then
            			if IsEntityInWater(ped) then
                    		hasShot = false
                    		TriggerServerEvent('GSR:Remove')
							exports['mythic_notify']:SendAlert('success', '硝煙已去除')
                		else
							exports['mythic_notify']:SendAlert('error', '硝煙尚未去除')
                		end
        			end
    			-- end)
				Citizen.Wait(Config.waterCleanTime)
            end
        end
    end
end)

function status()
    if hasShot then
        ESX.TriggerServerCallback('GSR:Status', function(cb)
            if not cb then
                hasShot = false
            end
        end)
    end
end

function updateStatus()
    status()
    SetTimeout(Config.gsrUpdateStatus, updateStatus)
end

updateStatus()

RegisterNetEvent('GSR:inspect')
AddEventHandler('GSR:inspect', function(prop_name)
    if not IsAnimated then
        prop_name = prop_name or 'prop_cs_paper_cup'
        IsAnimated = true

        Citizen.CreateThread(function()
            local playerPed = PlayerPedId()
            local x,y,z = table.unpack(GetEntityCoords(playerPed))
            local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
            local boneIndex = GetPedBoneIndex(playerPed, 18905)
            AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.008, 0.03, 240.0, -60.0, 0.0, true, true, false, true, 1, true)
                    
            ESX.Streaming.RequestAnimDict('random@train_tracks', function()
                TaskPlayAnim(playerPed, 'random@train_tracks', 'idle_e', 1.0, -1.0, 8000, 0, 1, true, true, true)

                Citizen.Wait(5000)
                IsAnimated = false
                ClearPedSecondaryTask(playerPed)
                DeleteObject(prop)
            end)
        end)
    end
end)
