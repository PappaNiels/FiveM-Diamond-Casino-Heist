cartLayout = 0
vaultLayout = 0

isBusy = false

status = {
    {
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0
    },
    {
        false,
        false,
        false,
        false,
        false,
        false,
        false
    }
}

local test = {}
local takeObjs = {}
local paintingObjs = {}
local slideDoorObjs = {}
local blips = {}

local paintingNames = {
    "ch_prop_vault_painting_01a",
    "ch_prop_vault_painting_01d",
    "ch_prop_vault_painting_01f",
    "ch_prop_vault_painting_01g",
    "ch_prop_vault_painting_01h",
    "ch_prop_vault_painting_01i",
}

local paintingAnims = {
    {
        -- Player, Knife, Painting, Bag, Cam
        {"ver_01_top_left_enter",               "ver_01_top_left_enter_w_me_switchblade",                   "ver_01_top_left_enter_ch_prop_vault_painting_01a",                 "ver_01_top_left_enter_hei_p_m_bag_var22_arm_s",                "ver_01_top_left_enter_ch_prop_ch_sec_cabinet_02a",                "ver_01_top_left_enter_cam"}, -- Enter top left
        {"ver_01_cutting_top_left_idle",        "ver_01_cutting_top_left_idle_w_me_switchblade",            "ver_01_cutting_top_left_idle_ch_prop_vault_painting_01a",          "ver_01_cutting_top_left_idle_hei_p_m_bag_var22_arm_s",         "ver_01_cutting_top_left_idle_ch_prop_ch_sec_cabinet_02a",         "ver_01_cutting_top_left_idle_cam"}, -- Idle top left
        {"ver_01_cutting_top_left_to_right",    "ver_01_cutting_top_left_to_right_w_me_switchblade",        "ver_01_cutting_top_left_to_right_ch_prop_vault_painting_01a",      "ver_01_cutting_top_left_to_right_hei_p_m_bag_var22_arm_s",     "ver_01_cutting_top_left_to_right_ch_prop_ch_sec_cabinet_02a",     "ver_01_cutting_top_left_to_right_cam"}, -- Cut top left to right
        {"ver_01_cutting_top_right_idle",       "ver_01_cutting_top_right_idle_w_me_switchblade",           "ver_01_cutting_top_right_idle_ch_prop_vault_painting_01a",         "ver_01_cutting_top_right_idle_hei_p_m_bag_var22_arm_s",        "ver_01_cutting_top_right_idle_ch_prop_ch_sec_cabinet_02a",        "ver_01_cutting_top_right_idle_cam"}, -- Idle top right
        {"ver_01_cutting_right_top_to_bottom",  "ver_01_cutting_right_top_to_bottom_w_me_switchblade",      "ver_01_cutting_right_top_to_bottom_ch_prop_vault_painting_01a",    "ver_01_cutting_right_top_to_bottom_hei_p_m_bag_var22_arm_s",   "ver_01_cutting_right_top_to_bottom_ch_prop_ch_sec_cabinet_02a",   "ver_01_cutting_right_top_to_bottom_cam"}, -- Cut top right to bottom
        {"ver_01_cutting_bottom_right_idle",    "ver_01_cutting_bottom_right_idle_w_me_switchblade",        "ver_01_cutting_bottom_right_idle_ch_prop_vault_painting_01a",      "ver_01_cutting_bottom_right_idle_hei_p_m_bag_var22_arm_s",     "ver_01_cutting_bottom_right_idle_ch_prop_ch_sec_cabinet_02a",     "ver_01_cutting_bottom_right_idle_cam"}, -- Idle bottom right
        {"ver_01_cutting_bottom_right_to_left", "ver_01_cutting_bottom_right_to_left_w_me_switchblade",     "ver_01_cutting_bottom_right_to_left_ch_prop_vault_painting_01a",   "ver_01_cutting_bottom_right_to_left_hei_p_m_bag_var22_arm_s",  "ver_01_cutting_bottom_right_to_left_ch_prop_ch_sec_cabinet_02a",  "ver_01_cutting_bottom_right_to_left_cam"}, -- Cut top right to bottom
        {"ver_01_cutting_bottom_left_idle",     "ver_01_cutting_bottom_left_idle_w_me_switchblade",         "ver_01_cutting_bottom_left_idle_ch_prop_vault_painting_01a",       "ver_01_cutting_bottom_left_idle_hei_p_m_bag_var22_arm_s",      "ver_01_cutting_bottom_left_idle_ch_prop_ch_sec_cabinet_02a",      "ver_01_cutting_bottom_left_idle_cam"}, -- Idle bottom right
        {"ver_01_cutting_left_top_to_bottom",   "ver_01_cutting_left_top_to_bottom_w_me_switchblade",       "ver_01_cutting_left_top_to_bottom_ch_prop_vault_painting_01a",     "ver_01_cutting_left_top_to_bottom_hei_p_m_bag_var22_arm_s",    "ver_01_cutting_left_top_to_bottom_ch_prop_ch_sec_cabinet_02a",    "ver_01_cutting_left_top_to_bottom_cam"}, -- Cut top right to bottom
        {"ver_01_with_painting_exit",           "ver_01_with_painting_exit_w_me_switchblade",               "ver_01_with_painting_exit_ch_prop_vault_painting_01a",             "ver_01_with_painting_exit_hei_p_m_bag_var22_arm_s",            "ver_01_with_painting_exit_ch_prop_ch_sec_cabinet_02a",            "ver_01_with_painting_exit_cam"}, -- Cut top right to bottom
        
    }, 
    {}
}

