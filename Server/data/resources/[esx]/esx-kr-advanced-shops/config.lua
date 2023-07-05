Config                            = {}
Config.DrawDistance               = 20.0
Config.Locale = 'en'
Config.DeliveryTime = 0 -- IN SECOUNDS DEFAULT (18000) IS 5 HOURS / 300 MINUTES
Config.TimeBetweenRobberies = 0
Config.CutOnRobbery = 100 -- IN PERCENTAGE FROM THE TARGET SHOP
Config.RequiredPolices = 2 -- For the robbery
Config.SellValue = 2 -- This is the shops value divided by 2
Config.ChangeNamePrice = 100000 -- In $ - how much you can change the shops name for

-- CONFIG ITEMS, DON'T FORGET TO ADD CORRECT NUMBER IN THE BRACKETS
Config.Items = {
}

Config.Images = {
  [1] = {item = "礦泉水",   src = "img/bottle.png"},
  [2] = {item = "漢堡",   src = "img/burger.png"},
}

Config.Zones = {

  ShopCenter = {
    Pos   = {x = 6.09,   y = -708.89,  z = 44.97, number = 'center'},
  },
  Shop1 = {
    Pos   = {x = 373.875,   y = 325.896,  z = 102.566, number = 1},
  },
  Shop2 = {
    Pos = {x = 2557.458,  y = 382.282,  z = 107.622, number = 2},
  },
  Shop3 = {
    Pos = {x = -3038.939, y = 585.954,  z = 6.908, number = 3},
  },
  Shop4 = {
    Pos = {x = -1487.553, y = -379.107,  z = 39.163, number = 4},
  },
  Shop5 = {
    Pos = {x = 1392.562,  y = 3604.684,  z = 33.980, number = 5},
  },
  Shop6 = {
    Pos = {x = -2968.243, y = 390.910,   z = 14.043, number = 6},
  },
  Shop7 = {
    Pos = {x = 2678.916,  y = 3280.671, z = 54.241, number = 7},
  },
  Shop8 = {
    Pos = {x = -48.519,   y = -1757.514, z = 28.421, number = 8},
  },
  Shop9 = {
    Pos = {x = 1163.373,  y = -323.801,  z = 68.205, number = 9},
  },
  Shop10 = {
    Pos = {x = -707.501,  y = -914.260,  z = 18.215, number = 10},
  },
  Shop11 = {
    Pos = {x = -1820.523, y = 792.518,   z = 137.118, number = 11},
  },
  Shop12 = {
    Pos = {x = 1698.388,  y = 4924.404,  z = 41.063, number = 12},
  },
  Shop13 = {
    Pos = {x = 1961.464,  y = 3740.672, z = 31.343, number = 13},
  },
  Shop14 = {
    Pos = {x = 1135.808,  y = -982.281,  z = 45.415, number = 14},
  },
  Shop15 = {
    Pos = {x = 25.88,   y = -1347.1, z = 28.5, number = 15},
  },
  Shop16 = {
    Pos = {x = -1599.82, y = 5217.26,  z = 4.04, number = 16},
  },
  Shop17 = {
    Pos = {x = 547.431,   y = 2671.710, z = 41.156, number = 17},
  },
  Shop18 = {
    Pos = {x = -3241.927, y = 1001.462, z = 11.830, number = 18},
  },
  Shop19 = {
    Pos = {x = 1166.024,  y = 2708.930,  z = 37.157, number = 19},
  },
  Shop20 = {
    Pos = {x = 1729.216,  y = 6414.131, z = 34.037, number = 20},
  },
  Shop21 = {
    Pos = {x = -2540.79, y = 2313.5, z = 32.41, number = 21},
  },
  Shop22 = {
    Pos = {x = 123.05, y = -1035.75, z = 28.28, number = 22},
  }
}