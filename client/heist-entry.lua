player = 0
   
local blip = 0
local veh = 0
local keycardScene = 0

local cargobob = {}
local netIds = {}
local startCoords = {
    vector3(723.4, -827.73, 24.69),
    vector3(721.63, -827.73, 24.59),
    vector3(723.4, -825.58, 24.69),
    vector3(721.63, -825.58, 24.59)
}

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

local function FlyToPos()
    if player == 1 then 
        TaskHeliMission(cargobob[2], cargobob[1], 0, 0, cargobobFinalCoords, 4, 10.0, 0.0, 300.0, 9, 7, -1.0, 25280)
    end 

    while #(GetEntityCoords(cargobob[1]) - cargobobFinalCoords) > 200 do 
        DisableControlAction(0, 23, true)
        Wait(100)
    end
    
    DoScreenFadeOut(800)
    
    while not IsScreenFadedOut() do 
        Wait(500)
    end

    if player == 1 then 
        DeleteVehicle(cargobob[1])
        DeleteEntity(cargobob[2])
        RemoveBlip(cargobob[3])

        cargobob[1] = CreateVehicle(GetHashKey("cargobob2"), cargobobFinalCoords, 250.47, true, false)
        SetVehicleColours(cargobob[1], 0, 0)
        
        cargobob[2] = CreatePedInsideVehicle(cargobob[1], 0, GetHashKey("s_m_y_pilot_01"), -1, true, false)
        SetPedIntoVehicle(cargobob[2], cargobob[1], -1)
        SetVehicleEngineOn(cargobob[1], true, true, true)
    end
    
    SetModelAsNoLongerNeeded("cargobob2")
    SetModelAsNoLongerNeeded("s_m_y_pilot_01")

    SetVehicleDoorOpen(cargobob[1], 2, false, true)
    FreezeEntityPosition(cargobob[1], true)
    
    SetEntityCoords(PlayerPedId(), 1305.6, -70.52, 400.3, true, false, false, false)
    SetEntityHeading(PlayerPedId(), 69.19)

    Wait(2000)
    FreezeEntityPosition(cargobob[1], false)
    Wait(3000) 

    DoScreenFadeIn(1000)
end

local function IsAllPlayersInHeli()
    CreateThread(function()
        while true do 
            Wait(0)
            DisableControlAction(0, 23, true)

            if IsPedInAnyHeli(GetPlayerPed(GetPlayerFromServerId(hPlayer[1]))) and IsPedInAnyHeli(GetPlayerPed(GetPlayerFromServerId(hPlayer[2]))) and (IsPedInAnyHeli(GetPlayerPed(GetPlayerFromServerId(hPlayer[3]))) or hPlayer[3] == nil) and (IsPedInAnyHeli(GetPlayerPed(GetPlayerFromServerId(hPlayer[4])))or hPlayer[4] == nil) then 
                FlyToPos()
                break 
            end
        end 
    end)
end

