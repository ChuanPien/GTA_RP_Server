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
	while true do
		Citizen.Wait(0)
		-- SetCreateRandomCops(false) -- set random cops walking/driving around
		-- SetCreateRandomCopsNotOnScenarios(false) -- set random cops (not in a scenario) from spawning
		-- SetCreateRandomCopsOnScenarios(false) -- set random cops (in a scenario) from spawning
		-- SetVehicleDensityMultiplierThisFrame(0.5,0.5) -- set traffic density
		-- SetPedDensityMultiplierThisFrame(0.5,0.5) -- set npc/ai peds density
		-- SetRandomVehicleDensityMultiplierThisFrame(0.5,0.5) -- set random vehicles (car scenarios / cars driving off from a parking spot etc.)
		-- SetParkedVehicleDensityMultiplierThisFrame(0.3,0.3) -- set random parked vehicles (parked car scenarios)
		-- SetScenarioPedDensityMultiplierThisFrame(0.5,0.5) -- set random npc/ai peds or scenario peds
		-- DisablePlayerVehicleRewards(PlayerId())
		-- SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
		-- SetPedSuffersCriticalHits(GetPlayerPed(-1), false)
		SetWeaponDrops()
		-- ClearAreaOfVehicles(playerCoords, 1000, false, false, false, false, false)
		-- RemoveVehiclesFromGeneratorsInArea(playerCoords.x - 500.0, playerCoords.y - 500.0, playerCoords.z - 500.0, playerCoords.x + 500.0, playerCoords.y + 500.0, playerCoords.z + 500.0)
	end
end)

function SetWeaponDrops()
	local handle, ped = FindFirstPed()
	local finished = false

	repeat
		if not IsEntityDead(ped) then
			SetPedDropsWeaponsWhenDead(ped, false)
		end
		finished, ped = FindNextPed(handle)
	until not finished

	EndFindPed(handle)
end

-----------------------跌倒-----------------------

-- local sh = GetEntityHealth(ply)
-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(0)
-- 		local ply = GetPlayerPed(-1)
-- 		if PlayerData.job ~= nil and PlayerData.job.name ~= 'admin' then
--             if HasEntityBeenDamagedByAnyPed(ply) then
--                     dam = sh - GetEntityHealth(ply)
--                     if (dam > 0) and (GetPedArmour(ply) <= 25) then
--                         if dam >= 17 then
--                             hurtPainful(ply, dam)
--                         end
--                     end
                    
--                     sh = GetEntityHealth(ply)
-- 			end
-- 			ClearEntityLastDamageEntity(ply)
-- 		end
-- 	 end
-- end)



function hurtMedium(ped, r)
    if IsEntityDead(ped) then return false end
    SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
    --print(r)
end
function hurtMediumBad(ped, r)
    if IsEntityDead(ped) then return false end
    SetPedToRagdoll(GetPlayerPed(-1), 1500, 1500, 0, 0, 0, 0)
    --Citizen.SetTimeout( 4000, function() SetPedIsDrunk(ped, true) end)
    --Citizen.SetTimeout( 30000, function() SetPedIsDrunk(ped, false) end)
    --print(r)
end
function hurtBad(ped, r)
    if IsEntityDead(ped) then return false end
    SetPedToRagdoll(GetPlayerPed(-1), 2000, 2000, 0, 0, 0, 0)
    --Citizen.SetTimeout( 5000, function() SetPedIsDrunk(ped, true) end)
    --Citizen.SetTimeout( 120000, function() SetPedIsDrunk(ped, false) end)
    --print(r)
end
function hurtPainful(ped, r)
    if IsEntityDead(ped) then return false end
    SetPedToRagdoll(GetPlayerPed(-1), 2500, 2500, 0, 0, 0, 0)
    --Citizen.SetTimeout( 15000, function() SetPedIsDrunk(ped, true) end)
    --Citizen.SetTimeout( 120000, function() SetPedIsDrunk(ped, false) end)
    --print(r)
end

local x_axis = 1.720
local y_axis = 0.110

-----------------------跌倒-----------------------

local ragdoll_chance = 0.5

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100) -- check every 100 ticks, performance matters
		local ped = PlayerPedId()
		if PlayerData.job ~= nil and PlayerData.job.name ~= 'admin' then
			if IsPedOnFoot(ped) and not IsPedSwimming(ped) and (IsPedRunning(ped) or IsPedSprinting(ped)) and not IsPedClimbing(ped) and IsPedJumping(ped) and not IsPedRagdoll(ped) then
				local chance_result = math.random()
				----print('lose grip result: ' .. chance_result)
				if chance_result < ragdoll_chance then 
					Citizen.Wait(600) -- roughly when the ped loses grip
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08) -- change this float to increase/decrease camera shake
					SetPedToRagdoll(ped, 5000, 1, 2)
					----print('~y~你跌倒了!')
				else
					Citizen.Wait(2000) -- cooldown before continuing
				end
			end
		end
	end
end)

----------------------------------------------

local citizen = false

