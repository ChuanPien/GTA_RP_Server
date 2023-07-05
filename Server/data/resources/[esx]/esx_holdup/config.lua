Config = {}
Config.Locale = 'en'

Config.Marker = {
	r = 250, g = 0, b = 0, a = 100,  -- red color
	x = 1.0, y = 1.0, z = 1.5,       -- tiny, cylinder formed circle
	DrawDistance = 15.0, Type = 1    -- default circle type, low draw distance due to indoors area
}

Config.PoliceNumberRequired = 3
Config.TimerBeforeNewRob    = 5400 -- The cooldown timer on a store after robbery was completed / canceled, in seconds

Config.MaxDistance    = 40   -- max distance from the robbary, going any longer away from it will to cancel the robbary
Config.GiveBlackMoney = true -- give black money? If disabled it will give cash instead

Stores = {
	["paleto_twentyfourseven"] = {
		position = {x = 1706.88, y = 4919.8, z = 42.08},
		reward = math.random(100000,120000),
		nameOfStore = "2006超商",
		secondsRemaining = 300, -- seconds
		lastRobbed = 1800
	},
	["sandyshores_twentyfoursever"] = {
		position = { x = 1961.24, y = 3749.46, z = 32.34 },
		reward = math.random(100000,120000),
		nameOfStore = "3008超商",
		secondsRemaining = 300, -- seconds
		lastRobbed = 1800
	},
	["littleseoul_twentyfourseven"] = {
		position = {x = 1736.48, y = 6419.36, z = 35.04},
		reward = math.random(100000,120000),
		nameOfStore = "1000超商",
		secondsRemaining = 300, -- seconds
		lastRobbed = 1800
	},
	["bar_one"] = {
		position = {x = 545.04, y = 2663.6, z = 42.16},
		reward = math.random(100000,120000),
		nameOfStore = "4019超商",
		secondsRemaining = 300, -- seconds
		lastRobbed = 1800
	},
	["ocean_liquor"] = {
		position = { x = -2959.33, y = 388.21, z = 14.00 },
		reward = math.random(100000,120000),
		nameOfStore = "5065超商",
		secondsRemaining = 300, -- seconds
		lastRobbed = 1800
	},
	["rancho_liquor"] = {
		position = {x = 378.84, y = 332.28, z = 103.56},
		reward = math.random(100000,120000),
		nameOfStore = "7093超商",
		secondsRemaining = 300, -- seconds
		lastRobbed = 1800
	},
	["sanandreas_liquor"] = {
		position = {x = -1479.6, y = -374.04, z = 39.16},
		reward = math.random(100000,120000),
		nameOfStore = "7169超商",
		secondsRemaining = 300, -- seconds
		lastRobbed = 1800
	},
	["grove_ltd"] = {
		position = { x = -43.40, y = -1749.20, z = 29.42 },
		reward = math.random(100000,120000),
		nameOfStore = "9094超商",
		secondsRemaining = 300, -- seconds
		lastRobbed = 1800
	},
	["mirror_ltd"] = {
		position = { x = 1160.67, y = -314.40, z = 69.20 },
		reward = math.random(100000,120000),
		nameOfStore = "7302超商",
		secondsRemaining = 300, -- seconds
		lastRobbed = 1800
	},
	["9066"] = {
		position = {x = 29.32, y = -1340.12, z = 28.48},
		reward = math.random(100000,120000),
		nameOfStore = "9066超商",
		secondsRemaining = 300, -- seconds
		lastRobbed = 1800
	}
}
