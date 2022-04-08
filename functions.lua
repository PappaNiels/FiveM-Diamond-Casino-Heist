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


-- NEEDS TESTING
function HackKeypad(type, num)
    local animDict = "anim_heist@hs3f@ig1_hack_keypad@arcade@male@"
    local hackDevice = "ch_prop_ch_usb_drive01x"
    local phoneDevice = "prop_phone_ing"
    LoadAnim(animDict)
    LoadModel(hackDevice)
    LoadModel(phoneDevice)

    local keypad = GetClosestObjectOfType(keypads["lvlThreeKeypad"][1], 1.0, GetHashKey("ch_prop_fingerprint_scanner_01c"), false, false, false)
    local hackUsb = CreateObject(GetHashKey(hackDevice), GetEntityCoords(PlayerPedId()), true, true, false)
    local phone = CreateObject(GetHashKey(phoneDevice), GetEntityCoords(PlayerPedId()), true, true, false)

    for i = 1, #hackKeypadAnims["anims"], 1 do 
        hackKeypadAnims["networkScenes"][i] = NetworkCreateSynchronisedScene(GetEntityCoords(keypad), GetEntityRotation(keypad), 2, true, false, 1065353216, 0, 1.3) 
        NetworkAddPedToSynchronisedScene(PlayerPedId(), hackKeypadAnims["networkScenes"][i], animDict, hackKeypadAnims["anims"][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
        NetworkAddEntityToSynchronisedScene(hackUsb, hackKeypadAnim["networkScenes"][i], animDict, hackKeypadAnim["anim"][i][2], 1.0, -1.0, 1148846080)
        NetworkAddEntityToSynchronisedScene(phone, hackKeypadAnim["networkScenes"][i], animDict, hackKeypadAnim["anim"][i][3], 1.0, -1.0, 1148846080)
    end

    NetworkStartSynchronisedScene(hackKeypadAnim["networkScenes"][1])
    Wait(4000)
    NetworkStartSynchronisedScene(hackKeypadAnim["networkScenes"][2])
    Wait(2000)
    if IsControlPressed(0, 38) then 
        --Wait(5000)
        NetworkStartSynchronisedScene(hackKeypadAnim["networkScenes"][3])
        Wait(4000)
        DeleteObject(hackUsb)
        DeleteObject(phone)
    end
end


RegisterCommand("tp", function(source, args)
    local x, y, z, h = args[1], args[2], args[3], args[4]
    print(x, y, z, h)
    FadeTeleport(x, y, z, h)
end, false)