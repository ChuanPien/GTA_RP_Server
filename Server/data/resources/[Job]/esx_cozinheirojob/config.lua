Config                            = {}
Config.DrawDistance               = 100.0

Config.EnablePlayerManagement     = false
Config.EnableSocietyOwnedVehicles = false
Config.EnableVaultManagement      = true
Config.EnableHelicopters          = false
Config.EnableMoneyWash            = false
Config.MaxInService               = -1
Config.Locale                     = 'en'

Config.MissCraft                  = 10 -- %


Config.AuthorizedVehicles = {
    { name = 'faggio',  label = 'Entregas' },
}

Config.Blips = {
    
    -- Blip = {
      -- Pos     = { x = 114.65, y = -1038.6, z = 29.29 },
      -- Sprite  = 52,
      -- Display = 4,
      -- Scale   = 1.2,
      -- Colour  = 5,
    -- },

}

Config.Zones = {

    Cloakrooms = {
        Pos   = {x = -1840.52, y = -1189.28, z = 13.33},
        Size  = { x = 1.5, y = 1.5, z = 1.0 },
        Color = { r = 255, g = 187, b = 255 },
        Type  = 27,
    },

    Vaults = {
        Pos   = {x = -1838.2, y = -1187.6, z = 13.33},
        Size  = { x = 1.3, y = 1.3, z = 1.0 },
        Color = { r = 30, g = 144, b = 255 },
        Type  = 23,
    },

    -- Fridge = {
    --     Pos   = { x = 148.6, y = -1054.86, z = 21.97 },
    --     Size  = { x = 1.6, y = 1.6, z = 1.0 },
    --     Color = { r = 255, g = 0, b = 0 },
    --     Type  = 27,
    -- },
	
	Cook = {
        Pos   = {x = -1842.28, y = -1185.52, z = 13.33},
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 0, g = 200, b = 220 },
        Type  = 27,
    },
	
	-- Vehicles = {
        -- Pos          = { x = 130.85, y = -1032.58, z = 29.43 },
        -- SpawnPoint   = { x = -582.436, y = -385.095, z = 34.626 },
        -- Size         = { x = 1.8, y = 1.8, z = 1.0 },
        -- Color        = { r = 255, g = 255, b = 0 },
        -- Type         = 27,
        -- Heading      = 207.43,
    -- },

    -- VehicleDeleters = {
        -- Pos   = { x = 128.56, y = -1038.78, z = 29.43 },
        -- Size  = { x = 3.0, y = 3.0, z = 0.2 },
        -- Color = { r = 255, g = 255, b = 0 },
        -- Type  = 27,
    -- },

--[[
    Helicopters = {
        Pos          = { x = 137.177, y = -1278.757, z = 28.371 },
        SpawnPoint   = { x = 138.436, y = -1263.095, z = 28.626 },
        Size         = { x = 1.8, y = 1.8, z = 1.0 },
        Color        = { r = 255, g = 255, b = 0 },
        Type         = 23,
        Heading      = 207.43,
    },

    HelicopterDeleters = {
        Pos   = { x = 133.203, y = -1265.573, z = 28.396 },
        Size  = { x = 3.0, y = 3.0, z = 0.2 },
        Color = { r = 255, g = 255, b = 0 },
        Type  = 1,
    },
]]--

    -- BossActions = {
    --     Pos   = { x = 94.951, y = -1294.021, z = - 21.99 },
    --     Size  = { x = 1.5, y = 1.5, z = 1.0 },
    --     Color = { r = 0, g = 100, b = 0 },
    --     Type  = 1,
    -- },

