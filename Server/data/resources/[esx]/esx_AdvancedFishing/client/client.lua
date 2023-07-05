ESX = nil
local PlayerData,JobBlips = {}, {}
local fishing = false
local overfishing = false
local lastInput = 0
local pause = false
local pausetimer = 0
local correct = 0
local input = 0
local counter = 0
local bait = "none"
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

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)

	ESX.PlayerData = xPlayer

end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job

end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    exports['mythic_notify']:DoHudText('error', '停止釣魚')
    exports['mythic_notify']:DoHudText('error', '餌料空')
    ClearPedTasks(PlayerPedId())
end)

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

Citizen.CreateThread(function()
    while true do
        Wait(500)
        if pause and fishing or overfishing then
            pausetimer = pausetimer + 1
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(5)
        if fishing then
            if IsControlJustReleased(0, Keys['N4']) then
                input = 4
            end

            if IsControlJustReleased(0, Keys['N5']) then
                input = 5
            end

            if IsControlJustReleased(0, Keys['N6']) then
                input = 6
            end

            if IsControlJustReleased(0, Keys['N7']) then
                input = 7
            end

            if IsControlJustReleased(0, Keys['N8']) then
                input = 8
            end

            if IsControlJustReleased(0, Keys['N9']) then
                input = 9
            end

            if IsControlJustReleased(0, Keys['X']) then
                fishing = false
                ClearPedTasks(PlayerPedId())
                exports['mythic_notify']:DoHudText('error', '停止釣魚')
                TriggerEvent('fishing:setbait', "none")
            end

            if fishing then

                playerPed = GetPlayerPed(-1)
                local pos = GetEntityCoords(GetPlayerPed(-1))

                if pos.y >= 5282 or pos.y <= 5182.5 or pos.x <= -1638 or pos.x >= -1570 or pos.z <= 2.9 or IsPedInAnyVehicle(GetPlayerPed(-1)) then
                    fishing = false
                    exports['mythic_notify']:DoHudText('error', '已離開釣魚區')
                    exports['mythic_notify']:DoHudText('error', '停止釣魚')
                    TriggerEvent('fishing:setbait', "none")
                    ClearPedTasks(PlayerPedId())
                end

                if IsEntityDead(playerPed) or IsEntityInWater(playerPed) then
                    fishing = false
                    exports['mythic_notify']:DoHudText('error', '停止釣魚')
                    TriggerEvent('fishing:setbait', "none")
                    ClearPedTasks(PlayerPedId())
                end
            end

            if pausetimer > 6 then
                input = 99
            end

            if pause and input ~= 0 then
                pause = false
                if input == correct then
                    ESX.TriggerServerCallback('fishing:getitem',function(cb)
                        if cb then
                            exports['mythic_notify']:DoHudText('error', '停止釣魚')
                            fishing, overfishing = false, false
                            TriggerEvent('fishing:setbait', _source, "none")
                            ClearPedTasks(PlayerPedId())
                        else
                            TriggerServerEvent('fishing:catchfish', bait)
                        end
                    end)
                else
                    exports['mythic_notify']:DoHudText('error', '魚跑掉了')
                end
            end
        end

        if overfishing then

            if IsControlJustPressed(0, Keys['N4']) or IsControlJustPressed(0, Keys['N5']) then
                counter = counter + 1
            end

            if IsControlJustReleased(0, Keys['X']) then
                overfishing = false
                ClearPedTasks(PlayerPedId())
                exports['mythic_notify']:DoHudText('error', '停止釣魚')
                TriggerEvent('fishing:setbait', "none")
            end

            playerPed = GetPlayerPed(-1)
            local pos = GetEntityCoords(GetPlayerPed(-1))
            local distance = #(pos - vector3(-3879.6, 6730.52, 0.2))

            if distance >= 510 or IsPedInAnyVehicle(GetPlayerPed(-1)) then
                overfishing = false
                exports['mythic_notify']:DoHudText('error', '已離開釣魚區')
                exports['mythic_notify']:DoHudText('error', '停止釣魚')
                TriggerEvent('fishing:setbait', "none")
                ClearPedTasks(PlayerPedId())
            end

            if IsEntityDead(playerPed) or IsEntityInWater(playerPed) then
                overfishing = false
                exports['mythic_notify']:DoHudText('error', '停止釣魚')
                TriggerEvent('fishing:setbait', "none")
                ClearPedTasks(PlayerPedId())
            end

            if pausetimer > 10 then
                counter = 100
            end

            if pause and counter >= 20 then
                pause = false
                if counter <= 40 then
                    ESX.TriggerServerCallback('fishing:getitem',function(cb)
                        if cb then
                            exports['mythic_notify']:DoHudText('error', '停止釣魚')
                            fishing, overfishing = false, false
                            TriggerEvent('fishing:setbait', _source, "none")
                            ClearPedTasks(PlayerPedId())
                        else
                            TriggerServerEvent('fishing:overcatch', bait)
                            counter = 0
                        end
                    end)
                else
                    exports['mythic_notify']:DoHudText('error', '魚跑掉了')
                    counter = 0
                end
            end
        end

        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.weed.x, Config.weed.y,
            Config.weed.z, true) <= 3 then
            DisplayHelpText("[~g~E~s~]包裝")
            if IsControlJustReleased(0, Keys['E']) then
                if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
                    TriggerServerEvent('fishing:weed')
                    local playerPed = PlayerPedId()
                    local x,y,z = table.unpack(GetEntityCoords(playerPed))
                    local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
                    local boneIndex = GetPedBoneIndex(playerPed, 18905)
                    AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.008, 0.03, 240.0, -60.0, 0.0, true, true, false, true, 1, true)

                    ESX.Streaming.RequestAnimDict('anim@amb@clubhouse@tutorial@bkr_tut_ig3@', function()
                        TaskPlayAnim(playerPed, 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', 'machinic_loop_mechandplayer', 1.0, -1.0, 2000, 0, 1, true, true, true)

                        Citizen.Wait(3000)
                        IsAnimated = false
                        ClearPedSecondaryTask(playerPed)
                        DeleteObject(prop)
                    end)
                else
                    exports['mythic_notify']:DoHudText('error', '請下車')
                    Citizen.Wait(10000)
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(math.random(35000, 45000))
        if fishing then
            pause = true
            correct = math.random(4, 9)
            DisplayHelpText("[~g~N" .. correct .. "~s~]收線")
            input = 0
            pausetimer = 0
        end

        if overfishing then
            pause = true
            counter = 0
            pausetimer = 0
            DisplayHelpText("[~g~N4~s~][~g~N5~s~]收線")
        end
    end
end)

