ESX = nil
loaded = false

local health = 100
local armor = 0
local food = 0
local water = 0
local oxygen = 0


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end
    loaded = true
    ESX.PlayerData = ESX.GetPlayerData()
end)





Citizen.CreateThread(function()
    while loaded == false do
        Citizen.Wait(300)
    end

    while true do 
        Citizen.Wait(300)
        local ped =  GetPlayerPed(-1)
        local playerId = PlayerId()
        SetPlayerHealthRechargeMultiplier(playerId, 0)
        local pedhealth = GetEntityHealth(ped)

        if pedhealth < 100 then
          health = 0
        else
          pedhealth = pedhealth - 100
          health    = pedhealth
        end
        
        armor = GetPedArmour(ped)
        oxygen = GetPlayerUnderwaterTimeRemaining(playerId)*10
        oxygen = math.ceil(oxygen)
        SendNUIMessage({
            type = "update",
            health = health,
            armor = armor,
            food = food,
            water = water,
            oxygen = oxygen,
        })
    end
end)

Citizen.CreateThread(function()
    while loaded == false do
        Citizen.Wait(500)
    end

    while true do
        Citizen.Wait(2000)
        TriggerEvent('esx_status:getStatus', 'hunger', function(hunger)
            TriggerEvent('esx_status:getStatus', 'thirst', function(thirst)
              food = hunger.getPercent()
              water = thirst.getPercent()
            end)
        end)
    end
end)