-----------------------
-------- SHOPS --------

    -- Flacons = {
        -- Pos   = { x = -2955.242, y = 385.897, z = 14.041 },
        -- Size  = { x = 1.6, y = 1.6, z = 1.0 },
        -- Color = { r = 238, g = 0, b = 0 },
        -- Type  = 23,
        -- Items = {
            -- { name = 'jager',      label = _U('jager'),   price = 3 },
            -- { name = 'vodka',      label = _U('vodka'),   price = 4 },
            -- { name = 'rhum',       label = _U('rhum'),    price = 2 },
            -- { name = 'whisky',     label = _U('whisky'),  price = 7 },
            -- { name = 'tequila',    label = _U('tequila'), price = 2 },
            -- { name = 'martini',    label = _U('martini'), price = 5 }
        -- },
    -- },

    -- NoAlcool = {
        -- Pos   = { x = 178.028, y = 307.467, z = 104.392 },
        -- Size  = { x = 1.6, y = 1.6, z = 1.0 },
        -- Color = { r = 238, g = 110, b = 0 },
        -- Type  = 23,
        -- Items = {
            -- { name = 'soda',        label = _U('soda'),     price = 4 },
            -- { name = 'jusfruit',    label = _U('jusfruit'), price = 3 },
            -- { name = 'icetea',      label = _U('icetea'),   price = 4 },
            -- { name = 'energy',      label = _U('energy'),   price = 7 },
            -- { name = 'drpepper',    label = _U('drpepper'), price = 2 },
            -- { name = 'limonade',    label = _U('limonade'), price = 1 }
        -- },
    -- },

    -- Apero = {
        -- Pos   = { x = 98.675, y = -1809.498, z = 26.095 },
        -- Size  = { x = 1.6, y = 1.6, z = 1.0 },
        -- Color = { r = 142, g = 125, b = 76 },
        -- Type  = 23,
        -- Items = {
            -- { name = 'bolcacahuetes',   label = _U('bolcacahuetes'),    price = 7 },
            -- { name = 'bolnoixcajou',    label = _U('bolnoixcajou'),     price = 10 },
            -- { name = 'bolpistache',     label = _U('bolpistache'),      price = 15 },
            -- { name = 'bolchips',        label = _U('bolchips'),         price = 5 },
            -- { name = 'saucisson',       label = _U('saucisson'),        price = 25 },
            -- { name = 'grapperaisin',    label = _U('grapperaisin'),     price = 15 }
        -- },
    -- },

    -- Ice = {
        -- Pos   = { x = 26.979, y = -1343.457, z = 28.517 },
        -- Size  = { x = 1.6, y = 1.6, z = 1.0 },
        -- Color = { r = 255, g = 255, b = 255 },
        -- Type  = 23,
        -- Items = {
            -- { name = 'ice',     label = _U('ice'),      price = 1 },
            -- { name = 'menthe',  label = _U('menthe'),   price = 2 }
        -- },
    -- },

}


-----------------------
----- TELEPORTERS -----

Config.TeleportZones = {
  EnterBuilding = {
    Pos       = { x = 132.608, y = -1293.978, z = 28. },
    Size      = { x = 1.2, y = 1.2, z = 0.1 },
    Color     = { r = 128, g = 128, b = 128 },
    Marker    = 1,
    Hint      = _U('e_to_enter_1'),
    Teleport  = { x = 126.742, y = -1278.386, z = 27.569 }
  },

  ExitBuilding = {
    Pos       = { x = 132.517, y = -1290.901, z = 27.269 },
    Size      = { x = 1.2, y = 1.2, z = 0.1 },
    Color     = { r = 128, g = 128, b = 128 },
    Marker    = 1,
    Hint      = _U('e_to_exit_1'),
    Teleport  = { x = 131.175, y = -1295.598, z = 27.569 },
  },

--[[
  EnterHeliport = {
    Pos       = { x = 126.843, y = -729.012, z = 241.201 },
    Size      = { x = 2.0, y = 2.0, z = 0.2 },
    Color     = { r = 204, g = 204, b = 0 },
    Marker    = 1,
    Hint      = _U('e_to_enter_2),
    Teleport  = { x = -65.944, y = -818.589, z =  320.801 }
  },

  ExitHeliport = {
    Pos       = { x = -67.236, y = -821.702, z = 320.401 },
    Size      = { x = 2.0, y = 2.0, z = 0.2 },
    Color     = { r = 204, g = 204, b = 0 },
    Marker    = 1,
    Hint      = _U('e_to_exit_2'),
    Teleport  = { x = 124.164, y = -728.231, z = 241.801 },
  },
]]--
}


-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
  barman_outfit = {
    male = {
        ['tshirt_1'] = 57,  ['tshirt_2'] = 0,
        ['torso_1'] = 83,   ['torso_2'] = 4,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 11,
        ['pants_1'] = 7,   ['pants_2'] = 2,
        ['shoes_1'] = 1,   ['shoes_2'] = 1,
        ['chain_1'] = 0,  ['chain_2'] = 0
    },
    female = {
        ['tshirt_1'] = 34,   ['tshirt_2'] = 0,
        ['torso_1'] = 76,    ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 2,
        ['pants_1'] = 3,   ['pants_2'] = 0,
        ['shoes_1'] = 1,    ['shoes_2'] = 1,
        ['chain_1'] = 0,    ['chain_2'] = 2
    }
  }
}
