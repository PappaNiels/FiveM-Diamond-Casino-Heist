local cartLayout = 0

local slideDoorBigCoords = {
    vector3(2519.962, -226.0072, -71.74234),
    vector3(2533.56, -239.6175, -71.74234),
    vector3(2519.938, -251.0496, -71.74234)
}

local slideDoorSmallCoords = {
    vector3(2514.195, -222.1348, -71.74234),
    vector3(2536.185, -232.2094, -71.74234),
    vector3(2536.184, -244.8697, -71.74234),
    vector3(2514.696, -253.6722, -71.74234)
}

local slideDoorOpenBigCoords = {
    vector3(2517.912, -226.0072, -71.74234),
    vector3(2533.56, -241.6675, -71.74234),
    vector3(2517.888, -251.0496, -71.74234),
}

local slideDoorOpenSmallCoords = {
    vector3(2513.735, -221.0148, -71.74234),  
    vector3(2535.075, -232.6694, -71.74234),  
    vector3(2536.074, -244.4097, -71.74234),  
    vector3(2514.236, -254.7922, -71.74234)  
}

local bigDoorMove = { 
    vector2(-0.0205, 0),
    vector2(0, -0.0205),
    vector2(-0.0205, 0)
}

local smallDoorMove = {
    vector2(-0.0046,  0.0112),
    vector2(-0.0111, -0.0046),
    vector2(-0.0111,  0.0046),
    vector2(-0.0046, -0.0112)
}

local artCabinetCoords = {
    vector3(2507.609, -223.2121, -71.73716),
    vector3(2527.589, -219.2627, -71.73721),
    vector3(2541.379, -237.1996, -71.73713),
    vector3(2534.479, -253.8472, -71.73721),
    vector3(2522.384, -258.904, -71.73721),
    vector3(2502.734, -247.5772, -71.73713)
}

local paintingCoords = {
    vector3(2507.225, -222.7878, -70.56751),
    vector3(2527.759, -218.6664, -70.56751),
    vector3(2541.959, -237.2035, -70.56751),
    vector3(2534.866, -254.2816, -70.56751),
    vector3(2522.428, -259.4458, -70.56751),
    vector3(2502.229, -247.7811, -70.56751)
}

local cutPaintingPos = { 
    vector3(2507.53, -223.11, -71.73),
    vector3(2527.6, -219.1, -71.73), 
    vector3(2541.50, -237.22, -71.73), 
    vector3(2534.6, -253.96, -71.73),
    vector3(2522.4, -259.02, -71.73),
    vector3(2502.61, -247.59, -71.71)
}

local cartLoc = {
    [1] = {
        {vector3(2527.56885, -235.687744, -71.743), 117.08}, -- Cart Type A  A
        {vector3(2523.88159, -245.282669, -71.743), 22.55}, -- Cart Type B  B
        {vector3(2518.748, -237.311966, -71.743), 59.45}, -- Cart Type C  C
        {vector3(2513.519, -225.5228, -71.743), 321.67}, -- Cart Type A  D
        {vector3(2522.04688, -222.246826, -71.743), 172.0}, -- Cart Type B  E
        {vector3(2534.379, -231.07428, -71.743), 319.02},    -- Cart Type C F                                           
        {vector3(2532.42676, -245.743271, -71.743), 222.48}, -- Cart Type A G
        {vector3(2516.40869, -252.185562, -71.743), 0.0}    -- Cart Type B H
    },
    [2] = {
        {vector3(2527.56885, -235.687744, -71.743), 117.08}, -- Cart Type A A
        {vector3(2523.88159, -245.282669, -71.743), 22.55},-- Cart Type B B
        {vector3(2506.02979, -229.8687, -71.743), 325.98},--           C C               
        {vector3(2527.599, -224.06337, -71.743), 245.31},--           A D   
        {vector3(2531.93628, -251.4501, -71.743), 335.88},--           B E 
        {vector3(2528.15063, -249.921661, -71.743), 220.06},--           C F 
        {vector3(2516.40869, -252.185562, -71.743), 0.0},--           A G 
        {vector3(2505.54688, -245.549637, -71.743), 210.65}--           B H 
    }
}

