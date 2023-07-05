local pilot, aircraft, parachute, crate, pickup, blip, soundID
local requiredModels = {"p_cargo_chute_s", "ex_prop_adv_case_sm", "cargoplane", "s_m_m_pilot_02", "prop_box_wood02a_pu"}

-- RegisterCommand("cratedrop", function(playerServerID, args, rawString)
--     local playerCoords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 10.0, 0.0) -- ISN'T THIS A TABLE ALREADY?
--     TriggerEvent("crateDrop", args[1], tonumber(args[2]), args[3] or false, args[4] or 400.0, {["x"] = playerCoords.x, ["y"] = playerCoords.y, ["z"] = playerCoords.z})
-- end, false)

RegisterNetEvent("crateDrop")
AddEventHandler("crateDrop", function(weapon, ammo, roofCheck, planeSpawnDistance, dropCoords)
    Citizen.CreateThread(function()

        if IsWeaponValid(GetHashKey(weapon)) then
            weapon = "pickup_" .. weapon
        elseif IsWeaponValid(GetHashKey("weapon_" .. weapon)) then
            weapon = "pickup_weapon_" .. weapon
        elseif IsWeaponValid(GetHashKey(weapon:sub(8))) then
        else
            return
        end

        local ammo = 100

        if dropCoords.x and dropCoords.y and dropCoords.z and tonumber(dropCoords.x) and tonumber(dropCoords.y) and tonumber(dropCoords.z) then
        else
            dropCoords = {0.0, 0.0, 72.0}
        end

        if roofCheck and roofCheck ~= "false" then
            local ray = StartShapeTestRay(vector3(dropCoords.x, dropCoords.y, dropCoords.z) + vector3(0.0, 0.0, 500.0), vector3(dropCoords.x, dropCoords.y, dropCoords.z), -1, -1, 0)
            local _, hit, impactCoords = GetShapeTestResult(ray)

            if hit == 0 or (hit == 1 and #(vector3(dropCoords.x, dropCoords.y, dropCoords.z) - vector3(impactCoords)) < 10.0) then
                CrateDrop(weapon, ammo, planeSpawnDistance, dropCoords)
            else
                return
            end
        else
            CrateDrop(weapon, ammo, planeSpawnDistance, dropCoords)
        end

    end)
end)

function CrateDrop(weapon, ammo, planeSpawnDistance, dropCoords)
    Citizen.CreateThread(function()

        for i = 1, #requiredModels do
            RequestModel(GetHashKey(requiredModels[i]))
            while not HasModelLoaded(GetHashKey(requiredModels[i])) do
                Wait(0)
            end
        end

        RequestWeaponAsset(GetHashKey("weapon_flare"))
        while not HasWeaponAssetLoaded(GetHashKey("weapon_flare")) do
            Wait(0)
        end

        local rHeading = math.random(0, 360) + 0.0
        local planeSpawnDistance = (planeSpawnDistance and tonumber(planeSpawnDistance) + 0.0) or 400.0
        local theta = (rHeading / 180.0) * 3.14
        local rPlaneSpawn = vector3(dropCoords.x, dropCoords.y, dropCoords.z) - vector3(math.cos(theta) * planeSpawnDistance, math.sin(theta) * planeSpawnDistance, -500.0)

        local dx = dropCoords.x - rPlaneSpawn.x
        local dy = dropCoords.y - rPlaneSpawn.y
        local heading = GetHeadingFromVector_2d(dx, dy)

        aircraft = CreateVehicle(GetHashKey("cargoplane"), rPlaneSpawn, heading, true, true)
        SetEntityHeading(aircraft, heading)
        SetVehicleDoorsLocked(aircraft, 2)
        SetEntityDynamic(aircraft, true)
        ActivatePhysics(aircraft)
        SetVehicleForwardSpeed(aircraft, 60.0)
        SetHeliBladesFullSpeed(aircraft)
        SetVehicleEngineOn(aircraft, true, true, false)
        ControlLandingGear(aircraft, 3)
        OpenBombBayDoors(aircraft)
        SetEntityProofs(aircraft, true, false, true, false, false, false, false, false)

        pilot = CreatePedInsideVehicle(aircraft, 1, GetHashKey("s_m_m_pilot_02"), -1, true, true)
        SetBlockingOfNonTemporaryEvents(pilot, true)
        SetPedRandomComponentVariation(pilot, false)
        SetPedKeepTask(pilot, true)
        SetPlaneMinHeightAboveTerrain(aircraft, 50)

        TaskVehicleDriveToCoord(pilot, aircraft, vector3(dropCoords.x, dropCoords.y, dropCoords.z) + vector3(0.0, 0.0, 500.0), 60.0, 0, GetHashKey("cargoplane"), 262144, 15.0, -1.0)

        local droparea = vector2(dropCoords.x, dropCoords.y)
        local planeLocation = vector2(GetEntityCoords(aircraft).x, GetEntityCoords(aircraft).y)
        while not IsEntityDead(pilot) and #(planeLocation - droparea) > 5.0 do
            Wait(100)
            planeLocation = vector2(GetEntityCoords(aircraft).x, GetEntityCoords(aircraft).y)
        end

        if IsEntityDead(pilot) then
            do return end
        end

        TaskVehicleDriveToCoord(pilot, aircraft, 0.0, 0.0, 500.0, 60.0, 0, GetHashKey("cargoplane"), 262144, -1.0, -1.0)
        SetEntityAsNoLongerNeeded(pilot)
        SetEntityAsNoLongerNeeded(aircraft)

        local crateSpawn = vector3(479.64, -3370.08, GetEntityCoords(aircraft).z - 5.0)

        crate = CreateObject(GetHashKey("prop_box_wood02a_pu"), crateSpawn, true, true, true)
        SetEntityLodDist(crate, 1000)
        ActivatePhysics(crate)
        SetDamping(crate, 2, 0.1)
        SetEntityVelocity(crate, 0.0, 0.0, -0.2)

        parachute = CreateObject(GetHashKey("p_cargo_chute_s"), crateSpawn, true, true, true)
        SetEntityLodDist(parachute, 1000)
        SetEntityVelocity(parachute, 0.0, 0.0, -0.2)

        pickup = CreateAmbientPickup(GetHashKey(weapon), crateSpawn, 0, ammo, GetHashKey("ex_prop_adv_case_sm"), true, true)
        ActivatePhysics(pickup)
        SetDamping(pickup, 2, 0.0245)
        SetEntityVelocity(pickup, 0.0, 0.0, -0.2)

        soundID = GetSoundId()
        PlaySoundFromEntity(soundID, "Crate_Beeps", pickup, "MP_CRATE_DROP_SOUNDS", true, 0)

        -- blip = AddBlipForEntity(pickup)
        -- SetBlipSprite(blip, 408)
        -- SetBlipNameFromTextFile(blip, "AMD_BLIPN")
        -- SetBlipScale(blip, 0.7)
        -- SetBlipColour(blip, 2)
        -- SetBlipAlpha(blip, 120)

        AttachEntityToEntity(parachute, pickup, 0, 0.0, 0.0, 0.1, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
        AttachEntityToEntity(pickup, crate, 0, 0.0, 0.0, 0.3, 0.0, 0.0, 0.0, false, false, true, false, 2, true)

        while HasObjectBeenBroken(crate) == false do
            Wait(0)
        end

        local parachuteCoords = vector3(GetEntityCoords(parachute))
        ShootSingleBulletBetweenCoords(parachuteCoords, parachuteCoords - vector3(0.0001, 0.0001, 0.0001), 0, false, GetHashKey("weapon_flare"), 0, true, false, -1.0)
        DetachEntity(parachute, true, true)
        DeleteEntity(parachute)
        DetachEntity(pickup)
        -- SetBlipAlpha(blip, 255)
        while DoesEntityExist(pickup) do
            Wait(0)
        end

        while DoesObjectOfTypeExistAtCoords(parachuteCoords, 10.0, GetHashKey("w_am_flare"), true) do
            Wait(0)
            local prop = GetClosestObjectOfType(parachuteCoords, 10.0, GetHashKey("w_am_flare"), false, false, false)
            RemoveParticleFxFromEntity(prop)
            SetEntityAsMissionEntity(prop, true, true)
            DeleteObject(prop)
        end

        -- if DoesBlipExist(blip) then
        --     RemoveBlip(blip)
        -- end

        StopSound(soundID)
        ReleaseSoundId(soundID)
        for i = 1, #requiredModels do
            Wait(0)
            SetModelAsNoLongerNeeded(GetHashKey(requiredModels[i]))
        end

        RemoveWeaponAsset(GetHashKey("weapon_flare"))
        TriggerServerEvent('esx_customrob:giveitem')

    end)
end

-- AddEventHandler("onResourceStop", function(resource)
--     if resource == GetCurrentResourceName() then

--         SetEntityAsMissionEntity(pilot, false, true)
--         DeleteEntity(pilot)
--         SetEntityAsMissionEntity(aircraft, false, true)
--         DeleteEntity(aircraft)
--         DeleteEntity(parachute)
--         DeleteEntity(crate)
--         RemovePickup(pickup)
--         RemoveBlip(blip)
--         StopSound(soundID)
--         ReleaseSoundId(soundID)

--         for i = 1, #requiredModels do
--             Wait(0)
--             SetModelAsNoLongerNeeded(GetHashKey(requiredModels[i]))
--         end

--     end
-- end)