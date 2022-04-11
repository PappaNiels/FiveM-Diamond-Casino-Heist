local slideDoorBigCoords = {
    vector3(2519.962, -226.0072, -71.74234),
    vector3(2533.56, -239.6175, -71.74234),
    vector3(2519.938, -251.0496, -71.74234)
}

local slideDoorSmallCoords = {
    vector3(2514.195, -222.1348, -71.74234),
    vector3(2536.185, -232.2094, -71.74234),
    vector3(2536.184, -244.8697, -71.74234),
    vector3(2514.696, -253.6722, -71.74234)
}

local slideDoorOpenBigCoords = {
    vector3(2517.912, -226.0072, -71.74234),
    vector3(2533.56, -241.6675, -71.74234),
    vector3(2517.888, -251.0496, -71.74234),
}

local slideDoorOpenSmallCoords = {
    vector3(2513.735, -221.0148, -71.74234),  
    vector3(2535.075, -232.6694, -71.74234),  
    vector3(2536.074, -244.4097, -71.74234),  
    vector3(2514.236, -254.7922, -71.74234)  
}

local bigDoorMove = { 
    vector2(-0.0205, 0),
    vector2(0, -0.0205),
    vector2(-0.0205, 0)
}

local smallDoorMove = {
    vector2(-0.0046,  0.0112),
    vector2(-0.0111, -0.0046),
    vector2(-0.0111,  0.0046),
    vector2(-0.0046, -0.0112)
}

local artCabinetCoords = {
    vector4(2527.96, -218.3934, -71.73721, 223.12),
    vector4(2527.589, -219.2627, -71.73721, 0.1564346),
    vector4(2541.379, -237.1996, -71.73713, -0.6946586),
    vector4(2534.479, -253.8472, -71.73721, -0.9335806),
    vector4(2522.384, -258.904, -71.73721, -0.9996574),
    vector4(2502.734, -247.5772, -71.73713, 0.8571671)
}

local slideDoorBigName = "ch_prop_ch_vault_slide_door_lrg"
local slideDoorSmallName = "ch_prop_ch_vault_slide_door_sm"
local artCabinetName = "ch_prop_ch_sec_cabinet_02a"

local bigDoor = {}
local smallDoor = {}
local artCabinets = {}

--local i = 1
local statusBigDoor = {
    false,
    false,
    false
}

local statusSmallDoor = { 
    false,
    false,
    false,
    false
}

local vaultLayoutDoorBig = {
    [1] = {2, 3},
    [2] = {1},
    [3] = {2, 3},
    [4] = {1},
    [5] = {2, 3},
    [6] = {nil},
    [7] = {2, 3},
    [8] = {1},
    [9] = {2, 3},
    [10] = {nil}
}

local vaultLayoutDoorSmall = {
    [1] = {2, 4},
    [2] = {2, 4},
    [3] = {1, 2},
    [4] = {2, nil},
    [5] = {1},
    [6] = {1, 2},
    [7] = {1, 2},
    [8] = {3, 4},
    [9] = {2, nil},
    [10] = {2, 4}
}

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

local function GetVaultDoors()
    for i = 1, #slideDoorBigCoords, 1 do 
        table.insert(bigDoor, GetClosestObjectOfType(slideDoorBigCoords[i], 1.0, GetHashKey(slideDoorBigName), false, false, false))
    end

    for i = 1, #slideDoorSmallCoords, 1 do 
        table.insert(smallDoor, GetClosestObjectOfType(slideDoorSmallCoords[i], 1.0, GetHashKey(slideDoorSmallName), false, false, false))
    end
end

function SetVaultDoors()
    GetVaultDoors()

    for i = 1, #vaultLayoutDoorBig[vaultLayout], 1 do 
        SetEntityCoords(bigDoor[vaultLayoutDoorBig[vaultLayout][i]], slideDoorOpenBigCoords[vaultLayoutDoorBig[vaultLayout][i]])
        statusBigDoor[vaultLayoutDoorBig[vaultLayout][i]] = true
        print(vaultLayoutDoorBig[vaultLayout][i] .. "big")
    end
    
    for i = 1, #vaultLayoutDoorSmall[vaultLayout], 1 do
        SetEntityCoords(smallDoor[vaultLayoutDoorSmall[vaultLayout][i]], slideDoorOpenSmallCoords[vaultLayoutDoorSmall[vaultLayout][i]])
        statusSmallDoor[vaultLayoutDoorSmall[vaultLayout][i]] = true
        print(vaultLayoutDoorSmall[vaultLayout][i] .. "small")
    end
