Config = {}
Config.Locale = 'en'
Config.IncludeCash = true -- DONT TOUCH!
Config.IncludeWeapons = true -- TRUE or FALSE
Config.IncludeAccounts = true -- TRUE or FALSE
Config.ExcludeAccountsList = {"bank", "money"} --  DONT TOUCH!
Config.OpenControl = 289 -- Key for opening inventory. Edit html/js/config.js to change key for closing it.
Config.CloseControl = 200

-- List of item names that will close ui when used
Config.CloseUiItems = {"phone", "weed_seed", "tunerchip", "fixkit", "medikit","radio","notepad"} -- Add your own items here!

Config.ShopBlipID = 52
Config.LiquorBlipID = 93
Config.YouToolBlipID = 402
Config.PrisonShopBlipID = 52
Config.WeedStoreBlipID = 140
Config.WeaponShopBlipID = 110

Config.ShopLength = 14
Config.LiquorLength = 10
Config.YouToolLength = 2
Config.PrisonShopLength = 2

Config.MarkerSize = {x = 1.5, y = 1.5, z = 0.5}
Config.MarkerColor = {r = 0, g = 128, b = 255}
Config.Color = 2
Config.WeaponColor = 1

Config.LicensePrice = 5000

Config.Shops = {
    RegularShop = {
        Locations = {
            {x = -1818.92, y = -1197.4, z = 13.48}
        },
        Items = {
            { name = 'bread'},
            { name = 'burger'},
            { name = 'friedchicken'},
            { name = 'water'},
            { name = 'icetea'},
            { name = 'tea'},
            { name = 'noodle1'},
            { name = 'noodle2'},
            { name = 'noodle3'},
            { name = 'noodle4'},
            { name = 'noodle5'},
            { name = 'phone'},
            { name = 'radio'},
            { name = 'tequila'},
            { name = 'jager'},
            { name = 'jagerbomb'},
            { name = 'jagercerbere'}
        }
    },

    RobsLiquor = {
	Locations = {
            {x = 18.33, y = -1110.13, z = 28.8},
            {x = 252.35, y = -49.73, z = 68.94},
            {x = -664.48, y = -939.28, z = 20.84},
            {x = 810.32, y = -2157.76, z = 28.6},
            {x = -1305.4, y = -394.2, z = 35.68},
            {x = 1693.16, y = 3759.76, z = 33.72},
            {x = -329.28, y = 6079.2, z = 30.44}
        },
        Items = {
            { name = 'pAmmo'}
        }
	},

    YouTool = {
        Locations = {
        },
        Items = {
        }
    },

    PrisonShop = {
        Locations = {
        },
        Items = {
        }
    },

    WeaponShop = {
        Locations = {
        },
        Weapons = {
        },
        Ammo = {
        },
        Items = {
        }
    },
    LicenseShop = {
        Locations = {
        }
    }
}
