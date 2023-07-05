Config = {}

Config.CheckOwnership = false -- If true, Only owner of vehicle can store items in glovebox.
Config.AllowPolice = true -- If true, police will be able to search players' glovebox.

Config.Locale = "en"

Config.OpenKey = 183 --G

-- Limit, unit can be whatever you want. Originally grams (as average people can hold 25kg)
Config.Weight = 10

-- Default weight for an item:
-- weight == 0 : The item do not affect character inventory weight
-- weight > 0 : The item cost place on inventory
-- weight < 0 : The item add place on inventory. Smart people will love it.
Config.DefaultWeight = 1

Config.localWeight = {
}

Config.VehicleWeight = {
    [0] = 10, --Compact 小型
    [1] = 10, --Sedan 轎車
    [2] = 10, --SUV 休旅
    [3] = 10, --Coupes 雙門
    [4] = 10, --Muscle 肌肉
    [5] = 10, --Sports Classics 經典轎跑
    [6] = 10, --Sports 轎跑
    [7] = 10, --Super 超跑
    [8] = 5, --Motorcycles 機車
    [9] = 10, --Off-road 越野
    [10] = 10, --Industrial 工業用
    [11] = 10, --Utility 工作車
    [12] = 10, --Vans 箱型
    [13] = 5, --Cycles 腳踏車
    [14] = 500, --Boats 船
    [15] = 100, --Helicopters 直升機
    [16] = 999999999999, --Planes 飛機
    [17] = 10, --Service 服務
    [18] = 10, --Emergency 緊急
    [19] = 10, --Military 軍用
    [20] = 10, --Commercial 商用
    [21] = 0 --Trains 火車
}

Config.VehiclePlate = {
}
