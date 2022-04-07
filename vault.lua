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

local slideDoorBigName = "ch_prop_ch_vault_slide_door_lrg"
local slideDoorSmallName = "ch_prop_ch_vault_slide_door_sm"

local bigDoor = {}
local smallDoor = {}

--local i = 1

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

local function SetVaultDoors()
    GetVaultDoors()

    for i = 1, #vaultLayoutDoorBig[vaultLayout], 1 do 
        SetEntityCoords(bigDoor[vaultLayoutDoorBig[vaultLayout][i]], slideDoorOpenBigCoords[vaultLayoutDoorBig[vaultLayout][i]])
        --print(vaultLayoutDoorBig[vaultLayout][i].."big")
    end

    for i = 1, #vaultLayoutDoorSmall[vaultLayout], 1 do
        SetEntityCoords(smallDoor[vaultLayoutDoorSmall[vaultLayout][i]], slideDoorOpenSmallCoords[vaultLayoutDoorSmall[vaultLayout][i]])
        --print(vaultLayoutDoorSmall[vaultLayout][i].."small")
    end
end

local function OpenSlideDoors(prop, xTick, yTick)
    local coords = GetEntityCoords(prop)
    local x = 0
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

RegisterCommand("test_loop", function()
    
    for i = 1, 5, 1 do 
        if i == 2 or i == 4 then 
            i = i + 1
        end
        print(i)
    end

    OpenVaultDoors()
end)

RegisterCommand("vl_bdoor", function()
    SetLoot()
    SetLayout()
    SetVaultDoors()
    isInVault = true
    --print(loot)
    --print(vaultLayout.. "vl")
    --print(vaultLayoutDoorBig[vaultLayout][1], vaultLayoutDoorBig[vaultLayout][2])
end, false)