local function SetupCargobob()
    if player == 1 then 
        LoadModel("cargobob2")
        LoadModel("s_m_y_pilot_01")

        --ClearArea(cargobobCoords, 100.0, true, false, false, false)

        cargobob[1] = CreateVehicle(GetHashKey("cargobob2"), cargobobCoords, 328.34, true, false)
        SetVehicleColours(cargobob[1], 0, 0)
        
        cargobob[2] = CreatePed(0, GetHashKey("s_m_y_pilot_01"), cargobobCoords, 0, false, false)
        SetPedIntoVehicle(cargobob[2], cargobob[1], -1)
        SetEntityInvincible(cargobob[2], true)
        SetPedRelationshipGroupHash(cargobob[2], GetHashKey("PLAYER"))
        
        while not DoesEntityExist(cargobob[2]) do 
            Wait(10)
        end

        
        

        netIds[1] = VehToNet(cargobob[1])
        netIds[2] = PedToNet(cargobob[2])
        
        TriggerServerEvent("sv:casinoheist:syncNetIds", netIds)
    else
        
        NetworkRequestControlOfNetworkId(netIds[1])
        NetworkRequestControlOfNetworkId(netIds[2])
        
        Wait(2000)

        --while not NetworkHasControlOfNetworkId(netIds[1]) and not NetworkHasControlOfNetworkId(netIds[2]) do 
        --    Wait(10)
        --end
        cargobob[1] = NetToVeh(netIds[1])
        cargobob[2] = NetToPed(netIds[2])
        SetPedRelationshipGroupHash(cargobob[2], GetHashKey("PLAYER"))
    end

    cargobob[3] = AddBlipForCoord(cargobobCoords)
    
    SetBlipSprite(cargobob[3], 422)
    SetBlipColour(cargobob[3], 54)
    SetBlipHighDetail(cargobob[3], true)
    
    while not IsPedInAnyHeli(PlayerPedId()) do 
        Wait(50)
        if #(vector3(1060.1, -288.31, 50.81) - GetEntityCoords(PlayerPedId())) < 4 and IsControlPressed(0, 23) then 
            for i = 0, 4 do 
                if IsVehicleSeatFree(cargobob[1], i) then 
                    TaskEnterVehicle(PlayerPedId(), cargobob[1], 1.0, i, 2.0, 0, 0)
                    RemoveBlip(cargobob[3])
                    break
                end
            end
        end
    end

    Wait(3000)
    
    IsAllPlayersInHeli()
end

local function DistanceCasino()
    if selectedEntrance == 7 then 
        CreateThread(function()
            while true do 
                Wait(200)
    
                SubtitleMsg("Go to the ~y~Sewer.", 210)
    
                if #(GetEntityCoords(PlayerPedId()) - vector3(1031.04, -268.99, 50.85)) < 50 then 
                    TeleportThread()
                    break 
                end 
            end
        end)
    else
        CreateThread(function()
            while true do 
                Wait(200)
    
                SubtitleMsg("Go to the ~y~Casino.", 210)
    
                if #(GetEntityCoords(PlayerPedId()) - vector3(957.67, 42.7, 113.3)) < 250 then 
                    if keypads[1][selectedEntrance] ~= 0 and approach ~= 2 and selectedEntrance ~= 2 then 
                        KeycardThread()
                    else 
                        TeleportThread()
                    end
                    break 
                end 
            end
        end)
    end
end

function StartHeist()
    player = GetCurrentHeistPlayer()
    print(player)
    print(selectedEntrance)

    --loot = 3
    --approach = 3
    --selectedEntryDisguise = 3 
    --selectedDriver = 1
    --selectedVehicle = 1
    --selectedEntrance = 2
    --selectedHacker = 2
    --selectedBuyer = 3
    --selectedExit = 11


    playerAmount = #hPlayer

    if player == 1 then 
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
    end

    SetPedRelationshipGroupHash(PlayerPedId(), GetHashKey("PLAYER"))
    AddRelationshipGroup("GUARDS")
    SetRelationshipBetweenGroups(0, GetHashKey("GUARDS"), GetHashKey("GUARDS"))
    SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("GUARDS"))
    SetRelationshipBetweenGroups(5, GetHashKey("GUARDS"), GetHashKey("PLAYER"))

    DoScreenFadeOut(800)

    while not IsScreenFadedOut() do 
        Wait(100)
    end

    SetEntityCoords(PlayerPedId(), startCoords[player], true, false, false, true)
    SetEntityHeading(PlayerPedId(), 180.0)

    SetPedComponents(1)

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
            model = availableVehicles[selectedDriver][2]
        end

        LoadModel(model)
        veh = CreateVehicle(GetHashKey(model), 720.82, -842.88, 23.95, 271.44, true, false)

        if selectedEntryDisguise == 3 and approach == 2 then 
            SetVehicleColours(veh, 111, 0)
        elseif approach ~= 2 then 
            SetVehicleColours(veh, 0, 11) 
        end
    end

    DistanceCasino()

    Wait(5000)

    DrawTeamlives()

    DoScreenFadeIn(1500)

    if selectedEntrance == 3 or selectedEntrance == 4 or selectedEntrance == 5 or selectedEntrance == 8 or selectedEntrance == 9 or selectedEntrance == 10 then 
        SetupCargobob()
    end

