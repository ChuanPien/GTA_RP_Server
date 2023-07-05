Config = {}
Config.DrawDistance = 100.0
Config.MaxErrors = 5
Config.SpeedMultiplier = 3.6
Config.Locale = 'en'

Config.Prices = {
    dmv = 500,
    drive = 2500,
    drive_bike = 3000,
    drive_truck = 5000
}

Config.VehicleModels = {
    drive = 'issi2',
    drive_bike = 'sanchez',
    drive_truck = 'mule3'
}

Config.SpeedLimits = {
    residence = 50,
    town = 80,
    freeway = 140
}

Config.Zones = {

    DMVSchool = {
        Pos = {
            x = 214.56,
            y = -1397.36,
            z = 29.6
        },
        Size = {
            x = 1.5,
            y = 1.5,
            z = 1.0
        },
        Color = {
            r = 204,
            g = 204,
            b = 0
        },
        Type = 1
    },

    VehicleSpawnPoint = {
        Pos = {
            x = 249.409,
            y = -1407.230,
            z = 30.4094,
            h = 317.0
        },
        Size = {
            x = 1.5,
            y = 1.5,
            z = 1.0
        },
        Color = {
            r = 204,
            g = 204,
            b = 0
        },
        Type = -1
    }

}

Config.CheckPoints = {{
    Pos = {
        x = 255.139,
        y = -1400.731,
        z = 29.537
    },
    Action = function(playerPed, vehicle, setCurrentZoneType)
        DrawMissionText(_U('go_next_point'), 5000)
        PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
    end
}, {
    Pos = {
        x = 271.874,
        y = -1370.574,
        z = 30.932
    },
    Action = function(playerPed, vehicle, setCurrentZoneType)
        DrawMissionText(_U('go_next_point'), 5000)
        PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
    end
}, {
    Pos = {
        x = 234.907,
        y = -1345.385,
        z = 29.542
    },
    Action = function(playerPed, vehicle, setCurrentZoneType)
        Citizen.CreateThread(function()
            DrawMissionText(_U('go_next_point'), 5000)
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
        end)
    end
}, {
    Pos = {
        x = 217.821,
        y = -1410.520,
        z = 28.292
    },
    Action = function(playerPed, vehicle, setCurrentZoneType)
        setCurrentZoneType('town')

        Citizen.CreateThread(function()
            DrawMissionText(_U('go_next_point'), 5000)
            PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
        end)
    end
}, {
    Pos = {
        x = 183.44,
        y = -1395.6,
        z = 27.84
    },
    Action = function(playerPed, vehicle, setCurrentZoneType)
        DrawMissionText(_U('go_next_point'), 5000)
        PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
    end
}, {
    Pos = {
        x = 209.12,
        y = -1329.28,
        z = 27.92
    },
    Action = function(playerPed, vehicle, setCurrentZoneType)
        DrawMissionText(_U('go_next_point'), 5000)
        PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
    end
}, {
    Pos = {
        x = 218.32,
        y = -1146.8,
        z = 27.92
    },
    Action = function(playerPed, vehicle, setCurrentZoneType)
        DrawMissionText(_U('go_next_point'), 5000)
        PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
    end
}, {
    Pos = {
        x = 224.0,
        y = -1070.52,
        z = 27.76
    },
    Action = function(playerPed, vehicle, setCurrentZoneType)
        DrawMissionText(_U('go_next_point'), 5000)
        PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
    end
}, {
    Pos = {
        x = 381.72,
        y = -1054.44,
        z = 27.8
    },
    Action = function(playerPed, vehicle, setCurrentZoneType)
        DrawMissionText(_U('go_next_point'), 5000)
        PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
    end
}, {
    Pos = {
        x = 402.32,
        y = -970.24,
        z = 28.0
    },
    Action = function(playerPed, vehicle, setCurrentZoneType)
        DrawMissionText(_U('go_next_point'), 5000)
        PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
    end
}, {
    Pos = {
        x = 408.92,
        y = -876.76,
        z = 27.92
    },
    Action = function(playerPed, vehicle, setCurrentZoneType)
        DrawMissionText(_U('go_next_point'), 5000)
        PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
    end
}, {
    Pos = {
        x = 316.0,
        y = -849.84,
        z = 27.92
    },
    Action = function(playerPed, vehicle, setCurrentZoneType)
        DrawMissionText(_U('go_next_point'), 5000)
        PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
    end
}, {
    Pos = {
        x = 200.28,
        y = -822.44,
        z = 29.56
    },
    Action = function(playerPed, vehicle, setCurrentZoneType)
        DrawMissionText(_U('go_next_point'), 5000)
        PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
    end
}, {
    Pos = {
        x = 59.56,
        y = -771.4,
        z = 30.28
    },
    Action = function(playerPed, vehicle, setCurrentZoneType)
        DrawMissionText(_U('go_next_point'), 5000)
        PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
    end
}, {
    Pos = {
        x = -93.08,
        y = -711.72,
        z = 33.28
    },
    Action = function(playerPed, vehicle, setCurrentZoneType)
        DrawMissionText(_U('go_next_point'), 5000)
        PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
    end
}, {
    Pos = {
        x = -182.68,
        y = -866.76,
        z = 27.92
    },
    Action = function(playerPed, vehicle, setCurrentZoneType)
        DrawMissionText(_U('go_next_point'), 5000)
        PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
    end
}, {
    Pos = {
        x = -275.04,
        y = -1118.84,
        z = 21.68
    },
    Action = function(playerPed, vehicle, setCurrentZoneType)
        DrawMissionText(_U('go_next_point'), 5000)
        PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
    end
}, {
    Pos = {
        x = -275.8,
        y = -1405.32,
        z = 29.92
    },
    Action = function(playerPed, vehicle, setCurrentZoneType)
        DrawMissionText(_U('go_next_point'), 5000)
        PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
    end
}, {
    Pos = {
        x = -140.56,
        y = -1526.64,
        z = 32.88
    },
    Action = function(playerPed, vehicle, setCurrentZoneType)
        DrawMissionText(_U('go_next_point'), 5000)
        PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
    end
}, {
    Pos = {
        x = -140.56,
        y = -1526.64,
        z = 32.88
    },
    Action = function(playerPed, vehicle, setCurrentZoneType)
        DrawMissionText(_U('go_next_point'), 5000)
        PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
    end
}, {
    Pos = {
        x = 26.84,
        y = -1662.04,
        z = 27.88
    },
    Action = function(playerPed, vehicle, setCurrentZoneType)
        DrawMissionText(_U('go_next_point'), 5000)
        PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
    end
}, {
    Pos = {
        x = 162.68,
        y = -1608.96,
        z = 27.92
    },
    Action = function(playerPed, vehicle, setCurrentZoneType)
        DrawMissionText(_U('go_next_point'), 5000)
        PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
    end
}, {
    Pos = {
        x = 299.52,
        y = -1525.08,
        z = 27.92
    },
    Action = function(playerPed, vehicle, setCurrentZoneType)
        DrawMissionText(_U('go_next_point'), 5000)
        PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
    end
}, {
    Pos = {
        x = 232.04,
        y = -1401.16,
        z = 29.04
    },
    Action = function(playerPed, vehicle, setCurrentZoneType)
        ESX.Game.DeleteVehicle(vehicle)
    end
}}
