ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
    local playerPed = PlayerPedId()
    local xPlayer = ESX.IsPlayerLoaded(playerPed)

    Citizen.Wait(1000) -- Please Do Not Touch!
    
    if xPlayer then
        TriggerServerEvent('esx_armor:getDBArmor')

        if Config.Debug then
            print('Set Join Armor from DB')
        end
    else
        if Config.Debug then
            print('xPlayer not found')
        end
    end
end)

RegisterNetEvent('esx_armor:setJoinArmor')
AddEventHandler('esx_armor:setJoinArmor', function(health, armour)
    local playerPed = PlayerPedId()

    if Config.Debug then
        print('Set Join Armor bevor Trigger')
    end

    SetEntityHealth(playerPed, health)
    SetPedArmour(playerPed, armour)

    if Config.Debug then
        print('Set Join Armor after Trigger')
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerArmor = GetPedArmour(playerPed)
            
        if Config.EnableRefresh then
            TriggerServerEvent('esx_armor:refreshArmour', GetEntityHealth(playerPed), GetPedArmour(playerPed))
            Citizen.Wait(Config.Refresh * 1000)
        end
    end
end)