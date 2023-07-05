local holdingup = false
local store = ""
local blipRobbery = nil
local vetrineRotte = 0 

local vetrine = {
	{x = 147.085, y = -1048.612, z = 29.346, heading = 70.326, isOpen = false},--
	{x = -626.735, y = -238.545, z = 38.057, heading = 214.907, isOpen = false},--
	{x = -625.697, y = -237.877, z = 38.057, heading = 217.311, isOpen = false},--
	{x = -626.825, y = -235.347, z = 38.057, heading = 33.745, isOpen = false},--
	{x = -625.77, y = -234.563, z = 38.057, heading = 33.572, isOpen = false},--
	{x = -627.957, y = -233.918, z = 38.057, heading = 215.214, isOpen = false},--
	{x = -626.971, y = -233.134, z = 38.057, heading = 215.532, isOpen = false},--
	{x = -624.433, y = -231.161, z = 38.057, heading = 305.159, isOpen = false},--
	{x = -623.045, y = -232.969, z = 38.057, heading = 303.496, isOpen = false},--
	{x = -620.265, y = -234.502, z = 38.057, heading = 217.504, isOpen = false},--
	{x = -619.225, y = -233.677, z = 38.057, heading = 213.35, isOpen = false},--
	{x = -620.025, y = -233.354, z = 38.057, heading = 34.18, isOpen = false},--
	{x = -617.487, y = -230.605, z = 38.057, heading = 309.177, isOpen = false},--
	{x = -618.304, y = -229.481, z = 38.057, heading = 304.243, isOpen = false},--
	{x = -619.741, y = -230.32, z = 38.057, heading = 124.283, isOpen = false},--
	{x = -619.686, y = -227.753, z = 38.057, heading = 305.245, isOpen = false},--
	{x = -620.481, y = -226.59, z = 38.057, heading = 304.677, isOpen = false},--
	{x = -621.098, y = -228.495, z = 38.057, heading = 127.046, isOpen = false},--
	{x = -623.855, y = -227.051, z = 38.057, heading = 38.605, isOpen = false},--
	{x = -624.977, y = -227.884, z = 38.057, heading = 48.847, isOpen = false},--
	{x = -624.056, y = -228.228, z = 38.057, heading = 216.443, isOpen = false},--
}

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function DrawText3D(x, y, z, text, scale)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

	SetTextScale(scale, scale)
	SetTextFont(1)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(1)
	SetTextColour(255, 255, 255, 215)

	AddTextComponentString(text)
	DrawText(_x, _y)

end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent("mt:missiontext")
AddEventHandler("mt:missiontext", function(text, time)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(text)
    DrawSubtitleTimed(time, 1)
end)

function loadAnimDict( dict )  
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

RegisterNetEvent('esx_vangelico_robbery:currentlyrobbing')
AddEventHandler('esx_vangelico_robbery:currentlyrobbing', function(robb)
	holdingup = true
	store = robb
end)

RegisterNetEvent('esx_vangelico_robbery:killblip')
AddEventHandler('esx_vangelico_robbery:killblip', function()
    RemoveBlip(blipRobbery)
end)

RegisterNetEvent('esx_vangelico_robbery:setblip')
AddEventHandler('esx_vangelico_robbery:setblip', function(position)
    blipRobbery = AddBlipForCoord(position.x, position.y, position.z)
    SetBlipSprite(blipRobbery , 161)
    SetBlipScale(blipRobbery , 2.0)
    SetBlipColour(blipRobbery, 3)
    PulseBlip(blipRobbery)
end)

RegisterNetEvent('esx_vangelico_robbery:toofarlocal')
AddEventHandler('esx_vangelico_robbery:toofarlocal', function(robb)
	holdingup = false
	ESX.ShowNotification(_U('robbery_cancelled'))
	robbingName = ""
	incircle = false
end)


RegisterNetEvent('esx_vangelico_robbery:robberycomplete')
AddEventHandler('esx_vangelico_robbery:robberycomplete', function(robb)
	holdingup = false
	ESX.ShowNotification(_U('robbery_complete'))
	store = ""
	incircle = false
end)

