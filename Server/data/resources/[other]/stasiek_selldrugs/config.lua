Config                            = {}
Config.Locale = 'en' -- your language, It would be nice if you send me your translation on fivem forum
Config.TimeToSell = 7 -- how many seconds player have to wait/stand near ped
Config.CallCops = true -- if true and if ped reject your offer then there is [Config.CallCopsPercent]% to call cops
Config.CopsRequiredToSell = 2 -- required cops on server to sell drugs
Config.CallCopsPercent = 1 -- (min1) if 1 cops will be called every time=100%, 2=50%, 3=33%, 4=25%, 5=20%
Config.PedRejectPercent = 3 -- (min1) if 1 ped reject offer=100%, 2=50%, 3=33%, 4=25%, 5=20%
Config.PlayAnimation = true -- just play animation when sold
Config.SellPooch = true -- if true, players can sell pooch like weed_pooch, meth_pooch
Config.SellSingle = false -- if true, players can sell single item like weed, meth
Config.SellWeed = true	-- if true, players can sell weed
Config.WeedPrice = math.random(7500,10000)	-- 大麻  sell price for single, not pooch (black money)
Config.DistanceFromCity = 500 -- set distance that player cant sell drugs too far from city
Config.CityPoint = {x= -11.99, y= -1620.64, z= 30.21}