local cartType = {
    {"ch_prop_ch_cash_trolly_01a", "ch_prop_ch_cash_trolly_01b", "ch_prop_ch_cash_trolly_01c"},
    {"ch_prop_gold_trolly_01a", "ch_prop_gold_trolly_01b", "ch_prop_gold_trolly_01c"},
    {},
    {"ch_prop_diamond_trolly_01a", "ch_prop_diamond_trolly_01b", "ch_prop_diamond_trolly_01c"} 
}

local function CartType(i)
    j = 0
    if i > 3 and i < 7 then 
        j = i - 3 
    elseif i > 6 then 
        j = i - 6
    else 
        j = i
    end

    return j
end

RegisterCommand("test_doorslide", function() 
    OpenSlideDoors("A", 1, "ch_prop_ch_vault_slide_door_lrg")
end, false)

local function GetVaultObjs()
    if loot == 3 then 
        for i = 1, #artCabinets do 
            takeObjs[i] = GetClosestObjectOfType(artCabinets[i].x, artCabinets[i].y, artCabinets[i].z, 1.0, GetHashKey("ch_prop_ch_sec_cabinet_02a"), false, false, false)
            paintingObjs[i] = GetClosestObjectOfType(paintings[i], 1.0, GetHashKey(paintingNames[i]), false, false, false)
            
            blips[i] = AddBlipForEntity(takeObjs[i])
            SetBlipSprite(blips[i], 534 + i)
            SetBlipScale(blips[i], 0.8)
            SetBlipColour(blips[i], 2)
        end 
    else 
        for i = 1, #carts[cartLayout] do 
            local j = CartType(i)

            takeObjs[i] = GetClosestObjectOfType(carts[cartLayout][i].x, carts[cartLayout][i].y, carts[cartLayout][i].z, 1.0, GetHashKey(cartType[loot][j]), false, false, false)
            
            blips[i] = AddBlipForCoord(carts[cartLayout][i].x, carts[cartLayout][i].y, carts[cartLayout][i].z)
            SetBlipSprite(blips[i], 534 + i)
            SetBlipColour(blips[i], 2)
            SetBlipScale(blips[i], 0.8)
        end
    end
end

