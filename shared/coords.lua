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
cargobobCoords = vector3(1057.56, -292.71, 50.0)
cargobobFinalCoords = vector3(1303.6, -71.01, 400.0)

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

aggressiveMainEntry = vector3(2488.15, -292.65, -58.71)

rappelEntry = {
    vector3(2517.8, -257.58, -24.11),
    {
        vector4(2516.76, -266.94, -58.72, 240.0),
        vector4(2515.7, -267.96, -58.72, 240.0),
        vector4(2515.31, -266.2, -58.72, 240.0),
        vector4(2514.23, -266.94, -58.22, 240.0)
    }
}

casinoToLobby = {
    vector4(2526.85, -256.14, -61.32, 180.0),
    vector4(2525.28, -256.17, -61.32, 180.0),
    vector4(2526.85, -254.62, -61.32, 180.0), 
    vector4(2525.28, -256.17, -61.32, 180.0) 
}

sewerBomb = vector3(2480.1, -293.33, -70.67)

staffCoords = {
    vector3(2520.97, -279.37, -58.72), -- Elevator
    vector3(2514.67, -280.43, -58.72)  -- Stairs
} 

mantrapCoords = vector3(2423.94, -254.87, -70.81)
vaultEntryDoorCoords = vector3(2498.22, -238.43, -70.74)

vaultMiddle = vector3(2521.0, -238.5, -70.74)

meetingPoint = {
    {
        vector3(-1167.42, -1748.52, 3.95), -- Heading = 215.02
        vector3(-591.08, -2360.05, 13.16), -- Heading = 49.85
        vector3(1158.75, -2648.28, 8.56) -- Heading = 172.52
    },
    {
        vector3(-3157.33, 1071.27, 20.01), -- Heading = 280.27
        vector3(-1155.52, 2673.17, 17.43), -- Heading = 149.42
        vector3(2088.96, 4771.23, 40.56) -- Heading = 256.88
    },
    {
        vector3(-2072.75, 4566.8, 2.0), -- Heading = 344.02
        vector3(-598.56, 5306.08, 69.55), -- Heading = 253.94
        vector3(557.93, 6667.02, 9.27) -- Heading = 10.61
    }
}

-- Entities

keypads = {
    {
        vector3(991.47, 76.80, 81.14),  -- Waste Disposal
        vector3(0.0, 0.0, 0.0),                              -- Does not exist
        vector3(936.75, 13.07, 112.79), -- Roof South West
        vector3(972.24, 50.96, 120.38), -- Roof Helipad North
        vector3(953.68, 77.94, 111.39), -- Roof North West
        vector3(0.0, 0.0, 0.0),                              -- Does not exist
        vector3(0.0, 0.0, 0.0),                              -- Does not exist
        vector3(953.58, 5.25, 111.54),  -- Roof South West
        vector3(959.02, 33.13, 120.42), -- Roof Helipad South
        vector3(986.94, 58.68, 111.54), -- Roof North East
        vector3(978.39, 19.83, 81.13)   -- Staff Lobby
    },

    {
        vector3(978.39, 19.83, 81.13),
        vector3(978.39, 19.83, 81.13)
    },

    {
        vector3(2519.80, -226.47, -70.40), -- Main Doors
        vector3(2533.10, -237.28, -70.40),
        vector3(2519.72, -250.60, -70.40),

        vector3(2514.85, -223.50, -70.40), -- Other Doors
        vector3(2536.07, -232.34, -70.40),
        vector3(2536.06, -244.72, -70.40),
        vector3(2514.85, -253.55, -70.40)
    },

    {
        vector3(2464.828, -282.2930, -70.4072),
        vector3(2464.845, -276.1607, -70.4072),
        vector3(2492.825, -241.5286, -70.4072),
        vector3(2492.829, -235.4994, -70.4072)
    } 
}

carts = {
    {   -- Vault Layouts                                    -- Cart Model, Blip Sprite
        vector4(2527.56885, -235.687744, -71.743, 117.08),  --         A  A
        vector4(2523.88159, -245.282669, -71.743, 22.55),   --         B  B
        vector4(2518.748, -237.311966, -71.743, 59.45),     --         C  C
        vector4(2513.519, -225.5228, -71.743, 321.67),      --         A  D
        vector4(2522.04688, -222.246826, -71.743, 172.0),   --         B  E
        vector4(2534.379, -231.07428, -71.743, 319.02),     --         C  F                                           
        vector4(2532.42676, -245.743271, -71.743, 222.48),  --         A  G
        vector4(2516.40869, -252.185562, -71.743, 180.0)    --         B  H
    },
    {
        vector4(2527.56885, -235.687744, -71.743, 117.08),  --         A  A
        vector4(2523.88159, -245.282669, -71.743, 22.55),   --         B  B
        vector4(2506.02979, -229.8687, -71.743, 325.98),    --         C  C               
        vector4(2527.599, -224.06337, -71.743, 245.31),     --         A  D   
        vector4(2531.93628, -251.4501, -71.743, 335.88),    --         B  E 
        vector4(2528.15063, -249.921661, -71.743, 220.06),  --         C  F 
        vector4(2516.40869, -252.185562, -71.743, 0.0),     --         A  G 
        vector4(2505.54688, -245.549637, -71.743, 210.65)   --         B  H 
    }
}

artCabinets = {
    vector4(2507.659, -223.2621, -71.73716, 41.5),     -- A
    vector4(2527.589, -219.2627, -71.73721, 342.0),    -- B
    vector4(2541.289, -237.1996, -71.73713, 272.5),    -- C
    vector4(2534.469, -253.8372, -71.73721, 221.7),    -- D
    vector4(2522.384, -258.804, -71.73721, 183.0),     -- E
    vector4(2502.754, -247.5572, -71.73713, 117.5)     -- F
}

paintings = {
    vector3(2507.275, -222.8378, -70.73716),            -- A
    vector3(2527.805, -218.7364, -70.73716),            -- B
    vector3(2541.87, -237.2035, -70.73716),             -- C
    vector3(2534.866, -254.2816, -70.73716),            -- D
    vector3(2522.428, -259.3858, -70.73716),            -- E
    vector3(2502.229, -247.7811, -70.73716)             -- F
}

slideDoors = {
    -- Inner Doors
    vector3(2519.962, -226.0072, -71.74234),
    vector3(2533.56, -239.6175, -71.74234),
    vector3(2519.938, -251.0496, -71.74234),

    -- Outer Doors
    vector3(2514.195, -222.1348, -71.74234),
    vector3(2536.185, -232.2094, -71.74234),
    vector3(2536.184, -244.8697, -71.74234),
    vector3(2514.696, -253.6722, -71.74234)
}

regularVaultDoorCoords = vector3(2504.97, -240.31, -72.205)
aggressiveVaultDoorCoords = {
    vector3(2504.97, -240.31, -73.691), -- Door
    vector3(2504.97, -240.31, -75.339), -- Support Thingy
    vector3(2504.97, -240.31, -71.8)  -- Exploded Door 
}

getawayVehicles = {
    vector3(982.61, -211.15, 70.38),
    vector3(992.93, -214.45, 69.83)
}

-- Blips 

stairBlip = vector3(2526.51, -252.35, -24.12)

vaultCheckpointBlips = {
    vector3(2504.5, -236.85, -70.74),
    vector3(2504.5, -239.98, -70.71)
}

aggressiveAreaBlip = vector4(2502.51, -238.75, -70.2, 5.0)

-- Synchronised Scenes 

vaultDrillPos = {
    vector3(2505.1, -237.62, -70.425),
    vector3(2504.97, -239.35, -70.425)
}

--GetInvokingResource()