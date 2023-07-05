local hospitalCheckin = { x = 307.04, y = -594.96, z = 43.28, h = 180.4409942627 }
local bedOccupying = nil
local bedObject = nil
local bedOccupyingData = nil
local cam = nil
local inBedDict = "anim@gangops@morgue@table@"
local inBedAnim = "ko_front"
local getOutDict = 'switch@franklin@bed'
local getOutAnim = 'sleep_getup_rubeyes'
local busy = false
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function PrintHelpText(message)
    SetTextComponentFormat("STRING")
    AddTextComponentString(message)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function LeaveBed()
    RequestAnimDict(getOutDict)
    while not HasAnimDictLoaded(getOutDict) do
        Citizen.Wait(0)
    end

    RenderScriptCams(0, true, 200, true, true)
    DestroyCam(cam, false)

    SetEntityInvincible(PlayerPedId(), false)

    SetEntityHeading(PlayerPedId(), bedOccupyingData.h - 90)
    TaskPlayAnim(PlayerPedId(), getOutDict , getOutAnim ,8.0, -8.0, -1, 0, 0, false, false, false )
    Citizen.Wait(5000)
    ClearPedTasks(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), false)
    TriggerServerEvent('mythic_hospital:server:LeaveBed', bedOccupying)

    FreezeEntityPosition(bedObject, false)

    bedOccupying = nil
    bedObject = nil
    bedOccupyingData = nil
end

RegisterNetEvent('mythic_hospital:client:RPCheckPos')
AddEventHandler('mythic_hospital:client:RPCheckPos', function()
    TriggerServerEvent('mythic_hospital:server:RPRequestBed', GetEntityCoords(PlayerPedId()))
end)

RegisterNetEvent('mythic_hospital:client:RPSendToBed')
AddEventHandler('mythic_hospital:client:RPSendToBed', function(id, data)
    bedOccupying = id
    bedOccupyingData = data

    bedObject = GetClosestObjectOfType(data.x, data.y, data.z, 1.0, data.model, false, false, false)
    FreezeEntityPosition(bedObject, true)

    SetEntityCoords(PlayerPedId(), data.x, data.y, data.z)

    RequestAnimDict(inBedDict)
    while not HasAnimDictLoaded(inBedDict) do
        Citizen.Wait(0)
    end

    TaskPlayAnim(PlayerPedId(), inBedDict , inBedAnim ,8.0, -8.0, -1, 1, 0, false, false, false )
    SetEntityHeading(PlayerPedId(), data.h + 180)

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
    AttachCamToPedBone(cam, PlayerPedId(), 31085, 0, 0, 1.0 , true)
    SetCamFov(cam, 90.0)
    SetCamRot(cam, -90.0, 0.0, GetEntityHeading(PlayerPedId()) + 180, true)

    SetEntityInvincible(PlayerPedId(), true)


    Citizen.CreateThread(function()
        while bedOccupyingData ~= nil do
            Citizen.Wait(1)
            PrintHelpText('Press ~INPUT_VEH_DUCK~ to get up')
            if IsControlJustReleased(0, 73) then
                LeaveBed()
            end
        end
    end)
end)

RegisterNetEvent('mythic_hospital:client:SendToBed')
AddEventHandler('mythic_hospital:client:SendToBed', function(id, data)
    bedOccupying = id
    bedOccupyingData = data
    
    bedObject = GetClosestObjectOfType(data.x, data.y, data.z, 1.0, data.model, false, false, false)
    FreezeEntityPosition(bedObject, true)
    TriggerEvent('mythic_hospital:fu')
    SetEntityCoords(PlayerPedId(), data.x, data.y, data.z)
    RequestAnimDict(inBedDict)
    while not HasAnimDictLoaded(inBedDict) do
        Citizen.Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), inBedDict , inBedAnim ,8.0, -8.0, -1, 1, 0, false, false, false )
    SetEntityHeading(PlayerPedId(), data.h + 180)
    SetEntityInvincible(PlayerPedId(), true)

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
    AttachCamToPedBone(cam, PlayerPedId(), 31085, 0, 0, 1.0 , true)
    SetCamFov(cam, 90.0)
    SetCamRot(cam, -90.0, 0.0, GetEntityHeading(PlayerPedId()) + 180, true)

    Citizen.CreateThread(function ()
        Citizen.Wait(5)
        exports['mythic_notify']:DoHudText('inform', '住院中...')
        exports['mythic_notify']:DoHudText('inform', '剩30個月')
        Citizen.Wait(15000)
        exports['mythic_notify']:DoHudText('inform', '住院中...')
        exports['mythic_notify']:DoHudText('inform', '剩15個月')
        Citizen.Wait(15000)
        TriggerEvent('mythic_hospital:client:FinishServices')
    end)
