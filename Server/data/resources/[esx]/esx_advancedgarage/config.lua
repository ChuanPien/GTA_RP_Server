Config = {}
Config.Locale = 'en'

Config.MenuAlign = 'top-left'
Config.DrawDistance = 100

Config.UseCommand = true
Config.ParkVehicles = false

Config.PointMarker = {Type = 1, r = 0, g = 255, b = 0, x = 1.5, y = 1.5, z = 1.0} -- Green Color / Standard Size Circle.
Config.DeleteMarker = {Type = 1, r = 255, g = 0, b = 0, x = 3.0, y = 3.0, z = 1.0} -- Red Color / Big Size Circle.
Config.PoundMarker = {Type = 1, r = 0, g = 0, b = 100, x = 1.5, y = 1.5, z = 1.0} -- Blue Color / Standard Size Circle.
Config.JPoundMarker = {Type = 1, r = 255, g = 0, b = 0, x = 1.5, y = 1.5, z = 1.0} -- Red Color / Standard Size Circle.

Config.GarageBlip = {Sprite = 290, Color = 26, Display = 2, Scale = 1.0} -- Public Garage Blip.
Config.PGarageBlip = {Sprite = 290, Color = 26, Display = 2, Scale = 1.0} -- Private Garage Blip.
Config.PoundBlip = {Sprite = 67, Color = 53, Display = 2, Scale = 1.0} -- Pound Blip.
Config.JGarageBlip = {Sprite = 290, Color = 35, Display = 2, Scale = 1.0} -- Job Garage Blip.
Config.JPoundBlip = {Sprite = 67, Color = 36, Display = 2, Scale = 1.0} -- Job Pound Blip.

Config.PoundWait = 0 -- How many Minutes someone must wait before Opening Pound Menu Again.
Config.JPoundWait = 0 -- How many Minutes someone must wait before Opening Job Pound Menu Again.

Config.UseDamageMult = true -- true = Costs more to Store a Broken/Damaged Vehicle.
Config.DamageMult = 2 -- Higher Number = Higher Repair Price.

Config.UsingAdvancedVehicleShop = true -- Set to true if using esx_advancedvehicleshop

Config.UseAmbulanceGarages = true -- true = Allows use of Ambulance Garages.
Config.UseAmbulancePounds = true -- true = Allows use of Ambulance Pounds.
Config.UseAmbulanceBlips = false -- true = Use Ambulance Blips.
Config.AmbulancePoundPrice = 0 -- How much it Costs to get Vehicle from Ambulance Pound.

Config.UsePoliceGarages = true -- true = Allows use of Police Garages.
Config.UsePolicePounds = true -- true = Allows use of Police Pounds.
Config.UsePoliceBlips = false -- true = Use Police Blips.
Config.PolicePoundPrice = 0 -- How much it Costs to get Vehicle from Police Pound.

Config.UseAircraftGarages = false -- true = Allows use of Aircraft Garages.
Config.UseAircraftBlips = false -- true = Use Aircraft Blips.
Config.AircraftPoundPrice = 10000 -- How much it Costs to get Vehicle from Aircraft Pound.

Config.UseBoatGarages = false -- true = Allows use of Boat Garages.
Config.UseBoatBlips = false -- true = Use Boat Blips.
Config.BoatPoundPrice = 5000 -- How much it Costs to get Vehicle from Boat Pound.

Config.UseCarGarages = true -- true = Allows use of Car Garages.
Config.UseCarBlips = false -- true = Use Car Blips.
Config.CarPoundPrice = 5000 -- How much it Costs to get Vehicle from Car Pound.

Config.AmbulanceGarages = {
	Los_Santos = {
		Marker = vector3(339.88, -581.96, 27.8),
		Spawner = vector3(331.36, -580.28, 28.8),
		Spawner2 = vector3(351.55, -588.07, 73.17),
		Deleter = vector3(337.32, -579.32, 27.8),
		Deleter2 = vector3(351.55, -588.07, 73.17),
		Heading = 336.72,
		Heading2 = 337.63,
		garage = "A"
	},
	SA = {
		Marker = vector3(1856.32, 3705.44, 33.28),
		Spawner = vector3(1861.08, 3706.64, 33.36),
		Spawner2 = vector3(1831.68, 3690.84, 39.72),
		Deleter = vector3(1860.72, 3707.24, 31.96),
		Deleter2 = vector3(1821.72, 3675.84, 39.92),
		Heading = 28.84,
		Heading2 = 210,
		garage = "A"
	},
	Los_Santostop = {
		Marker = vector3(-458.96, 6034.96, 30.36),
		Spawner = vector3(-465.28, 6034.28, 31.0),
		Spawner2 = vector3(-473.0, 6024.48, 31.36),
		Deleter = vector3(-455.16, 6040.96, 30.0),
		Deleter2 = vector3(-475.28, 5988.64, 30.32),
		Heading = 221.24,
		Heading2 = 315.4,
		garage = "A"
	}
}

