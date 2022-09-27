local player = 0
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
    if num == 1 then 
        num = 2
    elseif num == 2 then 
        num = 1
    end
    
    local animDict = "anim_heist@hs3f@ig3_cardswipe_insync@male@"
    local animName = keycardSyncAnims[1][num][4]
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
        print("hi")
        local random = math.random(1, 3)
        NetworkStartSynchronisedScene(keycardSyncAnims[2][5 + random])
        Wait(2000)
        NetworkStartSynchronisedScene(keycardSyncAnims[2][2])
        KeycardReady(num)
    end
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
    player = GetCurrentHeistPlayer()
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
                if selectedEntryDisguise ~= 3
                    EnableMantrapDoors(0, 0)
                else
                    EnableMantrapDoors(0, 1)
                end

                RemoveAllBlips()
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

            print(#(GetEntityCoords(PlayerPedId()) - vaultEntryDoorCoords))
        end

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
                    else 
                        Bomb()
                        break
                    end
                end
            else 
                SubtitleMsg("Go the ~y~vault door.", 110)
            end
        end
    end)
end

RegisterNetEvent("cl:casinoheist:testCut", MainEntry)

RegisterCommand("test_doors", function(src, args)
    EnableMantrapDoors(tonumber(args[1]), tonumber(args[2]))
end, false)

RegisterCommand("test_basement", FirstMantrap, false)

RegisterCommand("test_cut_agg", function()
    MainEntry()
end, false)