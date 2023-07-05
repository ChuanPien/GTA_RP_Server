Config               = {}

Config.DrawDistance  = 10
Config.Size          = { x = 1.5, y = 1.5, z = 0.5 }
Config.Color         = { r = 50, g = 255, b = 50 }
Config.Type          = 27

Config.Locale        = 'en'

Config.Blur			 = true

Config.Loading		 = true

Config.LicenseEnable = false -- only turn this on if you are using esx_license
Config.LicensePrice  = 5000

Config.Zones = {

	GunShop = {
		Legal = true,
		Items = {},
		Locations = {
            vector3(22.09, -1106.91, 28.8),
            vector3(249.26, -46.33, 68.94),
            vector3(-662.32, -934.96, 20.84),
			vector3(812.56, -2153.28, 28.6),
            vector3(-1309.12, -390.88, 35.68),
            vector3(1694.76, 3755.32, 33.72),
            vector3(-330.76, 6084.0, 30.44)
		}
	},

	BlackWeashop = {
		Legal = false,
		Items = {},
		Locations = {
			vector3(728.92, 4188.70, -39.75)
		}
	}
}


Config.shop = {
	vector3(18.33, -1110.13, 28.8),
	vector3(249.26, -46.33, 68.94),
	vector3(-662.32, -934.96, 20.84),
	vector3(812.56, -2153.28, 28.6),
	vector3(-1309.12, -390.88, 35.68),
	vector3(1694.76, 3755.32, 33.72),
	vector3(-330.76, 6084.0, 30.44)
}