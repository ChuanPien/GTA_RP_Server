local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local ajdik = GetPlayerServerId(PlayerId())
local idVisable = true
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(2000)
	ESX.TriggerServerCallback('esx_scoreboard:getConnectedPlayers', function(connectedPlayers)
		UpdatePlayerTable(connectedPlayers)
	end)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	local data = xPlayer

	local job = data.job
	SendNUIMessage({action = "updatePraca", praca = job.label.." - "..job.grade_label})
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	SendNUIMessage({action = "updatePraca", praca = job.label.." - "..job.grade_label})
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		ajdik = GetPlayerServerId(PlayerId())
		if ajdik == nil or ajdik == '' then
			ajdik = GetPlayerServerId(PlayerId())
		end
	end
end)

Citizen.CreateThread(function()
	Citizen.Wait(500)
	ajdik = GetPlayerServerId(PlayerId())
	if ajdik == nil or ajdik == '' then
		ajdik = GetPlayerServerId(PlayerId())
	end
	SendNUIMessage({
		action = 'updateServerInfo',

		maxPlayers = GetConvarInt('sv_maxclients', 120),
		uptime = ajdik,
	})
end)

RegisterNetEvent('esx_scoreboard:updateConnectedPlayers')
AddEventHandler('esx_scoreboard:updateConnectedPlayers', function(connectedPlayers)
	UpdatePlayerTable(connectedPlayers)
end)

RegisterNetEvent('esx_scoreboard:updatePing')
AddEventHandler('esx_scoreboard:updatePing', function(connectedPlayers)
	SendNUIMessage({
		action  = 'updatePing',
		players = connectedPlayers
	})
end)

RegisterNetEvent('esx_scoreboard:toggleID')
AddEventHandler('esx_scoreboard:toggleID', function(state)
	if state then
		idVisable = state
	else
		idVisable = not idVisable
	end

	SendNUIMessage({
		action = 'toggleID',
		state = idVisable
	})
end)

RegisterNetEvent('uptime:tick')
AddEventHandler('uptime:tick', function(uptime)
	ajdik = GetPlayerServerId(PlayerId())
	if ajdik == nil or ajdik == '' then
		ajdik = GetPlayerServerId(PlayerId())
	end
	SendNUIMessage({
		action = 'updateServerInfo',
		uptime = ajdik
	})
end)

function UpdatePlayerTable(connectedPlayers)
	local formattedPlayerList, num = {}, 1
	local ambulance, police, mechanic, players = 0, 0, 0, 0

	for k,v in pairs(connectedPlayers) do
		players = players + 1

		if v.job == 'ambulance' then
			ambulance = ambulance + 1
		elseif v.job == 'police' then
			police = police + 1
		elseif v.job == 'mechanic' then
			mechanic = mechanic + 1
		end
	end

		if ambulance > 0 then
			ambulance = "✅"
		else
			ambulance = "⛔"
		end

		if mechanic > 0 then
			mechanic = "✅"
		else
			mechanic = "⛔"
		end

		if police > 0 and police < 3 then
			police = "🚨"
		elseif police > 2 and police < 4 then
			police = "🚨🚨"
		elseif police > 3 then
			police = "🚨🚨🚨"
		else
			police = "⛔"
		end

	SendNUIMessage({
		action = 'updatePlayerJobs',
		jobs   = {ambulance = ambulance, police = police, mechanic = mechanic, player_count = players}
	})

	local pingpong = nil

	ESX.TriggerServerCallback('Roddy-ping', function(data)
		local deta = data
		pingpong = deta
		
		SendNUIMessage({
			action = 'updateServerInfo',
			playTime = pingpong
		})

	end)

end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(0, Keys['F9']) and IsInputDisabled(0) then
			ToggleScoreBoard()
		end
		if IsControlJustReleased(0, Keys['F9']) and IsInputDisabled(0) then
			ToggleScoreBoard()
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(300)

		if IsPauseMenuActive() and not IsPaused then
			IsPaused = true
			SendNUIMessage({
				action  = 'close'
			})
		elseif not IsPauseMenuActive() and IsPaused then
			IsPaused = false
		end
	end
end)

function ToggleScoreBoard()
	SendNUIMessage({
		action = 'toggle'
	})
end