end

local function OpenSlideDoors(prop, xTick, yTick)
    
    local coords = GetEntityCoords(prop)
    local x = 0
    print(coords)
    print("opened")
    repeat 
        x = x + 1
        coords = coords + vector3(xTick, yTick, 0)
        SetEntityCoords(prop, coords)
        Wait(23)
    until x == 100
    
end

local function OpenVaultDoors()
    GetVaultDoors()
    
    --for i = 1, #bigDoor, 1 do 
    --    SetEntityCoords(bigDoor[i], slideDoorOpenBigCoords[i])
    --end
    for i = 1, #bigDoor, 1 do
        OpenSlideDoors(bigDoor[i], bigDoorMove[i].x, bigDoorMove[i].y)
        --Wait(5000)
    end
    
    Wait(5000)
    
    for i = 1, #smallDoor, 1 do
        OpenSlideDoors(smallDoor[i], smallDoorMove[i].x, smallDoorMove[i].y)
        --Wait(5000)
    end
    
    Wait(20000)
    
    for i = 1, #bigDoor, 1 do 
        SetEntityCoords(bigDoor[i], slideDoorBigCoords[i])
    end
    
    for i = 1, #smallDoor, 1 do 
        SetEntityCoords(smallDoor[i], slideDoorSmallCoords[i])
    end
end

local function HackKeypad(num)
    local animDict = "anim_heist@hs3f@ig1_hack_keypad@arcade@male@"
    local hackDevice = "ch_prop_ch_usb_drive01x"
    local phoneDevice = "prop_phone_ing"
    LoadAnim(animDict)
    LoadModel(hackDevice)
    LoadModel(phoneDevice)
    print(num)
    --keypad = 0 --GetClosestObjectOfType(keypads["lvlFourKeypad"][2], 2.0, GetHashKey("ch_prop_fingerprint_scanner_01d"), false, false, false)
    keypad = GetClosestObjectOfType(keypads["lvlThreeKeypad"][num], 1.0, GetHashKey("ch_prop_fingerprint_scanner_01c"), false, false, false)
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

CreateThread(function()
    while true do 
        if isInVault then 
            for i = 1, #keypads["lvlThreeKeypad"] do 
                local distance = #(GetEntityCoords(PlayerPedId()) - keypads["lvlThreeKeypad"][i])
                if distance < 2 then 
                    --print(distance) 
                    if i > 3 then 
                        local x = i - 3
                        if not statusSmallDoor[x] then  
                            HelpMsg("Press ~INPUT_CONTEXT~ to hack the keypad", 1000)
                            if IsControlPressed(0, 38) then
                                HackKeypad(i)
                                OpenSlideDoors(smallDoor[x], smallDoorMove[x].x, smallDoorMove[x].y)
                                statusSmallDoor[x] = true
                                --isInVault = false
                            else 
                                Wait(100)
                            end
                        --else 
                        --    Wait(1000)
                        end
                    else
                        if not statusBigDoor[i] then 
                            HelpMsg("Press ~INPUT_CONTEXT~ to hack the keypad", 1000)
                            if IsControlPressed(0, 38) then
                                HackKeypad(i)
                                OpenSlideDoors(bigDoor[i], bigDoorMove[i].x, bigDoorMove[i].y)
                                statusBigDoor[i] = true
                                --isInVault = false
                            else 
                                Wait(100)
                            end
                        --else 
                        --    Wait(1000)
                        end
                    end
                else 
                    Wait(5)
                end
            end
        else 
            Wait(500)
        end
    end
end)

RegisterCommand("test_loop", function()
    OpenVaultDoors()
end)
RegisterCommand("vl_testloop", function()
    isInVault = true
end)

RegisterCommand("vl_bdoor", function()
    print("command")
    --SetLoot()
    SetLayout()
    Wait(100)
    SetVaultDoors()
    --print(loot)
    print(vaultLayout.. "vl")
    --print(vaultLayoutDoorBig[vaultLayout][1], vaultLayoutDoorBig[vaultLayout][2], vaultLayoutDoorSmall[vaultLayout][1], vaultLayoutDoorSmall[vaultLayout][2])
    print("-----")
    for i = 1, #statusBigDoor, 1 do
       print(statusBigDoor[i]) 
    end
    print("-----")
    for i = 1, #statusSmallDoor, 1 do
       print(statusSmallDoor[i]) 
    end
    isInVault = true
end, false)

RegisterCommand("vl_dist", function()
    isInVault = true
end, false)