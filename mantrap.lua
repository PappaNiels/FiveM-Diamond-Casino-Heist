isInMantrap = false
canPlantExplosive = false
openedDoor = 0

local mantrapEntryDoorsCoords = {
    vector3(2464.183, -278.204, -71.694),
    vector3(2464.183, -280.288, -71.694), 
    vector3(2492.280, -237.459, -71.738), 
    vector3(2492.280, -239.544, -71.738)
}

local plantExplosives = {
    ["anims"] = {
        ["left"] = {
            [1] = { 
                {"player_ig8_vault_explosive_enter",    "semtex_a_ig8_vault_explosive_enter",   "bag_ig8_vault_explosive_enter",    "cam_ig8_vault_explosive_enter"},
                {"player_ig8_vault_explosive_idle",     "semtex_a_ig8_vault_explosive_idle",    "bag_ig8_vault_explosive_idle",     "cam_ig8_vault_explosive_idle"},
                {"player_ig8_vault_explosive_plant_a",  "semtex_a_ig8_vault_explosive_plant_a", "bag_ig8_vault_explosive_plant_a",  "cam_ig8_vault_explosive_plant_a"},
                {"player_ig8_vault_explosive_plant_b",  "semtex_a_ig8_vault_explosive_plant_b", "bag_ig8_vault_explosive_plant_b",  "cam_ig8_vault_explosive_plant_b"},
                {"player_ig8_vault_explosive",          "semtex_a_ig8_vault_explosive",         "bag_ig8_vault_explosive",          "cam_ig8_vault_explosive"} 
            },
            [2] = {
                {"player_ig8_vault_explosive_enter",    "semtex_b_ig8_vault_explosive_enter",   "bag_ig8_vault_explosive_enter",    "cam_ig8_vault_explosive_enter"},
                {"player_ig8_vault_explosive_idle",     "semtex_b_ig8_vault_explosive_idle",    "bag_ig8_vault_explosive_idle",     "cam_ig8_vault_explosive_idle"},
                {"player_ig8_vault_explosive_plant_a",  "semtex_b_ig8_vault_explosive_plant_a", "bag_ig8_vault_explosive_plant_a",  "cam_ig8_vault_explosive_plant_a"},
                {"player_ig8_vault_explosive_plant_b",  "semtex_b_ig8_vault_explosive_plant_b", "bag_ig8_vault_explosive_plant_b",  "cam_ig8_vault_explosive_plant_b"},
                {"player_ig8_vault_explosive",          "semtex_b_ig8_vault_explosive",         "bag_ig8_vault_explosive",          "cam_ig8_vault_explosive"} 
            }
        },
        ["right"] = { 
            [1] = { 
                {"player_ig8_vault_explosive_enter",    "semtex_a_ig8_vault_explosive_enter",   "bag_ig8_vault_explosive_enter",    "cam_ig8_vault_explosive_enter"},
                {"player_ig8_vault_explosive_idle",     "semtex_a_ig8_vault_explosive_idle",    "bag_ig8_vault_explosive_idle",     "cam_ig8_vault_explosive_idle"},
                {"player_ig8_vault_explosive_plant_a",  "semtex_a_ig8_vault_explosive_plant_a", "bag_ig8_vault_explosive_plant_a",  "cam_ig8_vault_explosive_plant_a"},
                {"player_ig8_vault_explosive_plant_b",  "semtex_a_ig8_vault_explosive_plant_b", "bag_ig8_vault_explosive_plant_b",  "cam_ig8_vault_explosive_plant_b"},
                {"player_ig8_vault_explosive_plant_c",  "semtex_a_ig8_vault_explosive_plant_c", "bag_ig8_vault_explosive_plant_c",  "cam_ig8_vault_explosive_plant_c"},
                {"player_ig8_vault_explosive",          "semtex_a_ig8_vault_explosive",         "bag_ig8_vault_explosive",          "cam_ig8_vault_explosive"} 
            },
            [2] = {
                {"player_ig8_vault_explosive_enter",    "semtex_b_ig8_vault_explosive_enter",   "bag_ig8_vault_explosive_enter",    "cam_ig8_vault_explosive_enter"},
                {"player_ig8_vault_explosive_idle",     "semtex_b_ig8_vault_explosive_idle",    "bag_ig8_vault_explosive_idle",     "cam_ig8_vault_explosive_idle"},
                {"player_ig8_vault_explosive_plant_a",  "semtex_b_ig8_vault_explosive_plant_a", "bag_ig8_vault_explosive_plant_a",  "cam_ig8_vault_explosive_plant_a"},
                {"player_ig8_vault_explosive_plant_b",  "semtex_b_ig8_vault_explosive_plant_b", "bag_ig8_vault_explosive_plant_b",  "cam_ig8_vault_explosive_plant_b"},
                {"player_ig8_vault_explosive_plant_c",  "semtex_b_ig8_vault_explosive_plant_c", "bag_ig8_vault_explosive_plant_c",  "cam_ig8_vault_explosive_plant_c"},
                {"player_ig8_vault_explosive",          "semtex_b_ig8_vault_explosive",         "bag_ig8_vault_explosive",          "cam_ig8_vault_explosive"} 
            },
            [3] = {
                {"player_ig8_vault_explosive_enter",    "semtex_c_ig8_vault_explosive_enter",   "bag_ig8_vault_explosive_enter",    "cam_ig8_vault_explosive_enter"},
                {"player_ig8_vault_explosive_idle",     "semtex_c_ig8_vault_explosive_idle",    "bag_ig8_vault_explosive_idle",     "cam_ig8_vault_explosive_idle"},
                {"player_ig8_vault_explosive_plant_a",  "semtex_c_ig8_vault_explosive_plant_a", "bag_ig8_vault_explosive_plant_a",  "cam_ig8_vault_explosive_plant_a"},
                {"player_ig8_vault_explosive_plant_b",  "semtex_c_ig8_vault_explosive_plant_b", "bag_ig8_vault_explosive_plant_b",  "cam_ig8_vault_explosive_plant_b"},
                {"player_ig8_vault_explosive_plant_c",  "semtex_c_ig8_vault_explosive_plant_c", "bag_ig8_vault_explosive_plant_c",  "cam_ig8_vault_explosive_plant_c"},
                {"player_ig8_vault_explosive",          "semtex_c_ig8_vault_explosive",         "bag_ig8_vault_explosive",          "cam_ig8_vault_explosive"} 
            }
        }
    },
    ["networkScenes"] = {}
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

RegisterCommand("test_anim_bomb", function()
    SetVaultDoorStatus()
    FreezeEntityPosition(GetClosestObjectOfType(2504.58, -240.4, -70.71, 2.0, GetHashKey("ch_prop_ch_vaultdoor01x"), false, false, false), true)
    PlantBombs("right")
end, false)

function PlantBombs(place)
    local animDict = "anim_heist@hs3f@ig8_vault_explosives@left@male@"
    local x = 0 
    local bomb = "ch_prop_ch_explosive_01a"
    local bag = "ch_p_m_bag_var02_arm_s"--"hei_p_m_bag_var22_arm_s" --

    if place == "left" then 
        animDict = "anim_heist@hs3f@ig8_vault_explosives@left@male@" 
        x = math.random(1, 2) 
    else
        animDict = "anim_heist@hs3f@ig8_vault_explosives@right@male@" 
        x = math.random(1, 3)
    end

    --print(x)
    --print("Animdict: "..animDict)
    --print(animDict)
    LoadAnim(animDict)
    LoadModel(bomb)
    LoadModel(bag)
    --print(plantExplosives["anims"][place][x][1][1])
    --print(plantExplosives["anims"][place][x][1][2])
    --print(plantExplosives["anims"][place][x][1][3])
    --print(#plantExplosives["anims"][place][1])
    vaultDoor = GetClosestObjectOfType(2504.58, -240.4, -70.71, 2.0, GetHashKey("ch_prop_ch_vaultdoor01x"), false, false, false)
    bombProp = CreateObject(GetHashKey(bomb), GetEntityCoords(PlayerPedId()), true, true, false)
    bagProp = CreateObject(GetHashKey(bag), GetEntityCoords(PlayerPedId()), true, true, false)
    print(GetEntityCoords(vaultDoor), GetEntityRotation(vaultDoor))

    --FreezeEntityPosition(bombProp, false)
    --PlayEntityAnim(bombProp, plantExplosives["anims"][place][x][1][2], animDict, 1.0, false, true, false, 0, 0x4000)
    --cam = CreateCam("DEFAULT_ANIMATED_CAMERA", true)

    for i = 1, #plantExplosives["anims"][place][1] do 
        plantExplosives["networkScenes"][i] = NetworkCreateSynchronisedScene(2504.975, -240.3, -70.2, 0.0, 0.0, 0.0, 2, true, false, 1065353216, 0.0, 1.3)
        NetworkAddPedToSynchronisedScene(PlayerPedId(), plantExplosives["networkScenes"][i], animDict, plantExplosives["anims"][place][x][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
        NetworkAddEntityToSynchronisedScene(bombProp, plantExplosives["networkScenes"][i], animDict, plantExplosives["anims"][place][x][i][2], 1.0, -1.0, 114886080)
        NetworkAddEntityToSynchronisedScene(bagProp, plantExplosives["networkScenes"][i], animDict, plantExplosives["anims"][place][x][i][3], 1.0, -1.0, 114886080)
    end

    --print(GetAnimDuration(animDict, plantExplosives["anims"][place][x][1][1]))
    --AttachEntityToEntity(bombProp, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 0xDEAD), GetEntityCoords(PlayerPedId()), GetEntityRotation(PlayerPedId()))
    NetworkStartSynchronisedScene(plantExplosives["networkScenes"][1])
    Wait(2000)
    print("1")
    --Wait(GetAnimDuration(animDict, plantExplosives["anims"][place][x][1][1]) * 1000)
    NetworkStartSynchronisedScene(plantExplosives["networkScenes"][3])
    print('3')
    Wait(2000)
    --Wait(GetAnimDuration(animDict, plantExplosives["anims"][place][x][3][1]) * 1000)
    print('4')
    NetworkStartSynchronisedScene(plantExplosives["networkScenes"][4])
    --NetworkStartSynchronisedScene(plantExplosives["networkScenes"][5])
    --ClearPedTasksImmediately(PlayerPedId())




end

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
        SetupCheckpoint()
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
                --print(openedDoor)
            if openedDoor == 1 then 
                local distance = #(GetEntityCoords(PlayerPedId()) - mantrapEntryDoorsCoords[3])
                --print(distance)
                if distance < 2.5 then 
                    OpenMantrapDoor(3)
                    isInMantrap = false
                    --isInVault = true
                    if heistType == 1 then 
                        canPlantExplosive = true 
                    end
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