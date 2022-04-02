RegisterCommand("keycard", function()
    local animDict = "anim_heist@hs3f@ig3_cardswipe_insync@male@"

    LoadAnim(animDict)
    LoadModel("ch_prop_vault_key_card_01a")
    --RequestAnimDict(animDict)
    --while not HasAnimDictLoaded(animDict) do 
    --    Wait(10)
    --end

    ClearPedTasksImmediately(PlayerPedId())

    --SetEntityCoords(PlayerPedId(), 2465.45, -281.27, -70.69)
    local coords = GetEntityCoords(PlayerPedId())
    local pass = CreateObject(GetHashKey("ch_prop_vault_key_card_01a"), coords, true, true, false)

    AttachEntityToEntity(pass, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 0x67F2), 0.13, -0.04, 0.0, 0.0, 90.0, 0.0, false, false, false, false, 2, true)
    TaskPlayAnimAdvanced(PlayerPedId(), animDict, "ped_a_enter", 2465.45, -282.0, -70.69, 0, 0, 109.0, 8.0, -8.0, 600, 8, 0, 0, 0)
    Wait(600)
    --TaskPlayAnimAdvanced(PlayerPedId(), animDict, animName, 2465.45, -282.0, -70.69, 0, 0, 109.0, 8.0, -8.0, -1, 8, 0, 0, 0)
    TaskPlayAnim(PlayerPedId(), animDict, "ped_a_intro_b", 8.0, -8.0, 1933, 8, 0, 0, 0, 0)
    Wait(1933)   
    TaskPlayAnim(PlayerPedId(), animDict, "ped_a_loop", 8.0, -8.0, 2000, 8, 0, 0, 0, 0)
    Wait(2000)
    TaskPlayAnim(PlayerPedId(), animDict, "ped_a_pass", 8.0, -8.0, 1933, 8, 0, 0, 0, 0)

    DeleteEntity(pass)
end, false)

RegisterCommand("keycard1", function()
    local animDict = "anim_heist@hs3f@ig3_cardswipe_insync@male@"

    LoadAnim(animDict)
    LoadModel("ch_prop_vault_key_card_01a")
    --RequestAnimDict(animDict)
    --while not HasAnimDictLoaded(animDict) do 
    --    Wait(10)
    --end

    ClearPedTasksImmediately(PlayerPedId())

    --SetEntityCoords(PlayerPedId(), 2465.45, -281.27, -70.69)
    local coords = GetEntityCoords(PlayerPedId())
    local pass = CreateObject(GetHashKey("ch_prop_vault_key_card_01a"), coords, true, true, false)

    AttachEntityToEntity(pass, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 0x67F2), 0.13, -0.04, 0.0, 0.0, 90.0, 0.0, false, false, false, false, 2, true)
    TaskPlayAnimAdvanced(PlayerPedId(), animDict, "ped_b_enter", 2465.3, -276.45, -70.69, 0, 0, 60.73, 8.0, -8.0, 600, 8, 0, 0, 0)
    --TaskPlayAnim(PlayerPedId(), animDict, "ped_b_enter", 8.0, -8.0, 600, 8, 0, 0, 0, 0)
    Wait(600)
    --TaskPlayAnimAdvanced(PlayerPedId(), animDict, animName, 2465.45, -282.0, -70.69, 0, 0, 109.0, 8.0, -8.0, -1, 8, 0, 0, 0)
    TaskPlayAnim(PlayerPedId(), animDict, "ped_b_intro_b", 8.0, -8.0, 1933, 8, 0, 0, 0, 0)
    Wait(1933)   
    TaskPlayAnim(PlayerPedId(), animDict, "ped_b_loop", 8.0, -8.0, 2000, 8, 0, 0, 0, 0)
    Wait(2000)
    TaskPlayAnim(PlayerPedId(), animDict, "ped_b_pass", 8.0, -8.0, 1933, 8, 0, 0, 0, 0)

    DeleteEntity(pass)
end, false)

local heistInProgress = false

