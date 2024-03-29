lvlFour = 0
vaultObjs = {}

local keycardObj = 0
local blip = 0
local keycardScene = 0

local isSwiping = false
local timerStarted = false
local plantBombs = false
local leftBombs = false                        
local rightBombs = false
local sewer = false                       

local bombObjs = {}
local blips = {}
local vStatus = {false, false}

keycardSyncAnims = {
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
        print("door registered: " .. doorHash)
        AddDoorToSystem(doorHash, objHash, coords, false, false, false)
    end 

    if IsDoorRegisteredWithSystem(doorHash) then 
        DoorSystemSetOpenRatio(doorHash, 0.0, false, false)
        DoorSystemSetDoorState(doorHash, num, false, false)
    end
end

function EnableMantrapDoors(security, vault)
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
    local random = math.random(1, 3)

    keycardScene = NetworkCreateSynchronisedScene(GetEntityCoords(keypadObj), GetEntityRotation(keypadObj), 2, true, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(PlayerPedId(), keycardScene, animDict, "success_var0" .. tonumber(random), 4.0, -4.0, 2000, 0, 1000.0, 0)
    NetworkAddEntityToSynchronisedScene(keycardObj, keycardScene, animDict, "success_var0" .. tonumber(random) .. "_card", 1.0, -1.0, 114886080)
    
    NetworkStartSynchronisedScene(keycardScene)
    Wait(3700)
    DeleteObject(keycardObj)
    ClearPedTasks(PlayerPedId())
end

function HackKeypad(level, j, start)
    if level > selectedKeycard and level ~= 4 then 
        isBusy = true
        local animDict = "anim_heist@hs3f@ig1_hack_keypad@arcade@male@"
        local hackDevice = "ch_prop_ch_usb_drive01x"
        local phoneDevice = "prop_phone_ing"
        local keypadHash = ""

        if level == 1 then 
            keypadHash = "ch_prop_fingerprint_scanner_01a"
        elseif level == 2 then 
            keypadHash = "ch_prop_fingerprint_scanner_01b"
        elseif level == 3 then 
            keypadHash = "ch_prop_fingerprint_scanner_01c"
        end

        if start then 
            LoadAnim(animDict)
            LoadModel(hackDevice)
            LoadModel(phoneDevice)
            
            local keypad = GetClosestObjectOfType(keypads[level][j], 1.0, GetHashKey(keypadHash), false, false, false)
            hackUsb = CreateObject(GetHashKey(hackDevice), GetEntityCoords(PlayerPedId()), true, false, false)
            phone = CreateObject(GetHashKey(phoneDevice), GetEntityCoords(PlayerPedId()), true, false, false)

            for i = 1, #hackKeypadAnims[1], 1 do 
                if i == 2 then
                    hackKeypadAnims[2][i] = NetworkCreateSynchronisedScene(GetEntityCoords(keypad), GetEntityRotation(keypad), 2, false, true, 1065353216, 0, 1.3) 
                    NetworkAddPedToSynchronisedScene(PlayerPedId(), hackKeypadAnims[2][i], animDict, hackKeypadAnims[1][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
                    NetworkAddEntityToSynchronisedScene(hackUsb, hackKeypadAnims[2][i], animDict, hackKeypadAnims[1][i][2], 1.0, -1.0, 1148846080)
                    NetworkAddEntityToSynchronisedScene(phone, hackKeypadAnims[2][i], animDict, hackKeypadAnims[1][i][3], 1.0, -1.0, 1148846080)
                else
                    hackKeypadAnims[2][i] = NetworkCreateSynchronisedScene(GetEntityCoords(keypad), GetEntityRotation(keypad), 2, true, false, 1065353216, 0, 1.3) 
                    NetworkAddPedToSynchronisedScene(PlayerPedId(), hackKeypadAnims[2][i], animDict, hackKeypadAnims[1][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
                    NetworkAddEntityToSynchronisedScene(hackUsb, hackKeypadAnims[2][i], animDict, hackKeypadAnims[1][i][2], 1.0, -1.0, 1148846080)
                    NetworkAddEntityToSynchronisedScene(phone, hackKeypadAnims[2][i], animDict, hackKeypadAnims[1][i][3], 1.0, -1.0, 1148846080)
                end
            end

            NetworkStartSynchronisedScene(hackKeypadAnims[2][1])
            Wait(4000)
        end
        NetworkStartSynchronisedScene(hackKeypadAnims[2][2])
        Wait(1500)
        -- Hack Minigame
        StartFingerprintHack(function(bool)
            if bool then 
                TriggerServerEvent("sv:casinoheist:syncDStatus", j)
                NetworkStartSynchronisedScene(hackKeypadAnims[2][3])
                Wait(3000)
                DeleteObject(hackUsb)
                DeleteObject(phone)
                ClearPedTasks(PlayerPedId())
                
                isBusy = false
            else
                NetworkStartSynchronisedScene(hackKeypadAnims[2][4])
                Wait(2000)
                NetworkStartSynchronisedScene(hackKeypadAnims[2][5])
                Wait(2000)
                HackKeypad(level, j, false)
            end
        end)
    else 
        KeypadOne(level, j)
    end
end

function KeycardReady(num)
    while true do 
        Wait(5)
        
        HelpMsg("Both Players must insert their keycards simultaneously. Press ~INPUT_FRONTEND_RDOWN~ when you are both ready. to back out press ~INPUT_FRONTEND_PAUSE_ALTERNATE~.")
        if IsControlPressed(0, 18) then 
            NetworkStartSynchronisedScene(keycardSyncAnims[2][3])
            Wait(2000)
            NetworkStartSynchronisedScene(keycardSyncAnims[2][4])
            break 
        elseif IsControlPressed(0, 200) then 
            ClearPedTasks(PlayerPedId())
            DeleteObject(keycardObj)
            isSwiping = false
            lvlFour = 0
            if num == 1 or num == 2 then 
                SecurityLobby(false, true)
            else 
                VaultLobby(false, true)
            end
            break
        else 
            Wait(10)
        end
    end
end

function SyncKeycardEnter(num)
    local animDict = "anim_heist@hs3f@ig3_cardswipe_insync@male@"
    local keycard = "ch_prop_vault_key_card_01a"

    LoadAnim(animDict)
    
    
    local keypadObj = GetClosestObjectOfType(keypads[4][num], 1.0, GetHashKey("ch_prop_fingerprint_scanner_01d"), false, false, false)
    
    if num > 2 then 
        num = num - 2
    end

    lvlFour = num
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
        SetEntityHeading(vaultObjs[2], 90.0)
        FreezeEntityPosition(vaultObjs[2], true)
        SetModelAsNoLongerNeeded("ch_prop_ch_vaultdoor01x")
    elseif approach == 3 then 
        LoadModel("ch_des_heist3_vault_01")
        LoadModel("ch_des_heist3_vault_02")
        LoadModel("ch_des_heist3_vault_end")

        vaultObjs[2] = CreateObject(GetHashKey("ch_des_heist3_vault_01"), aggressiveVaultDoorCoords[1], false, false, true)
        vaultObjs[3] = CreateObject(GetHashKey("ch_des_heist3_vault_02"), aggressiveVaultDoorCoords[2], false, false, true)
        vaultObjs[4] = CreateObject(GetHashKey("ch_des_heist3_vault_end"), aggressiveVaultDoorCoords[3], false, false, true)
        
        SetEntityVisible(vaultObjs[4], false, false)
        SetEntityCollision(vaultObjs[4], false, true)

        SetModelAsNoLongerNeeded("ch_des_heist3_vault_01")
        SetModelAsNoLongerNeeded("ch_des_heist3_vault_02")
        SetModelAsNoLongerNeeded("ch_des_heist3_vault_end")
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
    
    RequestScriptAudioBank("DLC_HEIST3/CASINO_HEIST_FINALE_GENERAL_01", false, -1)

    LoadAnim(animDict)
    LoadAnim(reactAnimDict)

    Wait(1000)

    RemoveBlip(blips[1])

    SetEntityVisible(vaultObjs[3], false, false)
    SetEntityCollision(vaultObjs[3], false, false)

    UseParticleFxAsset(ptfx)
    scene = CreateSynchronizedScene(2488.348, -267.364, -71.646, 0.0, 0.0, 0.0, 2)
    PlaySynchronizedEntityAnim(vaultObjs[2], scene, "explosion_vault_01", animDict, 1000.0, 8.0, 0, 1000.0)
    PlaySynchronizedEntityAnim(vaultObjs[3], scene, "explosion_vault_02", animDict, 1000.0, 8.0, 0, 1000.0)
    SetSynchronizedScenePhase(scene, 0.056)
    PlaySoundFromCoord(-1, "vault_door_explosion", 2504.961, -240.3102, -70.07, "dlc_ch_heist_finale_sounds", false, 20.0, false)
    StartParticleFxNonLoopedAtCoord("cut_hs3f_exp_vault", 2505.0, -238.5, -70.5, 0.0, 0.0, 0.0, 1.0, false, false, false)
    ShakeGameplayCam("LARGE_EXPLOSION_SHAKE", 0.5)
    SetPadShake(0, 130, 256)
    TaskPlayAnim(PlayerPedId(), reactAnimDict, reactAnimName,  8.0, -8.0, -1, 1048576, 0.0, false, false, false)
    RemoveAllBombs()
    SetEntityVisible(vaultObjs[1], true, true)

    Wait(4000)
    
    ReleaseNamedScriptAudioBank("DLC_HEIST3/CASINO_HEIST_FINALE_GENERAL_01")
    RemoveNamedPtfxAsset("cut_hs3f")
    RemoveAnimDict(animDict)
    RemoveAnimDict(reactAnimDict)
    SetEntityVisible(vaultObjs[4], true, false)
    SetEntityCollision(vaultObjs[4], true, true)

    if not DoesEntityExist(vaultObjs[2]) then 
        vaultObjs[2] = GetClosestObjectOfType(aggressiveVaultDoorCoords[2], 1.0, GetHashKey("ch_des_heist3_vault_01"), false, false, false)
    end
    
    if not DoesEntityExist(vaultObjs[3]) then 
        vaultObjs[3] = GetClosestObjectOfType(aggressiveVaultDoorCoords[3], 1.0, GetHashKey("ch_des_heist3_vault_02"), false, false, false)
    end
    DeleteEntity(vaultObjs[2])
    DeleteEntity(vaultObjs[3])

    ClearAreaOfObjects(aggressiveVaultDoorCoords[2], 3.0, 0)

    Vault()
end

local function VaultExplosionSetup()
    blips[1] = AddBlipForRadius(aggressiveAreaBlip)
    SetBlipColour(blips[1], 76)
    SetBlipAlpha(blips[1], 175)

    -- phone but disabled due to lack of testing and phone being quite unstable...
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
    local bomb = "ch_prop_ch_explosive_01a"
    local camNum = 4 + num 

    LoadModel(bomb)

    isBusy = true

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
    
    local cam = CreateCam("DEFAULT_ANIMATED_CAMERA", true)
    RenderScriptCams(true, true, 1000, true, false)

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
        end
    end
    PlayCamAnim(cam, bombAnims[1][num][1][4 + num], animDict, 2504.97, -240.2, -70.20, 0.0, 0.0, 0.0, false, 2)
    NetworkStartSynchronisedScene(bombAnims[2][1])
    Wait(2000)
    PlayCamAnim(cam, bombAnims[1][num][2][4 + num], animDict, 2504.97, -240.2, -70.20, 0.0, 0.0, 0.0, false, 2)
    NetworkStartSynchronisedScene(bombAnims[2][2])
    
    local x = 0
    local numerics = {"first", "second", "last"}
    
    while true do 
        Wait(10)
        
        DisableControlAction(0, 1, true)

        HelpMsg("Press ~INPUT_ATTACK~ to plant the ".. numerics[x + 1] .." explosive")
        if IsControlPressed(0, 24) then 
            PlayCamAnim(cam, bombAnims[1][num][3 + x][4 + num], animDict, 2504.97, -240.2, -70.20, 0.0, 0.0, 0.0, false, 2)
            NetworkStartSynchronisedScene(bombAnims[2][3 + x])
            FreezeEntityPosition(bombObjs[x + 1])
            SetEntityVisible(bombObjs[x + 2], true, true)
            
            Wait(2000)
            x = x + 1
            
            if x == (1 + num) then 
                break
            end
            
            PlayCamAnim(cam, bombAnims[1][num][2][4 + num], animDict, 2504.97, -240.2, -70.20, 0.0, 0.0, 0.0, false, 2)
            NetworkStartSynchronisedScene(bombAnims[2][2])
        end
    end

    TriggerServerEvent("sv:casinoheist:syncVault", num, x)
    Wait(1000)
    ClearPedTasks(PlayerPedId())
    DeleteEntity(bagObj)
    RenderScriptCams(false, true, 1000, true, false)
    DestroyCam(cam, false)
    isBusy = false

    if num == 1 then 
        RemoveBlip(blips[1])
        leftBombs = true 
    else 
        RemoveBlip(blips[2])
        rightBombs = true 
    end
end

local function PlantSewerBomb()
    isBusy = true 
    
    local animDict = "anim_heist@hs3f@ig7_plant_bomb@male@"
    local bomb = "ch_prop_ch_ld_bomb_01a"

    LoadModel(bomb)
    LoadAnim(animDict)

    local bombObj = CreateObject(GetHashKey(bomb), GetEntityCoords(PlayerPedId()), true, false, false)

    AttachEntityToEntity(bombObj, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 0xE5F2), 0.05, -0.12, -0.180, 180.0, 185.0, 15.0, false, false, false, false, 2, true)
    TaskPlayAnimAdvanced(PlayerPedId(), animDict, "plant_bomb", 2480.1, -293.33, -70.67, 0.0, 0.0, 0.0, 8.0, -8.0, 2000, 8, 0, 0, 0)

    Wait(2000)

    DetachEntity(bombObj, false, true)
    FreezeEntityPosition(bombObj, true)

    Wait(1300)

    ClearPedTasks(PlayerPedId())
    DeleteEntity(bombObj)

    isBusy = false
    sewer = false
end

function RoofTerraceEntry()
    if IsScreenFadedOut() then 
        DoScreenFadeIn(500)
    end
    
    local terrace = true
    local sprite = {63, 743}
    local zCoord = -41.12

    for i = 1, 2 do 
        blips[i] = AddBlipForCoord(terraceBlips[i])
        SetBlipSprite(blips[i], sprite[i])
        SetBlipColour(blips[i], 5)
    end

    CreateThread(function()
        while terrace do 
            Wait(100)
            
            SubtitleMsg("Go to the ~y~basement.", 110)

            if GetEntityCoords(PlayerPedId()).z < zCoord then 
                if zCoord > -42 then
                    RemoveBlip(blips[1])
                    RemoveBlip(blips[2])
                    zCoord = -55
                else
                    Basement()
                    terrace = false                
                end
            end
        end
    end)
end

function HeliPadEntry()
    DoScreenFadeIn(500)

    local blip = AddBlipForCoord(stairBlip)
    SetBlipSprite(blip, 743)
    SetBlipColour(blip, 5)
    
    local blip2 = AddBlipForCoord(rappelEntry[1])
    SetBlipColour(blip, 5)

    local helipad = true
    local useShaft = true

    local txt = "Go to the ~y~shaft~s~ or take the ~y~stairs"

    CreateThread(function()
        while helipad do 
            Wait(GetFrameTime())
            
            DrawMarker(1, rappelEntry[1].xy, rappelEntry[1].z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.75, 200, 200, 50, 100, false, false, 2, false)
        end
    end)
    
    CreateThread(function()
        while helipad do 
            Wait(100)
            
            if #(GetEntityCoords(PlayerPedId()) - rappelEntry[1]) < 1 and useShaft then 
                if IsNotClose(rappelEntry[1], 1) then 
                    SubtitleMsg("Wait for your team members", 110)
                else 
                    RemoveBlip(blip)
                    RemoveBlip(blip2)
                    RopeStart()
                    helipad = false
                end
            elseif (#(GetEntityCoords(GetHeistPlayerPed(hPlayer[1])) - stairBlip) < 1.5 or #(GetEntityCoords(GetHeistPlayerPed(hPlayer[2])) - stairBlip) < 2.5 or #(GetEntityCoords(GetHeistPlayerPed(hPlayer[3])) - stairBlip) < 2.5 or #(GetEntityCoords(GetHeistPlayerPed(hPlayer[4])) - stairBlip) < 2.5) and useShaft then 
                if useShaft then
                    useShaft = false
                    RemoveBlip(blip2)
                    txt = "Go to the ~y~stairs"
                end
            elseif GetEntityCoords(PlayerPedId()).z < -27.11 and not useShaft then 
                RemoveBlip(blip)
                RoofTerraceEntry()
                helipad = false
            else
                SubtitleMsg(txt, 110)
            end
        end 
    end)
end

function SewerEntry()
    if player ~= 1 and player ~= 2 and player ~= 3 and player ~= 4 then 
        player = 2
    end

    DoScreenFadeIn(500)

    local txt = "Wait for " .. GetPlayerName(GetPlayerFromServerId(hPlayer[2])) or "Player 2" .. " to plant the bomb."

    sewer = true

    if player == 2 then 
        txt = "Plant the ~y~bomb~s~ on the wall"

        CreateThread(function()
            while sewer do 
                Wait(GetFrameTime())

                local distance = #(GetEntityCoords(PlayerPedId()) - sewerBomb) 

                if distance < 10 and not isBusy then 
                    DrawMarker(1, sewerBomb.xy, sewerBomb.z - 1.0,  0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.75, 229, 202, 23, 100, false, false, 2, false, nil, nil, false)
                    if distance < 0.5 then 
                        HelpMsg("Press ~INPUT_CONTEXT~ to plant the bomb")

                        if IsControlJustPressed(0, 38) then 
                            PlantSewerBomb()
                        end
                    end
                else 
                    Wait(100)
                end
            end
        end)
    end

    CreateThread(function()
        while sewer do 
            Wait(100)
            SubtitleMsg(txt, 110)

            if IsEntityPlayingAnim(GetHeistPlayerPed(hPlayer[2]), "anim_heist@hs3f@ig7_plant_bomb@male@", "plant_bomb", 2) then 
                Wait(GetAnimDuration("anim_heist@hs3f@ig7_plant_bomb@male@", "plant_bomb") * 1000 - 1000)
                sewer = false
            end
        end

        AddDoorToSystem(1535590430, GetHashKey("v_ilev_rc_door2"), 2485.079, -288.2985, -70.54587, false, false, false)
        DoorSystemSetDoorState(1535590430, 0, false, true)

        LoadCutscene("hs3f_dir_sew")
        StartCutscene(0)

        repeat Wait(10) until HasCutsceneFinished()
        SecurityLobby(true, false)

        RemoveDoorFromSystem(1535590430)
    end)

end

function MainEntry()
    if approach == 3 then 
        LoadCutscene("hs3f_dir_ent")
        HideTimerBars()
        StartCutscene(0)

        DoScreenFadeIn(500)

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

        StartGuardSpawn(3)

        ShowTimerbars(false)
        Wait(30)

        TaskPutPedDirectlyIntoCover(PlayerPedId(), GetEntityCoords(PlayerPedId(), true), -1, false, false, false, false, false, false)

        TriggerServerEvent("sv:casinoheist:alarm")

        blips[1] = AddBlipForCoord(2525.77, -251.71, -60.31)
        SetBlipColour(blips[1], 5) 
        
        CreateThread(function()
            while true do 
                Wait(100)
                local distance = #(GetEntityCoords(PlayerPedId()) - vector3(2525.77, -251.71, -60.31)) 
                
                if distance < 3 then 
                    if IsNotClose(vector3(2525.77, -251.71, -60.31), 3) then
                        SubtitleMsg("Wait for your team members", 110)
                    else 
                        RemoveBlip(blips[1])

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
    else
        CreateThread(function()
            while true do 
                Wait(0)
            
            end
        end)
    end
end
    
function Basement()
    if alarmTriggered == 0 then 
        InitRoutes()
    end


    if IsScreenFadedOut() then 
        DoScreenFadeIn(500)
    end

    isInStaff = true

    RemoveAllBlips()
    local sprite = {63, 743}
    
    for i = 1, 2 do 
        blips[i] = AddBlipForCoord(staffCoords[i])
        SetBlipHighDetail(blips[i], true)
        SetBlipSprite(blips[i], sprite[i])
        SetBlipColour(blips[i], 5)
    end
    
    SetRoom(1)

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
                    SetRoom(2)
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

function TunnelEntry()
    blips[1] = AddBlipForCoord(2524.63, -288.3, -64.72)
    SetBlipColour(blips[1], 5)
    
    while IsPedInAnyVehicle(PlayerPedId(), false) do
        Wait(100)
        if #(GetEntityCoords(PlayerPedId()) - vector3(2524.63, -288.3, -64.72)) > 5 then
            SubtitleMsg("Park the ~y~vehicle~s~", 110)
        else
            SubtitleMsg("Get out of the vehicle", 110)
        end
    end

    RemoveBlip(blips[1])

    blips[1] = AddBlipForCoord(2514.73, -279.29, -64.72)
    SetBlipSprite(blips[1], 743)
    SetBlipColour(blips[1], 5)

    AddDoorToSystem(642441681, GetHashKey("ch_prop_ch_gendoor_01"), 2515.308, -281.5983, -64.57317, true, false, true)
    DoorSystemSetDoorState(642441681, 0, false, true)
    
    while GetEntityCoords(PlayerPedId()).z > -65 do
        Wait(100)
        SubtitleMsg("Go to the ~y~basement", 110) 
    end
    RemoveAllBlips()
    
    SecurityLobby(true, false)
    DoorSystemSetDoorState(642441681, 1, false, true)
    RemoveDoorFromSystem(642441681)

    SetRoom(2)
end

swiped = false
sync = false

function SecurityLobby(blip, old)
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
    local x = 0

    CreateThread(function()
        while true do 
            Wait(5)

            if not isSwiping then 
                SubtitleMsg("Go to one of the ~g~keypads~s~.", 120)

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
                        Wait(1000)
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
    StopCams()
    StopGuards()

    keycardSyncAnims[2] = {}

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
            
            if distance < 7 or (selectedEntryDisguise == 3 and IsAnyCrewNear(vaultEntryDoorCoords, 7)) then 
                if approach == 2 and selectedEntryDisguise == 3 then 
                    if not DoesEntityExist(vaultObjs[1]) then 
                        vaultObjs[1] = GetClosestObjectOfType(2505.54, -238.53, -71.65, 10.0, GetHashKey("ch_prop_ch_vault_wall_damage"), false, false, false)
                        SetEntityVisible(vaultObjs[1], false, false)
                    end

                    HideTimerBars()

                    LoadCutscene("hs3f_sub_vlt")
                    StartCutscene(0)

                    while not DoesCutsceneEntityExist("MP_3", 0) do 
                        Wait(0)
                    end

                    local arr = {}

                    if playerAmount == 2 then 
                        arr = {"MP_3", "MP_4"}
                    elseif playerAmount == 3 then 
                        arr = {"MP_4"}
                    end

                    if #arr > 0 then 
                        for i = 1, #arr do 
                            SetEntityVisible(GetEntityIndexOfCutsceneEntity(arr[i], 0), false, false)
                        end
                    end

                    repeat Wait(100) until HasCutsceneFinished()

                    Vault()
                    break
                elseif IsNotClose(vaultEntryDoorCoords, 6) then 
                    SubtitleMsg("Wait for your team members to reach the vault door", 110)
                else
                    if not DoesEntityExist(vaultObjs[1]) then 
                        vaultObjs[1] = GetClosestObjectOfType(2505.54, -238.53, -71.65, 10.0, GetHashKey("ch_prop_ch_vault_wall_damage"), false, false, false)
                        SetEntityVisible(vaultObjs[1], false, false)
                    end
                    
                    Wait(1000)
                    EnableMantrapDoors(1, 1)

                    VaultDoor()
                    break
                end
            else 
                SubtitleMsg("Go the ~y~vault door.", 110)
            end
        end
    end)
end

function VaultDoor()
    local distanceL, distanceR 
    local aTxt = ""
    local txt = {}
    if approach == 3 then 
        txt = { "Press ~INPUT_CONTEXT~ to plant explosives on the left side.", "Press ~INPUT_CONTEXT~ to plant explosives on the right side."}
        aTxt = "Plant the ~g~explosives."
    else
        txt = { "Press ~INPUT_CONTEXT~ to start drilling.", "Press ~INPUT_CONTEXT~ to start drilling." }
        aTxt = "Drill the ~g~door locks."
    end

    for i = 1, 2 do 
        blips[i] = AddBlipForCoord(vaultCheckpointBlips[i])
        SetBlipColour(blips[i], 2)
        SetBlipHighDetail(blips[i], true)
    end

    CreateThread(function()
        while not vStatus[1] or not vStatus[2] do 
            Wait(5)
            
            SubtitleMsg(aTxt, 110)

            if not isBusy then 
                
                if not vStatus[1] then 
                    distanceL = #(GetEntityCoords(PlayerPedId()) - vaultCheckpointBlips[1])
                end

                if not vStatus[2] then 
                    distanceR = #(GetEntityCoords(PlayerPedId()) - vaultCheckpointBlips[2]) 
                end

                if distanceL < 2 and not vStatus[1] then 
                    HelpMsg(txt[1])
                    if IsControlPressed(0, 38) then
                        if approach == 3 then  
                            PlantVaultBombs(1)
                        else 
                            StartDrilling(1)
                        end
                    else 
                        Wait(10)
                    end
                elseif distanceR < 2 and not vStatus[2] then 
                    HelpMsg(txt[2])
                    if IsControlPressed(0, 38) then 
                        if approach == 3 then 
                            PlantVaultBombs(2)
                        else 
                            StartDrilling(2)
                        end
                    else 
                        Wait(10)
                    end
                else 
                    Wait(100)
                end
            end
        end
    end)
end

RegisterNetEvent("cl:casinoheist:testCut", MainEntry)

RegisterNetEvent("cl:casinoheist:vaultExplosion", function()
    Wait(1000)
    VaultExplosion()
end)

RegisterNetEvent("cl:casinoheist:syncVault", function(key)
    RemoveBlip(blips[key])
    print("Removed", key)
    vStatus[key] = true 

    if vStatus[1] and vStatus[2] then 
        Wait(2000)
        if approach == 3 then 
            VaultExplosionSetup()
        else 
            LoadCutscene("hs3f_mul_vlt")
            StartCutscene(0)

            DeleteEntity(vaultObjs[2])

            while not DoesCutsceneEntityExist("MP_3") do 
                Wait(0)
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

            Vault()            
        end
    end
end)