-- Optimizations
local showMap, showBars, showArmor, showOxygen, isOpen, cinematicHud, isPaused
local healthActive, armorActive, hungerActive, thirstActive, staminaActive, oxygenActive, microphoneActive, timeActive, cinematicActive, idActive, jobActive, timedivActive, walletdivActive, bankdivActive, blackMoneydivActive, main2Active, mainActive, logoActive
local healthSwitch, armorSwitch, hungerSwitch, thirstSwitch, staminaSwitch, oxygenSwitch, microphoneSwitch, timeSwitch, cinematicSwitch, idSwitch, jobSwitch, timedivSwitch, walletdivSwitch, bankdivSwitch, blackMoneydivSwitch, main2Switch, mainSwitch, logoSwitch
local loadingscreen = true

AddEventHandler('playerSpawned', function()
	loadingscreen = false
end)
-- Variables
local whisper, normal, shout = 33, 66, 100 
local microphone = normal -- Change this for default (whisper, normal, shout)
local Keys = {
["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18, ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182, ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81, ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178, ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173, ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}


-- Main Thread
CreateThread(function()
while true do

local health = nil
local ped = PlayerPedId()
local player = PlayerId()
local oxygen = GetPlayerUnderwaterTimeRemaining(player) * Config.oxygenMax
local stamina = 100 - GetPlayerSprintStaminaRemaining(player)
local armor, id = GetPedArmour(ped), GetPlayerServerId(player)
local minutes, hours = GetClockMinutes(), GetClockHours()
local players = #GetActivePlayers() * 100 / Config.maxPlayers

TriggerEvent('esx_status:getStatus', 'hunger', function(h)
hunger = h.getPercent()
end)
TriggerEvent('esx_status:getStatus', 'thirst', function(t)
 thirst = t.getPercent()
end)

if IsEntityDead(ped) then
health = 0
else
health = GetEntityHealth(ped) - 100
end

if (minutes <= 9) then
minutes = "0" .. minutes
end
if (hours <= 9) then
hours = "0" .. hours
end

-- Armor hide if not used and configured to true (config.lua)
if Config.hideArmor and not cinematicHud and not isPaused then
if (armor <= 0) then
if not armorSwitch then
SendNUIMessage({action = 'armorHide'})
armorActive = true
showArmor = true
else
SendNUIMessage({action = 'armorShow'})
armorActive = false
showArmor = false
end
elseif not armorSwitch then
SendNUIMessage({action = 'armorShow'})
armorActive = false
showArmor = false
end


end

-- Action when pause menu on
if IsPauseMenuActive() and not isPaused and not isOpen then
if not mainActive then
mainActive = true
SendNUIMessage({action = 'mainHide'})
end
isPaused = true
elseif not IsPauseMenuActive() and isPaused and not cinematicHud and not loadingscreen then
if mainActive then
mainActive = false
SendNUIMessage({action = 'mainShow'})
end
isPaused = false
end

SendNUIMessage({
action = "hud",
health = health,
armor = armor,
stamina = stamina,
hunger = hunger,
thirst = thirst,
oxygen = oxygen,
id = id,
players = players,
time = hours .. " : " .. minutes
})

Wait(Config.waitTime)
end
end)
-- Disable action control
CreateThread(function()
while isOpen do
Wait(500)
DisableControlAction(0, 322, true)
end
end)

--  Events
RegisterNUICallback('close', function(event)
SendNUIMessage({ action = 'hide' })
SetNuiFocus(false, false)
isOpen = false
end)

RegisterNUICallback('change', function(data)
TriggerEvent('oc_hud:change', data.action)
end)

-- Change Switch list
RegisterNetEvent('oc_hud:change')
AddEventHandler('oc_hud:change', function(action)

if action == "hunger" then
if not hungerActive then
hungerActive = true
hungerSwitch = true
SendNUIMessage({action = 'hungerHide'})
else
hungerActive = false
hungerSwitch = false
SendNUIMessage({action = 'hungerShow'})
end

elseif action == "thirst" then
if not thirstActive then
thirstActive = true
thirstSwitch = true
SendNUIMessage({action = 'thirstHide'})
else
thirstActive = false
thirstSwitch = false
SendNUIMessage({action = 'thirstShow'})
end

elseif action == "walletdiv" then
if not walletdivActive then
walletdivActive = true
walletdivSwitch = true
SendNUIMessage({action = 'walletdivHide'})
else
walletdivActive = false
walletdivSwitch = false
SendNUIMessage({action = 'walletdivShow'})
end

elseif action == "blackMoneydiv" then
if not blackMoneydivActive then
blackMoneydivActive = true
blackMoneydivSwitch = true
SendNUIMessage({action = 'blackMoneydivHide'})
else
blackMoneydivActive = false
blackMoneydivSwitch = false
SendNUIMessage({action = 'blackMoneydivShow'})
end

elseif action == "bankdiv" then
if not bankdivActive then
bankdivActive = true
bankdivSwitch = true
SendNUIMessage({action = 'bankdivHide'})
else
bankdivActive = false
bankdivSwitch = false
SendNUIMessage({action = 'bankdivShow'})
end

elseif action == "main" then
if not mainActive then
mainActive = true
mainSwitch = true
showMap = false
DisplayRadar(false)
SendNUIMessage({action = 'mainHide'})

else 
mainActive = false
mainSwitch = false
showMap = true
DisplayRadar(true)
SendNUIMessage({action = 'mainShow'})
end

elseif action == "main2" then
if not main2Active then
main2Active = true
main2Switch = true
SendNUIMessage({action = 'main2Hide'})
else
main2Active = false
main2Switch = false
SendNUIMessage({action = 'main2Show'})
end

elseif action == "job" then
if not jobActive then
jobActive = true
jobSwitch = true
SendNUIMessage({action = 'jobHide'})
else
jobActive = false
jobSwitch = false
SendNUIMessage({action = 'jobShow'})
end

elseif action == "time" then
if not timeActive then
timeActive = true
timeSwitch = true
SendNUIMessage({action = 'timeHide'})
else
timeActive = false
timeSwitch = false
SendNUIMessage({action = 'timeShow'})
end

elseif action == "microphone" then
if not microphoneActive then
microphoneActive = true
microphoneSwitch = true
SendNUIMessage({action = 'microphoneHide'})
else
microphoneActive = false
microphoneSwitch = false
SendNUIMessage({action = 'microphoneShow'})
end

elseif action == "oxygen" then
if not oxygenActive then
oxygenActive = true
oxygenSwitch = true
SendNUIMessage({action = 'oxygenHide'})
else
oxygenActive = false
oxygenSwitch = false
SendNUIMessage({action = 'oxygenShow'})
end

elseif  action == "health" then
if not healthActive then
healthActive = true
healthSwitch = true
SendNUIMessage({action = 'healthHide'})
else
healthActive = false
healthSwitch = false
SendNUIMessage({action = 'healthShow'})
end

elseif action == "armor" then
if not armorActive then
armorActive = true
armorSwitch = true
SendNUIMessage({action = 'armorHide'})
else
armorActive = false
armorSwitch = false
SendNUIMessage({action = 'armorShow'})
end

elseif action == "stamina" then
if not staminaActive then
staminaActive = true
staminaSwitch = true
SendNUIMessage({action = 'staminaHide'})
else
staminaActive = false
staminaSwitch = false
SendNUIMessage({action = 'staminaShow'})
end

elseif action == "id" then
if not idActive then
idActive = false
idSwitch = false
SendNUIMessage({action = 'idHide'})
else
idActive = false
idSwitch = false
SendNUIMessage({action = 'idShow'})
end

elseif action == "map" then
if not showMap then
showMap = true
DisplayRadar(true)
else
showMap = false
DisplayRadar(false)
end

elseif action == "cinematic" then
if not cinematicActive then
cinematicActive = true
cinematicSwitch = true
cinematicHud = true
if not mainActive then
mainActive = true
showMap = false
DisplayRadar(false)
SendNUIMessage({action = 'mainHide'})
end

SendNUIMessage({action = 'cinematicShow'})
else
cinematicActive = false
cinematicSwitch = false
cinematicHud = false
if mainActive and not mainSwitch then
mainActive = false
showMap = true
DisplayRadar(true)
SendNUIMessage({action = 'mainShow'})
end
SendNUIMessage({action = 'cinematicHide'})
end

end

end)


RegisterNetEvent("esx_status:onTick")
AddEventHandler("esx_status:onTick", function(status)
TriggerEvent('esx_status:getStatus', 'hunger', function(status)
hunger = status.val / 10000
end)
TriggerEvent('esx_status:getStatus', 'thirst', function(status)
thirst = status.val / 10000
end)
end)



RegisterNetEvent("oc_hud:hudopen") 
AddEventHandler("oc_hud:hudopen", function() 
hud()
end)


-- command open menu
RegisterCommand('hud', function()
if not isOpen and not isPaused then
isOpen = true
SendNUIMessage({ action = 'show' })
SetNuiFocus(true, true)
end
end)

-- hud
 function hud()
if not isOpen and not isPaused then
isOpen = true
SendNUIMessage({ action = 'show' })
SetNuiFocus(true, true)
end
end

-- Handler
AddEventHandler('playerSpawned', function()
Wait(Config.waitSpawn)
SendNUIMessage({ action = 'setPosition' })
end)

AddEventHandler('onResourceStart', function(resourceName)
if (GetCurrentResourceName() == resourceName) then
Wait(Config.waitResource)
SendNUIMessage({ action = 'setPosition' })
end
end)




-- Money

Citizen.CreateThread(function() 
while true do
Citizen.Wait(1000)
TriggerServerEvent('oc_hud:getMoneys')
end

end)

RegisterNetEvent("oc_hud:setValues")

AddEventHandler("oc_hud:setValues", function(wallet, bank, black_money)
  SendNUIMessage({
  wallet = wallet,
  bank = bank,
  black_money = black_money
})

end)


-- job

ESX = nil
local lastJob = nil
local isAmmoboxShown = false
local PlayerData = nil

Citizen.CreateThread(function()
  while ESX == nil do
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
Citizen.Wait(10)
  end
  Citizen.Wait(500)
  if PlayerData == nil or PlayerData.job == nil then
  PlayerData = ESX.GetPlayerData()
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


Citizen.CreateThread(function()
while true do
Citizen.Wait(500)
if(PlayerData ~= nil) and (PlayerData.job ~= nil) then
local jobName = PlayerData.job.label..' - '..PlayerData.job.grade_label
if(lastJob ~= jobName) then
lastJob = jobName
SendNUIMessage({
action = 'setJob',
data = jobName
})
end
end
end
end)


