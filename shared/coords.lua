--[[
    These are the coordinates you can edit to your liking. For example if you use a different casino.
    Please be cautious when editing these coords, since it can break the resource when given the incorrect coordinates for the models and scenes. Enable the debug option in the config to check if the coords are correct.

    Do note that increasing or decreasing the amount of entries and exits may cause the resource to break.
]]

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

exitCoords = {
    [1] = vector3(993.17, 77.05, 80.99),      -- Waste Disposal
    [2] = vector3(923.76, 47.20, 81.11),      -- Main Entrance
    [3] = vector3(936.42, 14.51, 112.55),     -- Roof South West
    [4] = vector3(972.15, 25.54, 120.24),     -- Roof Helipad North  
    [5] = vector3(953.40, 79.20, 111.25),     -- Roof North West
    [8] = vector3(953.78, 4.02, 111.26),      -- Roof South East 
    [9] = vector3(959.39, 31.75, 120.23),     -- Roof Helipad South 
    [10] = vector3(988.32, 59.03, 111.26),    -- Roof North East
    [11] = vector3(978.78, 18.64, 80.99)      -- Staff Lobby
}