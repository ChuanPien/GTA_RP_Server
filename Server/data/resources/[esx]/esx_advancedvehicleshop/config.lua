Config = {}
Config.Locale = 'en'

Config.MenuAlign = 'top-left'
Config.DrawDistance = 100

Config.UseAmbulanceShop = true -- true = Use Ambulance Shop | false = Does Opposite
Config.UseAmbulanceBlip = false -- true = Use Ambulance Blip | false = Does Opposite
Config.AmbulanceBlip = {Coords = vector3(300.14, -602.91, 42.38), Sprite = 326, Color = 1, Display = 4, Scale = 1.0}
Config.AmbulanceHeli = 'as365'
Config.AmbulanceHeli2 = 'as365'

Config.UsePoliceShop = true -- true = Use Police Shop | false = Does Opposite
Config.UsePoliceBlip = false -- true = Use Police Blip | false = Does Opposite
Config.PoliceBlip = {Coords = vector3(460.88, -997.92, 24.68), Sprite = 326, Color = 3, Display = 4, Scale = 1.0}
Config.PoliceHeli = 'eheli'

Config.UseAircraftShop = false -- true = Use Aircraft Shop | false = Does Opposite
Config.UseAircraftBlip = false -- true = Use Aircraft Blip | false = Does Opposite
Config.AircraftBlip = {Coords = vector3(-956.04, -2957.12, 48.72), Sprite = 90, Color = 4, Display = 4, Scale = 1.0}

Config.UseBoatShop = false -- true = Use Boat Shop | false = Does Opposite
Config.UseBoatBlip = false -- true = Use Boat Blip | false = Does Opposite
Config.BoatBlip = {Coords = vector3(-714.3, -1297.3, 4.1), Sprite = 410, Color = 3, Display = 4, Scale = 1.0}

Config.UseCarShop = true -- true = Use Car Shop | false = Does Opposite
Config.UseCarBlip = true -- true = Use Car Blip | false = Does Opposite
Config.CarBlip = {Coords = vector3(-33.7, -1102.0, 25.4), Sprite = 326, Color = 2, Display = 4, Scale = 1.0}

Config.UseTruckShop = false -- true = Use Truck Shop | false = Does Opposite
Config.UseTruckBlip = false -- true = Use Truck Blip | false = Does Opposite
Config.TruckBlip = {Coords = vector3(900.4, -1155.0, 24.1), Sprite = 67, Color = 2, Display = 4, Scale = 1.0}

-- You will need to setup your own callback for VIP Shop
Config.UseVIPShop = false -- true = Use VIP Shop | false = Does Opposite
Config.UseVIPBlip = false -- true = Use VIP Blip | false = Does Opposite
Config.VIPBlip = {Coords = vector3(1094.6, 215.21, -49), Sprite = 326, Color = 5, Display = 4, Scale = 1.0}

Config.ResellPercentage = 25 -- The Resell % of Vehicles Sold | Example: $10,000 / 50% = $5,000 Back
Config.LicenseEnable = true -- Requires licenses to buy Aircrafts, Boats, Cars, & Trucks.

-- looks like this: 'LLL NNN'
-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
Config.PlateLetters = 3
Config.PlateNumbers = 4
Config.PlateUseSpace = false

-- ShopEntering = Marker for Accessing Shop | ShopInside = Marker for Viewing Vehicles
-- ShopOutside = Marker for Purchasing Vehicles | ResellVehicle = Marker for Selling Vehicles