end)

RegisterNetEvent('mythic_hospital:client:FinishServices')
AddEventHandler('mythic_hospital:client:FinishServices', function()
	local player = PlayerPedId()
    busy = false
	if IsPedDeadOrDying(player) then
		local playerPos = GetEntityCoords(player, true)
		NetworkResurrectLocalPlayer(playerPos, true, true, false)
	end

	SetEntityHealth(player, GetEntityMaxHealth(player))
    ClearPedBloodDamage(player)
    SetPlayerSprint(PlayerId(), true)
    exports['mythic_notify']:DoHudText('inform', '出院了')
    TriggerEvent('mythic_hospital:unfu')
    TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(PlayerId()), 'society_ambulance', '住院掛號治療費', 3500)
	TriggerServerEvent('esx_joblogs:AddInLog', 'ambulance', 'autoheal', GetPlayerName(PlayerId()))
    LeaveBed()
end)

RegisterNetEvent('mythic_hospital:client:ForceLeaveBed')
AddEventHandler('mythic_hospital:client:ForceLeaveBed', function()
    LeaveBed()
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local plyCoords = GetEntityCoords(PlayerPedId(), 0)
        local distance = #(vector3(hospitalCheckin.x, hospitalCheckin.y, hospitalCheckin.z) - plyCoords)
        if distance < 10 then

            if not IsPedInAnyVehicle(PlayerPedId(), true) then
                if distance < 1 then
                    PrintHelpText('[~g~E~s~]住院掛號')
					if IsControlJustReleased(0, 54) then
                        ESX.TriggerServerCallback('mythic_hospital',function (vild)
                            if vild == false then
                                exports['mythic_progbar']:Progress({
                                    name = "hospital_action",
                                    duration = 10000,
                                    label = "填寫基本資料中",
                                    useWhileDead = true,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "missheistdockssetup1clipboard@base",
                                        anim = "base",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "p_amb_clipboard_01",
                                        bone = 18905,
                                        coords = { x = 0.10, y = 0.02, z = 0.08 },
                                        rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                    propTwo = {
                                        model = "prop_pencil_01",
                                        bone = 58866,
                                        coords = { x = 0.12, y = 0.0, z = 0.001 },
                                        rotation = { x = -150.0, y = 0.0, z = 0.0 },
                                    },
                                }, function(status)
                                    if not status then
                                        TriggerServerEvent('mythic_hospital:server:RequestBed')
                                    end
                                end)
                            else
                                exports['mythic_notify']:DoHudText('inform', '醫護職勤中')
                            end
                        end)
                    end
                end
            end
        else
            Citizen.Wait(1000)
        end
    end
end)

RegisterNetEvent('mythic_hospital:fu')
AddEventHandler('mythic_hospital:fu', function()
    Citizen.CreateThread(function()
        Citizen.Wait(0)
        busy = true
        while busy do
            Citizen.Wait(0)
            DisableAllControlActions(0)
        end
    end)
end)

RegisterNetEvent('mythic_hospital:unfu')
AddEventHandler('mythic_hospital:unfu', function()
    busy = false
    while true do
        Citizen.Wait(0)
        if busy == false then
            EnableAllControlActions(0)
        end
    end
end)