local function SetVaultObjs()
    --loot = 1
    if loot == 3 then        
        LoadModel("ch_prop_ch_sec_cabinet_02a")

        for i = 1, #paintingNames do 
            LoadModel(paintingNames[i])
        end 

        for i = 1, #artCabinets do 
            takeObjs[i] = CreateObject(GetHashKey("ch_prop_ch_sec_cabinet_02a"), artCabinets[i].x, artCabinets[i].y, artCabinets[i].z, true, false, false)
            SetEntityHeading(takeObjs[i], artCabinets[i].w)
            paintingObjs[i] = CreateObject(GetHashKey(paintingNames[i]), paintings[i], true, false, false)
            SetEntityHeading(paintingObjs[i], artCabinets[i].w)

            blips[i] = AddBlipForEntity(takeObjs[i])
            SetBlipSprite(blips[i], 534 + i)
            SetBlipScale(blips[i], 0.8)
            SetBlipColour(blips[i], 2)
        end

        for i = 1, #paintingNames do 
            SetModelAsNoLongerNeeded(paintingNames[i]) 
        end

        SetModelAsNoLongerNeeded("ch_prop_ch_sec_cabinet_02a") 
    else 
        loot = 1
        cartLayout = 1
            
        for i = 1, #cartType[loot] do 
            LoadModel(cartType[loot][i])
        end
        
        for i = 1, #carts[cartLayout] do 
            local j = CartType(i)
            
            takeObjs[i] = CreateObject(GetHashKey(cartType[loot][j]), carts[cartLayout][i].x, carts[cartLayout][i].y, carts[cartLayout][i].z, true, false, false)
            SetEntityHeading(takeObjs[i], carts[cartLayout][i].w)

            blips[i] = AddBlipForCoord(carts[cartLayout][i].x, carts[cartLayout][i].y, carts[cartLayout][i].z)
            SetBlipSprite(blips[i], 534 + i)
            SetBlipColour(blips[i], 2)
            SetBlipScale(blips[i], 0.8)
        end
        
        for i = 1, #cartType[loot] do 
            SetModelAsNoLongerNeeded(cartType[loot][i])
        end
    end
end

local function SetVaultLayout()
    local layouts = {
        {2, 3, 5, 7},
        {1, 5, 7},
        {2, 3, 4, 5},
        {1, 5, 7},
        {2, 3, 4},
        {4, 5},
        {2, 3, 4, 5},
        {1, 6, 7},
        {2, 3, 5},
        {5, 7}
    }
    
    if loot == 3 then 
        vaultLayout = math.random(7, 10)
    else
        vaultLayout = math.random(1, 6)
        
        if vaultLayout < 3 then 
            cartLayout = 1
        else 
            cartLayout = 2
        end
    end

    --vaultLayout = 1

    for i = 1, 7 do 
        if i < 4 then 
            slideDoorObjs[i] = GetClosestObjectOfType(slideDoors[i], 1.0, GetHashKey("ch_prop_ch_vault_slide_door_lrg"), false, false, false)
        else
            slideDoorObjs[i] = GetClosestObjectOfType(slideDoors[i], 1.0, GetHashKey("ch_prop_ch_vault_slide_door_sm"), false, false, false)
        end
    end 

    for i = 1, #layouts[vaultLayout] do 
        local coords = GetEntityCoords(slideDoorObjs[layouts[vaultLayout][i]])

        SetEntityCoords(slideDoorObjs[layouts[vaultLayout][i]], coords + (GetEntityOffset(slideDoorObjs[layouts[vaultLayout][i]], true) * 2), true, false, false, false)
        status[2][layouts[vaultLayout][i]] = true
    end
end

