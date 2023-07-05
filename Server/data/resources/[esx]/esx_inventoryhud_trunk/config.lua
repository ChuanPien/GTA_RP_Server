Config = {}

Config.CheckOwnership = false -- If true, Only owner of vehicle can store items in trunk.
Config.AllowPolice = true -- If true, police will be able to search players' trunks.

Config.Locale = "en"

Config.OpenKey = 183

-- Limit, unit can be whatever you want. Originally grams (as average people can hold 25kg)
Config.Weight = 50

-- Default weight for an item:
-- weight == 0 : The item do not affect character inventory weight
-- weight > 0 : The item cost place on inventory
-- weight < 0 : The item add place on inventory. Smart people will love it.
Config.DefaultWeight = 1

Config.localWeight = {
}

Config.VehicleWeight = {
    [0] = 10, --Compact 小型
    [1] = 20, --Sedan 轎車
    [2] = 25, --SUV 休旅
    [3] = 20, --Coupes 雙門
    [4] = 20, --Muscle 肌肉
    [5] = 20, --Sports Classics 經典轎跑
    [6] = 15, --Sports 轎跑
    [7] = 5, --Super 超跑
    [8] = 0, --Motorcycles 機車
    [9] = 20, --Off-road 越野
    [10] = 20, --Industrial 工業用
    [11] = 20, --Utility 工作車
    [12] = 100, --Vans 箱型
    [13] = 0, --Cycles 腳踏車
    [14] = 0, --Boats 船
    [15] = 0, --Helicopters 直升機
    [16] = 999999999999, --Planes 飛機
    [17] = 20, --Service 服務
    [18] = 20, --Emergency 緊急
    [19] = 20, --Military 軍用
    [20] = 500, --Commercial 商用
    [21] = 0 --Trains 火車
}

Config.VehiclePlate = {
    -- taxi = "TAXI",
    -- cop = "police",
    -- police = "police",
    -- ambulance = "ambulance",
    -- mecano = "mechano",
    -- mechanic = "mechanic",
    -- police = "police",
    -- nightclub = "club",
    -- bahamas = "bahamas",
    -- cardealer = "dealer"
}