Config.AmbulancePounds = {
	Los_Santos = {
		Marker = vector3(374.42, -1620.68, 28.29),
		Spawner = vector3(391.74, -1619.0, 28.29),
		Heading = 318.34
	},
	SA = {
		Marker = vector3(1863.77, 3692.23, 33.27),
		Spawner = vector3(1870.79, 3692.58, 32.61),
		Heading = 209.16
	},
	North = {
		Marker = vector3(-445.35, 6023.89, 30.49),
		Spawner = vector3(-431.71, 6031.46, 30.34),
		Heading = 31.89
	}
}
-- End of Ambulance

-- Start of Police
Config.PoliceGarages = {
	Los_Santos = {
		Marker = vector3(457.88, -975.12, 24.68),
		Spawner = vector3(431.16, -976.96, 25.68),
		Spawner2 = vector3(449.24, -983.12, 43.68),
		Deleter = vector3(451.76, -975.8, 24.68),
		Deleter2 = vector3(481.53, -982.77, 39.4),
		Heading = 179.68,
		Heading2 = 179.12,
		garage = "A"
	},
	SA = {
		Marker = vector3(1856.32, 3705.44, 33.28),
		Spawner = vector3(1861.08, 3706.64, 33.36),
		Spawner2 = vector3(1831.68, 3690.84, 39.72),
		Deleter = vector3(1860.72, 3707.24, 31.96),
		Deleter2 = vector3(1821.72, 3675.84, 39.92),
		Heading = 28.84,
		Heading2 = 210,
		garage = "A"
	},
	Los_Santostop = {
		Marker = vector3(-458.96, 6034.96, 30.36),
		Spawner = vector3(-465.28, 6034.28, 31.0),
		Spawner2 = vector3(-473.0, 6024.48, 31.36),
		Deleter = vector3(-455.16, 6040.96, 30.0),
		Deleter2 = vector3(-475.28, 5988.64, 30.32),
		Heading = 221.24,
		Heading2 = 315.4,
		garage = "A"
	}
}

Config.PolicePounds = {
	Los_Santos = {
		Marker = vector3(374.42, -1620.68, 28.29),
		Spawner = vector3(391.74, -1619.0, 28.29),
		Heading = 318.34
	},
	SA = {
		Marker = vector3(1863.77, 3692.23, 33.27),
		Spawner = vector3(1870.79, 3692.58, 32.61),
		Heading = 209.16
	},
	North = {
		Marker = vector3(-445.35, 6023.89, 30.49),
		Spawner = vector3(-431.71, 6031.46, 30.34),
		Heading = 31.89
	}
}
-- End of Police

-- Start of Aircrafts
Config.AircraftGarages = {
	Los_Santos_Airport = {
		Marker = vector3(-1617.64, -3140.96, 13.0),
		Spawner = vector3(-1622.28, -3096.92, 13.96),
		Deleter = vector3(-1544.08, -3145.36, 12.96),
		Heading = 326.28
	},
	Sandy_Shores_Airport = {
		Marker = vector3(1723.84, 3288.29, 40.16),
		Spawner = vector3(1710.85, 3259.06, 40.69),
		Deleter = vector3(1739.52, 3285.48, 40.12),
		Heading = 104.66
	},
	topleft_Airport = {
		Marker = vector3(-460.84, 6015.72, 30.48),
		Spawner = vector3(-475.12, 5988.64, 30.32),
		Deleter = vector3(-475.12, 5988.64, 30.32),
		Heading = 319.16
	}
}

Config.AircraftPounds = {
	Los_Santos_Airport = {
		Marker = vector3(-1243.0, -3391.92, 12.94),
		Spawner = vector3(-1247.64, -3337.6, 14.6),
		Heading = 330.25
	}
}
-- End of Aircrafts

