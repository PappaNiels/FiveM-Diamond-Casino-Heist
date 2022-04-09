heistInprogress = false

hPlayer = { 
    PlayerPedId(),
    PlayerPedId(),
    PlayerPedId(),
    PlayerPedId()    
}

heistType = 0
entryType = 0

entrypointsCasino = {
    -- Agressive 

    --[[1]]  vector3(923.76, 47.20, 81.11),  -- Front
    --[[2]]  vector3(893.29, -176.47, 22.58),  -- Sewer

    -- Silent and sneaky + Big con

    --[[3]]  vector3(978.78, 18.64, 80.99),  -- Staff Entry
    --[[4]]  vector3(993.17, 77.05, 80.99),  -- Garbage Entry
    --[[5]]  vector3(972.15, 25.54, 120.24),  -- Roof Helipad North  
    --[[6]]  vector3(959.39, 31.75, 120.23),  -- Roof Helipad South 
    --[[7]]  vector3(988.32, 59.03, 111.26),  -- Roof North East
    --[[8]]  vector3(953.78, 4.02, 111.26),  -- Roof South East 
    --[[9]] vector3(936.42, 14.51, 112.55), -- Roof South West
    --[[10]] vector3(953.40, 79.20, 111.25), -- Roof North West
    
    -- Gruppe Sechs
    --[[11]] vector3(0, 0, 0)  -- Garage

}


keypads = {
    ["lvlOneKeypad"] = {

    },

    ["lvlTwoKeypad"] = {

    },

    ["lvlThreeKeypad"] = {
        vector3(2519.80, -226.47, -70.40),
        vector3(2533.10, -237.28, -70.40),
        vector3(2519.72, -250.60, -70.40),
        vector3(2514.85, -223.50, -70.40),
        vector3(2536.07, -232.34, -70.40),
        vector3(2536.06, -244.72, -70.40),
        vector3(2514.85, -253.55, -70.40)
    },

    ["lvlFourKeypad"]  = {
        vector3(2464.828, -282.2930, -70.4072),
        vector3(2464.845, -276.1607, -70.4072),
        vector3(2492.825, -241.5286, -70.4072),
        vector3(2492.829, -235.4994, -70.4072)
    } 
}


difficulty = 0
loot = 0
vaultLayout = 0

local models = { 
    GetHashKey("a_f_m_bevhills_01"),
    GetHashKey("a_f_m_bevhills_02"),
    GetHashKey("a_f_m_bodybuild_01") 
}

local nPropsCoords = { 
    vector3(2505.54, -238.53, -71.65),
    vector3(2504.98, -240.31, -70.19)
}

local nPropsNames = { 
    GetHashKey("ch_prop_ch_vault_wall_damage"),
    GetHashKey("ch_des_heist3_vault_end")
}

RegisterCommand("vl_break", function()
    for i = 1, #nPropsCoords, 1 do 
        local prop = GetClosestObjectOfType(nPropsCoords[i], 1.0, nPropsNames[i], false, false, false)
        local prop1 = GetClosestObjectOfType(2504.97, -240.31, -70.17, 1.0, GetHashKey("ch_des_heist3_vault_01"), false, false, false)
        SetEntityVisible(prop, true)
        SetEntityVisible(prop1, false)
        SetEntityCollision(prop, true, true)
        SetEntityCollision(prop1, false, true)
    end
end, false)

function GetHeistPlayer()
    Models()
    hPlayer[2] = CreatePed(7, models[1], 0.0, 0.0, 0.0, 0.0, true, true)
    hPlayer[3] = CreatePed(7, models[2], 0.0, 0.0, 0.0, 0.0, true, true)
    hPlayer[4] = CreatePed(7, models[3], 0.0, 0.0, 0.0, 0.0, true, true)
    return hPlayer 
end

function DeletePeds()
    for i = 2, #hPlayer, 1 do 
        DeletePed(hPlayer[i])
    end
end

function Models()
    for i = 1, #models, 1 do 
        LoadModel(models[i])
    end
end

--function SetLoot()
--    loot = math.random(1, 4)
--end

function SetLayout()
    if loot ~= 2 then 
        vaultLayout = math.random(1,6)
    else  
        vaultLayout = math.random(7,10)
    end
    --vaultLayout = math.random(1,4)
end

AddEventHandler("onResourceStart", function()
    HideNPropsStart()
end)

function HideNPropsStart()
    for i = 1, #nPropsCoords, 1 do 
        local prop = GetClosestObjectOfType(nPropsCoords[i], 1.0, nPropsNames[i], false, false, false)
        --local prop1 = GetClosestObjectOfType(2504.97, -240.31, -70.17, 1.0, GetHashKey("ch_des_heist3_vault_01"), false, false, false)
        SetEntityVisible(prop, false)
        SetEntityCollision(prop, false, true)
        --SetEntityVisible(prop1, true)
        --SetEntityCollision(prop1, true, true)
    end
end