RegisterNetEvent('fishing:break')
AddEventHandler('fishing:break', function()
    fishing = false
    overfishing = false
    ClearPedTasks(GetPlayerPed(-1))
    TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'toolbroken', 0.5)
end)

RegisterNetEvent('fishing:spawnPed')
AddEventHandler('fishing:spawnPed', function()

    RequestModel(GetHashKey("A_C_SharkTiger"))
    while (not HasModelLoaded(GetHashKey("A_C_SharkTiger"))) do
        Citizen.Wait(1)
    end
    local pos = GetEntityCoords(GetPlayerPed(-1))

    local ped = CreatePed(29, 0x06C3F072, pos.x, pos.y, pos.z, 90.0, true, false)
    SetEntityHealth(ped, 0)
end)

RegisterNetEvent('fishing:setbait')
AddEventHandler('fishing:setbait', function(bool)
    bait = bool
end)

RegisterNetEvent('fishing:fishstart')
AddEventHandler('fishing:fishstart', function()

    playerPed = GetPlayerPed(-1)
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local distance = #(pos - vector3(-3879.6, 6730.52, 0.2))

    if IsPedInAnyVehicle(playerPed) then
        exports['mythic_notify']:DoHudText('error', '請下車')
    else
        if pos.y <= 5282 and pos.y >= 5182.5 and pos.x >= -1638 and pos.x <= -1570 and pos.z >= 3 then
            exports['mythic_notify']:DoHudText('success', '開始釣魚')
            TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_STAND_FISHING", 0, true)
            fishing = true
        elseif distance <= 510 then
            exports['mythic_notify']:DoHudText('success', '開始釣魚')
            TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_STAND_FISHING", 0, true)
            overfishing = true
        else
            exports['mythic_notify']:DoHudText('error', '請在釣魚場釣魚')
        end
    end
end, false)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
        if fishing or overfishing then
            if IsControlJustReleased(0, Keys['N+']) then
                SetBaitMenu()
            end
		end
	end
end)

function SetBaitMenu()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), "fish", {
		title = ('魚餌口袋'),
		elements = {
			{label = ('蚯蚓'),value = "fishbait"},
			{label = ('鯛魚肉塊'),value = "fishmeat"},
			{label = ('蝦仁'),value = "shrimp"},
			{label = ('海龜肉'),value = "turtlemeat"}
		}
	}, function(data, menu)
        menu.close()
        TriggerServerEvent('fishing:setautobait',data.current.value)
		end, function(data, menu)
		menu.close()
	end)
end