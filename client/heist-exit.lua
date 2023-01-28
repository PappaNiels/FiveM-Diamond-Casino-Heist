local triggered = false

local vehs = {}
local blips = {}
local peds = {}
local clothingChange = {}

local function ChangeClothing(k)
    local animDict = "anim_heist@hs3f@ig12_change_clothes@"
    TriggerServerEvent("sv:casinoheist:syncClotingBlips", k)
    LoadAnim(animDict)
    TaskLookAtEntity(PlayerPedId(), clothingChange[k], 1000, 2048, 3)
    Wait(1000)
    
    TaskPlayAnim(PlayerPedId(), animDict, "action_01_male", -4.0, 4.0, -1, 0, 2, false, false, false)
    
    SetPedComponents(2)
    RemoveAnimDict(animDict)
end

function VaultLobby(blip, old)
    if blip then 
        for i = 3, 4 do 
            blips[i] = AddBlipForCoord(keypads[4][i])
            SetBlipSprite(blips[i], 733)
            SetBlipColour(blips[i], 2)
            SetBlipHighDetail(blips[i], true)
        end

        ReleaseNamedScriptAudioBank("DLC_HEIST3/HEIST_FINALE_STEAL_PAINTINGS")
    end

    local animDict = "anim_heist@hs3f@ig3_cardswipe_insync@male@"
    local animNameOne = "ped_a_loop"
    local animNameTwo = "ped_b_loop"
    local swiped = false
    local sync = false
    local x = 0

    CreateThread(function()
        while true do 
            Wait(GetFrameTime())

            if not isSwiping then 
                SubtitleMsg("Go to one of the ~g~keypads~s~.", 110)

                local distanceL, distanceR = #(GetEntityCoords(PlayerPedId()) - keypads[4][3]), #(GetEntityCoords(PlayerPedId()) - keypads[4][4])
                
                if distanceL < 2.0 or distanceR < 2.0 then 
                    HelpMsg("Press ~INPUT_CONTEXT~ to get in position to insert the keycard.") 
                    if IsControlPressed(0, 38) then 
                        if distanceL < distanceR then 
                            SyncKeycardEnter(3)
                        else
                            SyncKeycardEnter(4)
                        end
                        isSwiping = true
                        break
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

                if (sync and swiped) or triggered then 
                    if isSwiping then 
                        NetworkStartSynchronisedScene(keycardSyncAnims[2][5])
                        Wait(2000)
                        ClearPedTasks(PlayerPedId())
                        DeleteEntity(keycardObj)
                    end 

                    swiped = false
                    isSwiping = true
                    RemoveBlip(blips[3])
                    RemoveBlip(blips[4])
                    SetRoom(2)
                    GoToExit()
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

function GoToExit()
    local isInCasino = true 
    local disguise = false 

    EnableMantrapDoors(0, 0)

    blips[1] = AddBlipForCoord(casinoEntryCoords[selectedExit][1][1])
    SetBlipColour(blip, 5)

    local txt = {
        [1] = "Waste Disposal",
        [3] = "Roof Terrace",
        [4] = "Roof",
        [5] = "Roof Terrace",
        [8] = "Roof Terrace",
        [9] = "Roof",
        [10] = "Roof Terrace",
        [11] = "Staff Lobby"
    }

    CreateThread(function()
        while isInCasino do 
            Wait(100)

            local coords = GetEntityCoords(PlayerPedId())

            if #(coords - casinoEntryCoords[selectedExit][1][1]) < 3 then 
                if IsNotClose(casinoEntryCoords[selectedExit][1][1], 3) then 
                    SubtitleMsg("Wait for your team members", 110)
                else 
                    ExitCasino()
                    DeleteEntity(clothingChange[1])
                    DeleteEntity(clothingChange[2])
                    isInCasino = false
                end
            else 
                SubtitleMsg("Exit the Casino via the ~y~" .. txt[selectedExit], 110)
            end

            if coords.z > -59 --[[and GetRoom() == 2]] then 
                --SetRoom(1)

                --if alarmTriggered == 0 then 
                --    SetBlipsColour(1)
                --end 

                if approach == 2 and selectedExitDisguise ~= 0 and selectedExitDisguise < 4 then 
                    local bag = "ch_prop_ch_duffelbag_01x"
                    local basket = "v_res_tre_laundrybasket"
            
                    if player == 1 then 
                        LoadModel(bag)
            
                        for i = 1, 2 do 
                            clothingChange[i] = CreateObject(GetHashKey(bag), clothingChangeCoords[i].xyz, true, false, false)
                            SetEntityHeading(clothingChange[i], clothingChangeCoords[i].w)
                        end
                        SetModelAsNoLongerNeeded(bag)
                    else 
                        Wait(10)
            
                        for i = 1, 2 do 
                            clothingChange[i] = GetClosestObjectOfType(clothingChangeCoords[i].xyz, 1.0, GetHashKey(bag), false, false, false)
                        end
                    end
            
                    if playerAmount == 3 then 
                        clothingChange[3] = GetClosestObjectOfType(clothingChangeCoords[3], 1.0, GetHashKey(basket), false, false, false)
                    elseif playerAmount == 4 then 
                        clothingChange[3] = GetClosestObjectOfType(clothingChangeCoords[3], 1.0, GetHashKey(basket), false, false, false)
                        clothingChange[4] = GetClosestObjectOfType(clothingChangeCoords[4], 1.0, GetHashKey(basket), false, false, false)
                    end
            
                    for i = 1, #clothingChange do 
                        blips[i + 1] = AddBlipForEntity(clothingChange[i])
                        SetBlipSprite(blips[i + 1], 73)
                        SetBlipScale(blips[i + 1], 0.75)
                    end
                end
            end
        end
    end)

    CreateThread(function()
        while isInCasino and not disguise and alarmTriggered == 0 do 
            Wait(GetFrameTime())

            for k, v in pairs(clothingChangeCoords) do 
                if #(GetEntityCoords(PlayerPedId()) - v.xyz) < 1.5 and DoesBlipExist(blips[k + 1]) then 
                    HelpMsg("Press ~INPUT_CONTEXT~ to change clothes")

                    if IsControlJustPressed(0, 38) then 
                        ChangeClothing(k)
                        SetBlipsColour(0)
                        disguise = true
                    end
                end
            end
        end
        for i = 2, #blips do 
            RemoveBlip(blips[i])
        end
    end)
end

function ExitCasino()
    local doorHash = {1466913421, -2088850773, 1969557112, -1608031236}

    for i = 1, #blips do 
        RemoveBlip(blips[i])
    end

    RemoveObjs()

    DeletePaths()

    DoScreenFadeIn(1000)
    print("Data set")
    player = 1
    selectedExit = 11
    selectedDriver = 1
    selectedVehicle = 4
    selectedBuyer = 3
    DoScreenFadeOut(2000)

    while not IsScreenFadedOut() do 
        Wait(10)
    end

    RemoveAnimDict("anim_heist@hs3f@ig1_hack_keypad@arcade@male@")
    RemoveAnimDict("anim_heist@hs3f@ig3_cardswipe@male@")
    RemoveAnimDict("anim_heist@hs3f@ig3_cardswipe_insync@male@")

    SetModelAsNoLongerNeeded("prop_phone_ing")
    SetModelAsNoLongerNeeded("ch_prop_ch_usb_drive01x")
    SetModelAsNoLongerNeeded("ch_prop_vault_key_card_01a")

    EnableMantrapDoors(1, 1)

    for i = 1, #doorHash do 
        RemoveDoorFromSystem(doorHash[i])
    end

    SetEntityCoords(PlayerPedId(), entryCoords[selectedExit], true, false, false, true)
    SetEntityHeading(PlayerPedId(), 0)

    ClearAreaOfPeds(entryCoords[selectedExit], 1000, 1)

    HideTimerBars()

    LoadCutscene("hs3f_all_esc")
    StartCutscene(0)
    DoScreenFadeIn(100)
    
    repeat Wait(10) until GetCutsceneTotalDuration() - GetCutsceneTime() < 1000

    DoScreenFadeOut(1000)
    
    while not IsScreenFadedOut() do 
        Wait(10)
    end

    ShowTimerbars(true)
    RemoveCutscene()

    if player == 1 then 
        LoadModel(availableVehicles[selectedDriver][1][selectedVehicle][1])
        vehs[1] = CreateVehicle(GetHashKey(availableVehicles[selectedDriver][1][selectedVehicle][1]), 982.61, -211.15, 70.38, 57.54, true, false)
        vehs[2] = CreateVehicle(GetHashKey(availableVehicles[selectedDriver][1][selectedVehicle][1]), 992.93, -214.45, 69.83, 238.67, true, false)
        SetModelAsNoLongerNeeded(availableVehicles[selectedDriver][1][selectedVehicle][1])
    end
    
    for i = 1 , 2 do 
        blips[i] = AddBlipForCoord(getawayVehicles[i])
        SetBlipSprite(blips[i], 225)
        SetBlipColour(blips[i], 54)
    end
    
    DoScreenFadeIn(2000)
    
    while not IsPedInAnyVehicle(GetHeistPlayerPed(hPlayer[1]), true) and not IsPedInAnyVehicle(GetHeistPlayerPed(hPlayer[2]), true) and not IsPedInAnyVehicle(GetHeistPlayerPed(hPlayer[3]), true) and not IsPedInAnyVehicle(GetHeistPlayerPed(hPlayer[4]), true) do 
        Wait(100)
        
        if IsPedInAnyVehicle(PlayerPedId(), true) then 
            SubtitleMsg("Wait for your team to get into a vehicle", 110)
        else
            SubtitleMsg("Deliver the ~g~loot~s~ to the ~y~buyer", 110)
        end 
    end

    if alarmTriggered == 1 then 
        CancelMusicEvent("CH_GUNFIGHT_START")
    else 
        CancelMusicEvent("CH_IDLE")
    end

    PrepareMusicEvent("CH_DELIVERING")
    TriggerMusicEvent("CH_DELIVERING")
    
    RemoveBlip(blips[2])
    RemoveBlip(blips[1])
    
    if player == 1 then 
        print(print(" yesy"))
        TriggerServerEvent("sv:casinoheist:syncMeet", false)
    end
end

local function Route(meet)
    if not meet then 
        meet = 1
    end

    local pedModels = {
        --{"g_m_m_armboss_01", "g_m_m_armgoon_01", "g_m_m_armgoon_01"},
        {"g_m_m_mexboss_01", "g_m_y_mexgoon_01", "g_f_y_vagos_01"},
        {"g_m_m_mexboss_01", "g_m_y_mexgoon_01", "g_f_y_vagos_01"},
        {"s_m_m_movprem_01", "s_m_m_highsec_01", "s_m_m_highsec_01"}
    }
    local model = {
        "cognoscenti",
        "cognoscenti",
        "baller6"
    }

    blips[1] = AddBlipForCoord(meetingPoint[selectedBuyer][meet])
    SetBlipColour(blips[1], 5)
    SetBlipRoute(blips[1], true)
    SetBlipRouteColour(blips[1], 5)
    
    heistInProgress = true

    if player == 1 then 
        LoadModel(model[selectedBuyer])

        for i = 1, 3 do 
            LoadModel(pedModels[selectedBuyer][i])
        end
    end
    
    CreateThread(function()
        while heistInProgress do 
            Wait(1000)
            
            if #(GetEntityCoords(PlayerPedId()) - meetingPoint[selectedBuyer][meet]) < 10 then 
                if IsNotClose(meetingPoint[selectedBuyer][meet], 10) then 
                    SubtitleMsg("Wait for your team to reach the buyer", 1100)
                else 
                    FinishHeist(meet)
                end
            else 
                SubtitleMsg("Deliver the ~g~loot~s~ to the ~y~buyer.", 1100)
            end
        end
    end)

    while #(GetEntityCoords(PlayerPedId()).xy - meetingPoint[selectedBuyer][meet].xy) > 2000 do 
        Wait(1000)
    end

    DisableAlarm()
    ReleaseNamedScriptAudioBank("DLC_VINEWOOD/VW_CASINO_FINALE")

    vehs[3] = CreateVehicle(GetHashKey(model[selectedBuyer]), meetingPoint[selectedBuyer][meet], false, false)

    repeat Wait(10) print("tick") until DoesEntityExist(vehs[3])

    for i = 1, 3 do 
        peds[i] = CreatePedInsideVehicle(vehs[3], 1, GetHashKey(pedModels[selectedBuyer][i]), -2 + i, false, false)
    end

    SetModelAsNoLongerNeeded(model[selectedBuyer])

    for i = 1, #pedModels[selectedBuyer] do 
        SetModelAsNoLongerNeeded(pedModels[selectedBuyer][i])
    end

    for i = 1, 3 do 
        SetPedRelationshipGroupHash(peds[i], GetHashKey("PLAYER"))
    end
end

function FinishHeist(meet)
    local buyer = 0
    heistInProgress = false
    if selectedBuyer == 1 then 
        buyer = 2
    else 
        buyer = selectedBuyer
    end

    LoadCutscene("hs3f_all_drp" .. buyer)
    SetCutsceneOrigin(meetingPoint[selectedBuyer][meet])
    StartCutscene(0)

    for i = 1, #vehs do 
        DeleteVehicle(vehs[i])
    end

    for i = 1, #peds do 
        DeletePed(peds[i])
    end

    for i = 1, #blips do 
        RemoveBlip(blips[i])
    end

    HideTimerBars()
    CancelMusicEvent("CH_DELIVERING")

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

    repeat Wait(100) until GetCutsceneTotalDuration() - GetCutsceneTime() < 1000

    --DoScreenFadeOut(2000)
--
    --while not IsScreenFadedOut() do 
    --    Wait(10)
    --end

    EndScreen()
    RemoveCutscene()
    SetStreamedTextureDictAsNoLongerNeeded("timerbars")
    --LoadCutscene("")

    ReleaseNamedScriptAudioBank("DLC_HEIST3/CASINO_HEIST_FINALE_GENERAL_01")
    exports.spawnmanager:setAutoSpawn(true)
end

RegisterNetEvent("cl:casinoheist:syncMeet", Route)

RegisterNetEvent("cl:casinoheist:syncClotingBlips", function(k)
    RemoveBlip(blips[k + 1])
end)

RegisterCommand("test_veh", function()
    LoadModel("t20")
    veh = CreateVehicle(GetHashKey("t20"), 985.31, -215.88, 70.5, 271.44, true, false)
end)

RegisterCommand("test_exit", ExitCasino, false)

RegisterCommand("skip_swipe2", function()
    triggered = true
end)

RegisterCommand("test_cc", function()
    selectedExit = 11
    approach = 2
    player = 1
    selectedEntryDisguise = 3
    selectedExitDisguise = 3
    GoToExit()
end, false)