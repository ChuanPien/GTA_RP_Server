-- carblacklist = {
-- 	"rhino",
-- 	"buzzard",
-- 	"buzzard2",
-- 	"cargobob",
-- 	"cargobob2",
-- 	"cargobob3",
-- 	"cargobob4",
-- 	"annihilator",
-- 	"besra",
-- 	"policeb",
-- 	"firetruk",
-- 	"ambulance"
-- }

-- -- CODE --
-- whitelisted = nil
-- AddEventHandler('playerSpawned', function(spawn)
--     TriggerServerEvent('white')
-- end)

-- RegisterNetEvent('checkwhitelist')
-- AddEventHandler('checkwhitelist', function(whitelist)
-- 	whitelisted = whitelist
-- end)

-- Citizen.CreateThread(function()
-- 	while true do
-- 		Wait(1)
-- 		if IsPedInAnyVehicle(GetPlayerPed(-1)) then
-- 		v = GetVehiclePedIsIn(playerPed, false)
-- 		end
-- 		playerPed = GetPlayerPed(-1)
-- 		if whitelisted == nil and playerPed and v then
-- 		if GetPedInVehicleSeat(v, -1) == playerPed then
-- 			checkCar(GetVehiclePedIsIn(playerPed, false))

-- 			end
-- 		end
-- 	end
-- end)
-- function checkCar(car)
-- 	if car then
-- 		carModel = GetEntityModel(car)
-- 		carName = GetDisplayNameFromVehicleModel(carModel)

-- 		if isCarBlacklisted(carModel) then
-- 			_DeleteEntity(car)
-- 		end
-- 	end
-- end

-- function isCarBlacklisted(model)
-- 	for _, blacklistedCar in pairs(carblacklist) do
-- 		if model == GetHashKey(blacklistedCar) then
-- 			return true
-- 		end
-- 	end

-- 	return false
-- end

-- function _DeleteEntity(entity)
-- 	Citizen.InvokeNative(0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized(entity))
-- end