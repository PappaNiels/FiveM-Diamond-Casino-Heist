--[[
    These are the coordinates you can edit to your liking. For example if you use a different casino.
    Please be cautious when editing these coords, since it can break the resource when given the incorrect coordinates for the models and scenes. Enable the debug option in the config to check if the coords are correct.

    Do note that increasing or decreasing the amount of entries and exits may cause the resource to break.
]]


-- These are the coords where you enter/leave the Casino (6 and 7 are not exits)
entryCoords = {
    vector3(993.17, 77.05, 80.99),     -- Waste Disposal 
    vector3(923.76, 47.20, 81.11),     -- Main Entrance 
    vector3(936.42, 14.51, 112.55),    -- Roof South West 
    vector3(972.15, 52.54, 120.24),    -- Roof Helipad North 
    vector3(953.40, 79.20, 111.25),    -- Roof North West 
    vector3(1000.4, -54.99, 74.96),    -- Security Tunnel 
    vector3(893.29, -176.47, 22.58),   -- Sewer 
    vector3(953.78, 4.02, 111.26),     -- Roof South East 
    vector3(959.39, 31.75, 120.23),    -- Roof Helipad South 
    vector3(988.32, 59.03, 110.26),    -- Roof North East 
    vector3(978.78, 18.64, 80.99)      -- Staff Lobby 
}

-- These are the coordinates where the cargobob spawns (first vector) and where it flies to (second vector).
cargobobCoords = vector3(1057.56, -292.71, 50.95)
cargobobFinalCoords = vector3(1303.6, -71.01, 297.33)

-- These are the coords where your ped will teleport to when you enter the casino 
casinoEntryCoords = {
    { -- Waste Disposal
        -- Coords, Heading
        {vector3(2542.56, -213.34, -58.72), 205.7}, -- Player One
        {vector3(2541.23, -214.05, -58.72), 205.7}, -- Player Two
        {vector3(2541.78, -211.91, -58.72), 205.7}, -- Player Three
        {vector3(2540.67, -212.82, -58.72), 205.7}  -- Player Four
    },
    {   -- Main Entrance (not for the aggressive approach)
        {vector3(1090.15, 209.73, -49), 306.11},
        {vector3(1091.1, 208.53, -49), 306.11},
        {vector3(1088.69, 208.47, -49), 306.11},
        {vector3(1089.95, 207.33, -49), 306.11}
    },
    {   -- South West Terrace
        {vector3(2487.44, -291.86, -39.12), 0.0},
        {vector3(2488.7, -291.86, -39.12), 0.0},
        {vector3(2487.44, -293.3, -39.12), 0.0},
        {vector3(2488.7, -293.3, -39.12), 0.0}
    },
    {   -- North Helipad
        {vector3(2523.01, -245.9, -24.91), 178.47},
        {vector3(2521.7, -245.9, -24.11), 178.47},
        {vector3(2523.09, -244.43, -24.11), 178.47},
        {vector3(2521.7, -244.43, -24.11), 178.47}
    },
    {   -- North West Terrace
        {vector3(2527.87, -265.14, -39.12), 90.0},
        {vector3(2527.87, -263.92, -39.12), 90.0},
        {vector3(2529.17, -265.14, -39.12), 90.0},
        {vector3(2529.17, -263.92, -39.12), 90.0}
    },
    {   -- Security Tunnel 
        vector3(2650.31, -339.48, -65.12), 49.55 -- Vehicle
    }, 
    {   -- Sewer
        {vector3(2514.85, -327.85, -70.6), 74.1},
        {vector3(2515.01, -325.94, -70.61), 74.1},
        {vector3(2516.7, -327.69, -70.65), 74.1},
        {vector3(2516.85, -326.27, -70.68), 74.1}
    },
    {   -- South East Terrace
        {vector3(2525.63, -290.65, -39.12), 90.0},
        {vector3(2525.63, -289.15, -39.12), 90.0},
        {vector3(2526.98, -290.65, -39.12), 90.0},
        {vector3(2526.98, -289.15, -39.12), 90.0}
    },
    {   -- South Helipad
        {vector3(2521.22, -263.0, -24.11), 350.94},
        {vector3(2521.54, -263.0, -24.11), 350.94},
        {vector3(2521.22, -264.42, -24.11), 350.94},
        {vector3(2522.54, -264.41, -24.11), 350.94}
    },
    {   -- North East Terrace
        {vector3(2051.75, -232.63, -39.12), 270.0},
        {vector3(2051.75, -234.01, -39.12), 270.0},
        {vector3(2500.36, -232.63, -39.12), 270.0},
        {vector3(2500.36, -234.01, -39.12), 270.0}
    },
    {   -- Staff Lobby
        {vector3(2548.33, -270.06, -58.72), 90.0},
        {vector3(2548.33, -268.77, -58.72), 90.0},
        {vector3(2549.77, -270.06, -58.72), 90.0},
        {vector3(2549.77, -268.77, -58.72), 90.0}
    },
}

casinoToLobby = {
    vector3(2526.85, -256.14, -61.32),
    vector3(2525.28, -256.17, -61.32),
    vector3(2526.85, -254.62, -61.32), 
    vector3(2525.28, -256.17, -61.32) 
}

staffCoords = {
    vector3(2520.97, -279.37, -58.72), -- Elevator
    vector3(2514.67, -280.43, -58.72)  -- Stairs
} 

mantrapCoords = vector3(2423.94, -254.87, -70.81)
vaultEntryDoorCoords = vector3(2498.22, -238.43, -70.74)

-- Entities

regularVaultDoorCoords = vector3(2504.97, -240.31, -73.691)
aggressiveVaultDoorCoords = {
    vector3(2504.97, -240.31, -73.691), -- Door
    vector3(2504.97, -240.31, -75.339), -- Support Thingy
    vector3(2504.97, -240.31, -71.8)  -- Exploded Door 
}

-- Blips 

vaultCheckpointBlips = {
    vector3(2504.5, -236.85, -70.74),
    vector3(2504.5, -239.98, -70.71)
}

aggressiveAreaBlip = vector3(2502.51, -238.75, -70.2, 5.0)