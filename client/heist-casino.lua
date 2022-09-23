local keycardScene = 0
local player = 0

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

local function SyncKeycardEnter(num)
    local animDict = "anim_heist@hs3f@ig3_cardswipe_insync@male@"
    local keycard = "ch_prop_vault_key_card_01a"
    LoadAnim(animDict)
    
    if not keycardSyncAnims[2][1] then
        local keypadObj = GetClosestObjectOfType(keypads[4][num], 1.0, GetHashKey("ch_prop_fingerprint_scanner_01d"), false, false, false)
        local keycardObj = CreateObject(GetHashKey(keycard), GetEntityCoords(PlayerPedId()), true, true, false)

        for i = 1, keycardSyncAnims[1][2] do 
            keycardSyncAnims[2][i] = NetworkCreateSynchronisedScene(GetEntityCoords(keypadObj), GetEntityRotation(keypadObj), 2, true, false, 0, 0, 1.3)
            NetworkAddPedToSynchronisedScene(PlayerPedId(), keycardSyncAnims[2][i], animDict, keycardSyncAnims[1][num][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
            NetworkAddEntityToSynchronisedScene(keycardObj, keycardSyncAnims[2][i], animDict, keycardSyncAnims[1][num][i][2], 1.0, -1.0, 114886080)
        end
    end

    NetworkStartSynchronisedScene(keycardSyncAnims[2][1])

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
    if DoesEntityExist(blips[1]) then 
        RemoveBlip(blips[1])
    end
    
    for i = 1, 2 do 
        blips[i] = AddBlipForCoord(staffCoords[i])
        SetBlipColour(blips[i], 5)
        SetBlipHighDetail(blips[i], true)
    end

    SetBlipSprite(blips[1], 63)
    SetBlipSprite(blips[2], 743)

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
                    --SecurityLobby() 
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

    CreateThread(function()
        while true do 
            Wait(5)

            local distanceL, distanceR = #(GetEntityCoords(PlayerPedId()) - keypads[4][1]), #(GetEntityCoords(PlayerPedId()) - keypads[4][2])
            
            if distanceL < 2.0 or distanceR < 2.0 then 
                HelpMsg("Press ~INPUT_CONTEXT~ to get in position to insert the keycard.") 
                if IsControlPressed(0, 38) then 
                    if distanceL < distanceR then 
                        SyncKeycardEnter(1)
                    else
                        SyncKeycardEnter(2)
                    end
                    break
                end
            end 
        end
    end)
end

RegisterNetEvent("cl:casinoheist:testCut", MainEntry)

RegisterCommand("test_cut_agg", function()
    MainEntry()
end, false)