local function GrabLoot(i)
    if loot == 2 or loot == 4 then 
        if status[1][1] == 0.0 then 
            for j = 1, 8 do 
                status[1][j] = 0.5037
            end
        end
    end

    local animTime = status[1][i]
    local grabbing = false
    local quit = false
    local waiting = false
    local animDict = "anim@heists@ornate_bank@grab_cash"
    local bag = "hei_p_m_bag_var22_arm_s"
    local propType = {
        "ch_prop_20dollar_pile_01a",
        "ch_prop_gold_bar_01a",
        "",
        "ch_prop_dimaondbox_01a"
    }
    local lootStrings = {
        "cash",
        "gold",
        "",
        "diamonds"
    }
    
    isBusy = true
    
    local cartCoords = GetEntityCoords(takeObjs[i])
    local cartHeading = GetEntityHeading(takeObjs[i]) / 180 * math.pi
    local camCoords = (1.25 * vector3(math.cos(cartHeading + ((14 / 12) * math.pi)), math.sin(cartHeading + ((14 / 12) * math.pi)), 1.0)) + cartCoords

    LoadAnim(animDict)
    LoadModel(propType[loot])
    LoadModel(bag)
        
    bagObj = CreateObject(GetHashKey(bag), GetEntityCoords(PlayerPedId()), true, false, false)
    boxObj = CreateObject(propType[loot], GetEntityCoords(PlayerPedId()), true, false, false)

    AttachEntityToEntity(boxObj, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
    SetEntityVisible(boxObj, false, false)
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    --AttachCamToEntity(cam, trollyObj, 1.0, 1.0, 1.0, true)
    SetCamCoord(cam, camCoords)
    PointCamAtCoord(cam, cartCoords.xy, cartCoords.z + 0.5)
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 1000, true, false)
    
    y = NetworkCreateSynchronisedScene(cartCoords, GetEntityRotation(takeObjs[i]), 2, true, false, 1.0, animTime, 0.0)
    NetworkAddEntityToSynchronisedScene(takeObjs[i], y, animDict, "cart_cash_dissapear", 1000.0, -4.0, 1)
    ForceEntityAiAndAnimationUpdate(takeObjs[i])
    NetworkStartSynchronisedScene(y)
    
    x = NetworkCreateSynchronisedScene(cartCoords, GetEntityRotation(takeObjs[i]), 2, true, false, 1.0, 0.0, 1.0)
    NetworkAddEntityToSynchronisedScene(bagObj, x, animDict, "bag_intro", 1000.0, -1000.0, 0)
    ForceEntityAiAndAnimationUpdate(bagObj)
    NetworkAddPedToSynchronisedScene(PlayerPedId(), x, animDict, "intro", 1.5, -8.0, 13, 16, 1.5, 0)
    ForcePedAiAndAnimationUpdate(PlayerPedId(), false, true)
    NetworkStartSynchronisedScene(x)
    
    Wait(2000)
    
    z = NetworkCreateSynchronisedScene(cartCoords, GetEntityRotation(takeObjs[i]), 2, false, true, 1.0, 0.0, 1.0)
    NetworkAddEntityToSynchronisedScene(bagObj, z, animDict, "bag_grab_idle", 1000.0, -1000.0, 0)
    ForceEntityAiAndAnimationUpdate(bagObj)
    NetworkAddPedToSynchronisedScene(PlayerPedId(), z, animDict, "grab_idle", 2.0, -8.0, 13, 16, 1000.0, 0)
    ForcePedAiAndAnimationUpdate(PlayerPedId(), false, true)
    NetworkStartSynchronisedScene(z)
    
    Wait(1000)
    
    CreateThread(function()
        while animTime < 1.0 and not quit do 
            Wait(5)
            HelpMsg("Repeatedly tap ~INPUT_CURSOR_ACCEPT~ to quickly grab the \n" .. lootStrings[loot] .. ". Press ~INPUT_CURSOR_CANCEL~ to stop grabbing the \n" .. lootStrings[loot] .. ".")
        end
    end)
    
    while animTime < 1.0 do 
        Wait(10)

        if IsControlPressed(0, 237) and not grabbing then 
            waiting = false
            grabbing = true
            
            a = NetworkCreateSynchronisedScene(cartCoords, GetEntityRotation(takeObjs[i]), 2, true, false, 1.0, animTime, 1.0)
            NetworkAddEntityToSynchronisedScene(bagObj, a, animDict, "bag_grab", 1000.0, -1000.0, 0)
            ForceEntityAiAndAnimationUpdate(bagObj)
            NetworkAddPedToSynchronisedScene(PlayerPedId(), a, animDict, "grab", 4.0, -4.0, 13, 16, 1000.0, 0)
            NetworkAddEntityToSynchronisedScene(takeObjs[i], a, animDict, "cart_cash_dissapear", 1000.0, -4.0, 1)
            ForceEntityAiAndAnimationUpdate(takeObjs[i])
            NetworkStartSynchronisedScene(a)
            
            while not HasAnimEventFired(PlayerPedId(), GetHashKey("CASH_APPEAR")) do 
                Wait(1)
            end
            
            SetEntityVisible(boxObj, true, false)            
            
            while not HasAnimEventFired(PlayerPedId(), GetHashKey("RELEASE_CASH_DESTROY")) do 
                Wait(1)
            end
            
            SetEntityVisible(boxObj, false, false)            
            
            Wait(100)

            SetSynchronizedSceneRate(NetworkGetLocalSceneFromNetworkId(a), 0)
            animTime = GetSynchronizedScenePhase(NetworkGetLocalSceneFromNetworkId(a))
            
            grabbing = false
        elseif IsControlPressed(0, 238) then 
            waiting = false
            quit = true
            break
        elseif not waiting then 
            waiting = true 
            y = NetworkCreateSynchronisedScene(cartCoords, GetEntityRotation(takeObjs[i]), 2, true, false, 1.0, animTime, 0.0)
            NetworkAddEntityToSynchronisedScene(takeObjs[i], y, animDict, "cart_cash_dissapear", 1000.0, -4.0, 1)
            ForceEntityAiAndAnimationUpdate(takeObjs[i])
            NetworkStartSynchronisedScene(y)
            
            z = NetworkCreateSynchronisedScene(cartCoords, GetEntityRotation(takeObjs[i]), 2, false, true, 1.0, 0.0, 1.0)
            NetworkAddEntityToSynchronisedScene(bagObj, z, animDict, "bag_grab_idle", 1000.0, -1000.0, 0)
            ForceEntityAiAndAnimationUpdate(bagObj)
            NetworkAddPedToSynchronisedScene(PlayerPedId(), z, animDict, "grab_idle", 2.0, -8.0, 13, 16, 1000.0, 0)
            ForcePedAiAndAnimationUpdate(PlayerPedId(), false, true)
            NetworkStartSynchronisedScene(z)
        end
    end 

    y = NetworkCreateSynchronisedScene(cartCoords, GetEntityRotation(takeObjs[i]), 2, true, false, 1.0, animTime, 0.0)
    NetworkAddEntityToSynchronisedScene(takeObjs[i], y, animDict, "cart_cash_dissapear", 1000.0, -4.0, 1)
    ForceEntityAiAndAnimationUpdate(takeObjs[i])
    NetworkStartSynchronisedScene(y)


    exit = NetworkCreateSynchronisedScene(cartCoords, GetEntityRotation(takeObjs[i]), 2, true, false, 1.0, 0.0, 1.0)
    NetworkAddEntityToSynchronisedScene(bagObj, exit, animDict, "bag_exit", 1000.0, -1000.0, 0)
    ForceEntityAiAndAnimationUpdate(bagObj)
    NetworkAddPedToSynchronisedScene(PlayerPedId(), exit, animDict, "exit", 4.0, -1.5, 13, 16, 1000.0, 0)
    ForcePedAiAndAnimationUpdate(PlayerPedId(), false, true)
    NetworkStartSynchronisedScene(exit)
    RenderScriptCams(false, true, 2000, true, false)
    TriggerServerEvent("sv:casinoheist:syncLStatus", i, animTime)

    Wait(1000)

    DeleteEntity(bagObj)
    DeleteEntity(boxObj)
    DestroyCam(cam)

    isBusy = false
