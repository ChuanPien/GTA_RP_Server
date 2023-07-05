Garages = {
    vector3(216.16, -810.24, 29.72),
    vector3(1737.59, 3710.2, 33.14),
    vector3(-759.88, -1307.77, 4.15),
    vector3(-1586.66, 5157.37, 18.59),
    vector3(-680.64, 5775.32, 16.32),
    vector3(-430.52, 6036.36, 30.48),
    vector3(404.08, -1626.88, 28.28)
}

Citizen.CreateThread(function()
    local currentCGBlip = 0

    while true do
        local Gcoords = GetEntityCoords(PlayerPedId())
        local closest = 8000
        local closestCoords

        for _, Garages in pairs(Garages) do
            local dstcheck = GetDistanceBetweenCoords(Gcoords, Garages)

            if dstcheck < closest then
                closest = dstcheck
                closestCoords = Garages
            end
        end

        if DoesBlipExist(currentCGBlip) then
            RemoveBlip(currentCGBlip)
        end

        currentCGBlip = CreateBlipCG(closestCoords)

        Citizen.Wait(10000)
    end
end)

function CreateBlipCG(Gcoords)
	local blip = AddBlipForCoord(Gcoords)

	SetBlipSprite (blip, Config.GarageBlip.Sprite)
    SetBlipColour (blip, Config.GarageBlip.Color)
    SetBlipDisplay(blip, Config.GarageBlip.Display)
    SetBlipScale  (blip, Config.GarageBlip.Scale)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('公共停車場')
    EndTextCommandSetBlipName(blip)

	return blip
end

CarPounds = {
    vector3(408.61, -1625.47, 28.29),
    vector3(1651.38, 3804.84, 37.65),
    vector3(-234.82, 6198.65, 30.94)
}


Citizen.CreateThread(function()
    local currentPBlip = 0

    while true do
        local Pcoords = GetEntityCoords(PlayerPedId())
        local closest = 8000
        local closestCoords

        for _, CarPounds in pairs(CarPounds) do
            local dstcheck = GetDistanceBetweenCoords(Pcoords, CarPounds)

            if dstcheck < closest then
                closest = dstcheck
                closestCoords = CarPounds
            end
        end

        if DoesBlipExist(currentPBlip) then
            RemoveBlip(currentPBlip)
        end

        currentPBlip = CreateBlipCP(closestCoords)

        Citizen.Wait(10000)
    end
end)

function CreateBlipCP(Pcoords)
	local blip = AddBlipForCoord(Pcoords)

	SetBlipSprite (blip, Config.PoundBlip.Sprite)
    SetBlipColour (blip, Config.PoundBlip.Color)
    SetBlipDisplay(blip, Config.PoundBlip.Display)
    SetBlipScale  (blip, Config.PoundBlip.Scale)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('扣押場')
    EndTextCommandSetBlipName(blip)

	return blip
end