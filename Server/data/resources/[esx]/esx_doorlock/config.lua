Config = {}
Config.Locale = 'en'

Config.DoorList = {
	-- 大門
	{
		textCoords = vector3(434.88, -981.92, 31.72),
		authorizedJobs = {'police','offpolice','admin'},
		locked = true,
		maxDistance = 4,
		doors = {
			{objHash = GetHashKey('gabz_mrpd_reception_entrancedoor'), objHeading = 90.0, objCoords  = vector3(434.72, -983.0, 30.72)},
			{objHash = GetHashKey('gabz_mrpd_reception_entrancedoor'), objHeading = 270.0, objCoords  = vector3(434.8, -980.76, 30.72)}
		}
	},
	-- 車庫側門
	{
		textCoords = vector3(441.96, -998.72, 31.72),
		authorizedJobs = {'police','offpolice','admin'},
		locked = true,
		maxDistance = 4,
		doors = {
			{objHash = GetHashKey('gabz_mrpd_reception_entrancedoor'), objHeading = 180.0, objCoords  = vector3(443.04, -998.72, 30.72)},
			{objHash = GetHashKey('gabz_mrpd_reception_entrancedoor'), objHeading = 0.0, objCoords  = vector3(440.76, -998.76, 30.72)}
		}
	},
	-- 側門
	{
		textCoords = vector3(457.12, -972.2, 31.72),
		authorizedJobs = {'police','offpolice','admin'},
		locked = true,
		maxDistance = 4,
		doors = {
			{objHash = GetHashKey('gabz_mrpd_reception_entrancedoor'), objHeading = 180.0, objCoords  = vector3(458.24, -972.76, 30.72)},
			{objHash = GetHashKey('gabz_mrpd_reception_entrancedoor'), objHeading = 0.0, objCoords  = vector3(455.88, -972.68, 30.72)}
		}
	},
	-- 後鐵門
	{
		objHash = GetHashKey('hei_prop_station_gate'),
		objHeading = 90.0,
		objCoords = vector3(488.8, -1017.2, 27.1),
		textCoords = vector3(488.8, -1020.2, 30.0),
		authorizedJobs = {'police','offpolice','admin'},
		locked = true,
		maxDistance = 10,
		size = 2
	},
	-- 後門
	{
		textCoords = vector3(468.6, -1014.32, 27.4),
		authorizedJobs = {'police','offpolice','admin'},
		locked = true,
		maxDistance = 4,
		doors = {
			{objHash = GetHashKey('gabz_mrpd_door_03'), objHeading = 0.0, objCoords  = vector3(467.8, -1014.5, 26.39)},
			{objHash = GetHashKey('gabz_mrpd_door_03'), objHeading = 180.0, objCoords  = vector3(470.0, -1014.32, 26.4)}
		}
	},
	-- 證物室
	{
		objHash = GetHashKey('gabz_mrpd_fencedoor'),
		objHeading = 0.0,
		objCoords = vector3(474.76, -992.04, 26.28),
		textCoords = vector3(474.76, -992.04, 27.28),
		authorizedJobs = {'police','offpolice','admin'},
		locked = true,
		maxDistance = 2,
		size = 1
	},
	-- 牢房N
	{
		objHash = GetHashKey('gabz_mrpd_cells_door'),
		objHeading = 180.0,
		objCoords = vector3(481.92, -1004.24, 26.32),
		textCoords = vector3(481.62, -1004.24, 27.32),
		authorizedJobs = {'police','offpolice','admin'},
		locked = true,
		maxDistance = 3,
		size = 1
	},
	-- 牢房S
	{
		objHash = GetHashKey('gabz_mrpd_cells_door'),
		objHeading = -90.0,
		objCoords = vector3(476.28, -1007.88, 26.28),
		textCoords = vector3(476.76, -1008.29, 27.28),
		authorizedJobs = {'police','offpolice','admin'},
		locked = true,
		maxDistance = 3,
		size = 1
	},
	-- 大牢房
	{
		objHash = GetHashKey('gabz_mrpd_cells_door'),
		objHeading = 180.0,
		objCoords = vector3(485.12, -1007.76, 26.32),
		textCoords = vector3(484.72, -1007.76, 27.32),
		authorizedJobs = {'police','offpolice','admin'},
		locked = true,
		maxDistance = 2,
		size = 1
	},
	-- 小牢房
	{
		objHash = GetHashKey('gabz_mrpd_cells_door'),
		objHeading = 0.0,
		objCoords = vector3(477.44, -1011.76, 26.28),
		textCoords = vector3(477.44, -1012.0, 27.28),
		authorizedJobs = {'police','offpolice','admin'},
		locked = true,
		maxDistance = 2,
		size = 1
	},
	{
		objHash = GetHashKey('gabz_mrpd_cells_door'),
		objHeading = 0.0,
		objCoords = vector3(480.32, -1011.76, 26.28),
		textCoords = vector3(480.32, -1012.0, 27.28),
		authorizedJobs = {'police','offpolice','admin'},
		locked = true,
		maxDistance = 2,
		size = 1
	},
	{
		objHash = GetHashKey('gabz_mrpd_cells_door'),
		objHeading = 0.0,
		objCoords = vector3(483.32, -1011.76, 26.28),
		textCoords = vector3(483.32, -1012.0, 27.28),
		authorizedJobs = {'police','offpolice','admin'},
		locked = true,
		maxDistance = 2,
		size = 1
	},
	{
		objHash = GetHashKey('gabz_mrpd_cells_door'),
		objHeading = 0.0,
		objCoords = vector3(486.0, -1012.16, 26.32),
		textCoords = vector3(486.45, -1012.0, 27.32),
		authorizedJobs = {'police','offpolice','admin'},
		locked = true,
		maxDistance = 2,
		size = 1
	},
	-- 審訊室
	{
		objHash = GetHashKey('gabz_mrpd_door_04'),
		objHeading = 270.0,
		objCoords = vector3(482.76, -988.16, 26.36),
		textCoords = vector3(482.76, -988.16, 27.36),
		authorizedJobs = {'police','offpolice','admin'},
		locked = true,
		maxDistance = 2,
		size = 1
	},
	{
		objHash = GetHashKey('gabz_mrpd_door_04'),
		objHeading = 270.0,
		objCoords = vector3(482.56, -996.4, 26.36),
		textCoords = vector3(482.56, -996.4, 27.36),
		authorizedJobs = {'police','offpolice','admin'},
		locked = true,
		maxDistance = 2,
		size = 1
	},
	-- 車庫左
	{
		objHash = GetHashKey('gabz_mrpd_room13_parkingdoor'),
		objHeading = 90.0,
		objCoords = vector3(464.08, -996.6, 26.36),
		textCoords = vector3(464.08, -996.86, 27.36),
		authorizedJobs = {'police','offpolice','admin'},
		locked = true,
		maxDistance = 5,
		size = 1
	},
	-- 車庫右
	{
		objHash = GetHashKey('gabz_mrpd_room13_parkingdoor'),
		objHeading = -90.0,
		objCoords = vector3(464.4, -975.34, 26.36),
		textCoords = vector3(464.4, -975.34, 27.36),
		authorizedJobs = {'police','offpolice','admin'},
		locked = true,
		maxDistance = 5,
		size = 1
	},
	-- 頂樓
	{
		objHash = GetHashKey('gabz_mrpd_door_03'),
		objHeading = 90.0,
		objCoords = vector3(464.08, -983.76, 43.76),
		textCoords = vector3(464.08, -983.76, 44.76),
		authorizedJobs = {'police','offpolice','admin'},
		locked = true,
		maxDistance = 5,
		size = 1
	},
	-- 局長室
	{
		objHash = GetHashKey('gabz_mrpd_door_05'),
		objHeading = -90.0,
		objCoords = vector3(458.4, -989.84, 30.8),
		textCoords = vector3(458.4, -989.84, 31.8),
		authorizedJobs = {'police','offpolice','admin'},
		locked = true,
		maxDistance = 3,
		size = 1
	},
	-- 更衣室
	{
		objHash = GetHashKey('gabz_mrpd_door_02'),
		objHeading = 225.0,
		objCoords = vector3(457.32, -996.04, 30.8),
		textCoords = vector3(457.65, -995.83, 31.8),
		authorizedJobs = {'police','offpolice','admin'},
		locked = true,
		maxDistance = 3,
		size = 1
	},
	-- 櫃台左
	{
		objHash = GetHashKey('gabz_mrpd_door_04'),
		objHeading = 0.0,
		objCoords = vector3(441.14, -977.44, 30.69),
		textCoords = vector3(441.14, -977.44, 31.69),
		authorizedJobs = {'police','offpolice','admin'},
		locked = true,
		maxDistance = 4,
		size = 1
	},
	-- 櫃台右
	{
		objHash = GetHashKey('gabz_mrpd_door_05'),
		objHeading = 180.0,
		objCoords = vector3(441.12, -986.28, 30.68),
		textCoords = vector3(441.12, -986.28, 31.68),
		authorizedJobs = {'police','offpolice','admin'},
		locked = true,
		maxDistance = 4,
		size = 1
	},
	-----------------------拖吊場------------------------
	{
		objHash = GetHashKey('prop_facgate_07b'),
		objHeading = 90.0,
		objCoords = vector3(-156.82, -1177.53, 23.56),
		textCoords = vector3(-156.82, -1180.83, 25.0),
		authorizedJobs = {'mechanic','admin'},
		locked = true,
		maxDistance = 20,
		size = 2
	}
}
	--餐廳
	-- {
    --     objHash = GetHashKey('sibaaa_pearls_kitchendoor'),
    --     objHeading = -30.0,
    --     objCoords = vector3(-1846.6, -1190.6, 14.2),
    --     textCoords = vector3(-1846.6, -1190.6, 14.8),
    --     authorizedJobs = {'cozinheiro','admin'},
    --     locked = true,
    --     maxDistance = 2,
    --     size = 1
    -- },
    -- {
    --     objHash = GetHashKey('sibaaa_pearls_frontdoor'),
    --     objHeading = 60.0,
    --     objCoords = vector3(-1839.46, -1181.83, 14.3),
    --     textCoords = vector3(-1839.46, -1181.83, 14.8),
    --     authorizedJobs = {'cozinheiro','admin'},
    --     locked = true,
    --     maxDistance = 2,
    --     size = 1
    -- },
    -- {
    --     objHash = GetHashKey('sibaaa_pearls_frontdoor'),
    --     objHeading = 60.0,
    --     objCoords = vector3(-1831.07, -1181.27, 14.3),
    --     textCoords = vector3(-1831.07, -1181.27, 14.8),
    --     authorizedJobs = {'cozinheiro','admin'},
    --     locked = true,
    --     maxDistance = 2,
    --     size = 1
    -- },
    -- {
    --     textCoords = vector3(-1842.68, -1198.88, 15.32),
    --     authorizedJobs = {'cozinheiro','admin'},
    --     locked = true,
    --     maxDistance = 4,
    --     doors = {
    --         {objHash = GetHashKey('sibaaa_pearls_maindoor'), objHeading = 150.0, objCoords  = vector3(-1842.44, -1199.4, 14.32)},
    --         {objHash = GetHashKey('sibaaa_pearls_maindoor'), objHeading = -30.0, objCoords  = vector3(-1842.68, -1198.88, 14.32)}
    --     }
    -- },
    -- {
    --     textCoords = vector3(-1816.92, -1194.56, 15.36),
    --     authorizedJobs = {'cozinheiro','admin'},
    --     locked = false,
    --     maxDistance = 4,
    --     doors = {
    --         {objHash = GetHashKey('sibaaa_pearls_maindoor'), objHeading = 60.0, objCoords  = vector3(-1817.36, -1194.28, 14.36)},
    --         {objHash = GetHashKey('sibaaa_pearls_maindoor'), objHeading = 240.0, objCoords  = vector3(-1816.92, -1194.56, 14.36)}
    --     }
    -- },
	--motel