Citizen.CreateThread(function()
	for k,v in pairs(Stores)do
		local ve = v.position

		local blip = AddBlipForCoord(ve.x, ve.y, ve.z)
		SetBlipSprite(blip, 439)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('shop_robbery'))
		EndTextCommandSetBlipName(blip)
	end
end)

animazione = false
incircle = false
soundid = GetSoundId()

function drawTxt(x, y, scale, text, red, green, blue, alpha)
	SetTextFont(1)
	SetTextProportional(1)
	SetTextScale(0.64, 0.64)
	SetTextColour(red, green, blue, alpha)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
    DrawText(0.155, 0.935)
end

local borsa = nil

Citizen.CreateThread(function()
	while true do
	  Citizen.Wait(1000)
	  TriggerEvent('skinchanger:getSkin', function(skin)
		borsa = skin['bags_1']
	  end)
	  Citizen.Wait(1000)
	end
end)

AddEventHandler("datacrack", function(output)
	local pos = GetEntityCoords(GetPlayerPed(-1), true)
	for k,v in pairs(Stores)do
		local pos2 = v.position
		if output then
			if Config.NeedBag then
				if borsa == 40 or borsa == 41 or borsa == 44 or borsa == 45 then
					ESX.TriggerServerCallback('esx_vangelico_robbery:conteggio', function(CopsConnected)
						if CopsConnected >= Config.RequiredCopsRob then
							TriggerServerEvent('esx_vangelico_robbery:rob', k)
							PlaySoundFromCoord(soundid, "VEHICLES_HORNS_AMBULANCE_WARNING", pos2.x, pos2.y, pos2.z)
						else
							exports['mythic_notify']:DoHudText('error', '警察不足')
						end
					end)
				else
					exports['mythic_notify']:DoHudText('error', _U('need_bag'))
				end
			else
				ESX.TriggerServerCallback('esx_vangelico_robbery:conteggio', function(CopsConnected)
					if CopsConnected >= Config.RequiredCopsRob then
						TriggerServerEvent('esx_vangelico_robbery:rob', k)
						PlaySoundFromCoord(soundid, "VEHICLES_HORNS_AMBULANCE_WARNING", pos2.x, pos2.y, pos2.z)
					else
						exports['mythic_notify']:DoHudText('error', '警察不足')
					end
				end)	
			end
		end
	end
end)

