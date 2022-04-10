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
        print(GetEntityCoords(bigDoor[i]))
        print(vaultLayoutDoorBig[vaultLayout][i].."big")
    end

    for i = 1, #vaultLayoutDoorSmall[vaultLayout], 1 do
        SetEntityCoords(smallDoor[vaultLayoutDoorSmall[vaultLayout][i]], slideDoorOpenSmallCoords[vaultLayoutDoorSmall[vaultLayout][i]])
        print(GetEntityCoords(smallDoor[i]))
        print(vaultLayoutDoorSmall[vaultLayout][i].."small")
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

CreateThread(function()
    while true do 
        if isInVault then 
            for i = 1, #keypads["lvlThreeKeypad"] do 
                local distance = #(GetEntityCoords(PlayerPedId()) - keypads["lvlThreeKeypad"][i])
                if distance < 3 then 
                    print(distance) 
                    GetVaultDoors()
                    if i > 3 then 
                        local x = i - 3
                        if IsControlPressed(0, 38) and not statusSmallDoor[x] then
                            HackKeypad(i)
                            OpenSlideDoors(smallDoor[x], smallDoorMove[x].x, smallDoorMove[x].y)
                            isInVault = false
                        else 
                            Wait(10)
                        end
                    else
                        if IsControlPressed(0, 38) and not statusBigDoor[i] then
                            HackKeypad(i)
                            OpenSlideDoors(bigDoor[i], bigDoorMove[i].x, bigDoorMove[i].y)
                            isInVault = false
                        else 
                            Wait(10)
                        end
                    end
                else 
                    Wait(30)
                end
            end
        else 
            Wait(1000)
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
    SetLoot()
    SetLayout()
    Wait(1000)
    SetVaultDoors()
    --isInVault = true
    --print(loot)
    print(vaultLayout.. "vl")
    print(vaultLayoutDoorBig[vaultLayout][1], vaultLayoutDoorBig[vaultLayout][2], vaultLayoutDoorSmall[vaultLayout][1], vaultLayoutDoorSmall[vaultLayout][2])
end, false)

RegisterCommand("vl_dist", function()
    isInVault = true
end, false)