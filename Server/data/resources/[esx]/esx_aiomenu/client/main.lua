Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end

    while true do
        ESX.PlayerData = ESX.GetPlayerData()
        Citizen.Wait(1000)
    end
end)

RegisterCommand('private', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				
    if closestPlayer == -1 or closestDistance > 2.0 then
        TriggerServerEvent('esx_aiomenu:showID', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
    elseif closestPlayer ~= -1 and closestDistance <= 2.0 then
        TriggerServerEvent('esx_aiomenu:showID', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer))
        ESX.UI.Menu.CloseAll()
    end
end, false)

RegisterNetEvent('esx_aiomenu:showID')
AddEventHandler('esx_aiomenu:showID', function(data)
    if data.name ~= 'Nil' then	
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'show_id', {
            title    = _U('aiomenu'),
            align    = 'top-left',
            elements = {
                {label = '姓名: ' .. tostring(data.name), value = 'nil'},
                {label = '生日: ' .. tostring(data.dob), value = 'nil'},
                {label = '性別: ' .. tostring(data.sex), value = 'nil'},
                {label = '身高: ' .. tostring(data.height), value = 'nil'}
            }
        }, function(data, menu)

        end, function(data, menu)
            menu.close()
        end)
    else
        ESX.ShowNotification('~r~發生不明錯誤,請通知管理員')
    end	
end)
