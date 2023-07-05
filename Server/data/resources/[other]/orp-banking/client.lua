ESX = nil

local showBankBlips = false
local atBank = false
local bankMenu = true
local inMenu = false
local atATM = false
local bankColor = "green"

local bankLocations = {
    {i = 108, c = 0, x = 241.727, y = 220.706, z = 106.286, s = 0.8, n = "銀行"}, -- blip id, blip color, x, y, z, scale, name/label
	{i = 108, c = 0, x = 150.266, y = -1040.203, z = 29.374, s = 0.7, n = "銀行"},
	{i = 108, c = 0, x = -1212.980, y = -330.841, z = 37.787, s = 0.7, n = "銀行"},
	{i = 108, c = 0, x = -2962.582, y = 482.627, z = 15.703, s = 0.7, n = "銀行"},
	{i = 108, c = 0, x = -112.202, y = 6469.295, z = 31.626, s = 0.7, n = "銀行"},
	{i = 108, c = 0, x = 314.187, y = -278.621, z = 54.170, s = 0.7, n = "銀行"},
	{i = 108, c = 0, x = -351.534, y = -49.529, z = 49.042, s = 0.7, n = "銀行"},
	{i = 108, c = 0, x = 1175.0643310547, y = 2706.6435546875, z = 38.094036102295, s = 0.7, n = "銀行"},
}
	