end

function KeycardThread()
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
                    KeypadOne(selectedEntrance)
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
                EnterCasino()
                break
            end
        end
    end)
end

function TeleportThread()
    veh = GetVehiclePedIsIn(GetHeistPlayerPed(hPlayer[1]), false)
    CreateThread(function()
        while true do 
            Wait(100)

            if selectedEntrance == 6 and #(GetEntityCoords(veh) - entryCoords[6]) < 50 then 
                EnterCasinoTunnel()
                break
            elseif #(GetEntityCoords(PlayerPedId()) - entryCoords[selectedEntrance]) < 3 and selectedEntrance ~= 6 then
                if IsNotClose(entryCoords[selectedEntrance], 3) then
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

function EnterCasino()
    DoScreenFadeOut(500)

    while not IsScreenFadedOut() do 
        Wait(10)
    end

    if approach == 3 and selectedEntrance == 2 then 
        SetEntityCoords(PlayerPedId(), aggressiveMainEntry, true, false, false, false)
    else
        SetEntityCoords(PlayerPedId(), casinoEntryCoords[selectedEntrance][player][1], true, false, false, false)
        SetEntityHeading(PlayerPedId(), casinoEntryCoords[selectedEntrance][player][2])
    end 
    
    RemoveBlip(blip)
    Wait(2000)

    if selectedEntrance == 2 then 
        MainEntry()
    elseif selectedEntrance == 4 or selectedEntrance == 9 then 
        HeliPadEntry()
    elseif selectedEntrance == 3 or selectedEntrance == 5 or selectedEntrance == 8 or selectedEntrance == 10 then 
        RoofTerraceEntry()
    elseif selectedEntrance == 7 then 
        SewerEntry()
    elseif selectedEntrance == 1 or selectedEntrance == 11 then 
        Basement()
    end
end

function EnterCasinoTunnel()
    DoScreenFadeOut(500)
    
    while not IsScreenFadedOut() do 
        Wait(0)
    end

    if player == 1 then 
        SetEntityCoords(veh, 974.74, -73.41, 74.65, true, false, false, false)
    end

    DoScreenFadeIn(500)

    local cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 1007.69, -56.7, 75.5, 0, 0, 112.75, 40.0, true, 2)
    local garageDoor = GetClosestObjectOfType(998.97, -52.5, 73.95, 1.0, GetHashKey("vw_prop_vw_garagedoor_01a"), false, false, false)
    player = GetCurrentHeistPlayer()

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

    while #(GetEntityCoords(GetHeistPlayerPed(hPlayer[1])) - vector3(997.1, -48.63, 74.56)) > 10 do 
        Wait(10)
    end 
    
    DoScreenFadeOut(800)
    
    while not IsScreenFadedOut() do 
        Wait(10)
    end 
    
    RenderScriptCams(false, false, 0, true, false)
    DestroyCam(cam)
    
    if player == 1 then 
        SetEntityCoords(veh, casinoEntryCoords[selectedEntrance][1], true, false, false, true)
        SetEntityHeading(veh, casinoEntryCoords[selectedEntrance][2])
        TaskVehicleDriveToCoord(GetPedInVehicleSeat(veh, -1), veh, GetEntityCoords(veh), 80.0, 1.0, GetHashKey("stockade"), 786944, 0.5, 100.0)
    end
    --for i = 1, #hPlayer do 
    --    if PlayerPedId() ~= GetHeistPlayerPed(hPlayer[i]) then 
    --        SetEntityVisible(GetHeistPlayerPed(hPlayer[i]), true, true)
    --    end
    --end

    --if player == 1 then 
    --    veh = CreateVehicle(GetHashKey("stockade"), casinoEntryCoords[selectedEntrance][1], 0.0, true, false)
    --    SetVehicleColours(veh, 111, 0)
    --    SetEntityHeading(veh, casinoEntryCoords[selectedEntrance][2])
    --    --NetworkRegisterEntityAsNetworked(veh)
    --    local id = SetEntityForAll(veh)
    --    SetPedIntoVehicle(PlayerPedId(), veh, 0)
    --    TriggerServerEvent("sv:casinoheist:syncStockade", id)
    --else 
    --    veh = GetClosestVehicle(casinoEntryCoords[selectedEntrance][1], 5.0, GetHashKey("stockade"), 70)
    --    local i = 0
    --
    --    if GetCurrentHeistPlayer() == 2 then 
    --        i = 0
    --    elseif GetCurrentHeistPlayer() == 3 then 
    --        i = 1
    --    elseif GetCurrentHeistPlayer() == 4 then 
    --        i = 2 
    --    end
    --
    --    SetPedIntoVehicle(PlayerPedId(), veh, i)
    --end

    
    Wait(5000) 
    DoScreenFadeIn(1500)

    RemoveBlip(blip)
    SetEntityVisible(garageDoor, true)
    SetEntityCollision(garageDoor, true, true)
    
    TunnelEntry()
