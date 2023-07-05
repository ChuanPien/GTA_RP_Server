Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = {x = 1.5, y = 1.5, z = 0.5}
Config.MarkerColor                = {r = 50, g = 50, b = 204}

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableLicenses             = true -- enable if you're using esx_license

Config.EnableHandcuffTimer        = true -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.EnableJobBlip              = true -- enable blips for cops on duty, requires esx_society
Config.EnableCustomPeds           = false -- enable custom peds in cloak room? See Config.CustomPeds below to customize peds

Config.EnableESXService           = false -- enable esx service?
Config.MaxInService               = 5

Config.Locale                     = 'en'

Config.PoliceStations = {

	LSPD = {

		Blip = {
			Coords  = vector3(425.1, -979.5, 30.7),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 26
		},

		Cloakrooms = {
			vector3(461.76, -999.16, 30.68)
		},

		Armories = {
			vector3(485.4, -995.56, 30.68)
		},

		BossActions = {
			vector3(462.92, -985.32, 30.72)
		}
	}
}

Config.AuthorizedWeapons = {
	recruit = {
		{weapon = 'WEAPON_NIGHTSTICK', price = 100},
		{weapon = 'WEAPON_FLASHLIGHT', price = 100},
		{weapon = 'WEAPON_STUNGUN', price = 100},
		{weapon = 'WEAPON_COMBATPISTOL', price = 5000},
		{weapon = 'WEAPON_PUMPSHOTGUN', price = 5000},
	},

	officer = {
		{weapon = 'WEAPON_NIGHTSTICK', price = 100},
		{weapon = 'WEAPON_FLASHLIGHT', price = 100},
		{weapon = 'WEAPON_STUNGUN', price = 100},
		{weapon = 'WEAPON_COMBATPISTOL', price = 5000},
		{weapon = 'WEAPON_PUMPSHOTGUN', price = 5000},
	},

	sergeant = {
		{weapon = 'WEAPON_NIGHTSTICK', price = 100},
		{weapon = 'WEAPON_FLASHLIGHT', price = 100},
		{weapon = 'WEAPON_STUNGUN', price = 100},
		{weapon = 'WEAPON_COMBATPISTOL', price = 5000},
		{weapon = 'WEAPON_PUMPSHOTGUN', price = 5000},
	},

	lieutenant = {
		{weapon = 'WEAPON_NIGHTSTICK', price = 100},
		{weapon = 'WEAPON_FLASHLIGHT', price = 100},
		{weapon = 'WEAPON_STUNGUN', price = 100},
		{weapon = 'WEAPON_COMBATPISTOL', price = 5000},
		{weapon = 'WEAPON_PUMPSHOTGUN', price = 5000},
	},

	boss = {
		{weapon = 'WEAPON_NIGHTSTICK', price = 100},
		{weapon = 'WEAPON_FLASHLIGHT', price = 100},
		{weapon = 'WEAPON_STUNGUN', price = 100},
		{weapon = 'WEAPON_COMBATPISTOL', price = 5000},
		{weapon = 'WEAPON_PUMPSHOTGUN', price = 5000},
	}
}

-- Config.AuthorizedVehicles = {
	-- car = {
		-- recruit = {
			-- {model = 'policeb', price = 1},
			-- {model = 'police', price = 1},
			-- {model = 'police2', price = 20000},
			-- {model = 'police3', price = 20000},	
			-- {model = 'sheriff', price = 20000}		
		-- },

		-- officer = {
			-- {model = 'policeb', price = 1},
			-- {model = 'police', price = 1},
			-- {model = 'police2', price = 20000},
			-- {model = 'police3', price = 20000},	
			-- {model = 'sheriff', price = 20000},
			-- {model = 'polgs350', price = 50000}
		-- },

		-- sergeant = {
			-- {model = 'policeb', price = 1},
			-- {model = 'police', price = 1},
			-- {model = 'police2', price = 20000},
			-- {model = 'police3', price = 20000},	
			-- {model = 'sheriff', price = 20000},
			-- {model = 'polgs350', price = 50000},
			-- {model = 'ghispo2', price = 100000}
		-- },

		-- lieutenant = {
			-- {model = 'policeb', price = 1},
			-- {model = 'police', price = 1},
			-- {model = 'police2', price = 20000},
			-- {model = 'police3', price = 20000},	
			-- {model = 'sheriff', price = 20000},
			-- {model = 'polgs350', price = 50000},
			-- {model = 'ghispo2', price = 100000}
		-- },

		-- boss = {
			-- {model = 'policeb', price = 1},
			-- {model = 'police', price = 1},
			-- {model = 'police2', price = 20000},
			-- {model = 'police3', price = 20000},	
			-- {model = 'sheriff', price = 20000},
			-- {model = 'polgs350', price = 50000},
			-- {model = 'ghispo2', price = 100000}
		-- }
	-- },

	-- helicopter = {
		-- recruit = {},

		-- officer = {},

		-- sergeant = {},

		-- lieutenant = {},

		-- boss = {
			-- {model = 'polmav', props = {modLivery = 0}, price = 100000}
		-- }
	-- }
-- }

Config.CustomPeds = {
	shared = {
		{label = 'Sheriff Ped', maleModel = 's_m_y_sheriff_01', femaleModel = 's_f_y_sheriff_01'},
		{label = 'Police Ped', maleModel = 's_m_y_cop_01', femaleModel = 's_f_y_cop_01'}
	},

	recruit = {},

	officer = {},

	sergeant = {},

	lieutenant = {},

	boss = {
		{label = 'SWAT Ped', maleModel = 's_m_y_swat_01', femaleModel = 's_m_y_swat_01'}
	}
}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements
Config.Uniforms = {
	recruit = {
		male = {
			tshirt_1 = 59,  tshirt_2 = 1,
			torso_1 = 55,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 41,
			pants_1 = 25,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = 46,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	officer = {
		male = {
			tshirt_1 = 58,  tshirt_2 = 0,
			torso_1 = 55,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 41,
			pants_1 = 25,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	sergeant = {
		male = {
			tshirt_1 = 58,  tshirt_2 = 0,
			torso_1 = 55,   torso_2 = 0,
			decals_1 = 8,   decals_2 = 1,
			arms = 41,
			pants_1 = 25,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 1,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	lieutenant = {
		male = {
			tshirt_1 = 58,  tshirt_2 = 0,
			torso_1 = 55,   torso_2 = 0,
			decals_1 = 8,   decals_2 = 2,
			arms = 41,
			pants_1 = 25,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 2,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	boss = {
		male = {
			tshirt_1 = 58,  tshirt_2 = 0,
			torso_1 = 55,   torso_2 = 0,
			decals_1 = 8,   decals_2 = 3,
			arms = 41,
			pants_1 = 25,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 3,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	bullet_wear = {
		male = {
			bproof_1 = 11,  bproof_2 = 1
		},
		female = {
			bproof_1 = 13,  bproof_2 = 1
		}
	},

	gilet_wear = {
		male = {
			tshirt_1 = 59,  tshirt_2 = 1
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1
		}
	}
}
