isInMantrap = false
openedDoor = 0

local mantrapEntryDoorsCoords = {
    vector3(2464.183, -278.204, -71.694),
    vector3(2464.183, -280.288, -71.694), 
    vector3(2492.280, -237.459, -71.738), 
    vector3(2492.280, -239.544, -71.738)
}

RegisterCommand("doors_unrev", function()
    OpenMantrapDoor(1)
    isInMantrap = true
    openedDoor = 1
end, false)

RegisterCommand("doors_rev", function()
    OpenMantrapDoor(3)
    isInMantrap = true
    openedDoor = 3
end, false)

function OpenMantrapDoor(num)
    local pDoorL, pDoorR = GetHashKey("ch_prop_ch_tunnel_door_01_l"), GetHashKey("ch_prop_ch_tunnel_door_01_r")
    local doorL = GetClosestObjectOfType(mantrapEntryDoorsCoords[num], 1.0, pDoorL, false, false, false)
    local doorR = GetClosestObjectOfType(mantrapEntryDoorsCoords[num + 1], 1.0, pDoorR, false, false, false)
    local x = 0
    local coords1, coords2 = mantrapEntryDoorsCoords[num], mantrapEntryDoorsCoords[num + 1]
    if num == 3 then 
        --local vaultShell = GetClosestObjectOfType(2505.54, -238.53, -71.65, 1.0, GetHashKey("ch_prop_ch_vault_wall_damage"), false, false, false)
        --SetEntityVisible(vaultShell, false)
        --print("vault")
        HideNPropsStart()
    end
    repeat 
        coords1 = coords1 + vector3(0, 0.0105, 0)
        coords2 = coords2 - vector3(0, 0.0105, 0)
        SetEntityCoords(doorL, coords1)
        SetEntityCoords(doorR, coords2)
        x = x + 1
        Wait(23)
    until x == 100 
    doorNr = num 
    doorOpen = true
end 

function CloseMantrapDoor(num)
    local pDoorL, pDoorR = GetHashKey("ch_prop_ch_tunnel_door_01_l"), GetHashKey("ch_prop_ch_tunnel_door_01_r")
    local doorL = GetClosestObjectOfType(mantrapEntryDoorsCoords[num] + vector3(0, 1.05, 0), 2.0, pDoorL, false, false, false)
    local doorR = GetClosestObjectOfType(mantrapEntryDoorsCoords[num + 1] - vector3(0, 1.05, 0), 2.0, pDoorR, false, false, false)
    local x = 0
    local coords1, coords2 = mantrapEntryDoorsCoords[num] + vector3(0, 1.05, 0), mantrapEntryDoorsCoords[num + 1] - vector3(0, 1.05, 0)
    repeat 
        coords1 = coords1 - vector3(0, 0.0105, 0)
        coords2 = coords2 + vector3(0, 0.0105, 0)
        SetEntityCoords(doorL, coords1)
        SetEntityCoords(doorR, coords2)
        x = x + 1
        Wait(23)
    until x == 100 
    doorNr = 0
    doorOpen = false
end

CreateThread(function()
    while true do 
        Wait(10)
        if doorOpen then 
            if doorNr == 1 then 
                local distance = #(GetEntityCoords(PlayerPedId()) - mantrapEntryDoorsCoords[1])
                if distance > 10 then 
                    --print("close" .. doorNr)
                    CloseMantrapDoor(1)
                    Wait(100)
                else 
                    Wait(100)
                end
            elseif doorNr == 3 then
                local distance = #(GetEntityCoords(PlayerPedId()) - mantrapEntryDoorsCoords[3])
                if distance > 7 then 
                    --print("close" .. doorNr)
                    CloseMantrapDoor(3)
                    Wait(100)
                else 
                    Wait(100)
                end
            else 
                Wait(1000)
            end
        else 
            Wait(1000)
        end
    end
end)

CreateThread(function()
    while true do 
        Wait(0)
        if isInMantrap then 
            print(openedDoor)
            if openedDoor == 1 then 
                local distance = #(GetEntityCoords(PlayerPedId()) - mantrapEntryDoorsCoords[3])
                --print(distance)
                if distance < 2.5 then 
                    OpenMantrapDoor(3)
                    isInMantrap = false
                    isInVault = true
                    
                    --SetVaultDoors()
                    --print("door 1")
                else 
                    Wait(100)
                end
            elseif openedDoor == 3 then   
                local distance = #(GetEntityCoords(PlayerPedId()) - mantrapEntryDoorsCoords[1])
                if distance < 2.5 then 
                    OpenMantrapDoor(1)
                    isInMantrap = false
                    --print("door 3")
                else 
                    Wait(100)
                end
            else 
                Wait(50)
                print("niks")
            end
            --print("man")
        else 
            Wait(500)
        end        
    end
end)