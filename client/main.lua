heistInProgress = false

hPlayer = {1, 2}

entrypointsCasino = {
    -- Agressive 
    --[[4]]  vector3(993.17, 77.05, 80.99),     -- Waste Disposal
    --[[1]]  vector3(923.76, 47.20, 81.11),     -- Main Entrance
    --[[9]]  vector3(936.42, 14.51, 112.55),    -- Roof South West
    --[[5]]  vector3(972.15, 25.54, 120.24),    -- Roof Helipad North  
    --[[10]] vector3(953.40, 79.20, 111.25),    -- Roof North West
    --[[11]] vector3(1000.4, -54.99, 74.96),     -- Security Tunnel
    --[[2]]  vector3(893.29, -176.47, 22.58),   -- Sewer
    --[[8]]  vector3(953.78, 4.02, 111.26),     -- Roof South East 
    --[[6]]  vector3(959.39, 31.75, 120.23),    -- Roof Helipad South 
    --[[7]]  vector3(988.32, 59.03, 111.26),    -- Roof North East
    --[[3]]  vector3(978.78, 18.64, 80.99)     -- Staff Lobby
}


keypads = {
    [1] = {
        vector3(991.47, 76.80, 81.14),
        0,
        vector3(936.75, 13.07, 112.79),
        vector3(972.24, 50.96, 120.38),
        vector3(953.68, 77.94, 111.39),
        0,
        0,
        vector3(953.58, 5.25, 111.54),
        vector3(959.02, 33.13, 120.42),
        vector3(986.94, 58.68, 111.54),
        vector3(978.39, 19.83, 81.13)
    },

    [2] = {

    },

    [3] = {
        [1] = {
            vector3(2519.80, -226.47, -70.40),
            vector3(2533.10, -237.28, -70.40),
            vector3(2519.72, -250.60, -70.40)
        },
        [2] = {
            vector3(2514.85, -223.50, -70.40),
            vector3(2536.07, -232.34, -70.40),
            vector3(2536.06, -244.72, -70.40),
            vector3(2514.85, -253.55, -70.40)
        }
        
        
    },

    [4]  = {
        vector3(2464.828, -282.2930, -70.4072),
        vector3(2464.845, -276.1607, -70.4072),
        vector3(2492.825, -241.5286, -70.4072),
        vector3(2492.829, -235.4994, -70.4072)
    } 
}

difficulty = 1 -- 1 = Normal, 2 = Hard
loot = 0 -- 1 = CASH, 2 = GOLD, 3 = ARTWORK, 4 = DIAMONDS
approach = 3 -- 1 = Silent and Sneaky, 2 = The Big Con, 3 = Aggressive
playerAmount = 0
vaultLayout = 0
teamlives = 1
take = 8502100

cash = 5875
goldbar = 16156

selectedGunman = 0         
selectedLoadout = 0         
selectedDriver = 0          
selectedVehicle = 0         
selectedHacker = 0          
selectedKeycard = 0
selectedEntrance = 1        
selectedExit = 0            
selectedBuyer = 0          
selectedEntryDisguise = 1      
selectedExitDisguise = 1 

boughtCasinoModel = false 
boughtDoorSecurity = false 
boughtVault = false
boughtCleanVehicle = false
boughtDecoy = false

AddTextEntry("warning_message_first_line", "confirm")

playerCut = {
    [1] = {100},
    [2] = {85, 15},
    [3] = {70, 15, 15},
    [4] = {55, 15, 15, 15}
}

alarmTriggered = 0

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

function GetHeistPlayers()
    Models()
    --hPlayer[2] = CreatePed(7, models[1], 0.0, 0.0, 0.0, 0.0, true, true)
    --hPlayer[3] = CreatePed(7, models[2], 0.0, 0.0, 0.0, 0.0, true, true)
    --hPlayer[4] = CreatePed(7, models[3], 0.0, 0.0, 0.0, 0.0, true, true)
    return hPlayer 
end

function GetCurrentHeistPlayer()
    if PlayerId() == GetPlayerFromServerId(hPlayer[1]) then 
        return 1 
    elseif PlayerId() == GetPlayerFromServerId(hPlayer[2]) then 
        return 2
    elseif PlayerId() == GetPlayerFromServerId(hPlayer[3]) then 
        return 3
    elseif PlayerId() == GetPlayerFromServerId(hPlayer[4]) then
        return 4
    else 
        return nil
    end
end

function DeletePeds()
    for i = 3, #hPlayer, 1 do 
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
    if loot ~= 3 then 
        vaultLayout = math.random(1,6)
    else  
        vaultLayout = math.random(7,10)
    end
    --vaultLayout = math.random(1,4)
end

AddEventHandler("onResourceStart", function()
    --HideNPropsStart()
    --if GetCurrentResourceName() ~= "1heist" then 
    --    print("Not the correct resource name")
    --    StopResource(GetCurrentResourceName())
    --end
    --TriggerServerEvent("sv:casinoheist:setupheist" )
    SetEntityVisible(PlayerPedId(), true)
end)

function SetupCheckpoint()
    for i = 1, #nPropsCoords, 1 do 
        local prop = GetClosestObjectOfType(nPropsCoords[i], 1.0, nPropsNames[i], false, false, false)
        --local prop1 = GetClosestObjectOfType(2504.97, -240.31, -70.17, 1.0, GetHashKey("ch_des_heist3_vault_01"), false, false, false)
        SetEntityVisible(prop, false)
        SetEntityCollision(prop, false, true)
        --SetEntityVisible(prop1, true)
        --SetEntityCollision(prop1, true, true)
    end

    
    --FreezeEntityPosition(GetClosestObjectOfType(2504.58, -240.4, -70.71, 2.0, GetHashKey("ch_prop_ch_vaultdoor01x"), false, false, false), true)

    local shaft = GetClosestObjectOfType(2505.54, -238.53, -71.65, 10.0, GetHashKey("ch_prop_ch_vault_wall_damage"), false, false, false)
    local vaultDoorOne = "ch_des_heist3_vault_01"
    local vaultDoorTwo = "ch_des_heist3_vault_02"

    SetEntityVisible(shaft, false)
    LoadModel(vaultDoorOne)
    LoadModel(vaultDoorTwo)

    vaultObjOne = CreateObject(GetHashKey(vaultDoorOne), 2504.97, -240.31, -73.69, false, false, false)
    vaultObjTwo = CreateObject(GetHashKey(vaultDoorTwo), 2504.97, -240.31, -75.334, false, false, false)  

    SetEntityForAll(vaultObjOne)
    SetEntityForAll(vaultObjTwo)
end

RegisterNetEvent("cl:casinoheist:updateHeistPlayers", function(crew)
    hPlayer = crew
    PlayerJoinedCrew(#hPlayer)
end)

AddEventHandler("baseevents:onPlayerDied", function(o, i)
    if hPlayer[1] == GetPlayerServerId(PlayerId()) or hPlayer[2] == GetPlayerServerId(PlayerId()) or hPlayer[3] == GetPlayerServerId(PlayerId()) or hPlayer[4] == GetPlayerServerId(PlayerId()) then 
        TriggerServerEvent("sv:casinoheist:removeteamlive")
        print("works")
    else 
        print("isnt")
    end
end)

RegisterCommand("hPlayer", function(source, args)
    print(args[1])
    print(PlayerPedId())
    TriggerServerEvent("sv:casinoheist:setHeistPlayers", PlayerPedId(), tonumber(args[1]))
end, false)