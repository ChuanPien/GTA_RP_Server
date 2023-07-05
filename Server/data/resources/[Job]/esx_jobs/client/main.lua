local PlayerData = {}
ESX = nil

local mineActive = false
local impacts = 0
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

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
            if PlayerData.job ~= nil and PlayerData.job.name ~= 'police' and PlayerData.job.name ~= 'ambulance' and PlayerData.job.name ~= 'offpolice' and PlayerData.job.name ~= 'offambulance' then
                for i=1, #Config.miner1, 1 do
                    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.miner1[i].x, Config.miner1[i].y, Config.miner1[i].z, true) < 40 and mineActive == false then
                        DrawMarker(20, Config.miner1[i].x, Config.miner1[i].y, Config.miner1[i].z, 0, 0, 0, 0, 0, 100.0, 1.0, 1.0, 1.0, 0, 155, 253, 155, 0, 0, 2, 0, 0, 0, 0)
                        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.miner1[i].x, Config.miner1[i].y, Config.miner1[i].z, true) < 1 then
                            ESX.ShowHelpNotification("[~g~E~s~]挖礦")
                            if IsControlJustReleased(0, Keys['E']) then
                                Animation()
                                mineActive = true
                                exports['mythic_notify']:DoCustomHudText('inform', '挖礦中...',10000)
                            end
                        end
                    end
                end

                DrawMarker(1, Config.miner2.x, Config.miner2.y, Config.miner2.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0,2.0, 0, 70, 250, 30, false, true, 2, false, false, false, false)
                if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.miner2.x, Config.miner2.y, Config.miner2.z,true) <= 1.5 then
                    ESX.ShowHelpNotification("[~g~E~s~]洗礦石")
                    if IsControlJustReleased(0, Keys['E']) then
                        TriggerServerEvent('job:washstone')
                    end
                end

                DrawMarker(1, Config.miner3.x, Config.miner3.y, Config.miner3.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0,2.0, 0, 70, 250, 30, false, true, 2, false, false, false, false)
                if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.miner3.x, Config.miner3.y, Config.miner3.z,true) <= 1.5 then
                    ESX.ShowHelpNotification("[~g~E~s~]煉礦石")
                    if IsControlJustReleased(0, Keys['E']) then
                        TriggerServerEvent('job:finestone')
                    end
                end

                DrawMarker(1, Config.miners.x, Config.miners.y, Config.miners.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0,2.0, 0, 70, 250, 30, false, true, 2, false, false, false, false)
                if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.miners.x, Config.miners.y, Config.miners.z,true) <= 1.5 then
                    ESX.ShowHelpNotification("[~g~E~s~]出售")
                    if IsControlJustReleased(0, Keys['E']) then
                        TriggerServerEvent('job:sellstone')
                        RequestAnimDict("misscarsteal4@actor")
                        while (not TaskStartScenarioInPlace(PlayerPedId(), "actor_berating_loop", 0, true)) do
                            Citizen.Wait(0)
                        end
                        TaskPlayAnim(PlayerPedId(),"misscarsteal4@actor","actor_berating_loop",2.0, 2.0, 0.3, 120, 0, 0, 0, 0)
                    end
                end

                DrawMarker(1, Config.wood.x, Config.wood.y, Config.wood.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0,2.0, 0, 250, 70, 50, false, true, 2, false, false, false, false)
                if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.wood.x, Config.wood.y, Config.wood.z,true) <= 1.5 then
                    ESX.ShowHelpNotification("[~g~E~s~]砍樹")
                    if IsControlJustReleased(0, Keys['E']) then
                        TriggerServerEvent('job:wood')
                    end
                end

                DrawMarker(1, Config.CuttedWood.x, Config.CuttedWood.y, Config.CuttedWood.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0,2.0, 0, 250, 70, 50, false, true, 2, false, false, false, false)
                if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.CuttedWood.x, Config.CuttedWood.y, Config.CuttedWood.z,true) <= 1.5 then
                    ESX.ShowHelpNotification("[~g~E~s~]切割木材")
                    if IsControlJustReleased(0, Keys['E']) then
                        TriggerServerEvent('job:cuttedwood')
                    end
                end

                DrawMarker(1, Config.Plankswood.x, Config.Plankswood.y, Config.Plankswood.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0,2.0, 0, 250, 70, 50, false, true, 2, false, false, false, false)
                if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.Plankswood.x, Config.Plankswood.y, Config.Plankswood.z,true) <= 1.5 then
                    ESX.ShowHelpNotification("[~g~E~s~]包裝木材")
                    if IsControlJustReleased(0, Keys['E']) then
                        TriggerServerEvent('job:plankwood')
                    end
                end

                DrawMarker(1, Config.sellswood.x, Config.sellswood.y, Config.sellswood.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0,2.0, 0, 250, 70, 50, false, true, 2, false, false, false, false)
                if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.sellswood.x, Config.sellswood.y, Config.sellswood.z,true) <= 1.5 then
                    ESX.ShowHelpNotification("[~g~E~s~]出售")
                    if IsControlJustReleased(0, Keys['E']) then
                        TriggerServerEvent('job:sellwood')
                        RequestAnimDict("misscarsteal4@actor")
                        while (not TaskStartScenarioInPlace(PlayerPedId(), "actor_berating_loop", 0, true)) do
                            Citizen.Wait(0)
                        end
                        TaskPlayAnim(PlayerPedId(),"misscarsteal4@actor","actor_berating_loop",2.0, 2.0, 0.3, 120, 0, 0, 0, 0)
                    end
                end

                DrawMarker(1, Config.wool.x, Config.wool.y, Config.wool.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0,2.0, 250, 0, 70, 50, false, true, 2, false, false, false, false)
                if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.wool.x, Config.wool.y, Config.wool.z,true) <= 1.5 then
                    ESX.ShowHelpNotification("[~g~E~s~]採集羊毛")
                    if IsControlJustReleased(0, Keys['E']) then
                        TriggerServerEvent('job:wool')
                    end
                end

                DrawMarker(1, Config.Fabricwool.x, Config.Fabricwool.y, Config.Fabricwool.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0,2.0, 250, 0, 70, 50, false, true, 2, false, false, false, false)
                if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.Fabricwool.x, Config.Fabricwool.y, Config.Fabricwool.z,true) <= 1.5 then
                    ESX.ShowHelpNotification("[~g~E~s~]製作布料")
                    if IsControlJustReleased(0, Keys['E']) then
                        TriggerServerEvent('job:Fabricwool')
                    end
                end

                DrawMarker(1, Config.Clothewool.x, Config.Clothewool.y, Config.Clothewool.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0,2.0, 250, 0, 70, 50, false, true, 2, false, false, false, false)
                if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.Clothewool.x, Config.Clothewool.y, Config.Clothewool.z,true) <= 1.5 then
                    ESX.ShowHelpNotification("[~g~E~s~]製作衣服")
                    if IsControlJustReleased(0, Keys['E']) then
                        TriggerServerEvent('job:Clothewool')
                    end
                end
                
                DrawMarker(1, Config.sellwool.x, Config.sellwool.y, Config.sellwool.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0,2.0, 250, 0, 70, 50, false, true, 2, false, false, false, false)
                if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.sellwool.x, Config.sellwool.y, Config.sellwool.z,true) <= 1.5 then
                    ESX.ShowHelpNotification("[~g~E~s~]出售")
                    if IsControlJustReleased(0, Keys['E']) then
                        TriggerServerEvent('job:sellwool')
                        RequestAnimDict("misscarsteal4@actor")
                        while (not TaskStartScenarioInPlace(PlayerPedId(), "actor_berating_loop", 0, true)) do
                            Citizen.Wait(0)
                        end
                        TaskPlayAnim(PlayerPedId(),"misscarsteal4@actor","actor_berating_loop",2.0, 2.0, 0.3, 120, 0, 0, 0, 0)
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('job:fu')
AddEventHandler('job:fu', function()
    Citizen.CreateThread(function()
        Citizen.Wait(0)
        busy = true
        while busy do
            Citizen.Wait(0)
            FreezeEntityPosition(PlayerPedId(), true)
			DisableControlAction(0, 32, true) -- W
			DisableControlAction(0, 34, true) -- A
			DisableControlAction(0, 31, true) -- S
			DisableControlAction(0, 30, true) -- D
			DisableControlAction(0, 38, true) -- D
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
        end
    end)
end)