end

RegisterNetEvent("cl:casinoheist:startHeist", StartHeist)

RegisterNetEvent("cl:casinoheist:setNetIds", function(ids)
    netIds = ids
end)


--RegisterCommand("test_heli", Test, false)

RegisterCommand("test_tunnel", function()
    StartHeist()
end, false)

RegisterCommand("test_keypads", function()
    KeycardThread()
end, false)

RegisterCommand("test_sync", function()
    LoadModel("stockade")
    veh = CreateVehicle(GetHashKey("stockade"), GetEntityCoords(PlayerPedId()), 0.0, true, false)
    SetVehicleColours(veh, 111, 0)
    SetEntityHeading(veh, 0.0)
    --local id = SetEntityForAll(veh)

    SetPedIntoVehicle(PlayerPedId(), veh, 1)
    print(NetworkGetEntityFromNetworkId(id))
    TriggerServerEvent("sv:casinoheist:syncStockade", id, veh)
end, false)

RegisterNetEvent("cl:casinoheist:syncStockadeNet", function(id, entity, source)
    print("test", id)
    print("entity: ", entity, DoesEntityExist(entity))
    local vehId = NetToVeh(id)
    Wait(1000)
    local i = 0
    local veh = entity
    NetworkRequestControlOfEntity(vehId)
    NetworkRequestControlOfNetworkId(id)
    
    print("test")
    --while not NetworkHasControlOfEntity(vehId) do 
    --    Wait(0)
    --end
    print("test")

    if GetCurrentHeistPlayer() == 2 then 
        i = 0
    elseif GetCurrentHeistPlayer() == 3 then 
        i = 1
    elseif GetCurrentHeistPlayer() == 4 then 
        i = 2 
    end

    print("net: " .. vehId)
    print(DoesEntityExist(vehId))
    
    veh = GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(source)), false)
    print("test: " .. veh)
    if GetPlayerFromServerId(source) ~= PlayerId() then
        print()
        SetPedIntoVehicle(PlayerPedId(), veh, 0)
    end
end)

RegisterCommand("tes_heli", function()
    LoadModel("cargobob2")
    LoadModel("s_m_y_pilot_01")
    
    cargobob[1] = CreateVehicle(GetHashKey("cargobob2"), cargobobFinalCoords, 250.47, true, false)
    SetVehicleColours(cargobob[1], 0, 0)
    
    cargobob[2] = CreatePedInsideVehicle(cargobob[1], 0, GetHashKey("s_m_y_pilot_01"), -1, true, false)
    SetPedIntoVehicle(cargobob[2], cargobob[1], -1)
    SetVehicleEngineOn(cargobob[1], true, true, true)

    SetModelAsNoLongerNeeded("cargobob2")
    SetModelAsNoLongerNeeded("s_m_y_pilot_01")

    SetVehicleDoorOpen(cargobob[1], 2, false, true)
    FreezeEntityPosition(cargobob[1], true)

    SetEntityCoords(PlayerPedId(), 1304.1, -71.24, 400.5, true, false, false, false)
    SetEntityHeading(PlayerPedId(), 69.19)

    Wait(2000)
    FreezeEntityPosition(cargobob[1], false)
end)