Citizen.CreateThread(function()
      
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)

		for k,v in pairs(Stores)do
			local pos2 = v.position

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 15.0)then
				if not holdingup then
					DrawMarker(27, v.position.x, v.position.y, v.position.z-0.9, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 255, 0, 0, 200, 0, 0, 0, 0)

					if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 1.0)then
						if (incircle == false) then
							DisplayHelpText(_U('press_to_rob'))
						end
						incircle = true
						if IsControlJustReleased(1, 51) then
							ESX.TriggerServerCallback('esx_vangelico_robbery:looptop', function(looptop)
								if looptop >= 1 then
									TriggerServerEvent('esx_outlawalert:JewelsInProgress')
									Start(50)
									exports['mythic_notify']:DoHudText('error', '開始搶劫')
									TriggerServerEvent('esx_vangelico_robbery:laptop')
								else
									exports['mythic_notify']:DoHudText('error', '無筆記型電腦')
								end
							end)
                        end
					elseif(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 1.0)then
						incircle = false
					end
				end
			end
		end

		if holdingup then
			-- drawTxt(0.3, 1.4, 0.45, _U('smash_case') .. ' :~r~ ' .. vetrineRotte .. '/' .. Config.MaxWindows, 185, 185, 185, 255)

			for i,v in pairs(vetrine) do
				if(GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 10.0) and not v.isOpen and Config.EnableMarker then
					DrawMarker(20, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 0.6, 0.6, 0.6, 0, 255, 0, 200, 1, 1, 0, 0)
				end
				if(GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 0.75) and not v.isOpen then 
					DrawText3D(v.x, v.y, v.z, '~w~[~g~E~w~]~r~' .. _U('press_to_collect'), 0.6)
					if IsControlJustPressed(0, 38) then
						animazione = true
					    SetEntityCoords(GetPlayerPed(-1), v.x, v.y, v.z-0.95)
					    SetEntityHeading(GetPlayerPed(-1), v.heading)
						v.isOpen = true 
						PlaySoundFromCoord(-1, "Glass_Smash", v.x, v.y, v.z, "", 0, 0, 0)
					    if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
					    RequestNamedPtfxAsset("scr_jewelheist")
					    end
					    while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
					    Citizen.Wait(0)
					    end
					    SetPtfxAssetNextCall("scr_jewelheist")
					    StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", v.x, v.y, v.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
					    loadAnimDict( "missheist_jewel" ) 
						TaskPlayAnim(GetPlayerPed(-1), "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
						TriggerEvent("mt:missiontext", _U('collectinprogress'), 5000)
					    --DisplayHelpText(_U('collectinprogress'))
					    DrawSubtitleTimed(5000, 1)
						Citizen.Wait(5000)
					    ClearPedTasksImmediately(GetPlayerPed(-1))
					    TriggerServerEvent('esx_vangelico_robbery:gioielli')
					    PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
					    vetrineRotte = vetrineRotte+1
						animazione = false

						if vetrineRotte == Config.MaxWindows then 
						    for i,v in pairs(vetrine) do 
								v.isOpen = false
								vetrineRotte = 0
							end
							TriggerServerEvent('esx_vangelico_robbery:endrob', store)
						    holdingup = false
						    StopSound(soundid)
						end
					end
				end	
			end

			local pos2 = Stores[store].position

			if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -622.566, -230.183, 38.057, true) > 30 ) then
				TriggerServerEvent('esx_vangelico_robbery:toofar', store)
				holdingup = false
				for i,v in pairs(vetrine) do 
					v.isOpen = false
					vetrineRotte = 0
				end
				StopSound(soundid)
			end

		end

		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
      
	while true do
		Wait(1)
		if animazione == true then
			if not IsEntityPlayingAnim(PlayerPedId(), 'missheist_jewel', 'smash_case', 3) then
				TaskPlayAnim(PlayerPedId(), 'missheist_jewel', 'smash_case', 8.0, 8.0, -1, 17, 1, false, false, false)
			end
		end
	end
end)

RegisterNetEvent("lester:createBlip")
AddEventHandler("lester:createBlip", function(type, x, y, z)
	local blip = AddBlipForCoord(x, y, z)
	SetBlipSprite(blip, type)
	SetBlipColour(blip, 1)
	SetBlipScale(blip, 0.8)
	SetBlipAsShortRange(blip, true)
	if(type == 77)then
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Lester")
		EndTextCommandSetBlipName(blip)
	end
end)

blip = false

Citizen.CreateThread(function()
	-- TriggerEvent('lester:createBlip', 77, 706.669, -966.898, 30.413)
	while true do
	
		Citizen.Wait(1)
	
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)
		
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -10.04, 531.24, 170.0, true) <= 10 and not blip then
			-- DrawMarker(20, 0, 0, 0, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 100, 102, 100, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -10.04, 531.24, 170.0, true) < 2.0 then
				if not IsPedInAnyVehicle(playerPed, true) then  
					DisplayHelpText(_U('press_to_sell'))
					if IsControlJustReleased(1, 51) then
						TriggerServerEvent('lester:vendita')
					end
				else
					exports['mythic_notify']:DoHudText('error', ('請下車'))
					Wait(10000)
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
	
		Citizen.Wait(1)
	
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)
		
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1588.4, -530.44, 25.68, true) <= 10 and not blip then
			-- DrawMarker(20, 0, 0, 0, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 100, 102, 100, false, true, 2, false, false, false, false)
			if GetDistanceBetweenCoords(coords, -1588.4, -530.44, 25.68, true) < 3.0 then
				if not IsPedInAnyVehicle(playerPed, true) then  
					DisplayHelpText('[~g~E~s~]販售金條')
					if IsControlJustReleased(1, 51) then
						TriggerServerEvent('lester:sellgold')
					end
				else
					exports['mythic_notify']:DoHudText('error', ('請下車'))
					Wait(10000)
				end
			end
		end
	end
