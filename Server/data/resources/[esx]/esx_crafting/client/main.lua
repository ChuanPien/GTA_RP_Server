local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}
ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local CurrentCraft = nil
local HasAlreadyEnteredMarker = false
local LastZone, CurrentAction, CurrentActionMsg

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerCoords = GetEntityCoords(PlayerPedId())
		local isInMarker, letSleep, currentZone = false, true

		local distance = #(playerCoords - vector3(606.5,-3088.02, 5.07))
		local distance2 = #(playerCoords - vector3(606.67, -3092.75, 6.0))
		local distance3 = #(playerCoords - vector3(472.84, -1312.3, 29.21))

        if distance < 10 then
            letSleep = false

            if distance < 2 then
                isInMarker, currentZone = true, 'Q'
            end
        end

        if distance2 < 10 then
            letSleep = false

            if distance2 < 2 then
                isInMarker, currentZone = true, 'O'
            end
        end

        if distance3 < 10 then
            letSleep = false

            if distance3 < 2 then
                isInMarker, currentZone = true, 'note'
            end
        end

        if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
            HasAlreadyEnteredMarker, LastZone = true, currentZone
            LastZone = currentZone
            TriggerEvent('craft:hasEnteredMarker', currentZone)
        end

        if not isInMarker and HasAlreadyEnteredMarker then
            HasAlreadyEnteredMarker = false
            TriggerEvent('craft:hasExitedMarker', LastZone)
        end

        if letSleep then
            Citizen.Wait(500)
        end
    end
end)

AddEventHandler('craft:hasEnteredMarker', function(zone)
    if zone == 'Q' then
        CurrentAction = 'Q'
        CurrentActionMsg = ('[~g~E~s~]與師父對話')
        CurrentActionData = {}
    elseif zone == 'O' then
        CurrentAction = 'O'
        CurrentActionMsg = ('[~g~E~s~]使用工作臺')
        CurrentActionData = {}
    elseif zone == 'note' then
        CurrentAction = 'note'
        CurrentActionMsg = ('[~g~E~s~]查看紙條')
        CurrentActionData = {}
    end
end)

-- Exited Marker
AddEventHandler('craft:hasExitedMarker', function()
    ESX.UI.Menu.CloseAll()
    CurrentAction = nil
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if CurrentAction then
            ESX.ShowHelpNotification(CurrentActionMsg)

            if IsControlJustReleased(0, 38) then
                if CurrentAction == 'Q' then
                    Q()
                elseif CurrentAction == 'O' then
                    OpenCraftMenu()
                elseif CurrentAction == 'note' then
                    ESX.ShowAdvancedNotification('老師傅', '[紙條]', "我把工作台移到\n~b~海邊私人傭兵船屋旁的倉庫~s~了", 'CHAR_MINOTAUR',2)
                end

                CurrentAction = nil
            end
        else
            Citizen.Wait(500)
        end
    end
end)

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNUICallback('CraftingSuccess', function()
    SetNuiFocus(false, false)
    ClearPedTasks(GetPlayerPed(-1))
    FreezeEntityPosition(GetPlayerPed(-1),false)
    TriggerServerEvent("rs_crafting:CraftingSuccess", CurrentCraft)
end)

RegisterNUICallback('CraftingFailed', function()
    SetNuiFocus(false, false)
    ClearPedTasks(GetPlayerPed(-1))
    FreezeEntityPosition(GetPlayerPed(-1),false)
    TriggerServerEvent("rs_crafting:CraftingFailed", CurrentCraft)
end)

function OpenCraftMenu()
    local elements = {}

    ESX.TriggerServerCallback('rs_crafting:GetSkillLevel', function(level)
        for item, v in pairs(Crafting.Items) do
            if tonumber(level) >= v.threshold then
                local elementlabel = v.label .. " | 材料 : "
                local somecount = 1
                for k, need in pairs(v.needs) do
                    if somecount == 1 then
                        somecount = somecount + 1
                        elementlabel = elementlabel .. need.count
                    else
                        elementlabel = elementlabel .. "/".. need.count
                    end
                end
                table.insert(elements, {value = item, label = elementlabel})
            end
        end

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'crafting_actions', {
            title = '一般工作台',
            align = 'top-left',
            elements = elements
        }, function(data, menu)
            menu.close()
            CurrentCraft = data.current.value
            ESX.TriggerServerCallback('rs_crafting:HasTheItems', function(result)
                if result then
                    SetNuiFocus(true,true)
                    SendNUIMessage({
                        action = "opengame",
                    })
                    RequestAnimDict("mini@repair")
                    while (not HasAnimDictLoaded("mini@repair")) do
                        Citizen.Wait(0)
                    end
                    TaskPlayAnim(GetPlayerPed(-1), "mini@repair" ,"fixing_a_ped" ,8.0, -8.0, -1, 1, 0, false, false, false )
                    FreezeEntityPosition(GetPlayerPed(-1),true)
                else
                    exports['mythic_notify']:DoHudText('error', '材料不足')
                end
            end, CurrentCraft)

        end, function(data, menu)
            menu.close()
        end)
    end)
end

function Q()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), "Q", {
        title = ('想問點啥呢'),
        elements = {
            {label = ('手藝等級'),value = "lv"},
            {label = ('等級有甚麼用'),value = "lv2"},
            {label = ('高階工作台'),value = "adcraft"},
        }
    }, function(data, menu)
        if data.current.value == 'lv' then
            ESX.TriggerServerCallback('rs_crafting:GetSkillLevel', function(level)
                ESX.ShowAdvancedNotification('老師傅', '[手藝等級]', "呵呵 年輕人!\n你才~g~ LV." .. level .. "~s~而已", 'CHAR_MINOTAUR')
            end)
        elseif data.current.value == 'lv2' then
            ESX.ShowAdvancedNotification('老師傅', '[等級有甚麼用]', '用處大的勒!當你手藝到 ~g~LV.200~s~ \n就可以製作~b~更多可以的東西~s~ 努力吧!', 'CHAR_MINOTAUR')
        elseif data.current.value == 'adcraft' then
            ESX.ShowAdvancedNotification('老師傅', '[高階工作台]', '可以用~b~較少量的資源做出較多的物品~s~，但你的~b~技術也要更厲害~s~才行', 'CHAR_MINOTAUR')
        end
    end, function(data, menu)
        menu.close()
    end)
end

RegisterNetEvent('rs_crafting:sound')
AddEventHandler('rs_crafting:sound', function()
	TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'toolbroken', 0.5)
end)