end

local function CutPainting(j)
    local animDict = "anim_heist@hs3f@ig11_steal_painting@male@"
    local blade = "w_me_switchblade"
    local bag = "hei_p_m_bag_var22_arm_s"
    local x = 2
    local quit = false
    local txt = {
        [2] = "~INPUT_MOVE_RIGHT_ONLY~ to cut right.",
        [4] = "~INPUT_MOVE_DOWN_ONLY~ to cut down.",
        [6] = "~INPUT_MOVE_LEFT_ONLY~ to cut left.",
        [8] = "~INPUT_MOVE_DOWN_ONLY~ to cut down."
    }
    local keys = { [2] = 35, [4] =  33, [6] = 34, [8] = 33}

    isBusy = true
    
    LoadAnim(animDict)
    LoadModel(blade)
    LoadModel(bag)
    
    bladeObj = CreateObject(GetHashKey(blade), GetEntityCoords(PlayerPedId()), true, false, false)
    bagObj = CreateObject(GetHashKey(bag), GetEntityCoords(PlayerPedId()), true, false, false)

    for i = 1, #paintingAnims[1] do 
        if i == 2 or i == 4 or i == 6 or i == 8 then 
            paintingAnims[2][i] = NetworkCreateSynchronisedScene(GetEntityCoords(takeObjs[j]), GetEntityRotation(takeObjs[j]), 2, false, true, 0, 0.0, 1.0)
            NetworkAddPedToSynchronisedScene(PlayerPedId(), paintingAnims[2][i], animDict, paintingAnims[1][i][1], 4.0, -1.5, 13, 16, 1000.0, 0)
            NetworkAddEntityToSynchronisedScene(bladeObj, paintingAnims[2][i], animDict, paintingAnims[1][i][2], 1000.0, -1000.0, 0)
            NetworkAddEntityToSynchronisedScene(paintingObjs[j], paintingAnims[2][i], animDict, paintingAnims[1][i][3], 1000.0, -1000.0, 0)
            NetworkAddEntityToSynchronisedScene(bagObj, paintingAnims[2][i], animDict, paintingAnims[1][i][4], 1000.0, -1000.0, 0)
        else 
            paintingAnims[2][i] = NetworkCreateSynchronisedScene(GetEntityCoords(takeObjs[j]), GetEntityRotation(takeObjs[j]), 2, true, false, 0, 0.0, 1.0)
            NetworkAddPedToSynchronisedScene(PlayerPedId(), paintingAnims[2][i], animDict, paintingAnims[1][i][1], 4.0, -1.5, 13, 16, 1000.0, 0)
            NetworkAddEntityToSynchronisedScene(bladeObj, paintingAnims[2][i], animDict, paintingAnims[1][i][2], 1000.0, -1000.0, 0)
            NetworkAddEntityToSynchronisedScene(paintingObjs[j], paintingAnims[2][i], animDict, paintingAnims[1][i][3], 1000.0, -1000.0, 0)
            NetworkAddEntityToSynchronisedScene(bagObj, paintingAnims[2][i], animDict, paintingAnims[1][i][4], 1000.0, -1000.0, 0)
        end
    end

    NetworkStartSynchronisedScene(paintingAnims[2][1])
    Wait(2000)
    NetworkStartSynchronisedScene(paintingAnims[2][2])

    while x < 10 or not quit do 
        Wait(10)

        HelpMsg(txt[x])
        if IsControlPressed(0, keys[x]) then 
            NetworkStartSynchronisedScene(paintingAnims[2][x])
            x = x + 1
            Wait(GetAnimDuration(animDict, paintingAnims[1][x][1]) * 1000)
            NetworkStartSynchronisedScene(paintingAnims[2][x])
            x = x + 1
            print(x)
        end
    end

    --Wait(3000)
    --NetworkStartSynchronisedScene(paintingAnims[2][4])
    --Wait(2000)
    --NetworkStartSynchronisedScene(paintingAnims[2][5])
    --Wait(2500)
    --NetworkStartSynchronisedScene(paintingAnims[2][6])
    --Wait(2000)
    --NetworkStartSynchronisedScene(paintingAnims[2][7])
    --Wait(2000)
    --NetworkStartSynchronisedScene(paintingAnims[2][8])
    --Wait(2400)
    --NetworkStartSynchronisedScene(paintingAnims[2][9])
    --Wait(3000)
