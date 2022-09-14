--local startCoords = {
--    {vector3(), },
--    {vector3(), },
--    {vector3(), },
--    {vector3(), }
--}

local cargobob = {}
local blip = 0
local veh = 0

local function FlyToPos()
    TaskHeliMission(cargobob[2], cargobob[1], 0, 0, cargobobFinalCoords, 4, 10.0, 0.0, 300.0, 9, 7, -1.0, 25280)
    
    while #(GetEntityCoords(cargobob[1]) - cargobobFinalCoords) > 200 do 
        Wait(100)
    end
    
    DoScreenFadeOut(800)
    
    while not IsScreenFadedOut() do 
        Wait(500)
    end

    DeleteVehicle(cargobob[1])
    DeleteEntity(cargobob[2])
    RemoveBlip(cargobob[3])

    cargobob[1] = CreateVehicle(GetHashKey("cargobob2"), cargobobFinalCoords, 250.47, true, false)
    SetVehicleColours(cargobob[1], 0, 0)
    
    cargobob[2] = CreatePed(0, GetHashKey("s_m_y_pilot_01"), cargobobFinalCoords, 0, false, false)
    SetPedIntoVehicle(cargobob[2], cargobob[1], -1)
    SetVehicleEngineOn(cargobob[1], true, true, true)
    
    SetModelAsNoLongerNeeded("cargobob2")
    SetModelAsNoLongerNeeded("s_m_y_pilot_01")

    SetVehicleDoorOpen(cargobob[1], 2, false, true)

    FreezeEntityPosition(cargobob[1], true)
    
    Wait(5000)


    SetEntityCoords(PlayerPedId(), 1305.6, -70.52, 298.0, true, false, false, false)
    SetEntityHeading(PlayerPedId(), 69.19)
    
    DoScreenFadeIn(1000)
    FreezeEntityPosition(cargobob[1], false)
end

local function IsAllPlayersInHeli()
    CreateThread(function()
        while true do 
            Wait(0)
            DisableControlAction(0, 23, true)

            if IsPedInAnyHeli(GetPlayerPed(GetPlayerFromServerId(hPlayer[1]))) and IsPedInAnyHeli(GetPlayerPed(GetPlayerFromServerId(hPlayer[2]))) and IsPedInAnyHeli(GetPlayerPed(GetPlayerFromServerId(hPlayer[3]))) and IsPedInAnyHeli(GetPlayerPed(GetPlayerFromServerId(hPlayer[4]))) then 
                FlyToPos()
                bool = false 
            end
        end 
    end)
end

local function SetupCargobob()
    LoadModel("cargobob2")
    LoadModel("s_m_y_pilot_01")
    
    print(hPlayer[2])

    cargobob[1] = CreateVehicle(GetHashKey("cargobob2"), cargobobCoords, 328.34, true, false)
    SetVehicleColours(cargobob[1], 0, 0)
    
    --SetCarBootOpen(cargobob[1])
    --SetVehicleEngineOn(cargob, true, true, false)

    cargobob[2] = CreatePed(0, GetHashKey("s_m_y_pilot_01"), cargobobCoords, 0, false, false)
    SetEntityForAll(cargobob[2])
    SetPedIntoVehicle(cargobob[2], cargobob[1], -1)
    SetEntityInvincible(cargobob[2], true)
    SetPedRelationshipGroupHash(cargobob[2], GetHashKey("PLAYER"))

    cargobob[3] = AddBlipForEntity(cargobob[1])
    SetBlipSprite(cargobob[3], 422)
    SetBlipColour(cargobob[3], 54)
    SetBlipHighDetail(cargobob[3], true)

    --SetModelAsNoLongerNeeded("cargobob2")
    --SetModelAsNoLongerNeeded("s_m_y_pilot_01")

    while not IsPedInAnyHeli(PlayerPedId()) do 
        Wait(50)
        --print("tick")
        if #(vector3(1060.1, -288.31, 50.81) - GetEntityCoords(PlayerPedId())) < 4 and IsControlPressed(0, 23) then 
            for i = 0, 4 do 
                if IsVehicleSeatFree(cargobob[1], i) then 
                    TaskEnterVehicle(PlayerPedId(), cargobob[1], 1.0, i, 2.0, 0, 0)
                    break
                end
            end
        end
    end

    Wait(3000)
    
    FlyToPos()
end

local function DistanceCasino()
    CreateThread(function()
        while true do 
            Wait(200)

            SubtitleMsg("Go to the ~y~Casino.", 210)

            if #(GetEntityCoords(PlayerPedId()) - vector3(957.67, 42.7, 113.3)) < 250 then 
                if keypads[1][selectedEntrance] ~= 0 and approach ~= 2 then 
                    KeycardThread()
                else 
                    TeleportThread()
                end
                break 
            end 
        end
    end)
