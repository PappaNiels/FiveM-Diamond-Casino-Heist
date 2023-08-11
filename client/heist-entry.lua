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

local function AreAllPlayersInHeli()
    CreateThread(function()
        while true do 
            Wait(GetFrameTime())
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
        
        cargobob[2] = CreatePed(0, GetHashKey("s_m_y_pilot_01"), cargobobCoords, 0, true, false)
        SetPedIntoVehicle(cargobob[2], cargobob[1], -1)
        --SET_PED_CAN_BE_DRAGGED_OUT
        SetPedCanBeDraggedOut(cargobob[2], false)
        SetEntityInvincible(cargobob[2], true)
        --SetPedRelationshipGroupHash(cargobob[2], GetHashKey("PLAYER"))
        
        while not DoesEntityExist(cargobob[2]) do 
            Wait(10)
        end

        NetworkRegisterEntityAsNetworked(cargobob[1])
        NetworkRegisterEntityAsNetworked(cargobob[2])

        netIds[1] = VehToNet(cargobob[1])
        netIds[2] = PedToNet(cargobob[2])


        SetNetworkIdExistsOnAllMachines(netIds[1], true)
        SetNetworkIdExistsOnAllMachines(netIds[2], true)
        SetNetworkIdCanMigrate(netIds[1], true)
        SetNetworkIdCanMigrate(netIds[2], true)
        
        repeat Wait(0) until NetworkDoesEntityExistWithNetworkId(netIds[1]) and NetworkDoesEntityExistWithNetworkId(netIds[2])

        print(NetworkDoesNetworkIdExist(netIds[1]))
        print(NetworkDoesNetworkIdExist(netIds[2]))

        TriggerServerEvent("sv:casinoheist:syncNetIds", netIds)
    else
        Wait(100)

        repeat Wait(0) until NetworkDoesEntityExistWithNetworkId(netIds[1]) and NetworkDoesEntityExistWithNetworkId(netIds[2])
        --while not NetworkHasControlOfNetworkId(netIds[1]) and not NetworkHasControlOfNetworkId(netIds[2]) do 
        --    Wait(10)
        --end

        cargobob[1] = NetToVeh(netIds[1])
        cargobob[2] = NetToPed(netIds[2])
        --SetPedRelationshipGroupHash(cargobob[2], GetHashKey("PLAYER"))
    end

    cargobob[3] = AddBlipForEntity(cargobob[1])
    
    SetBlipSprite(cargobob[3], 422)
    SetBlipColour(cargobob[3], 54)
    SetBlipHighDetail(cargobob[3], true)
    
    while not IsPedInAnyHeli(PlayerPedId()) do 
        Wait(50)
        if #(vector3(1060.1, -288.31, 50.81) - GetEntityCoords(PlayerPedId())) < 4 and IsControlPressed(0, 23) then 
            for i = 0, 4 do 
                if IsVehicleSeatFree(cargobob[1], i) then 
                    TaskEnterVehicle(PlayerPedId(), cargobob[1], 1.0, i, 2.0, 0, 0)
                else 
                    TaskEnterVehicle(PlayerPedId(), cargobob[1], 1.0, i + 1, 2.0, 0, 0)
                end
            end
        end
    end


    RemoveBlip(cargobob[3])

    Wait(3000)
    
    AreAllPlayersInHeli()
end

local function DistanceCasino()
    if selectedEntrance == 7 then 
        CreateThread(function()
            local coords = vector3(1031.04, -268.99, 50.85)

            while true do 
                Wait(200)
    
                SubtitleMsg("Go to the ~y~Sewer.", 210)
    
                if #(GetEntityCoords(PlayerPedId()) - coords) < 50 then 
                    if coords == vector3(1031.04, -268.99, 50.85) then 
                        coords = vector3()
                        SetBlipCoords(blip, coords)
                    else
                        TeleportThread()
                        break 
                    end
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
    exports.spawnmanager:setAutoSpawn(false)

    PrepareMusicEvent("CH_IDLE_START")
    TriggerMusicEvent("CH_IDLE_START")

    playerAmount = #hPlayer

    if player == 1 then 
        
    end

    for i = 1, #hPlayer do 
        SetPedRelationshipGroupHash(GetHeistPlayerPed(hPlayer[i]), GetHashKey("PLAYER"))
    end

    AddRelationshipGroup("GUARDS")
    SetRelationshipBetweenGroups(0, GetHashKey("GUARDS"), GetHashKey("GUARDS"))

    DoScreenFadeOut(800)

    while not IsScreenFadedOut() do 
        Wait(100)
    end

    SetEntityCoords(PlayerPedId(), startCoords[player], true, false, false, true)
    SetEntityHeading(PlayerPedId(), 180.0)

    SetPedComponents(1)

    RemoveAllPedWeapons(PlayerPedId(), true)

    -- To do
    if approach == 2 then 
        GiveWeaponToPed(PlayerPedId(), GetHashKey("weapon_ceramicpistol"), 1000, false, false)
    else 
        for i = 1, #weaponLoadout[approach][selectedGunman][selectedLoadout] do 
            if type(weaponLoadout[approach][selectedGunman][selectedLoadout][i]) == "table" then 
                GiveWeaponToPed(PlayerPedId(), GetHashKey(weaponLoadout[approach][selectedGunman][selectedLoadout][i][1]), 1000, false, false)
                GiveWeaponComponentToPed(PlayerPedId(), GetHashKey(weaponLoadout[approach][selectedGunman][selectedLoadout][i][1]), GetHashKey(weaponLoadout[approach][selectedGunman][selectedLoadout][i][2]))
            else
                GiveWeaponToPed(PlayerPedId(), GetHashKey(weaponLoadout[approach][selectedGunman][selectedLoadout][i]), 1000, false, false)
            end
        end
    end

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

        if selectedEntryDisguise == 3 and player == 1 then 
            NetworkRegisterEntityAsNetworked(veh)
            
            local net = VehToNet(veh)
            SetNetworkIdCanMigrate(net, true)
            SetNetworkIdExistsOnAllMachines(net, true)
            TriggerServerEvent("sv:casinoheist:syncStockade", net)
        end

        if selectedEntryDisguise == 3 and approach == 2 then 
            SetVehicleColours(veh, 111, 0)
        elseif approach ~= 2 then 
            SetVehicleColours(veh, 0, 11) 
        end
    end

    DistanceCasino()

    Wait(5000)

    
    DoScreenFadeIn(1500)
    DrawTeamlives()
    
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
    local txt = "Go to the ~y~Casino."
    
    if selectedEntrance == 6 and not DoesEntityExist(veh) then 
        veh = GetVehiclePedIsIn(GetHeistPlayerPed(hPlayer[1]), false)
    elseif selectedEntrance == 7 then 
        txt = "Go to ~y~sewer tunnel."
    end

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
                    SetBlipRoute(blip, false)
                    RemoveBlip(blip)
                    EnterCasino()
                    break
                end
            else 
                SubtitleMsg(txt, 110)
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
    SetBlipRoute(blip, false)
    RemoveBlip(blip)
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
    DisplayRadar(false)

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

    DisplayRadar(true)
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

RegisterNetEvent("cl:casinoheist:syncStockade", function(net)
    repeat Wait(0) until NetworkDoesEntityExistWithNetworkId(net)

    veh = NetToVeh(net)
end)

-- might be unused. my experimentation with networking 
RegisterNetEvent("cl:casinoheist:syncStockadeNet", function(id, entity, source)
    local vehId = NetToVeh(id)
    Wait(1000)
    local i = 0
    local veh = entity
    NetworkRequestControlOfEntity(vehId)
    NetworkRequestControlOfNetworkId(id)
    
    if GetCurrentHeistPlayer() == 2 then 
        i = 0
    elseif GetCurrentHeistPlayer() == 3 then 
        i = 1
    elseif GetCurrentHeistPlayer() == 4 then 
        i = 2 
    end

    veh = GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(source)), false)

    if GetPlayerFromServerId(source) ~= PlayerId() then
        SetPedIntoVehicle(PlayerPedId(), veh, 0)
    end
end)