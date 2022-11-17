local vehs = {}
local blips = {}
local peds = {}

function VaultLobby(blip, old)
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
    local animNameOne = "ped_a_loop"
    local animNameTwo = "ped_b_loop"
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
                            SyncKeycardEnter(3)
                        else
                            SyncKeycardEnter(4)
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
    EnableMantrapDoors(0, 0)

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
        while true do 
            Wait(100)

            if #(GetEntityCoords(PlayerPedId()) - casinoEntryCoords[selectedExit][1][1]) < 3 then 
                if IsNotClose(casinoEntryCoords[selectedExit][1][1], 3) then 
                    SubtitleMsg("Wait for your team members", 110)
                else 
                    ExitCasino()
                    break
                end
            else 
                SubtitleMsg("Exit the Casino via the ~y~" .. txt[selectedExit], 110)
            end
        end
    end)
end

function ExitCasino()
    DoScreenFadeIn(1000)
    player = 1
    selectedExit = 11
    selectedDriver = 1
    selectedVehicle = 4
    selectedBuyer = 3
    DoScreenFadeOut(2000)

    while not IsScreenFadedOut() do 
        Wait(10)
    end

    SetEntityCoords(PlayerPedId(), entryCoords[selectedExit], true, false, false, true)
    SetEntityHeading(PlayerPedId(), 0)

    
    LoadCutscene("hs3f_all_esc")
    StartCutscene(0)
    DoScreenFadeIn(0)
    
    repeat Wait(10) until HasCutsceneFinished()
    
    DoScreenFadeOut(1)
    
    while not IsScreenFadedOut() do 
        Wait(10)
    end

    if player == 1 then 
        LoadModel(availableVehicles[selectedDriver][1][selectedVehicle][1])
        print(print(availableVehicles[selectedDriver][1][selectedVehicle][1]))
        vehs[1] = CreateVehicle(GetHashKey(availableVehicles[selectedDriver][1][selectedVehicle][1]), 982.61, -211.15, 70.38, 57.54, true, false)
        vehs[2] = CreateVehicle(GetHashKey(availableVehicles[selectedDriver][1][selectedVehicle][1]), 992.93, -214.45, 69.83, 238.67, true, false)
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
    
    RemoveBlip(blips[2])
    RemoveBlip(blips[1])
    
    if player == 1 then 
        print(print(" yesy"))
        TriggerServerEvent("sv:casinoheist:syncMeet", false)
    end
end

local function Route(meet)
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

    selectedBuyer = 3
    blips[1] = AddBlipForCoord(meetingPoint[selectedBuyer][meet])
    print(meetingPoint[selectedBuyer][meet])
    SetBlipColour(blips[1], 5)
    SetBlipRoute(blips[1], true)
    SetBlipRouteColour(blips[1], 5)
    
    heistInProgress = true

    if player == 1 then 
        LoadModel(model[selectedBuyer])

        for i = 1, 2 do 
            LoadModel(pedModels[selectedBuyer][i])
        end
        
        vehs[3] = CreateVehicle(GetHashKey(model), meetingPoint[selectedBuyer][meet], true, false)
        
        for i = 1, 3 do 
            peds[i] = CreatePedInsideVehicle(veh[3], 0, GetHashKey(pedModels[selectedBuyer][i]), -2 + i, true, false)
        end
    end
    
    CreateThread(function()
        while heistInProgress do 
            Wait(1000)
            
            if #(GetEntityCoords(PlayerPedId()) - meetingPoint[selectedBuyer][meet]) < 5 then 
                if IsNotClose(meetingPoint[selectedBuyer][meet], 5) then 
                    SubtitleMsg("Wait for your team to reach the buyer", 1100)
                else 
                    FinishHeist(meet)
                end
            else 
                SubtitleMsg("Deliver the ~g~loot~s~ to the ~y~buyer.", 1100)
            end
        end
    end)
end

function FinishHeist(meet)
    local buyer = 0
    if selectedBuyer == 1 then 
        buyer = 2
    else 
        buyer = selectedBuyer
    end

    LoadCutscene("hs3f_all_drp" .. buyer)
    SetCutsceneOrigin(meetingPoint[selectedBuyer][meet])
    StartCutscene(0)

    for i = 1, 3 do 
        DeleteVehicle(vehs[i])
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

    repeat Wait(100) until HasCutsceneFinished()

    DoScreenFadeOut(2000)

    while not IsScreenFadedOut() do 
        Wait(10)
    end

    LoadCutscene("")
end

RegisterNetEvent("cl:casinoheist:syncMeet", Route)

RegisterCommand("test_veh", function()
    LoadModel("t20")
    veh = CreateVehicle(GetHashKey("t20"), 985.31, -215.88, 70.5, 271.44, true, false)
end)

RegisterCommand("test_exit", ExitCasino, false)