end

function StartHeist()
    local player = 1 --GetCurrentHeistPlayer()
    
    approach = 2
    selectedEntryDisguise = 2 
    selectedEntrance = 1

    SetPedRelationshipGroupHash(PlayerPedId(), GetHashKey("PLAYER"))
    AddRelationshipGroup("GUARDS")
    SetRelationshipBetweenGroups(0, GetHashKey("GUARDS"), GetHashKey("GUARDS"))
    SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("GUARDS"))
    SetRelationshipBetweenGroups(5, GetHashKey("GUARDS"), GetHashKey("PLAYER"))

    --DoScreenFadeOut(800)
--
    --while not IsScreenFadedOut() do 
    --    Wait(100)
    --end

    SetPedComponents(1)
    --SetPedModel()
    --FadeTeleport(startCoords[player][1].x, startCoords[player][1].y, startCoords[player][1].z, startCoords[player][2])

    blip = AddBlipForCoord(entryCoords[selectedEntrance])
    SetBlipHighDetail(blip, true)
    SetBlipColour(blip, 5)
    SetBlipRoute(blip, true)
    SetBlipRouteColour(blip, 5)

    if player == 1 then 
        local model = ""
        if approach == 2 and selectedEntryDisguise ~= 4 then
            if selectedEntryDisguise == 1 then 
                model = "burrito2"
            elseif selectedEntryDisguise == 2 then 
                model = "boxville"
            elseif selectedEntryDisguise == 3 then 
                model = "stockade"
            end 
        else
            model = availableVehicles[driver[selectedDriver][3]][2]
        end
        
        LoadModel(model)
        veh = CreateVehicle(GetHashKey(model), 720.82, -842.88, 23.95, 271.44, true, false)

        if selectedEntryDisguise == 3 and approach == 2 then 
            SetVehicleColours(veh, 111, 0)
        end
    end

    DistanceCasino()

    --DoScreenFadeIn(1500)
end

RegisterCommand("test_vehicle", function()
    --LoadModel("adder")
    --
    --veh = CreateVehicle(GetHashKey("adder"), GetEntityCoords(PlayerPedId()), 0, true, false)
    --
    --SetPedIntoVehicle(PlayerPedId(), veh, -1)
    --SetVehicleColours(veh, 7, 7)
    blip = AddBlipForCoord(957.67, 42.7, 113.3)
    SetBlipHighDetail(blip, true)
    SetBlipColour(blip, 5)
    SetBlipRoute(blip, true)
    SetBlipRouteColour(blip, 5)
    DistanceCasino()
    SetupCargobob()
    --FlyToPos()
end, false)

local keycardScene = 0