local ATMLocations = {	
  {i = 108, c = 0, x=-386.733, y=6045.953, z=31.501},
  {i = 108, c = 0, x=-284.037, y=6224.385, z=31.187},
  {i = 108, c = 0, x=-284.037, y=6224.385, z=31.187},
  {i = 108, c = 0, x=-135.165, y=6365.738, z=31.101},
  {i = 108, c = 0, x=-110.753, y=6467.703, z=31.784},
  {i = 108, c = 0, x=-94.9690, y=6455.301, z=31.784},
  {i = 108, c = 0, x=155.4300, y=6641.991, z=31.784},
  {i = 108, c = 0, x=174.6720, y=6637.218, z=31.784},
  {i = 108, c = 0, x=1703.138, y=6426.783, z=32.730},
  {i = 108, c = 0, x=1735.114, y=6411.035, z=35.164},
  {i = 108, c = 0, x=1702.842, y=4933.593, z=42.051},
  {i = 108, c = 0, x=1967.333, y=3744.293, z=32.272},
  {i = 108, c = 0, x=1821.917, y=3683.483, z=34.244},
  {i = 108, c = 0, x=1174.532, y=2705.278, z=38.027},
  {i = 108, c = 0, x=540.0420, y=2671.007, z=42.177},
  {i = 108, c = 0, x=2564.399, y=2585.100, z=38.016},
  {i = 108, c = 0, x=2558.683, y=349.6010, z=108.050},
  {i = 108, c = 0, x=2558.051, y=389.4817, z=108.660},
  {i = 108, c = 0, x=1077.692, y=-775.796, z=58.218},
  {i = 108, c = 0, x=1139.018, y=-469.886, z=66.789},
  {i = 108, c = 0, x=1168.975, y=-457.241, z=66.641},
  {i = 108, c = 0, x=1153.884, y=-326.540, z=69.245},
  {i = 108, c = 0, x=381.2827, y=323.2518, z=103.270},
  {i = 108, c = 0, x=236.4638, y=217.4718, z=106.840},
  {i = 108, c = 0, x=265.0043, y=212.1717, z=106.780},
  {i = 108, c = 0, x=285.2029, y=143.5690, z=104.970},
  {i = 108, c = 0, x=157.7698, y=233.5450, z=106.450},
  {i = 108, c = 0, x=-164.568, y=233.5066, z=94.919},
  {i = 108, c = 0, x=-1827.04, y=785.5159, z=138.020},
  {i = 108, c = 0, x=-1409.39, y=-99.2603, z=52.473},
  {i = 108, c = 0, x=-1205.35, y=-325.579, z=37.870},
  {i = 108, c = 0, x=-1215.64, y=-332.231, z=37.881},
  {i = 108, c = 0, x=-2072.41, y=-316.959, z=13.345},
  {i = 108, c = 0, x=-2975.72, y=379.7737, z=14.992},
  {i = 108, c = 0, x=-2962.60, y=482.1914, z=15.762},
  {i = 108, c = 0, x=-2955.70, y=488.7218, z=15.486},
  {i = 108, c = 0, x=-3044.22, y=595.2429, z=7.595},
  {i = 108, c = 0, x=-3144.13, y=1127.415, z=20.868},
  {i = 108, c = 0, x=-3241.10, y=996.6881, z=12.500},
  {i = 108, c = 0, x=-3241.11, y=1009.152, z=12.877},
  {i = 108, c = 0, x=-1305.40, y=-706.240, z=25.352},
  {i = 108, c = 0, x=-538.225, y=-854.423, z=29.234},
  {i = 108, c = 0, x=-711.156, y=-818.958, z=23.768},
  {i = 108, c = 0, x=-717.614, y=-915.880, z=19.268},
  {i = 108, c = 0, x=-526.566, y=-1222.90, z=18.434},
  {i = 108, c = 0, x=-256.831, y=-719.646, z=33.444},
  {i = 108, c = 0, x=-203.548, y=-861.588, z=30.205},
  {i = 108, c = 0, x=112.4102, y=-776.162, z=31.427},
  {i = 108, c = 0, x=112.9290, y=-818.710, z=31.386},
  {i = 108, c = 0, x=149.4551, y=-1038.95, z=29.366},
  {i = 108, c = 0, x=-846.304, y=-340.402, z=38.687},
  {i = 108, c = 0, x=-1204.35, y=-324.391, z=37.877},
  {i = 108, c = 0, x=-1216.27, y=-331.461, z=37.773},
  {i = 108, c = 0, x=-56.1935, y=-1752.53, z=29.452},
  {i = 108, c = 0, x=-261.692, y=-2012.64, z=30.121},
  {i = 108, c = 0, x=-273.001, y=-2025.60, z=30.197},
  {i = 108, c = 0, x=314.187, y=-278.621, z=54.170},
  {i = 108, c = 0, x=-351.534, y=-49.529, z=49.042},
  {i = 108, c = 0, x=24.589, y=-946.056, z=29.357},
  {i = 108, c = 0, x=-254.112, y=-692.483, z=33.616},
  {i = 108, c = 0, x=-1570.197, y=-546.651, z=34.955},
  {i = 108, c = 0, x=-1415.909, y=-211.825, z=46.500},
  {i = 108, c = 0, x=-1430.112, y=-211.014, z=46.500},
  {i = 108, c = 0, x=33.232, y=-1347.849, z=29.497},
  {i = 108, c = 0, x=129.216, y=-1292.347, z=29.269},
  {i = 108, c = 0, x=287.645, y=-1282.646, z=29.659},
  {i = 108, c = 0, x=289.012, y=-1256.545, z=29.440},
  {i = 108, c = 0, x=295.839, y=-895.640, z=29.217},
  {i = 108, c = 0, x=1686.753, y=4815.809, z=42.008},
  {i = 108, c = 0, x=-302.408, y=-829.945, z=32.417},
  {i = 108, c = 0, x=5.134, y=-919.949, z=29.557},
  {i = 108, c = 0, x=-37.86, y=-1115.04, z=25.44},
  {i = 108, c = 0, x=146.84, y=-1035.01, z=28.34},
  {i = 108, c = 0, x=-821.39, y=-1082.58, z=10.13},
  {i = 108, c = 0, x=-1390.91, y=-590.36, z=29.32},
  {i = 108, c = 0, x=-31.41, y=-1659.75, z=29.32},
  {i = 108, c = 0, x=147.03, y=-1034.69, z=29.32},
  {i = 108, c = 0, x=119.45, y=-883.93, z=30.12},
  {i = 108, c = 0, x=110.98, y=-776.1, z=30.12},
  {i = 108, c = 0, x=199.26, y=-904.9, z=30.12},
  {i = 108, c = 0, x=-2547.96, y=2313.84, z=32.40},
  {i = 108, c = 0, x=2682.73, y=3286.63, z=54.24},
  {i = 108, c = 0, x=-29.33, y=-724.5, z=43.23},
  {i = 108, c = 0, x = -613.12, y = -704.52, z = 31.24},
  {i = 108, c = 0, x = -619.12, y = -707.84, z = 30.04},
  {i = 108, c = 0, x = 315.24, y = -593.72, z = 43.28},
  {i = 108, c = 0, x = 472.4, y = -1001.68, z = 30.68},
  {i = 108, c = 0, x = 468.44, y = -990.56, z = 26.28},
  {i = 108, c = 0, x = 349.95, y = -594.53, z = 27.8},
}

-- ATM Object Models
local ATMs = {
    {o = -870868698, c = 'blue'}, 
    {o = -1126237515, c = 'blue'}, 
    {o = -1364697528, c = 'red'}, 
    {o = 506770882, c = 'green'}
}

