isInSecurity = false

local blipActive = false
local canSwipeKeycard = false
local holdingPass = false

local place = 0

local keycardProp
local keypad
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
        --print(i)
    end
end

local function NetworkMantrapDoors()
    local pDoorL, pDoorR = GetHashKey("ch_prop_ch_tunnel_door_01_l"), GetHashKey("ch_prop_ch_tunnel_door_01_r")
    local doorL = GetClosestObjectOfType(2464.183, -278.204, -71.694, 1.0, pDoorL, false, false, false)
    local doorR = GetClosestObjectOfType(2464.183, -280.288, -71.694, 1.0, pDoorR, false, false, false)

    print(doorL, doorR)

    NetworkRegisterEntityAsNetworked(doorL)
    netId = NetworkGetNetworkIdFromEntity(doorL)
    SetNetworkIdCanMigrate(netId, true)
    --SetNetworkIdExistsOnAllMachines(netId, true)
    print(netId)
    
    NetworkRegisterEntityAsNetworked(doorR)
    netId = NetworkGetNetworkIdFromEntity(doorR)
    SetNetworkIdCanMigrate(netId, true)
    --SetNetworkIdExistsOnAllMachines(netId, true)
    print(netId)
end

local function SwipeKeycardMantrap(pos, start)
    local animDict = "anim_heist@hs3f@ig3_cardswipe_insync@male@"
    local keycard = "ch_prop_vault_key_card_01a"
    LoadAnim(animDict)
    LoadModel(keycard)

    keypad = GetClosestObjectOfType(keypads["lvlFourKeypad"][pos], 1.0, GetHashKey("ch_prop_fingerprint_scanner_01d"), false, false, false)
    if start then 
        keycardProp = CreateObject(GetHashKey(keycard), GetEntityCoords(PlayerPedId()), true, true, false)
    end
    
    local x = 0

    if pos == 1 or pos == 3 then 
        place = 1
    else 
        place = 2
    end
    for i = 1, #keycardSwipeAnims["anims"][2] do 
        keycardSwipeAnims["networkScenes"][i] = NetworkCreateSynchronisedScene(GetEntityCoords(keypad), GetEntityRotation(keypad), 2, true, false, 1065353216, 0, 1.3)
        NetworkAddPedToSynchronisedScene(PlayerPedId(), keycardSwipeAnims["networkScenes"][i], animDict, keycardSwipeAnims["anims"][place][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
        NetworkAddEntityToSynchronisedScene(keycardProp, keycardSwipeAnims["networkScenes"][i], animDict, keycardSwipeAnims["anims"][place][i][2], 1.0, -1.0, 114886080)
    end

    if start then
        NetworkStartSynchronisedScene(keycardSwipeAnims["networkScenes"][1])
    end
    Wait(1000)
    NetworkStartSynchronisedScene(keycardSwipeAnims["networkScenes"][2])
    --Wait(2000)
    print("loop")
    loop = true
    while loop do 
        HelpMsg("Both Players must insert their keycards simultaneously. Press ~INPUT_FRONTEND_RDOWN~ when you are both ready. to back out press ~INPUT_FRONTEND_PAUSE_ALTERNATE~.")
        if IsControlPressed(0, 18) then 
            loop = false
        elseif IsControlPressed(0, ) then
            break
        else
            Wait(50)
        end
    end

    NetworkStartSynchronisedScene(keycardSwipeAnims["networkScenes"][3])
    print(keycardSwipeAnims["networkScenes"][3])
    Wait(2000)
    NetworkStartSynchronisedScene(keycardSwipeAnims["networkScenes"][4])

    TriggerServerEvent("sv:casinoheist:security:swipecard")
    --KeycardLoop()
end

function KeycardLoop(j)    
    --if j == 1 then 
    --    for i = 2, #keycardSwipeAnims["anims"][2] do 
    --        keycardSwipeAnims["networkScenes"][i] = NetworkCreateSynchronisedScene(GetEntityCoords(keypad), GetEntityRotation(keypad), 2, true, false, 1065353216, 0, 1.3)
    --        NetworkAddPedToSynchronisedScene(PlayerPedId(), keycardSwipeAnims["networkScenes"][i], animDict, keycardSwipeAnims["anims"][place][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
    --        NetworkAddEntityToSynchronisedScene(keycardProp, keycardSwipeAnims["networkScenes"][i], animDict, keycardSwipeAnims["anims"][place][i][2], 1.0, -1.0, 114886080)
    --    end
    --end

    
end

RegisterNetEvent("cl:casinoheist:security:keycardswipesucceeded")
AddEventHandler("cl:casinoheist:security:keycardswipesucceeded", function()
    print("true")
    --Wait(2000)
    NetworkStartSynchronisedScene(keycardSwipeAnims["networkScenes"][5])
    Wait(2000)
    --OpenMantrapDoor(1)
    --openedDoor = 1
    DeleteObject(keycardProp)
    --ClearPedTasks(PlayerPedId())
    print("boe")
end)

RegisterNetEvent("cl:casinoheist:security:keycardswipefailed")
AddEventHandler("cl:casinoheist:security:keycardswipefailed", function(num)
    --print("false")
    --print(num, source, GetPlayerFromServerId(source))
    NetworkStartSynchronisedScene(keycardSwipeAnims["networkScenes"][6 + num])
    --TaskPlayAnim(PlayerPedId(), "anim_heist@hs3f@ig3_cardswipe_insync@male@", keycardSwipeAnims["anims"][place][6 + num][1], 8.0, -8.0, 1700, 1, 0.0, false, false, false)
    --PlayEntityAnim(keycardProp, keycardSwipeAnims["anims"][place][6 + num][1])
    Wait(1800)
    --print(GetAnimDuration("anim_heist@hs3f@ig3_cardswipe_insync@male@", keycardSwipeAnims["anims"][1][6 + num][1]))
    ----ClearPedTasksImmediately(PlayerPedId())
    --KeycardLoop(1)
    SwipeKeycardMantrap(place, false)
end)

RegisterNetEvent("test:cl:casinoheist:keycardswipe")
AddEventHandler("test:cl:casinoheist:keycardswipe", function()
    isInSecurity = true
end)

CreateThread(function()
    while true do 
        Wait(0)
        if isInSecurity then 
            SubtitleMsg("Go to one of the ~g~keypads~s~.", 110)
            if not blipActive then 
                AddSecurityBlips()
                --NetworkMantrapDoors()
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
            
            if distance1 < 1 then 
                HelpMsg("Press ~INPUT_CONTEXT~ to get in position to insert the keycard.", 150) 
                if IsControlPressed(0, 38) then  
                    SwipeKeycardMantrap(1, true)
                    --OpenMantrapDoor(1)
                    --print("a")
                    isInMantrap = true
                    --openedDoor = 1
                    canSwipeKeycard = false
                    RemoveSecurityBlips()
                    
                    --keycard = 1
                else 
                    --print("wha") 
                    Wait(10)
                end
                
            elseif distance2 < 0.5 then
                HelpMsg("Press ~INPUT_CONTEXT~ to get in position to insert the keycard.", 150) 
                if IsControlPressed(0, 38) then 
                    SwipeKeycardMantrap(2)
                    --OpenMantrapDoor(1)
                    --print("a")
                    isInMantrap = true
                    canSwipeKeycard = false
                    --openedDoor = 1
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

RegisterCommand("test_clcallback", function()
    TriggerServerEvent("sv:security:swipecard", 1)
    --print(PlayerPedId())    
end, false)