end)

local output = {}
local stophack = false
local Dat_1 = { [1] = { val1 = 0.4, }, [2] = { val1 = 0.4, }, [3] = { val1 = 0.4, }, [4] = { val1 = 0.4, }, [5] = { val1 = 0.4, }, [6] = { val1 = 0.4, }, [7] = { val1 = 0.4, }, }
local Dat_2 = { [1] = { val0 = 1, val1 = (0.02 * 0.55), val2 = 0, val3 = 1, val4 = true }, [2] = { val0 = 1, val1 = (0.025 * 0.55), val2 = 0, val3 = 1, val4 = true }, [3] = { val0 = 1, val1 = (0.03 * 0.55), val2 = 0, val3 = 1, val4 = true }, [4] = { val0 = 1, val1 = (0.035 * 0.55), val2 = 0, val3 = 1, val4 = true }, [5] = { val0 = 1, val1 = (0.04 * 0.55), val2 = 0, val3 = 1, val4 = true }, [6] = { val0 = 1, val1 = (0.045 * 0.55), val2 = 0, val3 = 1, val4 = true }, [7] = { val0 = 1, val1 = (0.05 * 0.55), val2 = 0, val3 = 1, val4 = true } }
function F_02536(arg1) BeginTextCommandDisplayHelp('STRING') AddTextComponentSubstringPlayerName(arg1) EndTextCommandDisplayHelp(0, false, true, -1) end
function F_02539() DisableControlAction(0, 73, false) DisableControlAction(0, 24, true) DisableControlAction(0, 257, true) DisableControlAction(0, 25, true) DisableControlAction(0, 263, true) DisableControlAction(0, 32, true) DisableControlAction(0, 34, true) DisableControlAction(0, 31, true) DisableControlAction(0, 30, true) DisableControlAction(0, 45, true) DisableControlAction(0, 22, true) DisableControlAction(0, 44, true) DisableControlAction(0, 37, true) DisableControlAction(0, 23, true) DisableControlAction(0, 288, true) DisableControlAction(0, 289, true) DisableControlAction(0, 170, true) DisableControlAction(0, 167, true) DisableControlAction(0, 73, true) DisableControlAction(2, 199, true) DisableControlAction(0, 47, true) DisableControlAction(0, 264, true) DisableControlAction(0, 257, true) DisableControlAction(0, 140, true) DisableControlAction(0, 141, true) DisableControlAction(0, 142, true) DisableControlAction(0, 143, true) end
function F_02540(arg1) if (Dat_1[arg1].val1 >= 0.51) and (Dat_1[arg1].val1 <= 0.62) then return true end return false end
function F_02541(arg1, arg2, arg3) local number number = ((1.0 - Cos(F_02542((arg3 * 3.141593)))) * 0.5); return ((arg1 * (1 - number)) + (arg2 * number)); end
function F_02542(arg1) return (arg1 * 57.29578) end
function F_02668(arg1)
    Citizen.CreateThread(function()
        local current = 1
        Dat_2[current].val0 = 0
        while true do
            F_02539()
            F_02536("Press ~INPUT_FRONTEND_CANCEL~ to abort hack")
            if IsControlJustReleased(2, 237) then
                if F_02540(current) then
                    PlaySoundFrontend(-1, "Pin_Good", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                    Dat_2[current].val0 = 1
                    Dat_2[current].val4 = false
                    Dat_1[current].val1 = 0.572
                    if current < 7 then
                        Dat_2[current+1].val0 = 0
                    end
                    current = current + 1
                    if current > 7 then
                        return
                    end
                else
                    PlaySoundFrontend(-1, "Pin_Bad", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                    if current > 1 then
                        Dat_2[current].val0 = 1
                        current = current - 1
                        Dat_2[current].val0 = 0
                        Dat_1[current].val1 = 0.572
                        Dat_2[current].val4 = true
                    end
                end
            elseif IsControlJustReleased(2, 202) then
                Abort()
                return
            end
            if stophack then
                return
            end
            Citizen.Wait(1)
        end
    end)
    Citizen.CreateThread(function()
        while true do
            for i = 1, #Dat_2, 1 do
                if Dat_2[i].val3 == 1 then
                    if Dat_2[i].val2 < 1.0 then
                        Dat_2[i].val2 = Dat_2[i].val2 + ((Dat_2[i].val1 * Timestep()) * (arg1 * 1.0))
                    else
                        Dat_2[i].val3 = 0
                    end
                elseif Dat_2[i].val2 > 0.0 then
                    Dat_2[i].val2 = Dat_2[i].val2 - ((Dat_2[i].val1 * Timestep()) * (arg1 * 1.0))
                else
                    Dat_2[i].val3 = 1
                end
                if Dat_2[i].val0 == 0 or Dat_2[i].val4 then
                    Dat_1[i].val1 = F_02541(0.744, 0.4, Dat_2[i].val2)
                end
                if stophack then
                    return
                end
            end
            Citizen.Wait(1)
        end
    end)
    Citizen.CreateThread(function()
        RequestStreamedTextureDict("HACKING_PC_desktop_0", false)
        RequestStreamedTextureDict("hackingNG", false)
        local scaleform = RequestScaleformMovieInteractive("HACKING_PC")

        while not HasScaleformMovieLoaded(scaleform) do
            Citizen.Wait(0)
        end
        PushScaleformMovieFunction(scaleform, "ADD_PROGRAM")
        PushScaleformMovieFunctionParameterFloat(1.0)
        PushScaleformMovieFunctionParameterFloat(4.0)
        PushScaleformMovieFunctionParameterString("My Computer")
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "ADD_PROGRAM")
        PushScaleformMovieFunctionParameterFloat(6.0)
        PushScaleformMovieFunctionParameterFloat(6.0)
        PushScaleformMovieFunctionParameterString("Power Off")
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_BACKGROUND")
        PushScaleformMovieFunctionParameterInt(1)
        PopScaleformMovieFunctionVoid()

        while not HasStreamedTextureDictLoaded("hackingNG") do
            Citizen.Wait(1)
        end
        while true do
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
            DrawSprite("hackingNG", "DHMain",0.50, 0.50, 0.731, 1.306, 0, 255, 255, 255, 255, 0)
            if Dat_2[1].val0 == 1 then
                DrawSprite("hackingNG", "DHComp", 0.35, Dat_1[1].val1, 0.4, 0.4, 0, 255, 255, 255, 255, 0)
            elseif Dat_2[1].val0 == 0 then
                DrawSprite("hackingNG", "DHCompHi", 0.35, Dat_1[1].val1, 0.4, 0.4, 0, 255, 255, 255, 255, 0)
            end
            if Dat_2[2].val0 == 1 then
                DrawSprite("hackingNG", "DHComp", 0.40, Dat_1[2].val1, 0.4, 0.4, 0, 255, 255, 255, 255, 0)
            elseif Dat_2[2].val0 == 0 then
                DrawSprite("hackingNG", "DHCompHi", 0.40, Dat_1[2].val1, 0.4, 0.4, 0, 255, 255, 255, 255, 0)
            end
            if Dat_2[3].val0 == 1 then
                DrawSprite("hackingNG", "DHComp", 0.45, Dat_1[3].val1, 0.4, 0.4, 0, 255, 255, 255, 255, 0)
            elseif Dat_2[3].val0 == 0 then
                DrawSprite("hackingNG", "DHCompHi", 0.45, Dat_1[3].val1, 0.4, 0.4, 0, 255, 255, 255, 255, 0)
            end
            if Dat_2[4].val0 == 1 then
                DrawSprite("hackingNG", "DHComp", 0.50, Dat_1[4].val1, 0.4, 0.4, 0, 255, 255, 255, 255, 0)
            elseif Dat_2[4].val0 == 0 then
                DrawSprite("hackingNG", "DHCompHi", 0.50, Dat_1[4].val1, 0.4, 0.4, 0, 255, 255, 255, 255, 0)
            end
            if Dat_2[5].val0 == 1 then
                DrawSprite("hackingNG", "DHComp", 0.55, Dat_1[5].val1, 0.4, 0.4, 0, 255, 255, 255, 255, 0)
            elseif Dat_2[5].val0 == 0 then
                DrawSprite("hackingNG", "DHCompHi", 0.55, Dat_1[5].val1, 0.4, 0.4, 0, 255, 255, 255, 255, 0)
            end
            if Dat_2[6].val0 == 1 then
                DrawSprite("hackingNG", "DHComp", 0.60, Dat_1[6].val1, 0.4, 0.4, 0, 255, 255, 255, 255, 0)
            elseif Dat_2[6].val0 == 0 then
                DrawSprite("hackingNG", "DHCompHi", 0.60, Dat_1[6].val1, 0.4, 0.4, 0, 255, 255, 255, 255, 0)
            end
            if Dat_2[7].val0 == 1 then
                DrawSprite("hackingNG", "DHComp", 0.65, Dat_1[7].val1, 0.4, 0.4, 0, 255, 255, 255, 255, 0)
            elseif Dat_2[7].val0 == 0 then
                DrawSprite("hackingNG", "DHCompHi", 0.65, Dat_1[7].val1, 0.4, 0.4, 0, 255, 255, 255, 255, 0)
            end
            if stophack == true then
                return
            end
            if Dat_2[1].val4 == false and Dat_2[2].val4 == false and Dat_2[3].val4 == false and Dat_2[4].val4 == false and Dat_2[5].val4 == false and Dat_2[6].val4 == false and Dat_2[7].val4 == false then
                PlaySoundFrontend(-1, "HACKING_SUCCESS", "", true)
                Citizen.Wait(2500)
                stophack = true
                TriggerEvent("datacrack", true)
                return
            end
            Citizen.Wait(1)
        end
    end)
end

function Abort()
    stophack = true
    TriggerEvent("datacrack", false)
end

function Start(arg1)
	local loc1 = arg1
	
    -- if arg1 == nil then
    --     loc1 = 25
    -- elseif arg1 < 2 then
    --     loc1 = 50
    -- elseif arg1 > 5 then
    --     loc1 = 75
    -- else
    --     loc1 = arg1 * 10
	-- end
	
    Dat_1 = { [1] = { val1 = 0.4, }, [2] = { val1 = 0.4, }, [3] = { val1 = 0.4, }, [4] = { val1 = 0.4, }, [5] = { val1 = 0.4, }, [6] = { val1 = 0.4, }, [7] = { val1 = 0.4, }, }
    Dat_2 = { [1] = { val0 = 1, val1 = (0.02 * 0.55), val2 = 0, val3 = 1, val4 = true }, [2] = { val0 = 1, val1 = (0.025 * 0.55), val2 = 0, val3 = 1, val4 = true }, [3] = { val0 = 1, val1 = (0.03 * 0.55), val2 = 0, val3 = 1, val4 = true }, [4] = { val0 = 1, val1 = (0.035 * 0.55), val2 = 0, val3 = 1, val4 = true }, [5] = { val0 = 1, val1 = (0.04 * 0.55), val2 = 0, val3 = 1, val4 = true }, [6] = { val0 = 1, val1 = (0.045 * 0.55), val2 = 0, val3 = 1, val4 = true }, [7] = { val0 = 1, val1 = (0.05 * 0.55), val2 = 0, val3 = 1, val4 = true } }
    stophack = false
    F_02668(loc1)
end