-- Start of Boats
Config.BoatGarages = {
	Los_Santos_Dock = {
		Marker = vector3(-735.87, -1325.08, 0.6),
		Spawner = vector3(-742.28, -1348.76, -0.47),
		Deleter = vector3(-731.15, -1334.71, -0.47),
		Heading = 230.52
	},
	fishing = {
		Marker = vector3(-1598.85, 5257.01, 1.0),
		Spawner = vector3(-1583.42, 5256.0, -0.47),
		Deleter = vector3(-1601.2, 5263.36, -0.47),
		Heading = 294.63
	}
}

Config.BoatPounds = {
	Los_Santos_Dock = {
		Marker = vector3(-738.67, -1400.43, 4.0),
		Spawner = vector3(-748.78, -1354.98, 0.12),
		Heading = 228.79
	}
}	
-- End of Boats

-- Start of Cars
Config.CarGarages = {
	mainparking = {
		Marker = vector3(216.16, -810.24, 29.72),
		Spawner = vector3(229.68, -800.52, 30.56),
		Deleter = vector3(207.23, -797.21, 29.99),
		Heading = 163.0,
		garage = "A"
	},
	Sandy_Shores = {
		Marker = vector3(1737.59, 3710.2, 33.14),
		Spawner = vector3(1737.84, 3719.28, 33.04),
		Deleter = vector3(1722.66, 3713.74, 33.21),
		Heading = 21.22,
		garage = "B"
	},
	-- airport = {
	-- 	Marker = vector3(-1619.04, -3143.92, 13.0),
	-- 	Spawner = vector3(-1604.48, -3134.44, 13.96),
	-- 	Deleter = vector3(-1625.4, -3152.04, 13.0),
	-- 	Heading = 328.28
	-- },
	Fishing = {
		Marker = vector3(-759.88, -1307.77, 4.15),
		Spawner = vector3(-747.52, -1316.05, 4.15),
		Deleter = vector3(-754.19, -1323.97, 4.0),
		Heading = 51.16,
		garage = "C"
	},
	Fishingtop = {
		Marker = vector3(-1586.66, 5157.37, 18.59),
		Spawner = vector3(-1582.05, 5154.06, 18.59),
		Deleter = vector3(-1583.75, 5162.0, 18.59),
		Heading = 216.03,
		garage = "D"
	},
	henhunting = {
		Marker = vector3(-680.64, 5775.32, 16.32),
		Spawner = vector3(-685.96, 5783.28, 16.92),
		Deleter = vector3(-676.24, 5775.96, 16.32),
		Heading = 151.2,
		garage = "E"
	},
	topleft = {
		Marker = vector3(-430.52, 6036.36, 30.48),
		Spawner = vector3(-442.08, 6037.56, 31.36),
		Deleter = vector3(-435.28, 6031.8, 30.36),
		Heading = 298.52,
		garage = "F"
	},
	-- pounds = {
	-- 	Marker = vector3(404.08, -1626.88, 28.28),
	-- 	Spawner = vector3(408.76, -1647.12, 29.28),
	-- 	Deleter = vector3(402.36, -1629.76, 28.28),
	-- 	Heading = 229.12,
	-- 	garage = "G"
	-- },
	motell = {
		Marker 	= vector3(-1478.04, -673.4, 28.04),
		Spawner = vector3(-1480.6, -668.08, 28.96),
		Deleter = vector3(-1486.44, -663.64, 27.96),
		Heading = 122.36,
		garage = "H"
	},
	motelc = {
		Marker 	= vector3(315.6, -218.96, 53.2),
		Spawner = vector3(320.84, -214.24, 54.08),
		Deleter = vector3(327.68, -204.64, 53.08),
		Heading = 160.68,
		garage = "I"
	}
}

Config.CarPounds = {
	Los_Santos = {
		Marker = vector3(408.61, -1625.47, 28.29),
		Spawner = vector3(405.64, -1643.4, 27.61),
		Heading = 229.54
	},
	Sandy_Shores = {
		Marker = vector3(1651.38, 3804.84, 37.65),
		Spawner = vector3(1627.84, 3788.45, 33.77),
		Heading = 308.53
	},
	Paleto_Bay = {
		Marker = vector3(-234.82, 6198.65, 30.94),
		Spawner = vector3(-230.08, 6190.24, 30.49),
		Heading = 140.24
	}
}