local slideDoorBigName = "ch_prop_ch_vault_slide_door_lrg"
local slideDoorSmallName = "ch_prop_ch_vault_slide_door_sm"
local artCabinetName = "ch_prop_ch_sec_cabinet_02a"

local bigDoor = {}
local smallDoor = {}
local artCabinets = {}
local artBlips = {}
local carts = {}
local cartBlips = {}

local statusBigDoor = {
    false,
    false,
    false
}

local statusSmallDoor = { 
    false,
    false,
    false,
    false
}

local statusArt = {
    false, 
    false,
    false,
    false,
    false, 
    false
}

local statusTrolly = {
    false, 
    false, 
    false, 
    false,  
    false,
    false,
    false,
    false,
}

local vaultLayoutDoorBig = {
    [1] = {2, 3},
    [2] = {1},
    [3] = {2, 3},
    [4] = {1},
    [5] = {2, 3},
    [6] = {nil},
    [7] = {2, 3},
    [8] = {1},
    [9] = {2, 3},
    [10] = {nil}
}

local vaultLayoutDoorSmall = {
    [1] = {2, 4},
    [2] = {2, 4},
    [3] = {1, 2},
    [4] = {2, nil},
    [5] = {1},
    [6] = {1, 2},
    [7] = {1, 2},
    [8] = {3, 4},
    [9] = {2, nil},
    [10] = {2, 4}
}

local hackKeypadAnims = { 
    ["anims"] = {    
        {'action_var_01', 'action_var_01_ch_prop_ch_usb_drive01x', 'action_var_01_prop_phone_ing'},
        {'hack_loop_var_01', 'hack_loop_var_01_ch_prop_ch_usb_drive01x', 'hack_loop_var_01_prop_phone_ing'},
        {'success_react_exit_var_01', 'success_react_exit_var_01_ch_prop_ch_usb_drive01x', 'success_react_exit_var_01_prop_phone_ing'},
        {'fail_react', 'fail_react_ch_prop_ch_usb_drive01x', 'fail_react_prop_phone_ing'},
        {'reattempt', 'reattempt_ch_prop_ch_usb_drive01x', 'reattempt_prop_phone_ing'}
    },
    ["networkScenes"] = {}
} 

