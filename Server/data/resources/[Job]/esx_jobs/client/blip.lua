Citizen.CreateThread(function()
    for i=1, #Config.minerb, 1 do
        local blip = AddBlipForCoord(Config.minerb[i].x, Config.minerb[i].y, Config.minerb[i].z)

        SetBlipSprite (blip, 318)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 1.0)
		SetBlipColour (blip, 0)
		SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Config.minerb[i].name)
        EndTextCommandSetBlipName(blip)
    end
end)

Citizen.CreateThread(function()
    for i=1, #Config.woodb, 1 do
        local blip = AddBlipForCoord(Config.woodb[i].x, Config.woodb[i].y, Config.woodb[i].z)

        SetBlipSprite (blip, 285)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, 1.0)
        SetBlipColour (blip, 0)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Config.woodb[i].name)
        EndTextCommandSetBlipName(blip)
    end
end)

Citizen.CreateThread(function()
    for i=1, #Config.woolb, 1 do
        local blip = AddBlipForCoord(Config.woolb[i].x, Config.woolb[i].y, Config.woolb[i].z)

        SetBlipSprite (blip, 366)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, 1.0)
        SetBlipColour (blip, 0)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Config.woolb[i].name)
        EndTextCommandSetBlipName(blip)
    end
end)