Config.Zones = {
	-- Ambulance Shop
	ShopEnteringAmbulance = {
		Pos    = vector3(340.68, -579.6, 27.8),
		Marker = {r = 255, g = 0, b = 0},
		Size   = {x = 1.5, y = 1.5, z = 1.0},
		Type   = 1,
		ShopId = 1
	},
	ShopInsideAmbulance = {
		Pos     = vector3(340.32, -570.64, 28.8),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = 159.76,
		Type    = -1,
		ShopId  = 1
	},
	ShopOutsideAmbulance = {
		Pos     = vector3(337.32, -579.32, 27.8),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = 159.76,
		Type    = -1,
		ShopId  = 1
	},
	ShopOutsideAmbulanceHeli = {
		Pos     = vector3(352.44, -588.19, 73.17),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = 311.87,
		Type    = -1,
		ShopId  = 1
	},
	ResellVehicleAmbulance = {
		Pos    = vector3(385.08, -1634.17, 28.29),
		Marker = {r = 255, g = 0, b = 0},
		Size   = {x = 3.0, y = 3.0, z = 1.0},
		Type   = 1,
		ShopId = 1
	},
	ResellVehicleAmbulanceHeli = {
		Pos    = vector3(366.78, -1589.45, 35.95),
		Marker = {r = 255, g = 0, b = 0},
		Size   = {x = 3.0, y = 3.0, z = 1.0},
		Type   = 1,
		ShopId = 1
	},
	-- Police Shop
	ShopEnteringPolice = {
		Pos    = vector3(460.88, -997.92, 24.68),
		Marker = {r = 0, g = 0, b = 255},
		Size   = {x = 1.5, y = 1.5, z = 1.0},
		Type   = 1,
		ShopId = 2
	},
	ShopInsidePolice = {
		Pos     = vector3(459.0, -995.0, 25.68),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = 94.12,
		Type    = -1,
		ShopId  = 2
	},
	ShopOutsidePolice = {
		Pos     = vector3(459.16, -990.16, 25.68),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = 91.68,
		Type    = -1,
		ShopId  = 2
	},
	ShopOutsidePoliceHeli = {
		Pos     = vector3(476.59, -1106.58, 42.08),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = 269.69,
		Type    = -1,
		ShopId  = 2
	},
	ResellVehiclePolice = {
		Pos    = vector3(387.82, -1636.33, 28.29),
		Marker = {r = 0, g = 0, b = 255},
		Size   = {x = 3.0, y = 3.0, z = 1.0},
		Type   = 1,
		ShopId = 2
	},
	ResellVehiclePoliceHeli = {
		Pos    = vector3(371.38, -1592.91, 35.95),
		Marker = {r = 0, g = 0, b = 255},
		Size   = {x = 3.0, y = 3.0, z = 1.0},
		Type   = 1,
		ShopId = 2
	},
	-- Aircraft Shop
	ShopEnteringAircraft = {
		Pos    = vector3(-940.0, -2963.1, 18.8),
		Marker = {r = 145, g = 0, b = 255},
		Size   = {x = 1.5, y = 1.5, z = 1.0},
		Type   = 1,
		ShopId = 3
	},
	ShopInsideAircraft = {
		Pos     = vector3(-965.72, -2993.64, 14.6),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = 54.72,
		Type    = -1,
		ShopId  = 3
	},
	ShopOutsideAircraft = {
		Pos     = vector3(-965.72, -2993.64, 14.6),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = 59.9,
		Type    = -1,
		ShopId  = 3
	},
	ResellVehicleAircraft = {
		Pos    = vector3(-1112.48, -2883.72, 12.96),
		Marker = {r = 255, g = 0, b = 0},
		Size   = {x = 10.0, y = 10.0, z = 1.0},
		Type   = 1,
		ShopId = 3
	},
	-- Boat Shop
	ShopEnteringBoat = {
		Pos    = vector3(-714.3, -1297.3, 4.1),
		Marker = {r = 0, g = 17, b = 255},
		Size   = {x = 1.5, y = 1.5, z = 1.0},
		Type   = 1,
		ShopId = 4
	},
	ShopInsideBoat = {
		Pos     = vector3(-716.1, -1350.7, -0.4),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = 138.4,
		Type    = -1,
		ShopId  = 4
	},
	ShopOutsideBoat = {
		Pos     = vector3(-717.7, -1339.2, -0.4),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = 90.0,
		Type    = -1,
		ShopId  = 4
	},
	ResellVehicleBoat = {
		Pos    = vector3(-725.3, -1327.8, -0.4),
		Marker = {r = 0, g = 17, b = 255},
		Size   = {x = 3.0, y = 3.0, z = 1.0},
		Type   = 1,
		ShopId = 4
	},
	-- Car Shop
	ShopEnteringCar = {
		Pos    = vector3(-33.7, -1102.0, 25.4),
		Marker = {r = 0, g = 255, b = 0},
		Size   = {x = 1.5, y = 1.5, z = 1.0},
		Type   = 1,
		ShopId = 5
	},
	ShopInsideCar = {
		Pos     = vector3(-47.5, -1097.2, 25.4),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = -20.0,
		Type    = -1,
		ShopId  = 5
	},
	ShopOutsideCar = {
		Pos     = vector3(-13.24, -1082.96, 26.2),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = 92.13,
		Type    = -1,
		ShopId  = 5
	},
	ResellVehicleCar = {
		Pos    = vector3(396, -1644.68, 28.29),
		Marker = {r = 255, g = 0, b = 0},
		Size   = {x = 3.0, y = 3.0, z = 1.0},
		Type   = 1,
		ShopId = 5
	},
	-- Truck Shop
	ShopEnteringTruck = {
		Pos    = vector3(900.4, -1155.0, 24.1),
		Marker = {r = 0, g = 255, b = 0},
		Size   = {x = 1.5, y = 1.5, z = 1.0},
		Type   = 1,
		ShopId = 6
	},
	ShopInsideTruck = {
		Pos     = vector3(927.5, -1226.8, 24.6),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = 102.93,
		Type    = -1,
		ShopId  = 6
	},
	ShopOutsideTruck = {
		Pos     = vector3(994.7, -1186.4, 24.5),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = 93.19,
		Type    = -1,
		ShopId  = 6
	},
	ResellVehicleTruck = {
		Pos    = vector3(879.2, -1168.5, 24.0),
		Marker = {r = 0, g = 255, b = 0},
		Size   = {x = 3.0, y = 3.0, z = 1.0},
		Type   = 1,
		ShopId = 6
	},
	--VIP Shop
	ShopEnteringVIP = {
		Pos    = vector3(1094.6, 215.21, -50),
		Marker = {r = 255, g = 222, b = 0},
		Size   = {x = 1.5, y = 1.5, z = 1.0},
		Type   = 1,
		ShopId = 7
	},
	ShopInsideVIP = {
		Pos     = vector3(1099.76, 220.17, -48.75),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = 138.9,
		Type    = -1,
		ShopId  = 7
	},
	ShopOutsideVIP = {
		Pos     = vector3(914.87, 52.77, 80.9),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = 45.03,
		Type    = -1,
		ShopId  = 7
	},
	ResellVehicleVIP= {
		Pos    = vector3(-21.1, -1678.0, 28.48),
		Marker = {r = 255, g = 222, b = 0},
		Size   = {x = 3.0, y = 3.0, z = 1.0},
		Type   = 1,
		ShopId = 7
	}
}