RegisterNetEvent('LRP-Armour:Client:SetPlayerArmour')
AddEventHandler('LRP-Armour:Client:SetPlayerArmour', function(armour)
    Citizen.Wait(10000)  -- Give ESX time to load their stuff. Because some how ESX remove the armour when load the ped.
    SetPedArmour(PlayerPedId(), tonumber(armour))
    citizen = true
end)

local TimeFreshCurrentArmour = 60000  -- 60 seconds

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if citizen == true then
            TriggerServerEvent('LRP-Armour:Server:RefreshCurrentArmour', GetPedArmour(PlayerPedId()))
            Citizen.Wait(TimeFreshCurrentArmour)
        end
    end
end)


-----------------------武器傷害-----------------------

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 0.2) --徒手
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_FLASHLIGHT"), 0.2) --手電筒
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_HAMMER"), 0.2) --錘子
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_CROWBAR"), 0.2) --撬棍
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_BAT"), 0.2) --棒球棍
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_NIGHTSTICK"), 0.2) --警棍
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_GOLFCLUB"), 0.2) --高爾夫球棍
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MACHETE"), 0.2) --開山刀

		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_COMBATPISTOL"), 0.5) --戰鬥手槍
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PISTOL"), 0.4) --手槍
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PUMPSHOTGUN"), 0.4) --泵動式霰彈槍
    end
end)

-----------------------------------------------------------

function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

local config = {
    ["TITLE"] = " ~y~懶欣球3.0~s~|~b~discord.gg/GX2AxREJwA ",
    -- ["SUBTITLE"] = "~p~最原味的RP生活",
    ["MAP"] = "~y~懶欣地圖",
    -- ["STATUS"] = "New Name for Status",
    -- ["GAME"] = "New Name for Game",
    -- ["INFO"] = "New Name for Info",
    -- ["SETTINGS"] = "New Name for Settings",
    -- ["R*EDITOR"] = "New Name for Rockstar Editor"
}

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(0)
        N_0xb9449845f73f5e9c("SHIFT_CORONA_DESC")
        PushScaleformMovieFunctionParameterBool(true)
        PopScaleformMovieFunction()
        N_0xb9449845f73f5e9c("SET_HEADER_TITLE")
        PushScaleformMovieFunctionParameterString(config["TITLE"])
        PushScaleformMovieFunctionParameterBool(true)
        -- PushScaleformMovieFunctionParameterString(config["SUBTITLE"])
        -- PushScaleformMovieFunctionParameterBool(true)
        PopScaleformMovieFunctionVoid()
    end
end)

Citizen.CreateThread(function()
    AddTextEntry('PM_SCR_MAP', config["MAP"])
    -- AddTextEntry('PM_SCR_STA', config["STATUS"])
    -- AddTextEntry('PM_SCR_GAM', config["GAME"])
    -- AddTextEntry('PM_SCR_INF', config["INFO"])
    -- AddTextEntry('PM_SCR_SET', config["SETTINGS"])
    -- AddTextEntry('PM_SCR_RPL', config["R*EDITOR"])
end)

---車上開槍
-- local passengerDriveBy = true
-- Citizen.CreateThread(function()
-- 	while true do
-- 		Wait(1)
-- 		local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
-- 		local speed = GetEntitySpeed(vehicle)
-- 		local kmh = 3.6
-- 		local mph = 2.23694
-- 		local vehicleClass = GetVehicleClass(vehicle)
-- 		local vehicleModel = GetEntityModel(vehicle)
		
		
-- 		if vehicleClass ~= 15 and 16 then
-- 			GetEntitySpeed(GetPedInVehicleSeat(GetPlayerPed(-1), false)) 
-- 		if math.floor(speed*kmh) >= 0 then
-- 			if PlayerData.job ~= nil and PlayerData.job.name == 'admin' then
-- 				SetPlayerCanDoDriveBy(PlayerId(), true)
-- 			else
-- 				if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_UNARMED') then
-- 					SetPlayerCanDoDriveBy(PlayerId(), true)
-- 				else
-- 					SetPlayerCanDoDriveBy(PlayerId(), false)
-- 				end
-- 			end
-- 		elseif passengerDriveBy then
-- 			SetPlayerCanDoDriveBy(PlayerId(), true)
-- 		else
-- 			SetPlayerCanDoDriveBy(PlayerId(), false)
-- 			end
-- 		end
-- 	end
-- end)

---受傷走路

local hurt = false
Citizen.CreateThread(function()
    while true do
        Wait(0)
        if GetEntityHealth(GetPlayerPed(-1)) <= 159 then
            setHurt()
        elseif hurt and GetEntityHealth(GetPlayerPed(-1)) > 160 then
            setNotHurt()
        end
    end
end)

function setHurt()
    hurt = true
    RequestAnimSet("move_m@injured")
    SetPedMovementClipset(GetPlayerPed(-1), "move_m@injured", true)
end

function setNotHurt()
    hurt = false
    ResetPedMovementClipset(GetPlayerPed(-1))
    ResetPedWeaponMovementClipset(GetPlayerPed(-1))
    ResetPedStrafeClipset(GetPlayerPed(-1))
end