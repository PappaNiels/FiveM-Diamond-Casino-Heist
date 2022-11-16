local vehs = {}
local blips = {}

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
                if IsNotClose(exitCoords[selectedExit][1][1], 3) then 
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
    DoScreenFadeOut(800)

    while not IsScreenFadedOut() do 
        Wait(0)
    end

    SetEntityCoords(PlayerPedId(), 0, 0, 0, true, false, false, true)
    SetEntityHeading(PlayerPedId(), 0)

    DoScreenFadeIn(800)

    LoadCutscene("hs3f_all_esc")
    StartCutscene(0)

    repeat Wait(10) until HasCutsceneFinished()

    if player == 1 then 
        veh[1] = CreateVehicle(GetHashKey(availableVehicles[selectedDriver][1][selectedVehicle][1]), 982.61, -211.15, 70.38, 57.54, true, false)
        veh[2] =CreateVehicle(GetHashKey(availableVehicles[selectedDriver][1][selectedVehicle][1]), 992.93, -214.45, 69.83, 238.67, true, false)
    end

    for i = 1 , 2 do 
        blips[i] = AddBlipForCoord(getawayVehicles[i])
        SetBlipSprite(blips[i], 225)
        SetBlipColour(blips[i], 54)
    end

    CreateThread(function()
        while true do 
            Wait(1000)

            SubtitleMsg("Deliver the ~g~loot~s~ to the ~y~buyer.", 1100)
        end
    end)

    while not IsPedInAnyVehicle(PlayerPedId(), true) do 
        Wait(100)
    end

    RemoveBlip(blips[2])

    SetBlipCoords()
    SetBlipSprite()
    SetBlipColour()
    --RemoveBlip(blips[i])
end

RegisterCommand("test_veh", function()
    LoadModel("t20")
    veh = CreateVehicle(GetHashKey("t20"), 985.31, -215.88, 70.5, 271.44, true, false)
end)