RegisterNetEvent('job:unfu')
AddEventHandler('job:unfu', function()
    busy = false
    while true do
        Citizen.Wait(0)
        if busy == false then
            FreezeEntityPosition(PlayerPedId(), false)
            EnableAllControlActions(0)
            StopAnimTask(PlayerPedId(), "misscarsteal4@actor","actor_berating_loop", 1.0)
        end
    end
end)

function Animation()
    Citizen.CreateThread(function()
        while impacts < 5 do
            Citizen.Wait(0)
		    local ped = PlayerPedId()
            RequestAnimDict("melee@large_wpn@streamed_core")
            Citizen.Wait(100)
            TaskPlayAnim((ped), 'melee@large_wpn@streamed_core', 'ground_attack_on_spot', 8.0, 8.0, -1, 80, 0, 0, 0, 0)
            SetEntityHeading(ped, 270.0)

            if impacts == 0 then
                pickaxe = CreateObject(GetHashKey("prop_tool_pickaxe"), 0, 0, 0, true, true, true)
                AttachEntityToEntity(pickaxe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.18, -0.02, -0.02, 350.0, 100.00, 140.0, true, true, false, true, 1, true)
            end
            Citizen.Wait(2000)
            ClearPedTasks(ped)
            impacts = impacts+1
            if impacts == 5 then
                DetachEntity(pickaxe, 1, true)
                DeleteEntity(pickaxe)
                DeleteObject(pickaxe)
                mineActive = false
                impacts = 0
                TriggerServerEvent("job:givestone")
                break
            end
        end
    end)
end