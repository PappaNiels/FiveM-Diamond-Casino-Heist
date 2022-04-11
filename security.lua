isInSecurity = false

local blipActive = false
local canSwipeKeycard = false
local holdingPass = false
local keycard = 0
local keycardProp
--local blipsThreeKeypad = false 
--local blipOne
--local blipTwo 
local blip = {1, 1}
local keycardSwipeAnims = {
    ["anims"] = {
        [1] = {
            {"ped_a_enter", "ped_a_enter_keycard"},
            {"ped_a_enter_loop", "ped_a_enter_loop_keycard"},
            {"ped_a_intro_b", "ped_a_intro_b_keycard"},
            {"ped_a_loop", "ped_a_loop_keycard"},
            {"ped_a_pass", "ped_a_pass_keycard"},
            {"ped_a_fail_a", "ped_a_fail_a_keycard"}, 
            {"ped_a_fail_b", "ped_a_fail_b_keycard"}, 
            {"ped_a_fail_c", "ped_a_fail_c_keycard"} 
        },
        [2] = { 
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
    ["networkScenes"] = {}
}


RegisterCommand("sec_blips", function()
    --AddSecurityBlips()
    isInSecurity = true
end, false)

local function AddSecurityBlips()
    for i = 1, 2, 1 do 
        blip[i] = AddBlipForCoord(keypads["lvlFourKeypad"][i])    
        SetBlipSprite(blip[i], 733)
        SetBlipColour(blip[i], 2)
        SetBlipHighDetail(blip[i], true)
        blipActive = true
    end
end

local function RemoveSecurityBlips()
    for i = 1, 2, 1 do     
        RemoveBlip(blip[i])
        blipActive = false
        print(i)
    end
end

local function SwipeKeycardMantrap(pos)
    local animDict = "anim_heist@hs3f@ig3_cardswipe_insync@male@"
    local keycard = "ch_prop_vault_key_card_01a"
    LoadAnim(animDict)
    LoadModel(keycard)

    keypad = GetClosestObjectOfType(keypads["lvlFourKeypad"][pos], 1.0, GetHashKey("ch_prop_fingerprint_scanner_01d"), false, false, false)
    keycard = CreateObject(GetHashKey(keycard), GetEntityCoords(PlayerPedId()), true, true, false)
    local x = 0

    if pos == 1 or pos == 3 then 
        x = 1
    else 
        x = 2
    end
    for i = 1, #keycardSwipeAnims["anims"][2] do 
        keycardSwipeAnims["networkScenes"][i] = NetworkCreateSynchronisedScene(GetEntityCoords(keypad), GetEntityRotation(keypad), 2, true, false, 1065353216, 0, 1.3)
        NetworkAddPedToSynchronisedScene(PlayerPedId(), keycardSwipeAnims["networkScenes"][i], animDict, keycardSwipeAnims["anims"][x][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
        NetworkAddEntityToSynchronisedScene(keycard, keycardSwipeAnims["networkScenes"][i], animDict, keycardSwipeAnims["anims"][x][i][2], 1.0, -1.0, 114886080)
    end

    NetworkStartSynchronisedScene(keycardSwipeAnims["networkScenes"][1])
    Wait(2000)
    NetworkStartSynchronisedScene(keycardSwipeAnims["networkScenes"][2])
    --Wait(2000)
    while loop do 
        if IsControlPressed(0, 38) then 
            loop = false
        else
            Wait(50)
        end
    end
    NetworkStartSynchronisedScene(keycardSwipeAnims["networkScenes"][3])
    Wait(2000)
    NetworkStartSynchronisedScene(keycardSwipeAnims["networkScenes"][4])
    Wait(2000)
    NetworkStartSynchronisedScene(keycardSwipeAnims["networkScenes"][5])
    Wait(2000)
    DeleteObject(keycard)
end

--function StartKeycardAnim(num)
--    local animDict = "anim_heist@hs3f@ig3_cardswipe_insync@male@"
--    
--    LoadAnim(animDict)
--    LoadModel("ch_prop_vault_key_card_01a")
--    local coords = GetEntityCoords(PlayerPedId())
--    keycardProp = CreateObject(GetHashKey("ch_prop_vault_key_card_01a"), coords, true, true, false)
--    
--    ClearPedTasksImmediately(PlayerPedId())
--
--    if num == 1 then 
--        holdingPass = true
--        keycard = 1
--        AttachEntityToEntity(keycardProp, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 0x67F2), 0.13, -0.04, 0.0, 0.0, 90.0, 0.0, false, false, false, false, 2, true) 
--        TaskPlayAnimAdvanced(PlayerPedId(), animDict, "ped_a_enter", 2465.45, -282.0, -70.69, 0, 0, 109.0, 8.0, -8.0, -1, 8, 0, 0, 0)
--        Wait(600)
--        while holdingPass do 
--            TaskPlayAnimAdvanced(PlayerPedId(), animDict, "ped_a_enter_loop", 2465.45, -282.0, -70.69, 0, 0, 109.0, 8.0, -8.0, 600, 8, 0, 0, 0)
--            Wait(500)
--        end
--        --print("tick")
--
--        --TaskPlayAnim(PlayerPedId(), animDict, "ped_a_intro_b", 8.0, -8.0, -1, 8, 0, 0, 0, 0)
--    else 
--        holdingPass = true 
--        keycard = 2
--        AttachEntityToEntity(keycardProp, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 0x67F2), 0.13, -0.04, 0.0, 0.0, 90.0, 0.0, false, false, false, false, 2, true)
--        TaskPlayAnimAdvanced(PlayerPedId(), animDict, "ped_b_enter", 2465.3, -276.45, -70.69, 0, 0, 60.73, 8.0, -8.0, 600, 8, 0, 0, 0)
--        Wait(600)
--        while holdingPass do 
--            TaskPlayAnimAdvanced(PlayerPedId(), animDict, "ped_b_enter_loop", 2465.3, -276.45, -70.69, 0, 0, 60.73, 8.0, -8.0, 600, 8, 0, 0, 0)
--            Wait(500)
--            --print("tick")
--        end
--
--    end
--end
--
--function SwipeKeycardAnim(num)
--    local animDict = "anim_heist@hs3f@ig3_cardswipe_insync@male@"
--    
--    if num == 1 then 
--        --print("1")
--        Wait(300)
--        TaskPlayAnim(PlayerPedId(), animDict, "ped_a_intro_b", 8.0, -8.0, 1933, 8, 0, 0, 0, 0)
--        --print("test")
--        Wait(1933)   
--        TaskPlayAnim(PlayerPedId(), animDict, "ped_a_loop", 8.0, -8.0, 2000, 8, 0, 0, 0, 0)
--        Wait(2000)
--        TaskPlayAnim(PlayerPedId(), animDict, "ped_a_pass", 8.0, -8.0, 1933, 8, 0, 0, 0, 0)
--        --DetachEntity(keycardProp, false, true)
--        Wait(1000)
--        DeleteEntity(keycardProp)
--
--        
--    else
--        --print("2")
--        TaskPlayAnim(PlayerPedId(), animDict, "ped_b_intro_b", 8.0, -8.0, 1933, 8, 0, 0, 0, 0)
--        Wait(1933)   
--        TaskPlayAnim(PlayerPedId(), animDict, "ped_b_loop", 8.0, -8.0, 2000, 8, 0, 0, 0, 0)
--        Wait(2000)
--        TaskPlayAnim(PlayerPedId(), animDict, "ped_b_pass", 8.0, -8.0, 1933, 8, 0, 0, 0, 0)
--        Wait(1000)
--        DeleteEntity(keycardProp)
--    end
--
--    for i = 1, #blip, 1 do 
--        RemoveBlip(blip[i])
--    end
--    OpenMantrapDoor(1)
--    blipActive = false
--    isInMantrap = true
--    openedDoor = 1
--end

CreateThread(function()
    while true do 
        Wait(0)
        if isInSecurity then 
            SubtitleMsg("Go to one of the ~g~keypads~s~.", 110)
            if not blipActive then 
                AddSecurityBlips()
                Wait(100)
            else
                local distance1, distance2 = #(GetEntityCoords(PlayerPedId()) - keypads["lvlFourKeypad"][1]), #(GetEntityCoords(PlayerPedId()) - keypads["lvlFourKeypad"][2])
                if distance1 < 1.5 or distance2 < 1.5 then
                    isInSecurity = false
                    canSwipeKeycard = true 
                else 
                    Wait(100)
                    --print("false")
                end
            end
        else 
            Wait(500)
        end
    end
end)

CreateThread(function()
    while true do 
        Wait(0)
        if canSwipeKeycard then 
            SubtitleMsg("Simultaneously swipe the ~g~keycards~s~", 100)
            local distance1, distance2 = #(GetEntityCoords(PlayerPedId()) - keypads["lvlFourKeypad"][1]), #(GetEntityCoords(PlayerPedId()) - keypads["lvlFourKeypad"][2])
            
            if distance1 < 0.5 then 
                HelpMsg("Press ~INPUT_CONTEXT~ to swipe the keycard", 150) 
                if IsControlPressed(0, 38) then  
                    SwipeKeycardMantrap(1)
                    OpenMantrapDoor(1)
                    --print("a")
                    isInMantrap = true
                    openedDoor = 1
                    canSwipeKeycard = false
                    RemoveSecurityBlips()
                    
                    --keycard = 1
                else 
                    --print("wha") 
                    Wait(10)
                end
                
            elseif distance2 < 0.5 then
                HelpMsg("Press ~INPUT_CONTEXT~ to swipe the keycard", 150) 
                if IsControlPressed(0, 38) then 
                    SwipeKeycardMantrap(2)
                    OpenMantrapDoor(1)
                    --print("a")
                    isInMantrap = true
                    canSwipeKeycard = false
                    openedDoor = 1
                    RemoveSecurityBlips()
                    --keycard = 2
                else
                    --print("wha") 
                    Wait(10)
                end
            else 
                Wait(50)
            end 
        else 
            Wait(1000)
        end
    end
end)

--CreateThread(function()
--    while true do
--        Wait(0) 
--        if holdingPass then 
--            DisableControlAction(1, 200, true)
--            HelpMsg("Both Players must insert their keycards simultaneously. Press ~INPUT_FRONTEND_RDOWN~ when you are both ready. to back out press ~INPUT_FRONTEND_PAUSE_ALTERNATE~.")
--            if IsControlPressed(0, 18) then 
--                --print("enter")
--                --print(keycard) 
--                holdingPass = false
--                --SwipeKeycardAnim(keycard)
--            elseif IsControlPressed(0, 202) then 
--                --print("esc")
--                holdingPass = false 
--                canSwipeKeycard = true
--                keycard = 0
--            else 
--                Wait(50)
--            end
--
--        else 
--            Wait(1000)
--        end
--    end
--end)