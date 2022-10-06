local keycardObj = 0
local blip = 0
local keycardScene = 0
local lvlFour = 0
local cartLayout = 0
local vaultLayout = 0

local isSwiping = false
local timerStarted = false
local plantBombs = false
local leftBombs = false                        
local rightBombs = false                        

local vaultObjs = {}
local bombObjs = {}
local takeObjs = {}
local paintingObjs = {}
local slideDoorObjs = {}
local blips = {}
local keycardSyncAnims = {
    {
        {
            {"ped_a_enter", "ped_a_enter_keycard"},
            {"ped_a_enter_loop", "ped_a_enter_loop_keycard"},
            {"ped_a_intro_b", "ped_a_intro_b_keycard"},
            {"ped_a_loop", "ped_a_loop_keycard"},
            {"ped_a_pass", "ped_a_pass_keycard"},
            {"ped_a_fail_a", "ped_a_fail_a_keycard"}, 
            {"ped_a_fail_b", "ped_a_fail_b_keycard"}, 
            {"ped_a_fail_c", "ped_a_fail_c_keycard"} 
        },
        { 
            {"ped_b_enter", "ped_b_enter_keycard"},
            {"ped_b_enter_loop", "ped_b_enter_loop_keycard"},
            {"ped_b_intro_b", "ped_b_intro_b_keycard"},
            {"ped_b_loop", "ped_b_loop_keycard"},
            {"ped_b_pass", "ped_b_pass_keycard"},
            {"ped_b_fail_a", "ped_b_fail_a_keycard"}, 
            {"ped_b_fail_b", "ped_b_fail_b_keycard"}, 
            {"ped_b_fail_c", "ped_b_fail_c_keycard"}
        }
    },
    {}
}

local hackKeypadAnims = { 
    {    
        {"action_var_01", "action_var_01_ch_prop_ch_usb_drive01x", "action_var_01_prop_phone_ing"},
        {"hack_loop_var_01", "hack_loop_var_01_ch_prop_ch_usb_drive01x", "hack_loop_var_01_prop_phone_ing"},
        {"success_react_exit_var_01", "success_react_exit_var_01_ch_prop_ch_usb_drive01x", "success_react_exit_var_01_prop_phone_ing"},
        {"fail_react", "fail_react_ch_prop_ch_usb_drive01x", "fail_react_prop_phone_ing"},
        {"reattempt", "reattempt_ch_prop_ch_usb_drive01x", "reattempt_prop_phone_ing"}
    },
    {}
} 

local bombAnims = {
    {
        {
            {"player_ig8_vault_explosive_enter",    "semtex_a_ig8_vault_explosive_enter",   "semtex_b_ig8_vault_explosive_enter",   "bag_ig8_vault_explosive_enter",    "cam_ig8_vault_explosive_enter"},
            {"player_ig8_vault_explosive_idle",     "semtex_a_ig8_vault_explosive_idle",    "semtex_b_ig8_vault_explosive_idle",    "bag_ig8_vault_explosive_idle",     "cam_ig8_vault_explosive_idle"},
            {"player_ig8_vault_explosive_plant_a",  "semtex_a_ig8_vault_explosive_plant_a", "semtex_b_ig8_vault_explosive_plant_a", "bag_ig8_vault_explosive_plant_a",  "cam_ig8_vault_explosive_plant_a"},
            {"player_ig8_vault_explosive_plant_b",  "semtex_a_ig8_vault_explosive_plant_b", "semtex_b_ig8_vault_explosive_plant_b", "bag_ig8_vault_explosive_plant_b",  "cam_ig8_vault_explosive_plant_b"} 
        },
        { 
            {"player_ig8_vault_explosive_enter",    "semtex_a_ig8_vault_explosive_enter",    "semtex_b_ig8_vault_explosive_enter",   "semtex_c_ig8_vault_explosive_enter",      "bag_ig8_vault_explosive_enter",    "cam_ig8_vault_explosive_enter"},
            {"player_ig8_vault_explosive_idle",     "semtex_a_ig8_vault_explosive_idle",     "semtex_b_ig8_vault_explosive_idle",    "semtex_c_ig8_vault_explosive_idle",       "bag_ig8_vault_explosive_idle",     "cam_ig8_vault_explosive_idle"},
            {"player_ig8_vault_explosive_plant_a",  "semtex_a_ig8_vault_explosive_plant_a",  "semtex_b_ig8_vault_explosive_plant_a", "semtex_c_ig8_vault_explosive_plant_a",    "bag_ig8_vault_explosive_plant_a",  "cam_ig8_vault_explosive_plant_a"},
            {"player_ig8_vault_explosive_plant_b",  "semtex_a_ig8_vault_explosive_plant_b",  "semtex_b_ig8_vault_explosive_plant_b", "semtex_c_ig8_vault_explosive_plant_b",    "bag_ig8_vault_explosive_plant_b",  "cam_ig8_vault_explosive_plant_b"},
            {"player_ig8_vault_explosive_plant_c",  "semtex_a_ig8_vault_explosive_plant_c",  "semtex_b_ig8_vault_explosive_plant_c", "semtex_c_ig8_vault_explosive_plant_c",    "bag_ig8_vault_explosive_plant_c",  "cam_ig8_vault_explosive_plant_c"} 
        }
    },
    {}
}

