Config = {}
Config.Locale = 'en'

Config.RequiredCopsRob = 3
Config.RequiredCopsSell = 0
Config.MinJewels = 5 
Config.MaxJewels = 15
Config.MaxWindows = math.random(15,20)
Config.SecBetwNextRob = 5400
Config.MaxJewelsSell = 1
Config.PriceForOneJewel = math.random(2000,3000)
Config.EnableMarker = true
Config.NeedBag = true

Config.Borsoni = {40, 41, 44, 45}

Stores = {
	["jewelry"] = {
		position = { ['x'] = -630.12, ['y'] = -228.72, ['z'] = 38.04 },       
		nameofstore = "珠寶店",
		lastrobbed = 0
	}
}