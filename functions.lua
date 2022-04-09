local hackKeypadAnims = { 
    ["anims"] = {    
        {'action_var_01', 'action_var_01_ch_prop_ch_usb_drive01x', 'action_var_01_prop_phone_ing'},
        {'hack_loop_var_01', 'hack_loop_var_01_ch_prop_ch_usb_drive01x', 'hack_loop_var_01_prop_phone_ing'},
        {'success_react_exit_var_01', 'success_react_exit_var_01_ch_prop_ch_usb_drive01x', 'success_react_exit_var_01_prop_phone_ing'},
        {'fail_react', 'fail_react_ch_prop_ch_usb_drive01x', 'fail_react_prop_phone_ing'},
        {'reattempt', 'reattempt_ch_prop_ch_usb_drive01x', 'reattempt_prop_phone_ing'}
    },
    ["networkScenes"] = {}
} 

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

function HelpMsg(text, time)
    AddTextEntry("bomb", text)
    BeginTextCommandDisplayHelp("bomb")
    EndTextCommandDisplayHelp(0, false, true, time)
end

function SubtitleMsg(msg, time)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(msg)
    DrawSubtitleTimed(time, true)
end

function FadeTeleport(x, y, z, h)
    DoScreenFadeOut(800)

    while not IsScreenFadedOut() do 
        Wait(500)
    end

    if x ~= nil then
        SetEntityCoords(PlayerPedId(), x, y, z)
        SetEntityHeading(PlayerPedId(), h)
        
    end
    DoScreenFadeIn(800)
end

function LoadCutscene(name)
    RequestCutscene(name, 8)

    while not HasCutsceneLoaded() do 
        Wait(10)
    end

    
    local hPlayer = GetHeistPlayer()

    --print(hPlayer[2])

    SetCutsceneEntityStreamingFlags("MP_1", 0, 1)
    RegisterEntityForCutscene(hPlayer[2], "MP_1", 0, 0, 64)

    SetCutsceneEntityStreamingFlags("MP_2", 0, 1)
    RegisterEntityForCutscene(PlayerPedId(), "MP_2", 0, 0, 64)

    SetCutsceneEntityStreamingFlags("MP_3", 0, 1)
    RegisterEntityForCutscene(hPlayer[3], "MP_3", 0, 0, 64)

    SetCutsceneEntityStreamingFlags("MP_4", 0, 1)
    RegisterEntityForCutscene(hPlayer[4], "MP_4", 0, 0, 64)
end

function LoadModel(model)
    RequestModel(model)

    while not HasModelLoaded(model) do 
        Wait(10)
    end
end

function LoadAnim(animDict)
    RequestAnimDict(animDict)

    while not HasAnimDictLoaded(animDict) do
        Wait(10)
    end
end


RegisterCommand("test_anim", function()
    HackKeypad(4, 0)
end, false)

-- NEEDS TESTING
function HackKeypad()
    local animDict = "anim_heist@hs3f@ig1_hack_keypad@arcade@male@"
    local hackDevice = "ch_prop_ch_usb_drive01x"
    local phoneDevice = "prop_phone_ing"
    LoadAnim(animDict)
    LoadModel(hackDevice)
    LoadModel(phoneDevice)

    --keypad = 0 --GetClosestObjectOfType(keypads["lvlFourKeypad"][2], 2.0, GetHashKey("ch_prop_fingerprint_scanner_01d"), false, false, false)
    keypad = GetClosestObjectOfType(keypads["lvlThreeKeypad"][2], 1.0, GetHashKey("ch_prop_fingerprint_scanner_01c"), false, false, false)
    hackUsb = CreateObject(GetHashKey(hackDevice), GetEntityCoords(PlayerPedId()), true, true, false)
    phone = CreateObject(GetHashKey(phoneDevice), GetEntityCoords(PlayerPedId()), true, true, false)
    
    print(keypad)
    
    for i = 1, #hackKeypadAnims["anims"], 1 do 
        hackKeypadAnims["networkScenes"][i] = NetworkCreateSynchronisedScene(GetEntityCoords(keypad), GetEntityRotation(keypad), 2, true, false, 1065353216, 0, 1.3) 
        NetworkAddPedToSynchronisedScene(PlayerPedId(), hackKeypadAnims["networkScenes"][i], animDict, hackKeypadAnims["anims"][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
        NetworkAddEntityToSynchronisedScene(hackUsb, hackKeypadAnims["networkScenes"][i], animDict, hackKeypadAnims["anims"][i][2], 1.0, -1.0, 1148846080)
        NetworkAddEntityToSynchronisedScene(phone, hackKeypadAnims["networkScenes"][i], animDict, hackKeypadAnims["anims"][i][3], 1.0, -1.0, 1148846080)
    end
    
    print(hackKeypadAnims["networkScenes"][2])
    NetworkStartSynchronisedScene(hackKeypadAnims["networkScenes"][1])
    Wait(4000)
    NetworkStartSynchronisedScene(hackKeypadAnims["networkScenes"][2])
    Wait(2000)
    --if IsControlPressed(0, 38) then 
    Wait(3000)
    NetworkStartSynchronisedScene(hackKeypadAnims["networkScenes"][3])
    Wait(4000)
    DeleteObject(hackUsb)
    DeleteObject(phone)
    --end
end

function SwipeKeycardMantrap(pos)
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
    Wait(2000)
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

RegisterCommand("swipe_test", function()
    SwipeKeycardMantrap(4)
end, false)


RegisterCommand("tp", function(source, args)
    local x, y, z, h = args[1], args[2], args[3], args[4]
    print(x, y, z, h)
    FadeTeleport(x, y, z, h)
end, false)