local paintingAnims = {
    ["anims"] = {
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
    ["networkScenes"] = {}
}

local cartAnims = {
    ["anims"] = {
        -- Player, Bag, Trolly, Cam
        {"intro", "bag_intro"},
        {"grab", "bag_grab", "cart_cash_dissapear"},
        {"grab_idle", "bag_grab_idle"},
        {"exit", "bag_exit"}
    },
    ["networkScenes"] = {}
}

function AddArtBlips()
    for i = 1, #paintingCoords do 
        artBlips[i] = AddBlipForCoord(paintingCoords[i])
        SetBlipSprite(artBlips[i], 534 + i)
        SetBlipHighDetail(artBlips[i], true)
        SetBlipColour(artBlips[i], 2)
        SetBlipScale(artBlips[i], 0.75)
    end
end

function AddCartBlips()
    for i = 1, #cartLoc[cartLayout] do 
        cartBlips[i] = AddBlipForCoord(cartLoc[cartLayout][i][1])
        SetBlipSprite(cartBlips[i], 534 + i)
        SetBlipHighDetail(cartBlips[i], true)
        SetBlipColour(cartBlips[i], 2)
        SetBlipScale(cartBlips[i], 0.75)
    end
end

local function CartDefine(i)
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

local function PlaceCarts()
    local cartType = {
        {"ch_prop_ch_cash_trolly_01a", "ch_prop_ch_cash_trolly_01b", "ch_prop_ch_cash_trolly_01c"},
        {"nothing"},
        {"ch_prop_gold_trolly_01a", "ch_prop_gold_trolly_01b", "ch_prop_gold_trolly_01c"},
        {"ch_prop_diamond_trolly_01a", "ch_prop_diamond_trolly_01b", "ch_prop_diamond_trolly_01c"} 
    }

    for i = 1, #cartType[loot] do 
        LoadModel(cartType[loot][i])
    end

    
    if vaultLayout < 3 then 
        cartLayout = 1
    else 
        cartLayout = 2
    end

    for i = 1, #cartLoc[cartLayout] do 
        j = CartDefine(i)
        
        carts[i] = CreateObject(GetHashKey(cartType[loot][j]), cartLoc[cartLayout][i][1], true, true, false)
        SetEntityHeading(carts[i], cartLoc[cartLayout][i][2])
        print("i: " .. i)
        print("j: " .. j)
        print("---")
    end
end


local function RemoveCarts()
    for i = 1, #carts do 
        DeleteEntity(carts[i])
    end
end

local function GetVaultDoors()
    for i = 1, #slideDoorBigCoords, 1 do 
        local propB = GetClosestObjectOfType(slideDoorBigCoords[i], 1.0, GetHashKey(slideDoorBigName), false, false, false)
        table.insert(bigDoor, propB)
    end
    
    for i = 1, #slideDoorSmallCoords, 1 do 
        local propS = GetClosestObjectOfType(slideDoorSmallCoords[i], 1.0, GetHashKey(slideDoorSmallName), false, false, false)
        table.insert(smallDoor, propS)
    end
end

local function GetArtCabinets() 
    for i = 1, #artCabinetCoords do 
        table.insert(artCabinets, GetClosestObjectOfType(artCabinetCoords[i], 1.0, GetHashKey(artCabinetName), false, false, false))
    end
end

function SetVaultDoors()
    GetVaultDoors()
    if vaultLayout == 0 then vaultLayout = 1 end
    for i = 1, #vaultLayoutDoorBig[vaultLayout], 1 do 
        SetEntityCoords(bigDoor[vaultLayoutDoorBig[vaultLayout][i]], slideDoorOpenBigCoords[vaultLayoutDoorBig[vaultLayout][i]])
        statusBigDoor[vaultLayoutDoorBig[vaultLayout][i]] = true
    end
    
    for i = 1, #vaultLayoutDoorSmall[vaultLayout], 1 do
        SetEntityCoords(smallDoor[vaultLayoutDoorSmall[vaultLayout][i]], slideDoorOpenSmallCoords[vaultLayoutDoorSmall[vaultLayout][i]])
        statusSmallDoor[vaultLayoutDoorSmall[vaultLayout][i]] = true
    end
end

local function OpenSlideDoors(prop, xTick, yTick)
    
    local coords = GetEntityCoords(prop)
    local x = 0
    repeat 
        x = x + 1
        coords = coords + vector3(xTick, yTick, 0)
        SetEntityCoords(prop, coords)
        Wait(23)
    until x == 100
    
end

local function OpenVaultDoors()
    GetVaultDoors()
    
    for i = 1, #bigDoor, 1 do
        OpenSlideDoors(bigDoor[i], bigDoorMove[i].x, bigDoorMove[i].y)
    end
    
    Wait(5000)
    
    for i = 1, #smallDoor, 1 do
        OpenSlideDoors(smallDoor[i], smallDoorMove[i].x, smallDoorMove[i].y)
    end
    
    Wait(20000)
    
    for i = 1, #bigDoor, 1 do 
        SetEntityCoords(bigDoor[i], slideDoorBigCoords[i])
    end
    
    for i = 1, #smallDoor, 1 do 
        SetEntityCoords(smallDoor[i], slideDoorSmallCoords[i])
    end
end

local function HackKeypad(num)
    local animDict = "anim_heist@hs3f@ig1_hack_keypad@arcade@male@"
    local hackDevice = "ch_prop_ch_usb_drive01x"
    local phoneDevice = "prop_phone_ing"

    LoadAnim(animDict)
    LoadModel(hackDevice)
    LoadModel(phoneDevice)

    keypad = GetClosestObjectOfType(keypads["lvlThreeKeypad"][num], 1.0, GetHashKey("ch_prop_fingerprint_scanner_01c"), false, false, false)
    hackUsb = CreateObject(GetHashKey(hackDevice), GetEntityCoords(PlayerPedId()), true, true, false)
    phone = CreateObject(GetHashKey(phoneDevice), GetEntityCoords(PlayerPedId()), true, true, false)
    
    for i = 1, #hackKeypadAnims["anims"], 1 do 
        hackKeypadAnims["networkScenes"][i] = NetworkCreateSynchronisedScene(GetEntityCoords(keypad), GetEntityRotation(keypad), 2, true, false, 1065353216, 0, 1.3) 
        NetworkAddPedToSynchronisedScene(PlayerPedId(), hackKeypadAnims["networkScenes"][i], animDict, hackKeypadAnims["anims"][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
        NetworkAddEntityToSynchronisedScene(hackUsb, hackKeypadAnims["networkScenes"][i], animDict, hackKeypadAnims["anims"][i][2], 1.0, -1.0, 1148846080)
        NetworkAddEntityToSynchronisedScene(phone, hackKeypadAnims["networkScenes"][i], animDict, hackKeypadAnims["anims"][i][3], 1.0, -1.0, 1148846080)
    end
    
    NetworkStartSynchronisedScene(hackKeypadAnims["networkScenes"][1])
    Wait(4000)
    NetworkStartSynchronisedScene(hackKeypadAnims["networkScenes"][2])
    Wait(2000)
    Wait(3000)
    NetworkStartSynchronisedScene(hackKeypadAnims["networkScenes"][3])
    Wait(4000)
    DeleteObject(hackUsb)
    DeleteObject(phone)
end

local function CutPainting(num)
    local knife = "w_me_switchblade"
    local bag = "hei_p_m_bag_var22_arm_s"
    local animDict = "anim_heist@hs3f@ig11_steal_painting@male@"
    local painting = "ch_prop_vault_painting_01a"

    local paintingNum = {
        "ch_prop_vault_painting_01a",
        "ch_prop_vault_painting_01d",
        "ch_prop_vault_painting_01f",
        "ch_prop_vault_painting_01g",
        "ch_prop_vault_painting_01h",
        "ch_prop_vault_painting_01i"
    }

    LoadModel(knife)
    LoadModel(bag)
    LoadAnim(animDict)
    
    knifeObj = CreateObject(GetHashKey(knife), GetEntityCoords(PlayerPedId()), true, true, false)
    paintingObj = GetClosestObjectOfType(paintingCoords[num], 1.0, GetHashKey(paintingNum[num]), false, false, false)
    bagObj = CreateObject(GetHashKey(bag), GetEntityCoords(PlayerPedId()), true, true, false)
    
    for i = 1, #paintingAnims["anims"] do 
        paintingAnims["networkScenes"][i] = NetworkCreateSynchronisedScene(cutPaintingPos[num], GetEntityRotation(paintingObj), 2, true, false, 1065353216, 0, 1065353216)
        NetworkAddPedToSynchronisedScene(PlayerPedId(), paintingAnims["networkScenes"][i], animDict, paintingAnims["anims"][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
        NetworkAddEntityToSynchronisedScene(knifeObj, paintingAnims["networkScenes"][i], animDict, paintingAnims["anims"][i][2], 1.0, -1.0, 1148846080)
        NetworkAddEntityToSynchronisedScene(bagObj, paintingAnims["networkScenes"][i], animDict, paintingAnims["anims"][i][4], 1.0, -1.0, 1148846080)
    end
    
    cam = CreateCam("DEFAULT_ANIMATED_CAMERA", true)
    SetCamActive(cam, true)
    RenderScriptCams(true, 1, 1000, true, false)
    
    PlayCamAnim(cam, paintingAnims["anims"][2][6], animDict, cutPaintingPos[num], GetEntityRotation(paintingObj), false, 2)
    NetworkStartSynchronisedScene(paintingAnims["networkScenes"][1])
    PlayEntityAnim(paintingObj, paintingAnims["anims"][1][3], animDict, 1.0, false, true, true, 0.0, 0x4000)
    Wait(3000)
    PlayCamAnim(cam, paintingAnims["anims"][2][6], animDict, cutPaintingPos[num], GetEntityRotation(paintingObj), false, 2)
    PlayEntityAnim(paintingObj, paintingAnims["anims"][2][3], animDict, 1.0, false, true, true, 0.0, 0x4000)
    NetworkStartSynchronisedScene(paintingAnims["networkScenes"][2])
    local one = true 
    while one do 
        HelpMsg("~INPUT_MOVE_RIGHT_ONLY~ to cut right \n Press ~INPUT_FRONTEND_PAUSE_ALTERNATE~ to exit.")
        if IsControlPressed(0, 35) then 
            one = false 
        else 
            Wait(10)
        end
    end
    PlayCamAnim(cam, paintingAnims["anims"][3][6], animDict, cutPaintingPos[num], GetEntityRotation(paintingObj), false, 2)
    PlayEntityAnim(paintingObj, paintingAnims["anims"][3][3], animDict, 1.0, false, true, true, 0.0, 0x4000)
    NetworkStartSynchronisedScene(paintingAnims["networkScenes"][3])
    Wait(3000)
    PlayCamAnim(cam, paintingAnims["anims"][4][6], animDict, cutPaintingPos[num], GetEntityRotation(paintingObj), false, 2)
    PlayEntityAnim(paintingObj, paintingAnims["anims"][4][3], animDict, 1.0, false, true, true, 0.0, 0x4000)
    NetworkStartSynchronisedScene(paintingAnims["networkScenes"][4])
    local two = true 
    while two do 
        HelpMsg("~INPUT_MOVE_DOWN_ONLY~ to cut down \n Press ~INPUT_FRONTEND_PAUSE_ALTERNATE~ to exit.")
        if IsControlPressed(0, 33) then 
            two = false 
        else 
            Wait(10)
        end
    end
    PlayCamAnim(cam, paintingAnims["anims"][5][6], animDict, cutPaintingPos[num], GetEntityRotation(paintingObj), false, 2)
    PlayEntityAnim(paintingObj, paintingAnims["anims"][5][3], animDict, 1.0, false, true, true, 0.0, 0x4000)
    NetworkStartSynchronisedScene(paintingAnims["networkScenes"][5])
    Wait(3000)
    PlayCamAnim(cam, paintingAnims["anims"][6][6], animDict, cutPaintingPos[num], GetEntityRotation(paintingObj), false, 2)
    PlayEntityAnim(paintingObj, paintingAnims["anims"][6][3], animDict, 1.0, false, true, true, 0.0, 0x4000)
    NetworkStartSynchronisedScene(paintingAnims["networkScenes"][6])
    local three = true 
    while three do 
        HelpMsg("~INPUT_MOVE_LEFT_ONLY~ to cut left \n Press ~INPUT_FRONTEND_PAUSE_ALTERNATE~ to exit.")
        if IsControlPressed(0, 34) then 
            three = false 
        else 
            Wait(10)
        end
    end
    PlayCamAnim(cam, paintingAnims["anims"][7][6], animDict, cutPaintingPos[num], GetEntityRotation(paintingObj), false, 2)
    PlayEntityAnim(paintingObj, paintingAnims["anims"][7][3], animDict, 1.0, false, true, true, 0.0, 0x4000)
    NetworkStartSynchronisedScene(paintingAnims["networkScenes"][7])
    Wait(3000)
    local four = true 
    while four do 
        HelpMsg("~INPUT_MOVE_DOWN_ONLY~ to cut down \n Press ~INPUT_FRONTEND_PAUSE_ALTERNATE~ to exit.")
        if IsControlPressed(0, 33) then 
            four = false 
        else 
            Wait(10)
        end
    end
    PlayCamAnim(cam, paintingAnims["anims"][9][6], animDict, cutPaintingPos[num], GetEntityRotation(paintingObj), false, 2)
    PlayEntityAnim(paintingObj, paintingAnims["anims"][9][3], animDict, 1.0, false, true, true, 0.0, 0x4000)
    NetworkStartSynchronisedScene(paintingAnims["networkScenes"][9])
    Wait(2000)
    PlayCamAnim(cam, paintingAnims["anims"][10][6], animDict, cutPaintingPos[num], GetEntityRotation(paintingObj), false, 2)
    PlayEntityAnim(paintingObj, paintingAnims["anims"][10][3], animDict, 1.0, false, true, true, 0.0, 0x4000)
    NetworkStartSynchronisedScene(paintingAnims["networkScenes"][10])
    Wait(1000)
    RenderScriptCams(0, 0, 1000.0, false, false)
    Wait(7000)
    
    DeleteEntity(knifeObj)
    DeleteEntity(bagObj)
    RemoveBlip(artBlips[num])
end

local function GrabTrollyLoot(num)
    local animDict = "anim@heists@ornate_bank@grab_cash"
    local bag = "hei_p_m_bag_var22_arm_s"
    local propType = {
        "ch_prop_20dollar_pile_01a",
        "nothing",
        "ch_prop_gold_bar_01a",
        "ch_prop_dimaondbox_01a"
    }

    local cartType = {
        {"ch_prop_ch_cash_trolly_01a", "ch_prop_ch_cash_trolly_01b", "ch_prop_ch_cash_trolly_01c"},
        {"nothing"},
        {"ch_prop_gold_trolly_01a", "ch_prop_gold_trolly_01b", "ch_prop_gold_trolly_01c"},
        {"ch_prop_diamond_trolly_01a", "ch_prop_diamond_trolly_01b", "ch_prop_diamond_trolly_01c"} 
    }
    
    j = CartDefine(num)
    
    LoadAnim(animDict)
    LoadModel(propType[loot])
    LoadModel(bag)

    trollyObj = GetClosestObjectOfType(cartLoc[cartLayout][num][1], 1.0, GetHashKey(cartType[loot][j]), false, false, false)
    bagObj = CreateObject(GetHashKey(bag), GetEntityCoords(PlayerPedId()), true, false, false)
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    AttachCamToEntity(cam, trollyObj, 1.0, 1.0, 1.0, true)
    PointCamAtEntity(cam, PlayerPedId(), 0, 0, 0, true)
    SetCamActive(cam, true)
    
    for i = 1, #cartAnims["anims"] do 
        cartAnims["networkScenes"][i] = NetworkCreateSynchronisedScene(GetEntityCoords(trollyObj), GetEntityRotation(trollyObj), 2, true, false, 1065353216, 0, 1.3)
        NetworkAddPedToSynchronisedScene(PlayerPedId(), cartAnims["networkScenes"][i], animDict, cartAnims["anims"][i][1], 4.0, -4.0, 1, 16, 1148846080, 0)
        NetworkAddEntityToSynchronisedScene(bagObj, cartAnims["networkScenes"][i], animDict, cartAnims["anims"][i][2], 1.0, -1.0, 1148846080) 
        
        if i == 2 then 
            NetworkAddEntityToSynchronisedScene(trollyObj, cartAnims["networkScenes"][2], animDict, cartAnims["anims"][2][3], 1.0, -1.0, 1148846080)
        end
    end
    
    RenderScriptCams(true, true, 1000.0, true, false)
    NetworkStartSynchronisedScene(cartAnims["networkScenes"][1])
    Wait(2000)

    boxObj = CreateObject(propType[loot], GetEntityCoords(PlayerPedId()), true, false, false)

    FreezeEntityPosition(boxObj, true)
    SetEntityInvincible(boxObj, true)
    SetEntityNoCollisionEntity(boxObj, PlayerPedId())
    SetEntityVisible(boxObj, false, false)
    AttachEntityToEntity(boxObj, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
    local startedGrabbing = GetGameTimer()
    
    NetworkStartSynchronisedScene(cartAnims["networkScenes"][2])

    while GetGameTimer() - startedGrabbing < 37000 do
        Wait(5)
        DisableControlAction(0, 73, true)
        if HasAnimEventFired(PlayerPedId(), GetHashKey("CASH_APPEAR")) then
            if not IsEntityVisible(boxObj) then
                SetEntityVisible(boxObj, true, false)
            end
        end
        if HasAnimEventFired(PlayerPedId(), GetHashKey("RELEASE_CASH_DESTROY")) then
            if IsEntityVisible(boxObj) then
                SetEntityVisible(boxObj, false, false)
            end
        end
    end
    DeleteObject(boxObj)
    NetworkStartSynchronisedScene(cartAnims["networkScenes"][4])
    RenderScriptCams(false, false, 1000.0, true, false)
    Wait(1600)
    ClearPedTasks(PlayerPedId())
    DeleteEntity(bagObj)
    RemoveBlip(cartBlips[num])
end

CreateThread(function()
    while true do 
        Wait(0)
        if isInVault then 
            for i = 1, #keypads["lvlThreeKeypad"] do 
                local distance = #(GetEntityCoords(PlayerPedId()) - keypads["lvlThreeKeypad"][i])
                if distance < 1.5 then 
                    if i > 3 then 
                        local x = i - 3
                        if not statusSmallDoor[x] then  
                            HelpMsg("Press ~INPUT_CONTEXT~ to hack the keypad", 1000)
                            if IsControlPressed(0, 38) then
                                HackKeypad(i)
                                OpenSlideDoors(smallDoor[x], smallDoorMove[x].x, smallDoorMove[x].y)
                                statusSmallDoor[x] = true
                            else 
                                Wait(10)
                            end
                        end
                    else
                        if not statusBigDoor[i] then 
                            HelpMsg("Press ~INPUT_CONTEXT~ to hack the keypad", 1000)
                            if IsControlPressed(0, 38) then
                                HackKeypad(i)
                                OpenSlideDoors(bigDoor[i], bigDoorMove[i].x, bigDoorMove[i].y)
                                statusBigDoor[i] = true
                            else 
                                Wait(10)
                            end
                        end
                    end
                
                end
            end
            
        else 
            Wait(10000)
        end
    end
end)

CreateThread(function()
    while true do 
        Wait(0)
        if isInVault and loot == 2 then 
            for i = 1, #paintingCoords do 
                local distance = #(GetEntityCoords(PlayerPedId()) - paintingCoords[i])
                if distance < 2 and not statusArt[i] then 
                    HelpMsg("Press ~INPUT_CONTEXT~ to cut the painting.", 1000)
                    if IsControlPressed(0, 38) then 
                        print("catched e")
                        CutPainting(i)
                        statusArt[i] = true
                    else 
                        Wait(5)
                    end
                else 
                    Wait(7)
                end
            end
        else 
            Wait(5000)
        end
    end
end)

CreateThread(function()
    while true do 
        Wait(0)
        if isInVault and loot ~= 2 then 
            for i = 1, #cartLoc[cartLayout] do 
                local distance = #(GetEntityCoords(PlayerPedId()) - cartLoc[cartLayout][i][1])
                if distance < 1.5 and not statusTrolly[i] then 
                    HelpMsg("Press ~INPUT_CONTEXT~ to start " .. i, 1000)
                    if IsControlPressed(0, 38) then 
                        print("test: " .. i)
                        GrabTrollyLoot(i)
                        statusTrolly[i] = true
                    else 
                        Wait(5)
                    end
                else 
                    Wait(5)
                end
            end
        else 
            Wait(5000)
        end
    end
end)

RegisterCommand("vl_dist_paint", function()
    isInVault, loot = true, 2
end, false)

RegisterCommand("vl_dist_end", function()
    isInVault, loot = false, 0
end, false)

RegisterCommand("test_loop", function()
    print(TriggerServerEvent("test:sv:casinoheist:openvaultdoors"))
    
end)

RegisterNetEvent("test:cl:casinoheist:openvaultdoors")
AddEventHandler("test:cl:casinoheist:openvaultdoors", function()
    OpenVaultDoors()
end)


RegisterCommand("vl_testloop", function()
    isInVault = true
end)

RegisterCommand("vl_bdoor", function()
    print("command")
    SetLayout()
    Wait(100)
    SetVaultDoors()
    print(vaultLayout.. "vl")
    print("-----")
    for i = 1, #statusBigDoor, 1 do
       print(statusBigDoor[i]) 
    end
    print("-----")
    for i = 1, #statusSmallDoor, 1 do
       print(statusSmallDoor[i]) 
    end
    isInVault = true
end, false)

RegisterCommand("vl_dist", function()
    SetVaultDoors()
    isInVault, loot = true, 2
end, false)

RegisterCommand("vl_painting", function(source, args)
    CutPainting(tonumber(args[1]))
end, false)

RegisterCommand("vl_placecarts", function(src, args)
    loot = tonumber(args[1])
    vaultLayout = tonumber(args[2])
    PlaceCarts()
    AddCartBlips()
    isInVault = true 
end, false)

RegisterCommand("vl_removecarts", function()
    RemoveCarts()
end, false)