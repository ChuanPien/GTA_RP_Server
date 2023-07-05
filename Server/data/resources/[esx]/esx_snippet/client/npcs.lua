---------------------------------------------------------------------
                --[[SCRIPT MADE BY : ALEXMIHAI04]]--
               --[[DO NOT SELL OR COPY THIS SCRIPT]]--
                   --[[github.com/ItsAlexYTB]]--
        --[[ENJOY THE SCRIPT , DO NOT MAKE 1000 NPCS :))))) ]]
---------------------------------------------------------------------
ESX = nil
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

local coordonate = {
    {-10.04, 531.24, 169.6,"",297.72,0xC99F21C4,"a_m_y_business_01"},
    {2819.92, -741.32, 1.16,"保育類收購商",269.8,0x654ad86e,"a_f_m_downtown_01"},
    {-745.11,-1410.46,4.0,"魚攤老闆",-145.0,0x4f2e038a,"a_m_m_salton_01"},
    {1515.52, -2100.08, 75.8,"金屬收購商",276.12,0xC99F21C4,"a_m_y_business_01"},
    {835.08, 2171.2, 51.28,"木材收購商",65.8,0xB3B3F5E6,"a_m_y_business_02"},
    {1515.52, -2100.08, 7.8,"衣服收購商",276.12,0xC99F21C4,"a_m_y_business_01"},
    {308.36, -595.52, 42.28,"懶欣醫護員",69.24,0xD47303AC,"s_m_m_doctor_01"},
    {606.5,-3088.02, 5.07,"",271.71,0xa5720781,"a_m_y_gay_02"}, --師傅
    {2221.4, 5614.56, 53.92,"",109.8,0x20208E4D,"a_m_o_salton_01"}, --農夫
    {-1607.88, 5202.68, 3.32,"",114.28,0x6C9B2849,"a_m_m_hillbilly_01"}
}

Citizen.CreateThread(function()

    for _,v in pairs(coordonate) do
      RequestModel(GetHashKey(v[7]))
      while not HasModelLoaded(GetHashKey(v[7])) do
        Wait(1)
      end
  
      RequestAnimDict("mini@strip_club@idles@bouncer@base")
      while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
        Wait(1)
      end
      ped =  CreatePed(4, v[6],v[1],v[2],v[3], 3374176, false, true)
      SetEntityHeading(ped, v[5])
      FreezeEntityPosition(ped, true)
      SetEntityInvincible(ped, true)
      SetBlockingOfNonTemporaryEvents(ped, true)
      TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
    end
end)


Citizen.CreateThread(function()
    while true do
        local pos = GetEntityCoords(GetPlayerPed(-1), true)
        Citizen.Wait(0)
        for _,v in pairs(coordonate) do
            x = v[1]
            y = v[2]
            z = v[3]
            if(Vdist(pos.x, pos.y, pos.z, x, y, z) < 10.0)then
                DrawText3D(x,y,z+2.20, "~g~"..v[4], 0.9, 1)
                DrawText3D(x,y,z+1.95, "", 1.0, 1)
            end
        end
    end
end)


function DrawText3D(x,y,z, text, scl, font) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

--[[ENJOY]]--