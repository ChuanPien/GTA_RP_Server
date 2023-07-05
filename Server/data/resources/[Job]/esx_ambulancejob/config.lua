Config                            = {}

Config.DrawDistance               = 100.0 -- How close do you need to be in order for the markers to be drawn (in GTA units).

Config.Marker                     = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}

Config.ReviveReward               = 0  -- Revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = true -- Enable anti-combat logging? (Removes Items when a player logs back after intentionally logging out while dead.)
Config.LoadIpl                    = false -- Disable if you're using fivem-ipl or other IPL loaders

Config.Locale                     = 'en'

Config.EarlyRespawnTimer          = 60000 * 10  -- time til respawn is available
Config.BleedoutTimer              = 60000 * 5 -- time til the player bleeds out

Config.EnablePlayerManagement     = true -- Enable society managing (If you are using esx_society).

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = true

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = true
Config.EarlyRespawnFineAmount     = 20000

Config.EnableJobBlip			  = true

Config.RespawnPoint = {coords = vector3(341.0, -1397.3, 32.5), heading = 48.5}

Config.ICU_Time = 300 --IN SECONDS

Config.ICU_Beds = { --IF the player is upside down change the h by 180 degrees, Maximum value is 360.
    {x = 1116.26, y = -1531.09, z = 34.43, h = 0.12, taken = false },
	{x = 1116.87, y = -1533.23, z = 34.43, h = 90.12, taken = false },
	{x = 1116.72, y = -1538.61, z = 34.43, h = 90.12, taken = false },
	{x = 1148.83, y = -1585.37, z = 34.92, h = 180.12, taken = false },
	{x = 1144.45, y = -1585.38, z = 34.92, h = 180.12, taken = false },
	{x = 1140.23, y = -1585.38, z = 34.92, h = 180.12, taken = false },
	{x = 1136.12, y = -1585.39, z = 34.92, h = 180.12, taken = false },
}

Config.Hospitals = {

	Pillbox = {

		Blip = {
			coords = vector3(292.3, -583.6, 43.2),
			sprite = 61,
			scale  = 0.8,
			color  = 1
		},
	
		AmbulanceActions = {
			vector3(301.64, -598.96, 42.28)
		},
	
		Pharmacies = {
			vector3(311.04, -596.68, 42.28)
		}
	}
}