local function KeypadOne(j)
    local keycard = "ch_prop_vault_key_card_01a"
    local animDict = "anim_heist@hs3f@ig3_cardswipe@male@"
    
    LoadModel(keycard)
    LoadAnim(animDict)
    
    local keypadObj = GetClosestObjectOfType(keypads[1][j], 1.0, GetHashKey("ch_prop_fingerprint_scanner_01a"), false, false, false)
    local keycardObj = CreateObject(GetHashKey(keycard), GetEntityCoords(PlayerPedId()), true, true, false)
    
    keycardScene = NetworkCreateSynchronisedScene(GetEntityCoords(keypadObj), GetEntityRotation(keypadObj), 2, true, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(PlayerPedId(), keycardScene, animDict, "success_var02", 4.0, -4.0, 2000, 0, 1000.0, 0)
    NetworkAddEntityToSynchronisedScene(keycardObj, keycardScene, animDict, "success_var02_card", 1.0, -1.0, 114886080)
    
    NetworkStartSynchronisedScene(keycardScene)
    Wait(3700)
    DeleteObject(keycardObj)
    ClearPedTasks(PlayerPedId())
end

function KeycardThread()
    --blip = AddBlipForCoord(957.67, 42.7, 113.3)
    SetBlipCoords(blip, keypads[1][selectedEntrance])
    SetBlipSprite(blip, 730)
    SetBlipRoute(blip, false)
    SetBlipColour(blip, 2)
    
    CreateThread(function()
        while true do 
            Wait(30)
            
            SubtitleMsg("Enter the ~g~Casino.", 50)
            
            if #(GetEntityCoords(PlayerPedId()) - keypads[1][selectedEntrance]) < 1.3 then 
                
                HelpMsg("Press ~INPUT_CONTEXT~ to swipe your keycard.")
                if IsControlPressed(0, 38) then
                    RemoveBlip(blip) 
                    KeypadOne(1)
                    break
                end
            end
        end
    end)
    
    CreateThread(function()
        while true do 
            Wait(100)
            
            if IsEntityPlayingAnim(GetHeistPlayerPed(hPlayer[1]), "anim_heist@hs3f@ig3_cardswipe@male@", "success_var02", 3) or IsEntityPlayingAnim(GetHeistPlayerPed(hPlayer[2]), "anim_heist@hs3f@ig3_cardswipe@male@", "success_var02", 3) or IsEntityPlayingAnim(GetHeistPlayerPed(hPlayer[3]), "anim_heist@hs3f@ig3_cardswipe@male@", "success_var02", 3) or IsEntityPlayingAnim(GetHeistPlayerPed(hPlayer[4]), "anim_heist@hs3f@ig3_cardswipe@male@", "success_var02", 3) then 
                Wait(4000)
                SetBlipRoute(blip, false)
                RemoveBlip(blip)
                --EnterCasino()
                break
            end
        end
    end)
end

function TeleportThread()
    CreateThread(function()
        while true do 
            Wait(100)

            if #(GetEntityCoords(veh) - entryCoords[6]) < 50 and selectedEntrance == 6 then 
                EnterCasinoTunnel()
                break
            elseif #(GetEntityCoords(PlayerPedId()) - entryCoords[selectedEntrance]) < 5 then
                if IsNotClose(5) then
                    SubtitleMsg("Wait for your team members", 110)
                else 
                    EnterCasino()
                    break
                end
            else 
                SubtitleMsg("Go to the ~y~Casino.", 110)
            end
        end
    end)
end

function EnterCasinoTunnel()
    DoScreenFadeOut(500)

    while not IsScreenFadedOut() do 
        Wait(0)
    end

    DoScreenFadeIn(500)

    local cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 1007.69, -56.7, 75.5, 0, 0, 112.75, 40.0, true, 2)
    local garageDoor = GetClosestObjectOfType(998.97, -52.5, 73.95, 1.0, GetHashKey("vw_prop_vw_garagedoor_01a"), false, false, false)
    local player = 1 --GetCurrentHeistPlayer()

    SetCamActive(cam, true)
    RenderScriptCams(true, false, 0, true, true)
    PointCamAtEntity(cam, veh, 0.0, 0.0, 0.0, true)
    
    SetEntityVisible(garageDoor, false)
    SetEntityCollision(garageDoor, false, true)
    if player == 1 then 
        SetEntityCoords(veh, 974.74, -73.41, 74.65, true, false, false, false)
        SetEntityHeading(veh, 298.63)

        TaskVehicleDriveToCoord(GetPedInVehicleSeat(veh, -1), veh, 994.32, -63.89, 74.56, 45.0, 1.0, GetHashKey("stockade"), 524320, 0.5, 100.0)
        
        while #(GetEntityCoords(veh) - vector3(994.32, -63.89, 74.56)) > 1 do 
            Wait(10)
        end
        
        TaskVehicleDriveToCoord(GetPedInVehicleSeat(veh, -1), veh, 997.1, -48.63, 74.56, 25.0, 1.0, GetHashKey("stockade"), 786944, 0.5, 100.0)
    end

    while #(GetEntityCoords(veh) - vector3(997.1, -48.63, 74.56)) > 5 do 
        Wait(10)
    end 
    
    DoScreenFadeOut(800)
    
    while not IsScreenFadedOut() do 
        Wait(10)
    end 
    
    RenderScriptCams(false, false, 0, true, false)
    DestroyCam(cam)

    if player == 1 then 
        SetEntityCoords(veh, 2650.31, -339.48, -65.12, true, false, false, true)
        SetEntityHeading(veh, 49.55)
    end

    Wait(5000) 
    DoScreenFadeIn(1500)

    RemoveBlip(blip)
end

RegisterNetEvent("test:sync:nj", function()
    --LoadModel("stockade")
    --if GetCurrentHeistPlayer() == 1 then 
    --    veh = CreateVehicle(GetHashKey("stockade"), 974.74, -73.41, 74.65, 298.63, true, false)
    --    SetPedIntoVehicle(PlayerPedId(), -1)
    --end 
--
    --EnterCasinoTunnel()
end)

RegisterCommand("test_tunnel", function()
    --LoadModel("stockade")
    ----veh = CreateVehicle(GetHashKey("stockade"), 720.82, -842.88, 23.95, 271.44, true, false)
    --veh = CreateVehicle(GetHashKey("stockade"), 974.74, -73.41, 74.65, 298.63, true, false)
    --EnterCasinoTunnel()
    StartHeist()
end, false)

RegisterCommand("test_keypads", function()
    KeycardThread()
end, false)