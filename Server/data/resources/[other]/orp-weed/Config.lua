Config = {}

Config.Plants = {}

Config.GrowthTimer = 2 -- In Minutes

Config.StartingThirst = 60.0
Config.StartingHunger = 60.0

Config.Degrade = {min = 6, max = 12} 
Config.QualityDegrade = {min = 25, max = 50}
Config.GrowthIncrease = {min = 50, max = 75}
 
Config.YieldRewards = {
    {type = "weed", rewardMin = 5, rewardMax = 9, item = 'weed', label = '大麻'}
}

Config.MaxPlantCount = 10

Config.BadSeedReward = "weed_seed" -- 125

Config.GoodSeedRewards = {
    [1] = "weed_bananakush_seed", -- 185
    [2] = "weed_bluedream_seed", -- 175
    [3] = "weed_purple-haze_seed", -- 190
}

Config.WeedStages = {
    [1] = "bkr_prop_weed_01_small_01c",
    [2] = "bkr_prop_weed_med_01a",
    [3] = "bkr_prop_weed_lrg_01a",
}
