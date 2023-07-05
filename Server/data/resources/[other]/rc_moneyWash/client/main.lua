ESX              = nil
local PlayerData = {}

local currentMoney = 0
local currentblackMoney = 0
local currentWashCost = 0
local currentcops = 0


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
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



local isMenuOpen = false

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(4)
        local coords = GetEntityCoords(PlayerPedId())
        local distance = GetDistanceBetweenCoords(coords, Config.MoneyWashingDealer["pos"]["x"], Config.MoneyWashingDealer["pos"]["y"], Config.MoneyWashingDealer["pos"]["z"], true) -- Die Nullen durch die Cords des Markers oder so ersetzten. Alsi da wo der Spieler E drücken kann

        if distance <= 1.0 then
            if isMenuOpen == false then
                ESX.ShowHelpNotification("[~g~E~s~]互動")
                if IsControlJustReleased(0, 38) then

                    ESX.TriggerServerCallback('rc_moneyWash:getPlayerStats', function(blackmoney, percent, cops)
                        currentblackMoney = blackmoney
                        currentWashCost = percent
                        currentcops = cops
                    end)
                    Citizen.Wait(500)
                    SetDisplay(not display)
                    isMenuOpen = true
                end
            end
        end
	end
end)


RegisterNUICallback("exit", function(data) -- index.js ruft diesen Callback auf und dan passiert das was dadrin passiert
    SetDisplay(false) -- Deaktviert die UI
    isMenuOpen = false
end)

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
        currentblackMoney = currentblackMoney,
        currentWashCost = currentWashCost,
        currentcops = currentcops,
    })
end

Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)
        DisableControlAction(0, 1, display) -- LookLeftRight
        DisableControlAction(0, 2, display) -- LookUpDown
        DisableControlAction(0, 142, display) -- MeleeAttackAlternate
        DisableControlAction(0, 18, display) -- Enter
        DisableControlAction(0, 322, display) -- ESC
        DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
    end
end)

_RequestModel = function(hash)
    if type(hash) == "string" then hash = GetHashKey(hash) end
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(0)
    end
end

Citizen.CreateThread(function()
    local pedPosition = Config.MoneyWashingDealer["pos"]
    _RequestModel(349680864)
    if not DoesEntityExist(pedPosition["entity"]) then
        pedPosition["entity"] = CreatePed(4, 349680864, pedPosition["x"], pedPosition["y"], pedPosition["z"] -1, pedPosition["h"])
        SetEntityAsMissionEntity(pedPosition["entity"])
        SetBlockingOfNonTemporaryEvents(pedPosition["entity"], true)
        FreezeEntityPosition(pedPosition["entity"], true)
        SetEntityInvincible(pedPosition["entity"], true)

        TaskStartScenarioInPlace(pedPosition["entity"], "WORLD_HUMAN_SMOKING", 0, true);
    end
    SetModelAsNoLongerNeeded(349680864)
end)

RegisterNUICallback("success", function(data)
    SetDisplay(false)
    isMenuOpen = false

    TriggerServerEvent("rc_moneyWash:successEvent")
end)