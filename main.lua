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

    --[[1]]  vector3(923.76, 47.2, 81.11),  -- Front
    --[[2]]  vector3(893.29, -176.47, 22.58),  -- Sewer

    -- Silent and sneaky + Big con

    --[[3]]  vector3(0, 0, 0),  -- Staff entry
    --[[4]]  vector3(0, 0, 0),  -- Garbage entry
    --[[5]]  vector3(0, 0, 0),  -- Roof 1 
    --[[6]]  vector3(0, 0, 0),  -- Roof 2
    --[[7]]  vector3(0, 0, 0),  -- Roof 3
    --[[8]]  vector3(0, 0, 0),  -- Roof 4
    --[[9]]  vector3(0, 0, 0),  -- Roof 5
    --[[10]] vector3(0, 0, 0), -- Roof 6
    --[[11]] vector3(0, 0, 0), -- Roof 7
    
    -- Gruppe Sechs
    --[[12]] vector3(0, 0, 0)  -- Garage

}

lvlOneKeypad = {

}

lvlTwoKeypad = {

}

lvlThreeKeypad = {

}

lvlFourKeypad  = {
    vector3(2465.45, -282.00, -70.69),
    vector3(2465.30, -276.45, -70.69),
    vector3(2492.82, -241.52, -70.40),
    vector3(2492.83, -235.50, -70.40)
}

difficulty = 0
loot = 0

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

function GetDifficulty()
    return difficulty 
end

function SetLoot(_loot)
    loot = _loot
end

function GetLoot()
    return loot 
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