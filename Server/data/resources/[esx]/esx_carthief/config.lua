Config              = {}
Config.DrawDistance = 100.0
Config.CopsRequired = 3
Config.BlipUpdateTime = 5000 --In milliseconds. I used it on 3000. If you want instant update, 50 is more than enough. Even 100 is good. I hope it doesn't kill FPS and the server.
Config.CooldownMinutes = 60
Config.Locale = 'en'

Config.Zones = {
	VehicleSpawner = {
		Pos   = {x = 1208.52, y = -3120.56, z = 4.56},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Colour    = 6, --BLIP
		Id        = 229, --BLIP
	},
}

Config.VehicleSpawnPoint = {
      Pos   = {x = 1204.56, y = -3117.32, z = 5.56},
      Size  = {x = 3.0, y = 3.0, z = 1.0},
      Type  = -1,
}

Config.Delivery = {
	Delivery1 = {
		Pos      = {x = 2130.68, y = 4781.32, z = 39.87},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Payment  = math.random(40000,50000),
		Cars = {'felon2','dominator','buffalo','futo','kuruma','tailgater'},
	},
	Delivery2 = {
		Pos      = {x = -1892.56, y = 2046.91, z = 139.83},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Payment  = math.random(40000,50000),
		Cars = {'felon2','dominator','buffalo','futo','kuruma','tailgater'},
	},
	Delivery3 = {
		Pos      = {x = 373.18, y = 2987.28, z = 39.84},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Payment  = math.random(40000,50000),
		Cars = {'felon2','dominator','buffalo','futo','kuruma','tailgater'},
	},
	Delivery4 = {
		Pos      = {x = 3333.51, y = 5159.91, z = 17.20},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Payment  = math.random(40000,50000),
		Cars = {'felon2','dominator','buffalo','futo','kuruma','tailgater'},
	},
	Delivery5 = {
		Pos      = {x = 728.11, y = 4186.48, z = 39.71},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Payment  = math.random(40000,50000),
		Cars = {'felon2','dominator','buffalo','futo','kuruma','tailgater'},
	},
	Delivery6 = {
		Pos      = {x = 2704.59, y = 4136.74, z = 42.92},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Payment  = math.random(40000,50000),
		Cars = {'felon2','dominator','buffalo','futo','kuruma','tailgater'},
	},
	Delivery7 = {
		Pos   = {x = -1634.14, y = 3006.73, z = 30.83},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Payment  = math.random(40000,50000),
		Cars = {'felon2','dominator','buffalo','futo','kuruma','tailgater'},
	},
	Delivery8 = {
		Pos   = {x = 3804.25, y = 4443.33, z = 3.08},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Payment  = math.random(40000,50000),
		Cars = {'felon2','dominator','buffalo','futo','kuruma','tailgater'},
	},
	Delivery9 = {
		Pos   = {x = 2196.64, y = 5609.2, z = 52.56},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Payment  = math.random(40000,50000),
		Cars = {'felon2','dominator','buffalo','futo','kuruma','tailgater'},
	},
	Delivery10 = {
		Pos      = {x = -2177.51, y = 4269.51, z = 47.93},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Payment  = math.random(40000,50000),
		Cars = {'felon2','dominator','buffalo','futo','kuruma','tailgater'},
	},
	Delivery13 = {
		Pos      = {x = 895.02, y = 3603.87, z = 31.72},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1,
		Payment  = math.random(40000,50000),
		Cars = {'felon2','dominator','buffalo','futo','kuruma','tailgater'},
	},
}
