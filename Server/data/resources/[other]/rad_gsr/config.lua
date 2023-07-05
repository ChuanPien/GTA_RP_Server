Config                          = {}
Config.Locale                   = 'en'

Config.gsrUpdate                = 1 * 1000          -- Change first number only, how often a new shot is logged dont set this to low keep it above 1 min - raise if you experience performance issues (default: 1 min).
Config.waterClean               = true              -- Set to false if you dont want water to clean off GSR from people who shot
Config.waterCleanTime           = 30 * 1000         -- Change first number only, Set time in water needed to clean off GSR (default: 30 sec).
Config.gsrTime                  = 30 * 60           -- Change The first number only, if you want the GSR to be auto removed faster output is minutes (default: 30 min).
Config.gsrAutoRemove            = 10 * 60 * 1000    -- Change first number only, to set the auto clean up in minuets (default: 10 min).
Config.gsrUpdateStatus          = 5 * 60 * 1000     -- Change first number only, to change how often the client updates hasFired variable dont set it very high... 5-10 min should be fine. (default: 5 min).
Config.UseCharName				= false				-- This will show the suspects name in the PASSED or FAILED notification. Allows cop to make sure they checked the right person.

Config.weaponChecklist = {
	--Get models id here : https://pastebin.com/0wwDZgkF
	0x1B06D571,
	0x5EF9FEC4,
	0x22D8FE39,
	0x99AEEB3B,
	0x13532244,
	0x2BE6766B,
	0xEFE7E2DF,
	0x0A3D4D34,
	0xBFEFFF6D,
	0x83BF0278,
	0xAF113F99,
	0x9D07F764,
	0x7FD62962,
	0x1D073A89,
	0x7846A318,
	0xE284C527,
	0x9D61E50F,
	0x3656C8C1,
	0x5FC3C11,
	0xC472FE2,
	0xA284510B,
	0x4DD2DC56,
	0xB1CA77B1,
	0x42BF8A85,
	0x93E220BD,
	0x2C3731D9,
	0xFDBC8A50,
	0xA0973D5E,
	0x24B17070,
	0xBFD21232,
	0xC0A3098D,
	0xD205520E,
	0x7F229F94,
	0x63AB0442,
	0xAB564B93,
	0x83839C4,
	0x7F7497E5,
	0xA89CB99E,
	0xC734385A,
	0x3AABBBAA,
	0x61012683,
	0x6D544C99
	}
