ESX = nil
local Freeze = false
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

local blip = AddBlipForCoord(-3879.6, 6730.52, 0.2)
local Blip = AddBlipForRadius(-3879.6, 6730.52, 0.2, 500.0)

SetBlipHighDetail(Blip, true)
SetBlipColour(Blip, 18)
SetBlipAsShortRange(Blip, true)

SetBlipSprite(blip, 68)
SetBlipDisplay(blip, 4)
SetBlipScale(blip, 1.0)
SetBlipColour(blip, 1)
SetBlipAsShortRange(blip, true)

BeginTextCommandSetBlipName("STRING")
AddTextComponentString('漁獲-遠洋釣魚區')
EndTextCommandSetBlipName(blip)

RegisterNetEvent('fishing:overpoint')
AddEventHandler('fishing:overpoint', function()
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local distance = #(pos - vector3(-3879.6, 6730.52, 0.2))

    if distance <= 500 then
        TriggerServerEvent('fishing:canoverfish',source)
    else
        exports['mythic_notify']:DoHudText('error', '請在遠洋區垂釣')
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local pos = GetEntityCoords(GetPlayerPed(-1))
        local distance = #(pos - vector3(-3879.6, 6730.52, 0.2))
        local playerPed = GetPlayerPed(-1)
        local vehicle = GetVehiclePedIsIn(playerPed, false)

        if Freeze == true then
            FreezeEntityPosition(vehicle, true)
        else
            FreezeEntityPosition(vehicle, false)
        end

        if distance <= 500 then
            if IsPedInAnyVehicle(GetPlayerPed(-1)) then
                if Freeze == false then
                    DisplayHelpText('[~g~E~s~]下錨')
                    if IsControlJustReleased(0, Keys['E']) then
                        Freeze = true
                    end
                end
            end
        end

        if IsPedInAnyVehicle(GetPlayerPed(-1)) then
            if Freeze then
                DisplayHelpText('[~g~W~s~]起錨')
                if IsControlJustReleased(0, Keys['W']) then
                    Freeze = false
                end
            end
        end
    end
end)
