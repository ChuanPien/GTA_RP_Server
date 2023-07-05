Config = {}
Config.Locale = 'en'

Config.Marker = {
	r = 250, g = 0, b = 0, a = 100,  -- red color
	x = 1.0, y = 1.0, z = 1.5,       -- tiny, cylinder formed circle
	DrawDistance = 30.0, Type = 1    -- default circle type, low draw distance due to indoors area
}

Config.PoliceNumberRequired = 0
Config.TimerBeforeNewRob    = 43200 -- The cooldown timer on a store after robbery was completed / canceled, in seconds

Config.MaxDistance    = 5   -- max distance from the robbary, going any longer away from it will to cancel the robbary
Config.GiveBlackMoney = true -- give black money? If disabled it will give cash instead

Stores = {
	["south_merryweather"] = {
		position = {x = 502.92, y = -3337.04, z = 26.96},
		reward = math.random(0, 0),
		nameOfStore = "Merryweather",
		secondsRemaining = 1000, -- seconds
		lastRobbed = 0
	},
}