local drillAnims = { -- Laser: "anim_heist@hs3f@ig9_vault_drill@laser_drill@", "ch_prop_laserdrill_01a" Regular: "anim_heist@hs3f@ig9_vault_drill@drill@", "hei_prop_heist_drill"
    {   -- Ped, Drill, Bag, Cam
        {"intro", "intro_drill_bit", "bag_intro", "intro_cam"},
        {"drill_straight_start", "drill_straight_start_drill_bit", "bag_drill_straight_start", "drill_straight_start_cam"},
        {"drill_straight_idle", "drill_straight_idle_drill_bit", "bag_drill_straight_idle", "drill_straight_idle_cam"},
        {"drill_straight_end", "drill_straight_end_drill_bit", "bag_drill_straight_end", "drill_straight_end_cam"},
        {"drill_straight_end_idle", "drill_straight_end_idle_drill_bit", "bag_drill_straight_end_idle", "drill_straight_end_idle_cam"},
        {"drill_straight_fail", "", "", ""},
        {"exit", "exit_drill_bit", "bag_exit", "exit_cam"}
    },
    {}
}

local cartAnims = {
    {
        -- Player, Bag, Trolly, Cam
        {"intro", "bag_intro"},
        {"grab", "bag_grab", "cart_cash_dissapear"},
        {"grab_idle", "bag_grab_idle"},
        {"exit", "bag_exit"}
    },
    {}
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

local function PlaceCarts()
    if player == 1 then 
        local cartType = {
            {"ch_prop_ch_cash_trolly_01a", "ch_prop_ch_cash_trolly_01b", "ch_prop_ch_cash_trolly_01c"},
            {"ch_prop_gold_trolly_01a", "ch_prop_gold_trolly_01b", "ch_prop_gold_trolly_01c"},
            {"ch_prop_ch_sec_cabinet_02a"},
            {"ch_prop_diamond_trolly_01a", "ch_prop_diamond_trolly_01b", "ch_prop_diamond_trolly_01c"} 
        }

        for i = 1, #cartType[loot] do 
            LoadModel(cartType[loot][i])
        end
        if loot ~= 3 then 
            if vaultLayout < 3 then 
                cartLayout = 1
            else 
                cartLayout = 2
            end

            for i = 1, #cartLoc[cartLayout] do 
                j = CartType(i)

                cartObjs[i] = CreateObject(GetHashKey(cartType[loot][j]), carts[cartLayout][i].x, carts[cartLayout][i].y, carts[cartLayout][i].z, true, true, false)
                SetEntityHeading(cartObjs[i], carts[cartLayout][i].w)
                print("i: " .. i)
                print("j: " .. j)
                print("---")
            end
        end
    end
end

local function PlaceArt()
    LoadModel("ch_prop_ch_sec_cabinet_02a")
    LoadModel("ch_prop_vault_painting_01a")

    for i = 1, #artCabinets do 
        artCabinetObjs[i] = CreateObject(GetHashKey("ch_prop_ch_sec_cabinet_02a"), artCabinets[i].x, artCabinets[i].y, artCabinets[i].z, false, false, false)
        SetEntityHeading(artCabinetObjs[i], artCabinets[i].w)
        paintingObjs[i] = CreateObject(GetHashKey("ch_prop_vault_painting_01a"), paintings[i], false, false, false)
        SetEntityHeading(paintingObjs[i], artCabinets[i].w)
    end
end

local function RemoveAllBlips()
    for i = 1, #blips do 
        RemoveBlip(blips[i])
    end
end

local function RemoveAllBombs()
    for i = 1, #bombObjs do 
        DeleteEntity(bombObjs[i])
    end
end

local function SetDoors(doorHash, objHash, coords, num)
    if not IsDoorRegisteredWithSystem(doorHash) then 
        AddDoorToSystem(doorHash, objHash, coords, false, false, false)
    end 

    if IsDoorRegisteredWithSystem(doorHash) then 
        DoorSystemSetOpenRatio(doorHash, 0.0, false, false)
        DoorSystemSetDoorState(doorHash, num, false, false)
    end
end

local function EnableMantrapDoors(security, vault)
    local doorHash = {1466913421, -2088850773, 1969557112, -1608031236}
    local objHash = {GetHashKey("ch_prop_ch_tunnel_door_01_l"), GetHashKey("ch_prop_ch_tunnel_door_01_r")}
    local coords = {vector3(2464.183, -278.2036, -71.6943), vector3(2464.183, -280.2885, -71.6943), vector3(2492.28, -237.4592, -71.7386), vector3(2492.28, -239.544, -71.7386)}

    SetDoors(doorHash[1], objHash[1], coords[1], security)
    SetDoors(doorHash[2], objHash[2], coords[2], security)
    
    SetDoors(doorHash[3], objHash[1], coords[3], vault)
    SetDoors(doorHash[4], objHash[2], coords[4], vault)
end

local function KeypadOne(level, j)
    local keycard = "ch_prop_vault_key_card_01a"
    local animDict = "anim_heist@hs3f@ig3_cardswipe@male@"
    
    LoadModel(keycard)
    LoadAnim(animDict)
    
    local keypadObj = GetClosestObjectOfType(keypads[level][j], 1.0, GetHashKey("ch_prop_fingerprint_scanner_01b"), false, false, false)
    local keycardObj = CreateObject(GetHashKey(keycard), GetEntityCoords(PlayerPedId()), true, true, false)
    
    keycardScene = NetworkCreateSynchronisedScene(GetEntityCoords(keypadObj), GetEntityRotation(keypadObj), 2, true, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(PlayerPedId(), keycardScene, animDict, "success_var02", 4.0, -4.0, 2000, 0, 1000.0, 0)
    NetworkAddEntityToSynchronisedScene(keycardObj, keycardScene, animDict, "success_var02_card", 1.0, -1.0, 114886080)
    
    NetworkStartSynchronisedScene(keycardScene)
    Wait(3700)
    DeleteObject(keycardObj)
    ClearPedTasks(PlayerPedId())
end

local function HackKeyPad(level, j)
    if level > selectedKeycard and level ~= 4 then 
        local animDict = "anim_heist@hs3f@ig1_hack_keypad@arcade@male@"
        local hackDevice = "ch_prop_ch_usb_drive01x"
        local phoneDevice = "prop_phone_ing"

        LoadAnim(animDict)
        LoadModel(hackDevice)
        LoadModel(phoneDevice)

        local keypad = GetClosestObjectOfType(keypads[level][num], 1.0, GetHashKey("ch_prop_fingerprint_scanner_01c"), false, false, false)
        local hackUsb = CreateObject(GetHashKey(hackDevice), GetEntityCoords(PlayerPedId()), true, true, false)
        local phone = CreateObject(GetHashKey(phoneDevice), GetEntityCoords(PlayerPedId()), true, true, false)
        
        for i = 1, #hackKeypadAnims[1], 1 do 
            hackKeypadAnims[2][i] = NetworkCreateSynchronisedScene(GetEntityCoords(keypad), GetEntityRotation(keypad), 2, true, false, 1065353216, 0, 1.3) 
            NetworkAddPedToSynchronisedScene(PlayerPedId(), hackKeypadAnims[2][i], animDict, hackKeypadAnims[1][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
            NetworkAddEntityToSynchronisedScene(hackUsb, hackKeypadAnims[2][i], animDict, hackKeypadAnims[1][i][2], 1.0, -1.0, 1148846080)
            NetworkAddEntityToSynchronisedScene(phone, hackKeypadAnims[2][i], animDict, hackKeypadAnims[1][i][3], 1.0, -1.0, 1148846080)
        end

        NetworkStartSynchronisedScene(hackKeypadAnims[2][1])
        Wait(4000)
        NetworkStartSynchronisedScene(hackKeypadAnims[2][2])
        Wait(2000)
        -- Hack Minigame
        Wait(3000)
        NetworkStartSynchronisedScene(hackKeypadAnims[2][3])
        Wait(4000)
        DeleteObject(hackUsb)
        DeleteObject(phone)
    else 
        KeypadOne(level, j)
    end
end

local function KeycardReady(num)
    while true do 
        Wait(5)
        
        HelpMsg("Both Players must insert their keycards simultaneously. Press ~INPUT_FRONTEND_RDOWN~ when you are both ready. to back out press ~INPUT_FRONTEND_PAUSE_ALTERNATE~.")
        if IsControlPressed(0, 18) then 
            NetworkStartSynchronisedScene(keycardSyncAnims[2][3])
            Wait(2000)
            NetworkStartSynchronisedScene(keycardSyncAnims[2][4])
            --if not timerStarted then 
            --    SyncKeycardSwipe(num)
            --end
            break 
        elseif IsControlPressed(0, 200) then 
            ClearPedTasks(PlayerPedId())
            DeleteObject(keycardObj)
            isSwiping = false
            lvlFour = 0
            SecurityLobby(false, true)
            break
        else 
            Wait(10)
        end
    end
end

local function SyncKeycardEnter(num)
    local animDict = "anim_heist@hs3f@ig3_cardswipe_insync@male@"
    local keycard = "ch_prop_vault_key_card_01a"

    LoadAnim(animDict)
    
    lvlFour = num

    local keypadObj = GetClosestObjectOfType(keypads[4][num], 1.0, GetHashKey("ch_prop_fingerprint_scanner_01d"), false, false, false)
    keycardObj = CreateObject(GetHashKey(keycard), GetEntityCoords(PlayerPedId()), true, true, false)
    
    for i = 1, #keycardSyncAnims[1][2] do 
        keycardSyncAnims[2][i] = NetworkCreateSynchronisedScene(GetEntityCoords(keypadObj), GetEntityRotation(keypadObj), 2, true, false, 0, 0, 1.3)
        NetworkAddPedToSynchronisedScene(PlayerPedId(), keycardSyncAnims[2][i], animDict, keycardSyncAnims[1][num][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
        NetworkAddEntityToSynchronisedScene(keycardObj, keycardSyncAnims[2][i], animDict, keycardSyncAnims[1][num][i][2], 1.0, -1.0, 114886080)
    end
    
    NetworkStartSynchronisedScene(keycardSyncAnims[2][1])
    Wait(1000)
    NetworkStartSynchronisedScene(keycardSyncAnims[2][2])
    KeycardReady(num)
end

local function SetupVault()
    if selectedEntryDisguise ~= 3 then
        EnableMantrapDoors(0, 0)
    else
        EnableMantrapDoors(0, 1)
    end

    RemoveAllBlips()

    if approach == 1 or (approach == 2 and selectedEntryDisguise ~= 3) then 
        LoadModel("ch_prop_ch_vaultdoor01x")
        vaultObjs[2] = CreateObject(GetHashKey("ch_prop_ch_vaultdoor01x"), regularVaultDoorCoords, false, false, true)
    elseif approach == 3 then 
        LoadModel("ch_des_heist3_vault_01")
        LoadModel("ch_des_heist3_vault_02")
        LoadModel("ch_des_heist3_vault_end")

        vaultObjs[2] = CreateObject(GetHashKey("ch_des_heist3_vault_01"), aggressiveVaultDoorCoords[1], false, false, true)
        vaultObjs[3] = CreateObject(GetHashKey("ch_des_heist3_vault_02"), aggressiveVaultDoorCoords[2], false, false, true)
        vaultObjs[4] = CreateObject(GetHashKey("ch_des_heist3_vault_02"), aggressiveVaultDoorCoords[3], false, false, true)
        
        SetEntityVisible(vaultObjs[3], false, false)
        SetEntityCollision(vaultObjs[3], false, true)
    end
end

local function VaultExplosion()
    local animDict = "anim_heist@hs3f@ig8_vault_door_explosion@"
    local reactAnimDict = ""
    local reactAnimName = "player_react_explosive"
    local ptfx = "cut_hs3f"

    RequestNamedPtfxAsset(ptfx)
    
    if math.random(1, 2) == 1 then 
        reactAnimDict = "anim_heist@hs3f@ig8_vault_explosive_react@left@male@"
    else 
        reactAnimDict = "anim_heist@hs3f@ig8_vault_explosive_react@right@male@"
    end

    LoadAnim(animDict)
    LoadAnim(reactAnimDict)

    RequestMissionAudioBank("dlc_ch_heist_finale_sounds", true)
    RequestScriptAudioBank("dlc_ch_heist_finale_sounds", true)
    RequestAmbientAudioBank("dlc_ch_heist_finale_sounds", true)
    
    Wait(1000)

    RemoveBlip(blips[1])

    SetEntityVisible(vaultObjs[3], false, false)
    SetEntityCollision(vaultObjs[3], false, false)
    
    --Wait(1000)
    CreateThread(function()
        UseParticleFxAsset(ptfx)
        scene = CreateSynchronizedScene(2488.348, -267.364, -71.646, 0.0, 0.0, 0.0, 2)
        PlaySynchronizedEntityAnim(vaultObjs[1], scene, "explosion_vault_01", animDict, 1000.0, 8.0, 0, 1000.0)
        PlaySynchronizedEntityAnim(vaultObjs[2], scene, "explosion_vault_02", animDict, 1000.0, 8.0, 0, 1000.0)
        SetSynchronizedScenePhase(scene, 0.056)
        PlaySoundFromCoord(-1, "vault_door_explosion", 2504.961, -240.3102, -70.07, "dlc_ch_heist_finale_sounds", false, 0, false)
        StartParticleFxNonLoopedAtCoord("cut_hs3f_exp_vault", 2505.0, -238.5, -70.5, 0.0, 0.0, 0.0, 1.0, false, false, false)
        ShakeGameplayCam("LARGE_EXPLOSION_SHAKE", 0.5)
        SetPadShake(0, 130, 256)
        TaskPlayAnim(PlayerPedId(), reactAnimDict, reactAnimName,  8.0, -8.0, -1, 1048576, 0.0, false, false, false)
        RemoveAllBombs()
    end)
    Wait(4000)
    
    SetEntityVisible(vaultObjs[1], true, false)
    SetEntityVisible(vaultObjs[3], true, false)
    SetEntityCollision(vaultObjs[3], true, true)
    DeleteEntity(vaultObjs[1])
    DeleteEntity(vaultObjs[2])
end

local function VaultExplosionSetup()
    blips[1] = AddBlipForRadius(aggressiveAreaBlip)
    SetBlipColour(blips[1], 76)
    SetBlipAlpha(blips[1], 175)
    --if GetResourceState("ifruit-phone") == "stopped" and player == 1 then 
    --    TriggerEvent("cl:ifruit:setBombContact", true, "sv:casinoheist:vaultExplosion", true)
    --else 
        SubtitleMsg("Leave the ~r~blast radius.", 5010)
        Wait(5000)
        VaultExplosion()
    --end
end

local function PlantVaultBombs(num)
    local animDict = ""
    local bag = "hei_p_m_bag_var22_arm_s"
    local bomb = "ch_prop_ch_explosive_01a"
    --local bagColour = GetPedTextureVariation(PlayerPedId(), 5)
    local camNum = 4 + num 
    
    LoadModel(bomb)
    LoadModel(bag)

    plantBombs = true

    if DoesEntityExist(bombObjs[1]) and num == 1 then 
        bombObjs[4] = bombObjs[1]
        bombObjs[5] = bombObjs[2]
    elseif DoesEntityExist(bombObjs[1]) and num == 2 then 
        bombObjs[3] = bombObjs[1]
        bombObjs[4] = bombObjs[2]
        bombObjs[5] = bombObjs[3]
    end

    if num == 2 then 
        animDict = "anim_heist@hs3f@ig8_vault_explosives@right@male@"
        
        for i = 1, 3 do 
            bombObjs[i] = CreateObject(GetHashKey(bomb), GetEntityCoords(PlayerPedId()), true, false, false)
        end
    else   
        animDict = "anim_heist@hs3f@ig8_vault_explosives@left@male@"
        bombObjs[1] = CreateObject(GetHashKey(bomb), GetEntityCoords(PlayerPedId()), true, false, false)
        bombObjs[2] = CreateObject(GetHashKey(bomb), GetEntityCoords(PlayerPedId()), true, false, false)
    end

    LoadAnim(animDict)

    local bagObj = CreateObject(GetHashKey(bag), GetEntityCoords(PlayerPedId()), true, false, false)
    
    for i = 2, 3 do 
        SetEntityVisible(bombObjs[i], false, false)
    end

    for i = 1, #bombAnims[1][num] do 
        bombAnims[2][i] = NetworkCreateSynchronisedScene(2504.97, -240.2, -70.20, 0.0, 0.0, 0.0, 2, true, false, 1065353216, 0.0, 1.3)
        NetworkAddPedToSynchronisedScene(PlayerPedId(), bombAnims[2][i], animDict, bombAnims[1][num][i][1], 4.0, -4.0, 18, 0, 1000.0, 0)
        NetworkAddEntityToSynchronisedScene(bombObjs[1], bombAnims[2][i], animDict, bombAnims[1][num][i][2], 1.0, -1.0, 114886080)
        NetworkAddEntityToSynchronisedScene(bombObjs[2], bombAnims[2][i], animDict, bombAnims[1][num][i][3], 1.0, -1.0, 114886080)
        if num == 2 then 
            NetworkAddEntityToSynchronisedScene(bombObjs[3], bombAnims[2][i], animDict, bombAnims[1][num][i][4], 1.0, -1.0, 114886080)
            NetworkAddEntityToSynchronisedScene(bagObj, bombAnims[2][i], animDict, bombAnims[1][num][i][5], 1.0, -1.0, 114886080)
        else
            NetworkAddEntityToSynchronisedScene(bagObj, bombAnims[2][i], animDict, bombAnims[1][num][i][4], 1.0, -1.0, 114886080)
        end
    end

    NetworkStartSynchronisedScene(bombAnims[2][1])
    Wait(2000)
    NetworkStartSynchronisedScene(bombAnims[2][2])
    
    local x = 0
    local numerics = {"first", "second", "last"}

    while true do 
        Wait(10)
        
        HelpMsg("Press ~INPUT_ATTACK~ to plant the ".. numerics[x + 1] .." explosive")
        if IsControlPressed(0, 24) then 
            NetworkStartSynchronisedScene(bombAnims[2][3 + x])
            FreezeEntityPosition(bombObjs[x + 1])
            SetEntityVisible(bombObjs[x + 2], true, true)

            Wait(2000)
            x = x + 1

            if x == (1 + num) then 
                break
            end

            NetworkStartSynchronisedScene(bombAnims[2][2])
        end
    end

    Wait(1000)
    ClearPedTasks(PlayerPedId())
    DeleteEntity(bagObj)
    plantBombs = false

    if num == 1 then 
        RemoveBlip(blips[1])
        leftBombs = true 
    else 
        RemoveBlip(blips[2])
        rightBombs = true 
    end
end

local function SetVaultObjs()
    if loot == 3 then
        local paintingNames = {
            "ch_prop_vault_painting_01a",
            "ch_prop_vault_painting_01d",
            "ch_prop_vault_painting_01f",
            "ch_prop_vault_painting_01g",
            "ch_prop_vault_painting_01h",
            "ch_prop_vault_painting_01i",
        }
        
        LoadModel("ch_prop_ch_sec_cabinet_02a")

        for i = 1, #paintingNames do 
            LoadModel(paintingNames[i])
        end 

        for i = 1, #artCabinets do 
            takeObjs[i] = CreateObject(GetHashKey("ch_prop_ch_sec_cabinet_02a"), artCabinets[i].x, artCabinets[i].y, artCabinets[i].z, false, false, false)
            SetEntityHeading(artCabinetObjs[i], artCabinets[i].w)
            paintingObjs[i] = CreateObject(GetHashKey(paintingNames[i]), paintings[i], false, false, false)
            SetEntityHeading(paintingObjs[i], artCabinets[i].w)

            blips[i] = AddBlipForEntity(artCabinetObjs[i])
            SetBlipSprite(blips[i], 534 + i)
            SetBlipScale(blips[i], 0.8)
            SetBlipColour(blips[i], 3)
        end

        for i = 1, #paintingNames do 
            SetModelAsNoLongerNeeded(paintingNames[i]) 
        end

        SetModelAsNoLongerNeeded("ch_prop_ch_sec_cabinet_02a") 
    else 
        loot = 1
        cartLayout = 1
        local cartType = {
            {"ch_prop_ch_cash_trolly_01a", "ch_prop_ch_cash_trolly_01b", "ch_prop_ch_cash_trolly_01c"},
            {"ch_prop_gold_trolly_01a", "ch_prop_gold_trolly_01b", "ch_prop_gold_trolly_01c"},
            {},
            {"ch_prop_diamond_trolly_01a", "ch_prop_diamond_trolly_01b", "ch_prop_diamond_trolly_01c"} 
        }
    
        for i = 1, #cartType[loot] do 
            LoadModel(cartType[loot][i])
        end
        
        
        
        for i = 1, #carts[cartLayout] do 
            j = CartType(i)
            
            takeObjs[i] = CreateObject(GetHashKey(cartType[loot][j]), carts[cartLayout][i].x, carts[cartLayout][i].y, carts[cartLayout][i].z, true, true, false)
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

    vaultLayout = 1

    for i = 1, 7 do 
        if i < 4 then 
            slideDoorObjs[i] = GetClosestObjectOfType(slideDoors[i], 1.0, GetHashKey("ch_prop_ch_vault_slide_door_lrg"), false, false, false)
        else
            slideDoorObjs[i] = GetClosestObjectOfType(slideDoors[i], 1.0, GetHashKey("ch_prop_ch_vault_slide_door_sm"), false, false, false)
        end
    end 

    for i = 1, #layouts[vaultLayout] do 
        --print(DoesEntityExist(slideDoorObjs[layouts[vaultLayout][i]]))
        local coords = GetEntityCoords(slideDoorObjs[layouts[vaultLayout][i]])
        local heading = GetEntityHeading(slideDoorObjs[layouts[vaultLayout][i]]) / 180 * math.pi
        local plus = vector3(math.cos(heading), math.sin(heading), 0.0)
        
        SetEntityCoords(slideDoorObjs[layouts[vaultLayout][i]], coords + (plus * 2), true, false, false, false)
    end
end

function RoofTerraceEntry()

    CreateThread(function()
        while true do 
            Wait(0)
            
        end
    end)
end

function HeliPadEntry()

    CreateThread(function()
        while true do 
            Wait(0)
            
        end
    end)
end

function SewerEntry()

end

function TunnelEntry()

end

function MainEntry()
    --if approach == 3 then 
        LoadCutscene("hs3f_dir_ent")
        StartCutscene(0)

        while not DoesCutsceneEntityExist("MP_3") do 
            Wait(10)
        end

        local arr = {}
        if #hPlayer == 2 then 
            arr = {"MP_3", "Player_SMG_3", "Player_Mag_3", "MP_4", "Player_SMG_4", "Player_Mag_4"}
        elseif #hPlayer == 3 then 
            arr = {"MP_4", "Player_SMG_4", "Player_Mag_4"}
        end
        
        if #arr > 0 then 
            for i = 1, #arr do 
                SetEntityVisible(GetEntityIndexOfCutsceneEntity(arr[i], 0), false, false)
            end
        end 
        
        repeat Wait(100) until HasCutsceneFinished()

        Wait(100)

        TaskPutPedDirectlyIntoCover(PlayerPedId(), GetEntityCoords(PlayerPedId(), true), -1, false, false, false, false, false, false)

        blips[1] = AddBlipForCoord(2525.77, -251.71, -60.31)
        SetBlipColour(blips[1], 5) 
        
        player = GetCurrentHeistPlayer()

        CreateThread(function()
            while true do 
                Wait(100)
                local distance = #(GetEntityCoords(PlayerPedId()) - vector3(2525.77, -251.71, -60.31)) 
                
                if distance < 3 then 
                    if IsNotClose(vector3(2525.77, -251.71, -60.31), 3) then
                        SubtitleMsg("Wait for your team members", 110)
                    else 
                        DoScreenFadeOut(500)
                        
                        while not IsScreenFadedOut() do 
                            Wait(0)
                        end
                        
                        SetEntityCoords(PlayerPedId(), casinoToLobby[player])
                        SetEntityHeading(PlayerPedId(), casinoToLobby[player].w)
                        
                        Wait(3000)
                        
                        DoScreenFadeIn(1000)
                        Basement()
                        break
                    end
                else
                    SubtitleMsg("Go to the ~y~staff lobby.", 110)
                end
            end
        end)
        --else
        --CreateThread(function()
        --    while true do 
        --        Wait(0)
        --
        --    end
        --end)
        --end
    end
    
    function Basement()
        RemoveAllBlips()
        local sprite = {63, 743}
        
        for i = 1, 2 do 
            blips[i] = AddBlipForCoord(staffCoords[i])
            SetBlipHighDetail(blips[i], true)
            SetBlipSprite(blips[i], sprite[i])
            SetBlipColour(blips[i], 5)
        end
        
        local num = 1
        local zCoord = -61
        CreateThread(function()
            while true do 
                Wait(100)
                
                SubtitleMsg("Go to the ~y~basement~s~.", 110)
                
            local coords = GetEntityCoords(PlayerPedId())
            if coords.z < zCoord then 
                RemoveBlip(blips[num])

                if num == 1 then
                    zCoord = -67
                    num = 2
                elseif num == 2 then 
                    zCoord = -70
                    num = 3
                else
                    SecurityLobby(true, false) 
                    break
                end
            end
        end
    end)
end
    
function SecurityLobby(blip, old)
    --RemoveAllBlips()
    if blip then 
        for i = 1, 2 do 
            blips[i] = AddBlipForCoord(keypads[4][i])
            SetBlipSprite(blips[i], 733)
            SetBlipColour(blips[i], 2)
            SetBlipHighDetail(blips[i], true)
        end
    end

    local animDict = "anim_heist@hs3f@ig3_cardswipe_insync@male@"
    local animNameOne = keycardSyncAnims[1][1][4][1]
    local animNameTwo = keycardSyncAnims[1][2][4][1]
    local swiped = false
    local sync = false
    local x = 0

    CreateThread(function()
        while true do 
            Wait(5)

            if not isSwiping then 
                SubtitleMsg("Go to one of the ~g~keypads~s~.", 110)

                local distanceL, distanceR = #(GetEntityCoords(PlayerPedId()) - keypads[4][1]), #(GetEntityCoords(PlayerPedId()) - keypads[4][2])
                
                if distanceL < 2.0 or distanceR < 2.0 then 
                    HelpMsg("Press ~INPUT_CONTEXT~ to get in position to insert the keycard.") 
                    if IsControlPressed(0, 38) then 
                        if distanceL < distanceR then 
                            SyncKeycardEnter(1)
                        else
                            SyncKeycardEnter(2)
                        end
                        isSwiping = true
                        break
                    else 
                        Wait(10)
                    end
                else 
                    Wait(100)
                end 
            else 
                Wait(1000)
            end
        end
    end)

    if not old then 
        CreateThread(function()
            while true do 
                Wait(100)
                if IsEntityPlayingAnim(GetHeistPlayerPed(hPlayer[1]), animDict, animNameOne, 2) or IsEntityPlayingAnim(GetHeistPlayerPed(hPlayer[2]), animDict, animNameOne, 2) or IsEntityPlayingAnim(GetHeistPlayerPed(hPlayer[3]), animDict, animNameOne, 2) or IsEntityPlayingAnim(GetHeistPlayerPed(hPlayer[4]), animDict, animNameOne, 2) then 
                    swiped = true
                    while x < 30 do 
                        if IsEntityPlayingAnim(GetHeistPlayerPed(hPlayer[1]), animDict, animNameTwo, 2) or IsEntityPlayingAnim(GetHeistPlayerPed(hPlayer[2]), animDict, animNameTwo, 2) or IsEntityPlayingAnim(GetHeistPlayerPed(hPlayer[3]), animDict, animNameTwo, 2) or IsEntityPlayingAnim(GetHeistPlayerPed(hPlayer[4]), animDict, animNameTwo, 2) then
                            sync = true 
                        end
                        Wait(100)
                        x = x + 1
                    end 
                elseif IsEntityPlayingAnim(GetHeistPlayerPed(hPlayer[1]), animDict, animNameTwo, 2) or IsEntityPlayingAnim(GetHeistPlayerPed(hPlayer[2]), animDict, animNameTwo, 2) or IsEntityPlayingAnim(GetHeistPlayerPed(hPlayer[3]), animDict, animNameTwo, 2) or IsEntityPlayingAnim(GetHeistPlayerPed(hPlayer[4]), animDict, animNameTwo, 2) then
                    swiped = true
                    while x < 30 do 
                        if IsEntityPlayingAnim(GetHeistPlayerPed(hPlayer[1]), animDict, animNameOne, 2) or IsEntityPlayingAnim(GetHeistPlayerPed(hPlayer[2]), animDict, animNameOne, 2) or IsEntityPlayingAnim(GetHeistPlayerPed(hPlayer[3]), animDict, animNameOne, 2) or IsEntityPlayingAnim(GetHeistPlayerPed(hPlayer[4]), animDict, animNameOne, 2) then
                            sync = true 
                        end 
                        Wait(100)
                        x = x + 1
                    end
                end

                if sync and swiped then 
                    if isSwiping then 
                        NetworkStartSynchronisedScene(keycardSyncAnims[2][5])
                        Wait(2000)
                        ClearPedTasks(PlayerPedId())
                        DeleteEntity(keycardObj)
                    end 

                    swiped = false
                    isSwiping = true
                    SetupVault()
                    FirstMantrap()
                    break
                elseif swiped then 
                    local random = math.random(1, 3)
                    NetworkStartSynchronisedScene(keycardSyncAnims[2][5 + random])
                    Wait(2000)
                    NetworkStartSynchronisedScene(keycardSyncAnims[2][1])
                    Wait(1000)
                    NetworkStartSynchronisedScene(keycardSyncAnims[2][2])
                    KeycardReady(lvlFour)
                    swiped = false
                end
            end
        end)
    end
end

function FirstMantrap()
    blips[1] = AddBlipForCoord(mantrapCoords)
    SetBlipColour(blips[1], 5)


    CreateThread(function()
        while true do 
            Wait(100)

            local distance = #(GetEntityCoords(PlayerPedId()) - mantrapCoords)

            if distance < 20 then 
                if IsNotClose(mantrapCoords, 35) then 
                    SubtitleMsg("Wait for your team members to enter the mantrap", 110)
                else
                    RemoveBlip(blips[1])
                    break
                end
            else 
                SubtitleMsg("Enter the ~y~mantrap.", 110)
            end
        end

        while true do 
            Wait(100)
            
            local distance = #(GetEntityCoords(PlayerPedId()) - vaultEntryDoorCoords)
            
            if distance < 7 then 
                if approach == 2 and selectedEntryDisguise == 3 then 
                    if not DoesEntityExist(vaultObjs[1]) then 
                        vaultObjs[1] = GetClosestObjectOfType(2505.54, -238.53, -71.65, 10.0, GetHashKey("ch_prop_ch_vault_wall_damage"), false, false, false)
                        SetEntityVisible(vaultObjs[1], false, false)
                    end
                    LoadCutscene("hs3f_sub_vlt")
                    StartCutscene(0)

                    while not DoesCutsceneEntityExist("MP_3", 0) do 
                        Wait(0)
                    end

                    local arr = {}

                    if #playerAmount == 2 then 
                        arr = {"MP_3", "MP_4"}
                    elseif #playerAmount == 3 then 
                        arr = {"MP_4"}
                    end

                    if #arr > 0 then 
                        for i = 1, #arr do 
                            SetEntityVisible(GetEntityIndexOfCutsceneEntity(arr[i], 0), false, false)
                        end
                    end
                    SetVaultObjs()
                    break
                elseif IsNotClose(vaultEntryDoorCoords, 7) then 
                    SubtitleMsg("Wait for your team members to reach the vault door", 110)
                else
                    EnableMantrapDoors(1, 1)
                    if not DoesEntityExist(vaultObjs[1]) then 
                        vaultObjs[1] = GetClosestObjectOfType(2505.54, -238.53, -71.65, 10.0, GetHashKey("ch_prop_ch_vault_wall_damage"), false, false, false)
                        SetEntityVisible(vaultObjs[1], false, false)
                    end
                    
                    SetVaultObjs()

                    if approach == 3 then  
                        BombVaultDoor()
                        break
                    else
                        DrillVaultDoor()
                        break
                    end
                end
            else 
                SubtitleMsg("Go the ~y~vault door.", 110)
            end
        end
    end)
end

function DrillVaultDoor()

end

function BombVaultDoor()
    local distanceL, distanceR 
    
    for i = 1, 2 do 
        blips[i] = AddBlipForCoord(vaultCheckpointBlips[i])
        SetBlipColour(blips[i], 2)
        SetBlipHighDetail(blips[i], true)
    end

    CreateThread(function()
        while true do 
            Wait(5)
            
            SubtitleMsg("Plant the ~g~explosives.", 110)

            if not plantBombs then 
                
                if not leftBombs then 
                    distanceL = #(GetEntityCoords(PlayerPedId()) - vaultCheckpointBlips[1])
                end

                if not rightBombs then 
                    distanceR = #(GetEntityCoords(PlayerPedId()) - vaultCheckpointBlips[2]) 
                end

                if distanceL < 2 and not leftBombs then 
                    HelpMsg("Press ~INPUT_CONTEXT~ to plant explosives on the left side.")
                    if IsControlPressed(0, 38) then 
                        PlantVaultBombs(1)
                    else 
                        Wait(10)
                    end
                elseif distanceR < 2 and not rightBombs then 
                    HelpMsg("Press ~INPUT_CONTEXT~ to plant explosives on the right side.")
                    if IsControlPressed(0, 38) then 
                        PlantVaultBombs(2)
                    else 
                        Wait(10)
                    end
                else 
                    Wait(100)
                end
            end
            
            if leftBombs and rightBombs then 
                break
            end
        end
    end)
    
    CreateThread(function()
        while true do
            Wait(100)
            
            if not leftBombs and (IsEntityPlayingAnim(GetHeistPlayerPed(hPlayer[1]), "anim_heist@hs3f@ig8_vault_explosives@left@male@", "player_ig8_vault_explosive_plant_b", 2) or IsEntityPlayingAnim(GetHeistPlayerPed(hPlayer[2]), "anim_heist@hs3f@ig8_vault_explosives@left@male@", "player_ig8_vault_explosive_plant_b", 2) or IsEntityPlayingAnim(GetHeistPlayerPed(hPlayer[3]), "anim_heist@hs3f@ig8_vault_explosives@left@male@", "player_ig8_vault_explosive_plant_b", 2) or IsEntityPlayingAnim(GetHeistPlayerPed(hPlayer[4]), "anim_heist@hs3f@ig8_vault_explosives@left@male@", "player_ig8_vault_explosive_plant_b", 2)) then 
                RemoveBlip(blips[1])
                leftBombs = true
            end

            if not rightBombs and (IsEntityPlayingAnim(GetHeistPlayerPed(hPlayer[1]), "anim_heist@hs3f@ig8_vault_explosives@right@male@", "player_ig8_vault_explosive_plant_c", 2) or IsEntityPlayingAnim(GetHeistPlayerPed(hPlayer[2]), "anim_heist@hs3f@ig8_vault_explosives@right@male@", "player_ig8_vault_explosive_plant_c", 2) or IsEntityPlayingAnim(GetHeistPlayerPed(hPlayer[3]), "anim_heist@hs3f@ig8_vault_explosives@right@male@", "player_ig8_vault_explosive_plant_c", 2) or IsEntityPlayingAnim(GetHeistPlayerPed(hPlayer[4]), "anim_heist@hs3f@ig8_vault_explosives@right@male@", "player_ig8_vault_explosive_plant_c", 2)) then 
                RemoveBlip(blips[2])
                rightBombs = true
            end

            if leftBombs and rightBombs then 
                Wait(2000)
                VaultExplosionSetup()
                break
            end
        end
    end)
end

function Vault()

end

RegisterNetEvent("cl:casinoheist:testCut", MainEntry)

RegisterNetEvent("cl:casinoheist:vaultExplosion", function()
    Wait(1000)
    VaultExplosion()
end)

RegisterCommand("test_doors", function(src, args)
    EnableMantrapDoors(tonumber(args[1]), tonumber(args[2]))
end, false)

RegisterCommand("test_basement", FirstMantrap, false)

RegisterCommand("test_cut_agg", function()
    MainEntry()
end, false)

RegisterNetEvent("cl:testt", function()
    --LoadModel("ch_des_heist3_vault_01")
    --vaultObjs[1] = CreateObject(GetHashKey("ch_des_heist3_vault_01"), 2504.97, -240.31, -73.691, false, false, false)
    --
    --BombVaultDoor()

    SecurityLobby(true, false)
end)

RegisterCommand("test_vaultdoors", function()
    LoadModel("ch_des_heist3_vault_01")
    LoadModel("ch_des_heist3_vault_02")
    LoadModel("ch_des_heist3_vault_end")
    vaultObjs[1] = CreateObject(GetHashKey("ch_des_heist3_vault_01"), 2504.97, -240.31, -73.691, false, false, false)
    vaultObjs[2] = CreateObject(GetHashKey("ch_des_heist3_vault_02"), 2504.97, -240.31, -75.339, false, false, false)
    vaultObjs[3] = CreateObject(GetHashKey("ch_des_heist3_vault_end"), 2504.97, -240.31, -71.8, false, false, true)
    
    SetEntityVisible(vaultObjs[3], false, false)
    SetEntityCollision(vaultObjs[3], false, true)
    
    VaultExplosionSetup()
end, false)

RegisterCommand("test_bombs", function()
    LoadModel("ch_des_heist3_vault_01")
    vaultObjs[1] = CreateObject(GetHashKey("ch_des_heist3_vault_01"), 2504.97, -240.31, -73.691, false, false, false)
    
    BombVaultDoor()
end, false)

local test = {}

RegisterCommand("test_art", function()
    
    PlaySoundFromCoord(-1, "vault_door_explosion", 2504.961, -240.3102, -70.07, "dlc_ch_heist_finale_sounds", false, 0, false)

    LoadModel("ch_prop_ch_sec_cabinet_02a")
    LoadModel("ch_prop_vault_painting_01a")

    for i = 1, #artCabinets do 
        artCabinetObjs[i] = CreateObject(GetHashKey("ch_prop_ch_sec_cabinet_02a"), artCabinets[i].x, artCabinets[i].y, artCabinets[i].z, true, false, false)
        SetEntityHeading(artCabinetObjs[i], artCabinets[i].w)
        paintingObjs[i] = CreateObject(GetHashKey("ch_prop_vault_painting_01a"), paintings[i], false, false, false)
        SetEntityHeading(paintingObjs[i], artCabinets[i].w)
    end
end, false)

local test = {}

RegisterCommand("test_trolly", function()
    local cartType = {
        {"ch_prop_ch_cash_trolly_01a", "ch_prop_ch_cash_trolly_01b", "ch_prop_ch_cash_trolly_01c"},
        {"ch_prop_gold_trolly_01a", "ch_prop_gold_trolly_01b", "ch_prop_gold_trolly_01c"},
        {},
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

    local sprites = {}

    for i = 1, #carts[cartLayout] do 
        j = CartType(i)

        test[i] = CreateObject(GetHashKey(cartType[loot][j]), carts[cartLayout][i].x, carts[cartLayout][i].y, carts[cartLayout][i].z, true, true, false)
        SetEntityHeading(test[i], carts[cartLayout][i].w)
        
        blips[i] = AddBlipForCoord(carts[cartLayout][i].x, carts[cartLayout][i].y, carts[cartLayout][i].z)
        SetBlipSprite(blips[i], 534 + i)
        SetBlipColour(blips[i], 2)
        SetBlipScale(blips[i], 0.8)
    end
end, false)

RegisterCommand("test_door", SetVaultLayout, false)