Citizen.CreateThread(function()
	while ESX == nil or ORP == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(2000)
	end
	Citizen.Wait(2000)
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
            if playerNearBank() or playerNearatm123() and not inMenu  then
                if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
                    DisplayHelpText("[~g~E~s~]插入提款卡")
                    if IsControlJustPressed(0, 38) then
                        openPlayersBank('bank')
                        local ped = GetPlayerPed(-1)
                    end
                else
                    exports['mythic_notify']:DoHudText('error', '請下車')
                    Citizen.Wait(10000)
                end
            end

        if IsControlJustPressed(0, 322) then
            inMenu = false
            SetNuiFocus(false, false)
            SendNUIMessage({type = 'close'})
        end
    end
end)

function openPlayersBank(type, color)
    local dict = 'anim@amb@prop_human_atm@interior@male@enter'
    local anim = 'enter'
    local ped = GetPlayerPed(-1)
    local time = 2500

    RequestAnimDict(dict)

    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(7)
    end

    TaskPlayAnim(ped, dict, anim, 8.0, 8.0, -1, 0, 0, 0, 0, 0)
   -- exports['progressBars']:startUI(time, "Inserting card...")
    Citizen.Wait(time)
    ClearPedTasks(ped)
    if type == 'bank' then
        inMenu = true
        SetNuiFocus(true, true)
        bankColor = "green"
        SendNUIMessage({type = 'openBank', color = bankColor})
        TriggerServerEvent('orp:bank:balance')
        atATM = false
    elseif type == 'atm' then
        inMenu = true
        SetNuiFocus(true, true)
        SendNUIMessage({type = 'openBank', color = bankColor})
        TriggerServerEvent('orp:bank:balance')
        atATM = true
    end
end

function playerNearatm123() -- Checks if a player is near a atm
    local pos = GetEntityCoords(GetPlayerPed(-1))

    for _, search in pairs(ATMLocations) do
        local dist = GetDistanceBetweenCoords(search.x, search.y, search.z, pos.x, pos.y, pos.z, true)

        if dist <= 1.5 then
            color = "green"
            return true
        end
    end
end

function playerNearBank() -- Checks if a player is near a bank
    local pos = GetEntityCoords(GetPlayerPed(-1))

    for _, search in pairs(bankLocations) do
        local dist = GetDistanceBetweenCoords(search.x, search.y, search.z, pos.x, pos.y, pos.z, true)

        if dist <= 2.0 then
            color = "green"
            return true
        end
    end
end

local blipsLoaded = false

RegisterNetEvent('orp:bank:info')
AddEventHandler('orp:bank:info', function(balance)
    local id = PlayerId()
    local playerName = GetPlayerName(id)

    SendNUIMessage({
		type = "updateBalance",
		balance = balance,
        player = playerName,
		})
end)

RegisterNUICallback('deposit', function(data)
    if not atATM then
        TriggerServerEvent('orp:bank:deposit', tonumber(data.amount))
        TriggerServerEvent('orp:bank:balance')
    else
       exports['mythic_notify']:DoHudText('error', 'You cannot deposit money at an ATM')
    end
end)

RegisterNUICallback('withdrawl', function(data)
    TriggerServerEvent('orp:bank:withdraw', tonumber(data.amountw))
    TriggerServerEvent('orp:bank:balance')
end)

RegisterNUICallback('balance', function()
    TriggerServerEvent('orp:bank:balance')
end)

RegisterNetEvent('orp:balance:back')
AddEventHandler('orp:balance:back', function(balance)
    SendNUIMessage({type = 'balanceReturn', bal = balance})
end)

function closePlayersBank()
    local dict = 'anim@amb@prop_human_atm@interior@male@exit'
    local anim = 'exit'
    local ped = GetPlayerPed(-1)
    local time = 1800

    RequestAnimDict(dict)

    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(7)
    end

    SetNuiFocus(false, false)
    SendNUIMessage({type = 'closeAll'})
    TaskPlayAnim(ped, dict, anim, 8.0, 8.0, -1, 0, 0, 0, 0, 0)
    --exports['progressBars']:startUI(time, "Retrieving card...")
    Citizen.Wait(time)
    ClearPedTasks(ped)
    inMenu = false
end

RegisterNUICallback('transfer', function(data)
    TriggerServerEvent('orp:bank:transfer', data.to, data.amountt)
    TriggerServerEvent('orp:bank:balance')
end)

RegisterNetEvent('orp:bank:notify')
AddEventHandler('orp:bank:notify', function(type, message)
    exports['mythic_notify']:DoHudText(type, message)
end)

AddEventHandler('onResourceStop', function(resource)
    inMenu = false
    SetNuiFocus(false, false)
    SendNUIMessage({type = 'closeAll'})
end)

RegisterNUICallback('NUIFocusOff', function()
    closePlayersBank()
end)

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end