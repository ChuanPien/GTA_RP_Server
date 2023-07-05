ESX = nil
PlayerData = nil
local PlayerData = {}

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

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(100)
    end
    if #Config.elevators > 0 then
        StartElevatorsCheck()
    end
end)


function StartElevatorsCheck()
    Citizen.CreateThread(function()
        while true do
            local pedcoords = GetEntityCoords(PlayerPedId())

            for i = 1, #Config.elevators, 1 do
                if GetDistanceBetweenCoords(Config.elevators[i][1].x, Config.elevators[i][1].y, Config.elevators[i][1].z, pedcoords, false) <= 50.0 then
                    if currentfloor == nil then
                        for f = 1, #Config.elevators[i], 1 do
                            if GetDistanceBetweenCoords(Config.elevators[i][f].x, Config.elevators[i][f].y, Config.elevators[i][f].z, pedcoords, true) <= 5.0 then
                                DrawText3D(Config.elevators[i][f].x, Config.elevators[i][f].y, Config.elevators[i][f].z, "[~g~E~w~]電梯", 0.40)
                                DrawMarker(1, Config.elevators[i][f].x, Config.elevators[i][f].y, Config.elevators[i][f].z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8, 0.8, 0.8, 236, 236, 80, 155, false, false, 2, false, 0, 0, 0, 0)
                                if GetDistanceBetweenCoords(Config.elevators[i][f].x, Config.elevators[i][f].y, Config.elevators[i][f].z, pedcoords, true) <= 1.0 and IsControlJustReleased(0, 38) then
                                    OpenElevator(i, f)
                                end
                            end
                        end
                    else
                        if GetDistanceBetweenCoords(Config.elevators[i][currentfloor].x, Config.elevators[i][currentfloor].y, Config.elevators[i][currentfloor].z, pedcoords, true) <= 5.0 then
                            DrawText3D(Config.elevators[i][currentfloor].x, Config.elevators[i][currentfloor].y, Config.elevators[i][currentfloor].z, "[~g~E~w~]電梯", 0.40)
                            DrawMarker(1, Config.elevators[i][currentfloor].x, Config.elevators[i][currentfloor].y, Config.elevators[i][currentfloor].z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8, 0.8, 0.8, 236, 236, 80, 155, false, false, 2, false, 0, 0, 0, 0)
                            if GetDistanceBetweenCoords(Config.elevators[i][currentfloor].x, Config.elevators[i][currentfloor].y, Config.elevators[i][currentfloor].z, pedcoords, true) <= 1.0 and IsControlJustReleased(0, 38) then
                                OpenElevator(i, currentfloor)
                            end
                        end
                    end
                end
            end
            Citizen.Wait(1)
        end
    end)
end

function OpenElevator(i, f)
    local el = {}
    for a = 1, #Config.elevators[i], 1 do
        if a ~= f then
            table.insert(el, {label = Config.elevators[i][a].text, floor = a})
        end
    end
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open("default", "hope_elevator", "elevator", {
        title = "樓層",
        align = "top-left",
        elements = el
    }, function(data, menu)
        if data.current.floor ~= nil then
            ESX.UI.Menu.CloseAll()
            Teleport(i, data.current.floor)
        end
    end, function(data, menu)
        menu.close()
    end)
end

function Teleport(i, f)
    currentfloor = f
    DoScreenFadeOut(500)
    Citizen.Wait(600)
    PlaySoundFrontend(-1, "OPENING", "MP_PROPERTIES_ELEVATOR_DOORS" , 1)
    SetEntityCoords(PlayerPedId(), Config.elevators[i][f].x, Config.elevators[i][f].y, Config.elevators[i][f].z, 1, 0, 0, 0)
    Citizen.Wait(200)
    DoScreenFadeIn(500)
end

function DisableControl() DisableControlAction(0, 73, false) DisableControlAction(0, 24, true) DisableControlAction(0, 257, true) DisableControlAction(0, 25, true) DisableControlAction(0, 263, true) DisableControlAction(0, 32, true) DisableControlAction(0, 34, true) DisableControlAction(0, 31, true) DisableControlAction(0, 30, true) DisableControlAction(0, 45, true) DisableControlAction(0, 22, true) DisableControlAction(0, 44, true) DisableControlAction(0, 37, true) DisableControlAction(0, 23, true) DisableControlAction(0, 288, true) DisableControlAction(0, 289, true) DisableControlAction(0, 170, true) DisableControlAction(0, 167, true) DisableControlAction(0, 73, true) DisableControlAction(2, 199, true) DisableControlAction(0, 47, true) DisableControlAction(0, 264, true) DisableControlAction(0, 257, true) DisableControlAction(0, 140, true) DisableControlAction(0, 141, true) DisableControlAction(0, 142, true) DisableControlAction(0, 143, true) end
function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.40, 0.40)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    --local factor = (string.len(text)) / 250
    --DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 140)
end