--
--
    --NetworkStartSynchronisedScene(paintingAnims[2][10])
    --Wait(6000)
    --ClearPedTasks(PlayerPedId())

    DeleteEntity(bagObj)
    DeleteEntity(bladeObj)
    isBusy = false
end

local function OpenSlideDoors(size, num, hash)
    if not IsDoorRegisteredWithSystem(GetHashKey("WHOUSE_DOOR_RANCHO_" .. tostring(num) .. size)) then
        AddDoorToSystem(GetHashKey("WHOUSE_DOOR_RANCHO_" .. tostring(num) .. size), GetHashKey(hash), slideDoors[num], false, false, false)
    end
    
    DoorSystemSetDoorState(GetHashKey("WHOUSE_DOOR_RANCHO_" .. tostring(num) .. size), 0, false, false)
    
    Wait(4000)
    
    RemoveDoorFromSystem(GetHashKey("WHOUSE_DOOR_RANCHO_" .. tostring(num) .. size))
    FreezeEntityPosition(slideDoorObjs[num], true)
end

function Vault()
    loot = 3
    vaultLayout = 1
    cartLayout = 1
    player = 1--GetCurrentHeistPlayer() -- 1 

    

    --local lootObj = {}
    local txt = {
        "Press ~INPUT_CONTEXT~ to begin grabbing the cash.",
        "Press ~INPUT_CONTEXT~ to begin grabbing the gold.",
        "Press ~INPUT_CONTEXT~ to cut the paintings.",
        "Press ~INPUT_CONTEXT~ to begin grabbing the diamonds."
    }
    
    SetVaultLayout()

    if player == 1 then 
        SetVaultObjs()
    else 
        Wait(100)
        GetVaultObjs()
    end

    LoadTexture("timerbars")

    DrawTimer()

    if not showTake then 
        DrawTake()
    end

    if loot == 3 then 
        CreateThread(function()
            while true do 
                Wait(5)

                if not isBusy then 
                    for k, v in pairs(artCabinets) do 
                        if status[1][k] < 1.0 then 
                            local distance = #(GetEntityCoords(PlayerPedId()) - v.xyz)
                            if distance < 1.2 then 
                                HelpMsg("Press ~INPUT_CONTEXT~ to cut the paintings.")
                                if IsControlPressed(0, 38) then 
                                    CutPainting(k)
                                end
                            end
                        else 
                            Wait(100)
                        end
                    end
                else 
                    Wait(1000)
                end
            end
        end)
    elseif loot == 1 then 
        CreateThread(function()
            while true do 
                Wait(5)
                if not isBusy then
                    for k, v in pairs(carts[cartLayout]) do 
                        if status[1][k] < 1.0 then 
                            local distance = #(GetEntityCoords(PlayerPedId()) - (v.xyz + GetEntityOffset(takeObjs[k], false)))
                            if distance < 1.2 then
                                HelpMsg(txt[loot])
                                if IsControlPressed(0, 38) then 
                                    GrabLoot(k)
                                end
                            end
                        else 
                            Wait(10)
                        end
                    end
                else 
                    Wait(1000)
                end
            end
        end)
    end

    CreateThread(function()
        while true do 
            Wait(5)

            if not isBusy then 
                for k, v in pairs(keypads[3]) do
                    if not status[2][k] then 
                        local distance = #(GetEntityCoords(PlayerPedId()) - v)
                        if distance < 1.0 then 
                            HelpMsg("Press ~INPUT_CONTEXT~ to hack the keypad")
                            if IsControlPressed(0, 38) then 
                               HackKeypad(3, k, true)
                            end
                        end
                    else 
                        Wait(10)
                    end
                end
            else 
                Wait(1000)
            end
        end
    end)
end

RegisterNetEvent("cl:casinoheist:syncLStatus", function(key, time)
    status[1][key] = time
    RemoveBlip(blips[key])
end)

RegisterNetEvent("cl:casinoheist:syncDStatus", function(num)
    status[2][num] = true
    if num < 4 then 
        OpenSlideDoors("A", num, "ch_prop_ch_vault_slide_door_lrg")
        --SetEntityCoords(slideDoorObjs[num], GetEntityCoords(slideDoorObjs[num]) + (2 * GetEntityOffset(slideDoorObjs[num], true)), true, false, false, false)
    else 
        OpenSlideDoors("A", num, "ch_prop_ch_vault_slide_door_sm")
        --SetEntityCoords(slideDoorObjs[num], GetEntityCoords(slideDoorObjs[num]) + (1.5 * GetEntityOffset(slideDoorObjs[num], true)), true, false, false, false)
    end    
end)

RegisterNetEvent("test:cl:vault", Vault)

RegisterCommand("test_offset", Vault, false)