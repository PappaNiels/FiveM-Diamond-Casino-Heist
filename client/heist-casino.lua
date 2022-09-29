local keycardObj = 0
local blip = 0
local keycardScene = 0

local isSwiping = false

local vaultObjs = {}
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

local regularDrillAnims = {
    {},
    {}
}

local laserDrillAnims = {
    {},
    {}
}

local function RemoveAllBlips()
    for i = 1, #blips do 
        RemoveBlip(blips[i])
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

local function KeypadOne(j)
    local keycard = "ch_prop_vault_key_card_01a"
    local animDict = "anim_heist@hs3f@ig3_cardswipe@male@"
    
    LoadModel(keycard)
    LoadAnim(animDict)
    
    local keypadObj = GetClosestObjectOfType(keypads[2][j], 1.0, GetHashKey("ch_prop_fingerprint_scanner_01b"), false, false, false)
    local keycardObj = CreateObject(GetHashKey(keycard), GetEntityCoords(PlayerPedId()), true, true, false)
    
    keycardScene = NetworkCreateSynchronisedScene(GetEntityCoords(keypadObj), GetEntityRotation(keypadObj), 2, true, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(PlayerPedId(), keycardScene, animDict, "success_var02", 4.0, -4.0, 2000, 0, 1000.0, 0)
    NetworkAddEntityToSynchronisedScene(keycardObj, keycardScene, animDict, "success_var02_card", 1.0, -1.0, 114886080)
    
    NetworkStartSynchronisedScene(keycardScene)
    Wait(3700)
    DeleteObject(keycardObj)
    ClearPedTasks(PlayerPedId())
end

local function SyncKeycardSwipe(num)
    local x = 0
    if num == 1 then 
        x = 2
    elseif num == 2 then 
        x = 1
    end
    
    local animDict = "anim_heist@hs3f@ig3_cardswipe_insync@male@"
    local animName = keycardSyncAnims[1][x][4]
    local syncSwipe = false 
    local x = 0

    while x <= 10 do 
        if IsEntityPlayingAnim(GetHeistPlayerPed(hPlayer[1]), animDict, animName, 2) or IsEntityPlayingAnim(GetHeistPlayerPed(hPlayer[2]), animDict, animName, 2) or IsEntityPlayingAnim(GetHeistPlayerPed(hPlayer[3]), animDict, animName, 2) or IsEntityPlayingAnim(GetHeistPlayerPed(hPlayer[4]), animDict, animName, 2) then 
            syncSwipe = true
            break 

        end 

        x = x + 1
        Wait(300)
    end

    if syncSwipe then 
        NetworkStartSynchronisedScene(keycardSyncAnims[2][5])
    else 
        local random = math.random(1, 3)
        NetworkStartSynchronisedScene(keycardSyncAnims[2][5 + random])
        Wait(2000)
        NetworkStartSynchronisedScene(keycardSyncAnims[2][2])
        KeycardReady(num)
    end
end

local function PlantVaultBombs(num)
    local animDict = ""
    local bag = ""
    local bomb = "ch_prop_ch_explosive_01a"
    local bombObj = {}
    local bagColour = GetPedTextureVariation(PlayerPedId(), 5)

    if num == 2 then 
        animDict = "anim_heist@hs3f@ig8_vault_explosives@right@male@"
        bombObj[3] = CreateObject(GetHashKey(bomb), GetEntityCoords(PlayerPedId()), true, false, false)
    else   
        animDict = "anim_heist@hs3f@ig8_vault_explosives@left@male@"
    end

    LoadModel(bag)
    LoadModel(bomb)
    LoadAnim(animDict)

    local bagObj = CreateObject(GetHashKey(bag), GetEntityCoords(PlayerPedId()), true, false, false)
    bombObj[1] = CreateObject(GetHashKey(bomb), GetEntityCoords(PlayerPedId()), true, false, false)
    bombObj[2] = CreateObject(GetHashKey(bomb), GetEntityCoords(PlayerPedId()), true, false, false)
    
    for i = 2, 3 do 
        SetEntityVisible(bombObj[i], false, false)
    end

    for i = 1, #bombAnims[1][num] do 
        bombAnims[2][i] = NetworkCreateSynchronisedScene(2504.97, -240.31, -73.691, 0.0, 0.0, 0.0, 2, true, false, 1065353216, 0.0, 1.3)
        NetworkAddPedToSynchronisedScene(PlayerPedId(), bombAnims[2][i], animDict, bombAnims[1][num][i][1], 4.0, -4.0, 18, 0, 1000.0, 0)


end

function KeycardReady(num)
    while true do 
        Wait(5)
        
        SetPauseMenuActive(false)
        
        HelpMsg("Both Players must insert their keycards simultaneously. Press ~INPUT_FRONTEND_RDOWN~ when you are both ready. to back out press ~INPUT_FRONTEND_PAUSE_ALTERNATE~.")
        if IsControlJustPressed(0, 18) then 
            NetworkStartSynchronisedScene(keycardSyncAnims[2][3])
            Wait(2000)
            NetworkStartSynchronisedScene(keycardSyncAnims[2][4])
            SyncKeycardSwipe(num)
            break 
        elseif IsControlJustPressed(0, 200) then 
            ClearPedTasks(PlayerPedId())
            DeleteObject(keycardObj)
            isSwiping = false
            break
        end
    end
end

local function SyncKeycardEnter(num)
    local animDict = "anim_heist@hs3f@ig3_cardswipe_insync@male@"
    local keycard = "ch_prop_vault_key_card_01a"
    LoadAnim(animDict)
    
    if not keycardSyncAnims[2][1] then
        local keypadObj = GetClosestObjectOfType(keypads[4][num], 1.0, GetHashKey("ch_prop_fingerprint_scanner_01d"), false, false, false)
        keycardObj = CreateObject(GetHashKey(keycard), GetEntityCoords(PlayerPedId()), true, true, false)

        for i = 1, #keycardSyncAnims[1][2] do 
            keycardSyncAnims[2][i] = NetworkCreateSynchronisedScene(GetEntityCoords(keypadObj), GetEntityRotation(keypadObj), 2, true, false, 0, 0, 1.3)
            NetworkAddPedToSynchronisedScene(PlayerPedId(), keycardSyncAnims[2][i], animDict, keycardSyncAnims[1][num][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
            NetworkAddEntityToSynchronisedScene(keycardObj, keycardSyncAnims[2][i], animDict, keycardSyncAnims[1][num][i][2], 1.0, -1.0, 114886080)
        end
    end

    NetworkStartSynchronisedScene(keycardSyncAnims[2][1])
    Wait(1000)
    NetworkStartSynchronisedScene(keycardSyncAnims[2][2])
    
    KeycardReady(num)
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

function MainEntry()
    --if approach == 3 then 
        LoadCutscene("hs3f_dir_ent")
        StartCutscene(0)

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
        
        repeat Wait(10) until HasCutsceneFinished()

        TaskPutPedDirectlyIntoCover(PlayerPedId(), GetEntityCoords(PlayerPedId(), true), -1, false, false, false, false, false, false)

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
                        DoScreenFadeOut(500)
                        
                        while not IsScreenFadedOut() do 
                            Wait(0)
                        end
                        
                        SetEntityCoords(PlayerPedId(), casinoToLobby[player])
                        SetEntityHeading(PlayerPedId(), 180.0)
                        
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
        local sprite = {63, 743}
        
        SetBlipCoords(blips[1], staffCoords[1])
        blips[2] = AddBlipForCoord(staffCoords[2])
        
        for i = 1, 2 do 
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
                else
                    SecurityLobby() 
                    break
                end
            end
        end
    end)
end
    
function SecurityLobby()
    for i = 1, 2 do 
        blips[i] = AddBlipForCoord(keypads[4][i])
        SetBlipSprite(blips[i], 733)
        SetBlipColour(blips[i], 2)
        SetBlipHighDetail(blips[i], true)
    end

    local animDict = "anim_heist@hs3f@ig3_cardswipe_insync@male@"
    local animNameOne = keycardSyncAnims[1][1][5]
    local animNameTwo = keycardSyncAnims[1][2][5]


    CreateThread(function()
        while true do 
            Wait(5)

            if not isSwiping then 
                SubtitleMsg("Go to one of the ~g~keypads~s~.", 10)

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
                    end
                end 
            end

            if IsEntityPlayingAnim(GetHeistPlayerPed(hPlayer[1]), animDict, animNameOne, 2) or IsEntityPlayingAnim(GetHeistPlayerPed(hPlayer[2]), animDict, animNameOne, 2) or IsEntityPlayingAnim(GetHeistPlayerPed(hPlayer[3]), animDict, animNameOne, 2) or IsEntityPlayingAnim(GetHeistPlayerPed(hPlayer[4]), animDict, animNameOne, 2) then
                if selectedEntryDisguise ~= 3 then
                    EnableMantrapDoors(0, 0)
                else
                    EnableMantrapDoors(0, 1)
                end

                RemoveAllBlips()

                vaultObjs[1] = GetClosestObjectOfType(2505.54, -238.53, -71.65, 10.0, GetHashKey("ch_prop_ch_vault_wall_damage"), false, false, false)
                SetEntityVisible(vaultObjs[1], false, false)

                if player == 1 then 
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
                    end
                end
                break
            end
        end
    end)
end

function FirstMantrap()
    blips[1] = AddBlipForCoord(mantrapCoords)
    SetBlipColour(blips[1], 5)


    CreateThread(function()
        while true do 
            Wait(100)

            local distance = #(GetEntityCoords(PlayerPedId()) - mantrapCoords)

            if distance < 20 then 
                break
                if IsNotClose(mantrapCoords, 25) then 
                    SubtitleMsg("Wait for your team members to enter the mantrap", 110)
                else
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
                if IsNotClose(vaultEntryDoorCoords, 7) then 
                    SubtitleMsg("Wait for your team members to reach the vault door", 110)
                else
                    if selectedEntryDisguise ~= 3 then 
                        LoadCutscene("hs3f_sub_vlt")
                        StartCutscene(0)

                        while not DoesCutsceneEntityExist("MP_3", 0) do 
                            Wait(0)
                        end

                        local arr = {}

                        if #hPlayer == 2 then 
                            arr = {"MP_3", "MP_4"}
                        elseif #hPlayer == 3 then 
                            arr = {"MP_4"}
                        end

                        if #arr > 0 then 
                            for i = 1, #arr do 
                                SetEntityVisible(GetEntityIndexOfCutsceneEntity(arr[i], 0), false, false)
                            end
                        end 
                        break
                    elseif approach == 3 then  
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
    
end

RegisterNetEvent("cl:casinoheist:testCut", MainEntry)

RegisterCommand("test_doors", function(src, args)
    EnableMantrapDoors(tonumber(args[1]), tonumber(args[2]))
end, false)

RegisterCommand("test_basement", FirstMantrap, false)

RegisterCommand("test_cut_agg", function()
    MainEntry()
end, false)

RegisterCommand("test_vaultdoors", function()
    local animDict = "anim_heist@hs3f@ig8_vault_door_explosion@"
    print("test")
    LoadModel("ch_des_heist3_vault_01")
    print("test")
    LoadModel("ch_des_heist3_vault_02")
    LoadModel("ch_des_heist3_vault_end")
    vaultObjs[1] = CreateObject(GetHashKey("ch_des_heist3_vault_01"), 2504.97, -240.31, -73.691, false, false, false)
    vaultObjs[2] = CreateObject(GetHashKey("ch_des_heist3_vault_02"), 2504.97, -240.31, -75.339, false, false, false)
    vaultObjs[3] = CreateObject(GetHashKey("ch_des_heist3_vault_end"), 2504.97, -240.31, -71.8, false, false, true)
    print("test", GetEntityCoords(vaultObjs[3]))
    LoadAnim(animDict)

    SetEntityVisible(vaultObjs[3], false, false)
    SetEntityCollision(vaultObjs[3], false, false)
    
    Wait(1000)
    
    --PlayEntityAnim(vaultObjs[1], "explosion_vault_01", animDict, 1000.0, false, true, true, 0, 0x4000)
    --PlayEntityAnim(vaultObjs[2], "explosion_vault_02", animDict, 1000.0, false, true, true, 0, 0x4000)
    
    scene = CreateSynchronizedScene(2488.348, -267.364, -71.646, 0.0, 0.0, 0.0, 2)
    PlaySynchronizedEntityAnim(vaultObjs[1], scene, "explosion_vault_01", animDict, 1000.0, 8.0, 0, 1000.0)
    PlaySynchronizedEntityAnim(vaultObjs[2], scene, "explosion_vault_02", animDict, 1000.0, 8.0, 0, 1000.0)
    SetSynchronizedScenePhase(scene, 0.056)

    print(GetAnimDuration(animDict, "explosion_vault_01"))
    Wait(4000)
    print(GetAnimDuration(animDict, "explosion_vault_01"))
    
    SetEntityVisible(vaultObjs[3], true, false)
    SetEntityCollision(vaultObjs[3], true, true)
    DeleteEntity(vaultObjs[1])
    DeleteEntity(vaultObjs[2])
end, false)

--[[
    
Effects:
    STREAMING::REQUEST_NAMED_PTFX_ASSET("cut_hs3f")
    GRAPHICS::USE_PARTICLE_FX_ASSET("cut_hs3f");
    GRAPHICS::START_PARTICLE_FX_NON_LOOPED_AT_COORD("cut_hs3f_exp_vault", 2505f, -238.5f, -70.5f, 0f, 0f, 0f, 1f, false, false, false);
    AUDIO::PLAY_SOUND_FROM_COORD(-1, "vault_door_explosion", Param0, "dlc_ch_heist_finale_sounds", false, 0, false);
    GRAPHICS::REMOVE_DECALS_IN_RANGE(2505f, -238.5f, -70.5f, 8f);

On Explosion:
    ENTITY::SET_ENTITY_COMPLETELY_DISABLE_COLLISION(iLocal_9798, false, false);
	ENTITY::SET_ENTITY_COMPLETELY_DISABLE_COLLISION(iLocal_9799, true, false);
	iLocal_9801 = PED::CREATE_SYNCHRONIZED_SCENE(2488.348f, -267.364f, -71.646f, 0f, 0f, 0f, 2);
	ENTITY::PLAY_SYNCHRONIZED_ENTITY_ANIM(iLocal_9798, iLocal_9801, "explosion_vault_01", "anim_heist@hs3f@ig8_vault_door_explosion@", 1000f, 8f, 0, 1000f);
	ENTITY::PLAY_SYNCHRONIZED_ENTITY_ANIM(iLocal_9800, iLocal_9801, "explosion_vault_02", "anim_heist@hs3f@ig8_vault_door_explosion@", 1000f, 8f, 0, 1000f);
	PED::SET_SYNCHRONIZED_SCENE_PHASE(iLocal_9801, 0.056f);
	MISC::SET_BIT(&uLocal_9795, 1);

React Animation: 
    case 0:
        TASK::TASK_PLAY_ANIM(iLocal_932, "anim_heist@hs3f@ig8_vault_explosive_react@left@male@", "player_react_explosive", 8f, -8f, -1, 1048576, 0f, false, false, false);
        break;
    
    case 1:
        TASK::TASK_PLAY_ANIM(iLocal_932, "anim_heist@hs3f@ig8_vault_explosive_react@right@male@", "player_react_explosive", 8f, -8f, -1, 1048576, 0f, false, false, false);
        break;

Shake: 
    PAD::SET_PAD_SHAKE(0, 130, 256);
    CAM::SHAKE_GAMEPLAY_CAM("LARGE_EXPLOSION_SHAKE", 0.5f);
    MISC::SET_BIT(&uLocal_9795, 3);

Clear Up:
    ENTITY::CREATE_MODEL_HIDE(Param0, 25f, joaat("ch_prop_ch_explosive_01a"), false);
	MISC::CLEAR_AREA_OF_PROJECTILES(Param0, 25f, 0);
]]