CreateThread(function()
    while true do
        Wait(0) 
        if heistInProgress then 
            local distance = #(GetEntityCoords(PlayerPedId()) - vector3(2465.45, -282.0, -70.69))
            if distance < 10 then 
                DrawMarker(1, 2465.45, -282.0, -71.7, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.50, 0.75, 229, 202, 23, 100, false, false, 2, false, nil, nil, false)
                if distance < 1 then 
                    HelpMsg("Press ~INPUT_CONTEXT~ to swipe the keycard")
                    if IsControlJustPressed(0, 38) then 
                        ExecuteCommand("keycard")
                        heistInProgress = false 
                    end
                end
            else 
                Wait(200)
            end
        else 
            Wait(1000)
        end
    end
end)

RegisterCommand("key", function()
    SetEntityCoords(PlayerPedId(), 2465.45, -282.0, -71.3)
    heistInProgress = true
end, false)

local vaultEntryDoorsCoords = {
    vector3(2464.183, -278.204, -71.694),
    vector3(2464.183, -280.288, -71.694), 
    vector3(2492.280, -237.459, -71.738), 
    vector3(2492.280, -239.544, -71.738)
}

local doorNr = 0

local doorOpen = false
local completed = false

RegisterCommand("shaft_doors", function(source, args)
    --completed = true
    OpenVaultShaft(3)
end, false)

RegisterCommand("vl_reset", function()
    local vaultShell = GetClosestObjectOfType(2505.54, -238.53, -71.65, 1.0, GetHashKey("ch_prop_ch_vault_wall_damage"), false, false, false)
    SetEntityVisible(vaultShell, true)
end, false)

function OpenVaultShaft(num)
    local pDoorL, pDoorR = GetHashKey("ch_prop_ch_tunnel_door_01_l"), GetHashKey("ch_prop_ch_tunnel_door_01_r")
    local doorL = GetClosestObjectOfType(vaultEntryDoorsCoords[num], 1.0, pDoorL, false, false, false)
    local doorR = GetClosestObjectOfType(vaultEntryDoorsCoords[num + 1], 1.0, pDoorR, false, false, false)
    local x = 0
    local coords1, coords2 = vaultEntryDoorsCoords[num], vaultEntryDoorsCoords[num + 1]
    if num == 3 then 
        local vaultShell = GetClosestObjectOfType(2505.54, -238.53, -71.65, 1.0, GetHashKey("ch_prop_ch_vault_wall_damage"), false, false, false)
        SetEntityVisible(vaultShell, false)
        print("vault")
    end
    repeat 
        coords1 = coords1 + vector3(0, 0.0105, 0)
        coords2 = coords2 - vector3(0, 0.0105, 0)
        SetEntityCoords(doorL, coords1)
        SetEntityCoords(doorR, coords2)
        x = x + 1
        Wait(23)
        --print("tick")
        --print(GetEntityCoords(doorL))
    until x == 100 
    doorNr = num 
    doorOpen = true
    
    --Wait(10000)
    --SetEntityCoords(doorL, vaultEntryDoorsCoords[num])
    --SetEntityCoords(doorR, vaultEntryDoorsCoords[num + 1])
end 

function CloseShaftDoor(num)
    local pDoorL, pDoorR = GetHashKey("ch_prop_ch_tunnel_door_01_l"), GetHashKey("ch_prop_ch_tunnel_door_01_r")
    local doorL = GetClosestObjectOfType(vaultEntryDoorsCoords[num] + vector3(0, 1.05, 0), 2.0, pDoorL, false, false, false)
    local doorR = GetClosestObjectOfType(vaultEntryDoorsCoords[num + 1] - vector3(0, 1.05, 0), 2.0, pDoorR, false, false, false)
    local x = 0
    local coords1, coords2 = vaultEntryDoorsCoords[num] + vector3(0, 1.05, 0), vaultEntryDoorsCoords[num + 1] - vector3(0, 1.05, 0)
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
                local distance = #(GetEntityCoords(PlayerPedId()) - vaultEntryDoorsCoords[1])
                if distance > 10 then 
                    print("close" .. doorNr)
                    CloseShaftDoor(1)
                    Wait(100)
                else 
                    Wait(100)
                end
            elseif doorNr == 3 then
                local distance = #(GetEntityCoords(PlayerPedId()) - vaultEntryDoorsCoords[3])
                if distance > 7 then 
                    print("close" .. doorNr)
                    CloseShaftDoor(3)
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
