ESX = nil
local isDead = false

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
local myJob = nil
local HasAlreadyEnteredMarker = false
local LastZone = nil
local isInZone = false
local CurrentAction = nil
local CurrentActionMsg = ''
local CurrentActionData = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end
end)

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    TriggerServerEvent('esx_billing:autopay')
end)

AddEventHandler('esx_billing:hasEnteredMarker', function(zone)

    ESX.UI.Menu.CloseAll()

    if zone == 'Bills' then
        CurrentAction = zone
        CurrentActionMsg = '帳單'

    end
end)

-- Render markers
Citizen.CreateThread(function()
    while true do

        Citizen.Wait(0)

        local coords = GetEntityCoords(GetPlayerPed(-1))

        for k, v in pairs(Config.Zones) do
            if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config.DrawDistance) then
                DrawMarker(Config.MarkerType, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.ZoneSize.x,
                    Config.ZoneSize.y, Config.ZoneSize.z, Config.MarkerColor.r, Config.MarkerColor.g,
                    Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
            end
        end

    end
end)

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(-555.55, -619.69, 33.68)
    SetBlipSprite(blip, 419)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 1.0)
    SetBlipColour(blip, colour)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("國稅局")
    EndTextCommandSetBlipName(blip)
end)

-- Activate menu when player is inside marker
Citizen.CreateThread(function()
    while true do

        Citizen.Wait(0)

        local coords = GetEntityCoords(GetPlayerPed(-1))
        local isInMarker = false
        local currentZone = nil

        for k, v in pairs(Config.Zones) do
            if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config.ZoneSize.x / 2) then
                isInMarker = true
                currentZone = k
            end
        end

        if isInMarker and not hasAlreadyEnteredMarker then
            hasAlreadyEnteredMarker = true
            lastZone = currentZone
            TriggerServerEvent('esx_billing:GetUserInventory', currentZone)
        end

        if not isInMarker and hasAlreadyEnteredMarker then
            hasAlreadyEnteredMarker = false
            TriggerEvent('esx_billing:hasExitedMarker', lastZone)
        end

        if isInMarker and isInZone then
            TriggerEvent('esx_billing:hasEnteredMarker', 'Bills')
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)

        for k in pairs(Config.Zones) do
            local ped = PlayerPedId()
            local pedcoords = GetEntityCoords(ped, false)
            local distance = Vdist(pedcoords.x, pedcoords.y, pedcoords.z, Config.Zones[k].x, Config.Zones[k].y,
                                 Config.Zones[k].z)
            if distance <= 1.40 then

                DisplayHelpText('[~g~E~s~]查看帳單')

                if IsControlJustPressed(0, Keys['E']) and IsPedOnFoot(ped) then
                    ShowBillsMenu(Config.Zones[k].xs, Config.Zones[k].ys, Config.Zones[k].zs)
                end
            elseif distance < 1.45 then
                ESX.UI.Menu.CloseAll()
            end
        end
    end
end)

function ShowBillsMenu(x, y, z)
    ESX.TriggerServerCallback('esx_billing:getBills', function(bills)
        if #bills > 0 then
            ESX.UI.Menu.CloseAll()
            local elements = {}

            for k, v in ipairs(bills) do
                table.insert(elements, {
                    label = ('%s - <span style="color:red;">%s</span>'):format(v.label, '$' .. v.amount),
                    billId = v.id
                })
            end

            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'billing', {
                title = '帳單',
                align = 'top-latf',
                elements = elements
            }, function(data, menu)
                menu.close()

                ESX.TriggerServerCallback('esx_billing:payBill', function()
                    ShowBillsMenu()
                end, data.current.billId)
            end, function(data, menu)
                menu.close()
            end)
        else
            exports['mythic_notify']:DoHudText('inform', '無帳單')
        end
    end)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustReleased(0, Keys['F7']) then
            ESX.TriggerServerCallback('esx_billing:getBills', function(bills)
                if #bills > 0 then
                    ESX.UI.Menu.CloseAll()
                    local elements = {}

                    for k, v in ipairs(bills) do
                        table.insert(elements, {
                            label = ('%s - <span style="color:red;">%s</span>'):format(v.label, '$' .. v.amount),
                            billId = v.id
                        })
                    end

                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'billing', {
                        title = '帳單',
                        align = 'top-latf',
                        elements = elements
                    }, function(data, menu)
                        menu.close()

                    end, function(data, menu)
                        menu.close()
                    end)
                else
                    exports['mythic_notify']:DoHudText('inform', '無帳單')
                end
            end)
        end
    end
end)

RegisterKeyMapping('showbills', _U('keymap_showbills'), 'keyboard', 'F7')

AddEventHandler('esx:onPlayerDeath', function()
    isDead = true
end)

AddEventHandler('esx:onPlayerSpawn', function(spawn)
    isDead = false
end)

