ESX = nil
local PlayerData                = {}
local phoneProp = 0

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(10)
  end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)


local radioMenu = false

function PrintChatMessage(text)
    TriggerEvent('chatMessage', "system", { 255, 0, 0 }, text)
end

function newPhoneProp()
  deletePhone()
  RequestModel("prop_cs_walkie_talkie")
  while not HasModelLoaded("prop_cs_walkie_talkie") do
    Citizen.Wait(1)
  end

  phoneProp = CreateObject("prop_cs_walkie_talkie", 1.0, 1.0, 1.0, 1, 1, 0)
  local bone = GetPedBoneIndex(PlayerPedId(), 28422)
  AttachEntityToEntity(phoneProp, PlayerPedId(), bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
end

function deletePhone()
  if phoneProp ~= 0 then
    Citizen.InvokeNative(0xAE3CBE5BF394C9C9 , Citizen.PointerValueIntInitialized(phoneProp))
    phoneProp = 0
  end
end

function enableRadio(enable)
  if enable then
    local dict = "cellphone@"
    if IsPedInAnyVehicle(PlayerPedId(), false) then
      dict = "anim@cellphone@in_car@ps"
    end

    loadAnimDict(dict)

    local anim = "cellphone_call_to_text"
    TaskPlayAnim(PlayerPedId(), dict, anim, 3.0, -1, -1, 50, 0, false, false, false)
    newPhoneProp()
  else
    ClearPedSecondaryTask(PlayerPedId())
    deletePhone()
  end

  SetNuiFocus(true, true)
  radioMenu = enable
  SendNUIMessage({
    type = "enableui",
    enable = enable
  })

end

function loadAnimDict(dict)
  RequestAnimDict(dict)
  while not HasAnimDictLoaded(dict) do
    Citizen.Wait(1)
  end
end

RegisterCommand('radio', function(source, args)
    if Config.enableCmd then
      enableRadio(true)
    end
end, false)

RegisterNUICallback('joinRadio', function(data, cb)
  local _source = source
  local PlayerData = ESX.GetPlayerData(_source)
  local playerName = GetPlayerName(PlayerId())
  local GetPlayerRadioChannel = exports['mumble-voip']:GetPlayerRadioChannel(GetPlayerServerId(PlayerId()))

  if tonumber(data.channel) ~= GetPlayerRadioChannel then
      if tonumber(data.channel) <= Config.RestrictedChannels then
        if(PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'mechanic' or PlayerData.job.name == 'admin') then
          exports["mumble-voip"]:SetRadioChannel(0)
          exports["mumble-voip"]:SetRadioChannel(tonumber(data.channel))
          exports['mythic_notify']:DoHudText('inform', '進入頻道')
          TriggerServerEvent('esx_joblogs:AddInLog', "radio", "out", playerName, GetPlayerRadioChannel)
          TriggerServerEvent('esx_joblogs:AddInLog', "radio", "in", playerName, data.channel)
        else
          exports['mythic_notify']:DoHudText('error', '政府頻道')
        end
      end
    end
    if tonumber(data.channel) > Config.RestrictedChannels then
      exports["mumble-voip"]:SetRadioChannel(0)
      exports["mumble-voip"]:SetRadioChannel(tonumber(data.channel))
      exports['mythic_notify']:DoHudText('inform', '進入頻道')
      TriggerServerEvent('esx_joblogs:AddInLog', "radio", "out", playerName, GetPlayerRadioChannel)
      TriggerServerEvent('esx_joblogs:AddInLog', "radio", "in", playerName, data.channel)
    end
  cb('ok')
end)

RegisterNUICallback('leaveRadio', function(data, cb)
  local GetPlayerRadioChannel = exports['mumble-voip']:GetPlayerRadioChannel(GetPlayerServerId(PlayerId()))

  exports["mumble-voip"]:SetRadioChannel(0)
  exports['mythic_notify']:DoHudText('error', '離開頻道')
  TriggerServerEvent('esx_joblogs:AddInLog', "radio", "out", playerName, GetPlayerRadioChannel)
  cb('ok')
end)

RegisterNUICallback('escape', function(data, cb)
    enableRadio(false)
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNetEvent('ls-radio:use')
AddEventHandler('ls-radio:use', function()
  enableRadio(true)
end)

RegisterNetEvent('ls-radio:onRadioDrop')
AddEventHandler('ls-radio:onRadioDrop', function()
  exports["mumble-voip"]:SetRadioChannel(0)
end)

Citizen.CreateThread(function()
    while true do
        if radioMenu then
            DisableControlAction(0, 1, guiEnabled) -- LookLeftRight
            DisableControlAction(0, 2, guiEnabled) -- LookUpDown
            DisableControlAction(0, 142, guiEnabled) -- MeleeAttackAlternate
            DisableControlAction(0, 106, guiEnabled) -- VehicleMouseControlOverride
            if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
                SendNUIMessage({
                    type = "click"
                })
            end
        else
          Citizen.Wait(1500)
        end
        Citizen.Wait(10)
    end
end)
