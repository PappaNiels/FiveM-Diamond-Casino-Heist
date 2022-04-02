local models = { 
    GetHashKey("a_f_m_bevhills_01"),
    GetHashKey("a_f_m_bevhills_02"),
    GetHashKey("a_f_m_bodybuild_01") 
}

local hPlayer = { 
    PlayerPedId(),
    PlayerPedId(),
    PlayerPedId(),
    PlayerPedId()    
}

local nPropsCoords = { 
    vector3(2505.54, -238.53, -71.65),
    vector3(2504.98, -240.31, -70.19)
}

local nPropsNames = { 
    GetHashKey("ch_prop_ch_vault_wall_damage"),
    GetHashKey("ch_des_heist3_vault_end")
}

local difficulty
local loot

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

function HideNProps()
    for i = 1, #nPropsCoords, 1 do 
        local prop = GetClosestObjectOfType(nPropsCoords[i], 1.0, nPropsNames[i], false, false, false)
        local prop1 = GetClosestObjectOfType(2504.97, -240.31, -70.17, 1.0, GetHashKey("ch_des_heist3_vault_01"), false, false, false)
        SetEntityVisible(prop, false)
        SetEntityCollision(prop, false, true)
        SetEntityVisible(prop1, true)
        SetEntityCollision(prop1, true, true)
    end
end

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

AddEventHandler("onResourceStart", function()
    HideNProps()
end)