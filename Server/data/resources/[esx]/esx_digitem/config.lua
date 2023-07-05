Config = {}

Config.Locale = "tw" --en, tw

-- The unit is milliseconds
Config.SpawnWaitMin = 10000
Config.SpawnWaitMax = 30000

Config.DigTime = 10000

Config.Digs = {
	{
		digItem = {{"fishbait", 1, "蚯蚓"}}, needTool = "shovel", toolLabel = "鏟子",
		x = 1918.52, y = 385.8, z = 161.56, areaRange = 9, maxSpawn = 10, markerColor = {255, 179, 102},
		breakToolPercent = 4, blips = true, blipName = "挖掘區-蚯蚓"
	},
	{
		digItem = {{"oyster", 2, "牡蠣"}}, needTool = "rake", toolLabel = "耙子",
		x = -2676.16, y = 2788.8, z = 0.56, areaRange = 9, maxSpawn = 10, markerColor = {255, 179, 102},
		breakToolPercent = 4, blips = true, blipName = "挖掘區-牡蠣"
	}
}