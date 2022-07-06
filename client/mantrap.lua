isInMantrap = false
--isInCheckpoint = false
canPlantExplosive = false
doorOpen = false
doorNr = 0
openedDoor = 0


local leftExplosives = false
local rightExplosives = false
local blipActive = false
local blip = {}
local explosives = {}
local bombLeft = {}
local bombRight = {}

local mantrapEntryDoorsCoords = {
    vector3(2464.183, -278.204, -71.694),
    vector3(2464.183, -280.288, -71.694), 
    vector3(2492.280, -237.459, -71.738), 
    vector3(2492.280, -239.544, -71.738)
}

local plantExplosives = {
    ["anims"] = {
        ["left"] = {
            {"player_ig8_vault_explosive_enter",    "semtex_a_ig8_vault_explosive_enter",   "semtex_b_ig8_vault_explosive_enter",   "bag_ig8_vault_explosive_enter",    "cam_ig8_vault_explosive_enter"},
            {"player_ig8_vault_explosive_idle",     "semtex_a_ig8_vault_explosive_idle",    "semtex_b_ig8_vault_explosive_idle",    "bag_ig8_vault_explosive_idle",     "cam_ig8_vault_explosive_idle"},
            {"player_ig8_vault_explosive_plant_a",  "semtex_a_ig8_vault_explosive_plant_a", "semtex_b_ig8_vault_explosive_plant_a", "bag_ig8_vault_explosive_plant_a",  "cam_ig8_vault_explosive_plant_a"},
            {"player_ig8_vault_explosive_plant_b",  "semtex_a_ig8_vault_explosive_plant_b", "semtex_b_ig8_vault_explosive_plant_b", "bag_ig8_vault_explosive_plant_b",  "cam_ig8_vault_explosive_plant_b"} 
        },
        ["right"] = { 
            {"player_ig8_vault_explosive_enter",    "semtex_a_ig8_vault_explosive_enter",    "semtex_b_ig8_vault_explosive_enter",   "semtex_c_ig8_vault_explosive_enter",      "bag_ig8_vault_explosive_enter",    "cam_ig8_vault_explosive_enter"},
            {"player_ig8_vault_explosive_idle",     "semtex_a_ig8_vault_explosive_idle",     "semtex_b_ig8_vault_explosive_idle",    "semtex_c_ig8_vault_explosive_idle",       "bag_ig8_vault_explosive_idle",     "cam_ig8_vault_explosive_idle"},
            {"player_ig8_vault_explosive_plant_a",  "semtex_a_ig8_vault_explosive_plant_a",  "semtex_b_ig8_vault_explosive_plant_a", "semtex_c_ig8_vault_explosive_plant_a",    "bag_ig8_vault_explosive_plant_a",  "cam_ig8_vault_explosive_plant_a"},
            {"player_ig8_vault_explosive_plant_b",  "semtex_a_ig8_vault_explosive_plant_b",  "semtex_b_ig8_vault_explosive_plant_b", "semtex_c_ig8_vault_explosive_plant_b",    "bag_ig8_vault_explosive_plant_b",  "cam_ig8_vault_explosive_plant_b"},
            {"player_ig8_vault_explosive_plant_c",  "semtex_a_ig8_vault_explosive_plant_c",  "semtex_b_ig8_vault_explosive_plant_c", "semtex_c_ig8_vault_explosive_plant_c",    "bag_ig8_vault_explosive_plant_c",  "cam_ig8_vault_explosive_plant_c"} 
        }
    },
    ["networkScenesLeft"] = {},
    ["networkScenesRight"] = {}
}

RegisterCommand("doors_unrev", function()
    OpenMantrapDoor(1)
    isInMantrap = true
    openedDoor = 1
end, false)

RegisterCommand("doors_rev", function()
    local pDoorL, pDoorR = GetHashKey("ch_prop_ch_tunnel_door_01_l"), GetHashKey("ch_prop_ch_tunnel_door_01_r")
    local doorL = GetClosestObjectOfType(mantrapEntryDoorsCoords[num], 1.0, pDoorL, false, false, false)
    local doorR = GetClosestObjectOfType(mantrapEntryDoorsCoords[num + 1], 1.0, pDoorR, false, false, false)

    AddDoorToSystem()
end, false)

RegisterCommand("vl_anim", function()
    SetVaultDoorStatus(2)
    local prop = GetClosestObjectOfType(2505.54, -238.53, -71.65, 10.0, GetHashKey("ch_prop_ch_vault_wall_damage"), false, false, false)
    SetEntityVisible(prop, false)
    --VaultAnim()
end, false)

RegisterCommand("test_anim_bomb", function()
    SetVaultDoorStatus(1)
    FreezeEntityPosition(GetClosestObjectOfType(2504.58, -240.4, -70.71, 2.0, GetHashKey("ch_prop_ch_vaultdoor01x"), false, false, false), true) 
end, false)

RegisterCommand("vl_exp", function()
    for i = 1, #explosives do 
        AddExplosion(GetEntityCoords(explosives[i]), 4, 1.0, true, false, true)
        DeleteEntity(explosives[i])
    end
end, false)

local function AddBlipsVaultCheckpoint()
    blip[1] = AddBlipForCoord(2504.5, -236.85, -70.74)
    SetBlipColour(blip[1], 2)
    SetBlipHighDetail(blip[1], true)
    SetBlipScale(blip[1], 0.750)
    
    blip[2] = AddBlipForCoord(2504.5, -239.98, -70.71)
    SetBlipColour(blip[2], 2)
    SetBlipHighDetail(blip[2], true)
    SetBlipScale(blip[2], 0.750)
end

local function RemoveBlipsVaultCheckpoint()   
    RemoveBlip(blip[1])
    RemoveBlip(blip[2])
end

local function RegisterExplosives()
    for i = 1, #bombLeft do 
        table.insert(explosives, bombLeft[i])
    end
    for i = 1, #bombRight do 
        table.insert(explosives, bombRight[i])
    end
end

RegisterCommand("vl_blips", function() AddBlipsVaultCheckpoint() end, false)
RegisterCommand("vl_blips_re", function() RemoveBlipsVaultCheckpoint() end, false)
RegisterCommand("vl_start", function() 
    SetVaultDoorStatus(2)
    local prop = GetClosestObjectOfType(2505.54, -238.53, -71.65, 10.0, GetHashKey("ch_prop_ch_vault_wall_damage"), false, false, false)
    SetEntityVisible(prop, false)
    --local vaultDoorOne = "ch_des_heist3_vault_01"
    --local vaultDoorTwo = "ch_des_heist3_vault_02"
    --LoadModel(vaultDoorOne)
    --LoadModel(vaultDoorTwo)
    --vaultObjOne = CreateObject(GetHashKey(vaultDoorOne), 2504.97, -240.31, -73.69, false, false, false)
    --vaultObjTwo = CreateObject(GetHashKey(vaultDoorTwo), 2504.97, -240.31, -75.334, false, false, false)  
    --canPlantExplosive = true 
end, false)

function PlantBombsLeft()
    local animDict = "anim_heist@hs3f@ig8_vault_explosives@left@male@"
    local bomb = "ch_prop_ch_explosive_01a"
    local bag =  "hei_p_m_bag_var22_arm_s"--"ch_p_m_bag_var02_arm_s"

    LoadModel(bomb)
    LoadModel(bag)
    
    bombLeft[1] = CreateObject(GetHashKey(bomb), GetEntityCoords(PlayerPedId()), true, true, false)
    bombLeft[2] = CreateObject(GetHashKey(bomb), GetEntityCoords(PlayerPedId()), true, true, false)
    bagProp = CreateObject(GetHashKey(bag), GetEntityCoords(PlayerPedId()), true, true, false)
    cam = CreateCam("DEFAULT_ANIMATED_CAMERA", true)
    SetCamActive(cam, true)
    RenderScriptCams(true, 1, 1000.0, true, false)
    SetEntityVisible(bombLeft[2], false)
    
    LoadAnim(animDict)
    
    for i = 1, #plantExplosives["anims"]["left"] do 
        plantExplosives["networkScenesLeft"][i] = NetworkCreateSynchronisedScene(2504.975, -240.23, -70.2, 0.0, 0.0, 0.0, 2, true, false, 1065353216, 0.0, 1.3)
        NetworkAddPedToSynchronisedScene(PlayerPedId(), plantExplosives["networkScenesLeft"][i], animDict, plantExplosives["anims"]["left"][i][1], 4.0, -4.0, 18, 0, 1000.0, 0)
        NetworkAddEntityToSynchronisedScene(bombLeft[1], plantExplosives["networkScenesLeft"][i], animDict, plantExplosives["anims"]["left"][i][2], 1.0, -1.0, 114886080)
        NetworkAddEntityToSynchronisedScene(bombLeft[2], plantExplosives["networkScenesLeft"][i], animDict, plantExplosives["anims"]["left"][i][3], 1.0, -1.0, 114886080)
        NetworkAddEntityToSynchronisedScene(bagProp, plantExplosives["networkScenesLeft"][i], animDict, plantExplosives["anims"]["left"][i][4], 1.0, -1.0, 114886080)
    end
    
    PlayCamAnim(cam, plantExplosives["anims"]["left"][1][5], animDict, 2504.975, -240.23, -70.2, 0.0, 0.0, 0.0, false, 2)
    NetworkStartSynchronisedScene(plantExplosives["networkScenesLeft"][1])
    Wait(2000)
    PlayCamAnim(cam, plantExplosives["anims"]["left"][2][5], animDict, 2504.975, -240.23, -70.2, 0.0, 0.0, 0.0, false, 2)
    NetworkStartSynchronisedScene(plantExplosives["networkScenesLeft"][2])
    --Wait(1000)
    bombOne = true
    while bombOne do 
        HelpMsg("Press ~INPUT_ATTACK~ to plant the first explosive", 1000)
        if IsControlPressed(0, 24) then 
            bombOne = false 
        else 
            Wait(10)
        end
    end
    PlayCamAnim(cam, plantExplosives["anims"]["left"][3][5], animDict, 2504.975, -240.23, -70.2, 0.0, 0.0, 0.0, false, 2)
    NetworkStartSynchronisedScene(plantExplosives["networkScenesLeft"][3])
    FreezeEntityPosition(bombLeft[1], true)
    Wait(2000)
    SetEntityVisible(bombLeft[2], true) 
    bombTwo = true
    while bombTwo do 
        HelpMsg("Press ~INPUT_ATTACK~ to plant the next explosive", 1000)
        if IsControlPressed(0, 24) then 
            bombTwo = false 
        else 
            Wait(10)
        end
    end   
    PlayCamAnim(cam, plantExplosives["anims"]["left"][4][5], animDict, 2504.975, -240.23, -70.2, 0.0, 0.0, 0.0, false, 2)
    NetworkStartSynchronisedScene(plantExplosives["networkScenesLeft"][4])
    FreezeEntityPosition(bombLeft[2], true)
    Wait(3000)
    ClearPedTasksImmediately(PlayerPedId())
    RenderScriptCams(false, false, 1000.0, false)
    DestroyCam(cam, false)
    DeleteEntity(bagProp)
end

function PlantBombsRight()
    local animDict = "anim_heist@hs3f@ig8_vault_explosives@right@male@"
    local bomb = "ch_prop_ch_explosive_01a"
    local bag =  "hei_p_m_bag_var22_arm_s"--"ch_p_m_bag_var02_arm_s"

    LoadModel(bomb)
    LoadModel(bag)

    bombRight[1] = CreateObject(GetHashKey(bomb), GetEntityCoords(PlayerPedId()), true, true, false)
    bombRight[2] = CreateObject(GetHashKey(bomb), GetEntityCoords(PlayerPedId()), true, true, false)
    bombRight[3] = CreateObject(GetHashKey(bomb), GetEntityCoords(PlayerPedId()), true, true, false)
    bagProp = CreateObject(GetHashKey(bag), GetEntityCoords(PlayerPedId()), true, true, false)
    cam = CreateCam("DEFAULT_ANIMATED_CAMERA", true)
    SetCamActive(cam, true)
    RenderScriptCams(true, 1, 1000, true, false)    
    SetEntityVisible(bombRight[2], false)
    SetEntityVisible(bombRight[3], false)


    LoadAnim(animDict)
    
    for i = 1, #plantExplosives["anims"]["right"] do 
        plantExplosives["networkScenesRight"][i] = NetworkCreateSynchronisedScene(2504.975, -240.23, -70.2, 0.0, 0.0, 0.0, 2, true, false, 1065353216, 0.0, 1.3)
        NetworkAddPedToSynchronisedScene(PlayerPedId(), plantExplosives["networkScenesRight"][i], animDict, plantExplosives["anims"]["right"][i][1], 4.0, -4.0, 18, 0, 1000.0, 0)
        NetworkAddEntityToSynchronisedScene(bombRight[1], plantExplosives["networkScenesRight"][i], animDict, plantExplosives["anims"]["right"][i][2], 1.0, -1.0, 114886080)
        NetworkAddEntityToSynchronisedScene(bombRight[2], plantExplosives["networkScenesRight"][i], animDict, plantExplosives["anims"]["right"][i][3], 1.0, -1.0, 114886080)
        NetworkAddEntityToSynchronisedScene(bombRight[3], plantExplosives["networkScenesRight"][i], animDict, plantExplosives["anims"]["right"][i][4], 1.0, -1.0, 114886080)
        NetworkAddEntityToSynchronisedScene(bagProp, plantExplosives["networkScenesRight"][i], animDict, plantExplosives["anims"]["right"][i][5], 1.0, -1.0, 114886080)
    end
    
    PlayCamAnim(cam, plantExplosives["anims"]["right"][1][6], animDict, 2504.975, -240.23, -70.2, 0.0, 0.0, 0.0, false, 2)
    NetworkStartSynchronisedScene(plantExplosives["networkScenesRight"][1])
    Wait(500)
    NetworkStartSynchronisedScene(plantExplosives["networkScenesRight"][2])
    PlayCamAnim(cam, plantExplosives["anims"]["right"][2][6], animDict, 2504.975, -240.23, -70.2, 0.0, 0.0, 0.0, false, 2)
    bombOne = true
    while bombOne do 
        HelpMsg("Press ~INPUT_ATTACK~ to plant the first explosive", 1000)
        if IsControlPressed(0, 24) then 
            bombOne = false 
        else 
            Wait(10)
        end
    end
    PlayCamAnim(cam, plantExplosives["anims"]["right"][3][6], animDict, 2504.975, -240.23, -70.2, 0.0, 0.0, 0.0, false, 2)
    NetworkStartSynchronisedScene(plantExplosives["networkScenesRight"][3])
    FreezeEntityPosition(bombRight[1], true)
    Wait(1500)
    SetEntityVisible(bombRight[2], true) 
    bombTwo = true
    while bombTwo do 
        HelpMsg("Press ~INPUT_ATTACK~ to plant the next explosive", 1000)
        if IsControlPressed(0, 24) then 
            bombTwo = false 
        else 
            Wait(10)
        end
    end   
    PlayCamAnim(cam, plantExplosives["anims"]["right"][4][6], animDict, 2504.975, -240.23, -70.2, 0.0, 0.0, 0.0, false, 2)
    NetworkStartSynchronisedScene(plantExplosives["networkScenesRight"][4])
    FreezeEntityPosition(bombRight[2], true)
    Wait(1000)
    SetEntityVisible(bombRight[3], true)    
    bombThree = true
    while bombThree do 
        HelpMsg("Press ~INPUT_ATTACK~ to plant the next explosive", 1000)
        if IsControlPressed(0, 24) then 
            bombThree = false 
        else 
            Wait(10)
        end
    end
    PlayCamAnim(cam, plantExplosives["anims"]["right"][5][6], animDict, 2504.975, -240.23, -70.2, 0.0, 0.0, 0.0, false, 2)
    NetworkStartSynchronisedScene(plantExplosives["networkScenesRight"][5])
    FreezeEntityPosition(bombRight[3], true)
    Wait(3000)
    ClearPedTasksImmediately(PlayerPedId())
    RenderScriptCams(false, 0, 1000.0, false)
    DestroyAllCams(false)
    
    DeleteEntity(bagProp)
end

function VaultAnim()
    local animDict = "anim_heist@hs3f@ig8_vault_door_explosion@"
    local vaultDoorOne = "ch_des_heist3_vault_01"
    local vaultDoorTwo = "ch_des_heist3_vault_02"
    LoadAnim(animDict)
    LoadModel(vaultDoorOne)
    LoadModel(vaultDoorTwo)

    RegisterExplosives()

    PlayEntityAnim(vaultObjTwo, "explosion_vault_02", animDict, 1.0, false, true, true, 0, 0x4000)
    PlayEntityAnim(vaultObjOne, "explosion_vault_01", animDict, 1.0, false, true, true, 0, 0x4000)
    Wait(1300)
    AddExplosion(GetEntityCoords(explosives[1]), 4, 1.0, true, false, true)
    Wait(100)
    AddExplosion(GetEntityCoords(explosives[2]), 4, 1.0, true, false, true)
    AddExplosion(GetEntityCoords(explosives[3]), 4, 1.0, true, false, true)
    Wait(200)
    AddExplosion(GetEntityCoords(explosives[4]), 4, 1.0, true, false, true)
    AddExplosion(GetEntityCoords(explosives[5]), 4, 1.0, true, false, true)
    StopFireInRange(2504.97, -240.31, -73.69, 10.0)
    ClearArea(2504.97, -240.31, -73.69, 10.0)
    for i = 1, #explosives do 
        DeleteEntity(explosives[i])
    end

    SetEntityVisible(GetClosestObjectOfType(2502.34, -239.46, -70.71, 1.0, GetHashKey("ch_prop_ch_vault_wall_damage"), false, false, false), true)

    Wait(2500)
    SetVaultDoorStatus(3)

    DeleteEntity(vaultObjOne)
    

    leftExplosives, rightExplosives = false, false
end

function OpenMantrapDoor(num)
    print(num)
    local pDoorL, pDoorR = GetHashKey("ch_prop_ch_tunnel_door_01_l"), GetHashKey("ch_prop_ch_tunnel_door_01_r")
    local doorL = GetClosestObjectOfType(mantrapEntryDoorsCoords[num], 1.0, pDoorL, false, false, false)
    local doorR = GetClosestObjectOfType(mantrapEntryDoorsCoords[num + 1], 1.0, pDoorR, false, false, false)
    local x = 0
    local coords1, coords2 = mantrapEntryDoorsCoords[num], mantrapEntryDoorsCoords[num + 1]
    if num == 3 then 
        
        
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

RegisterNetEvent("cl:security:openmantrapdoors")
AddEventHandler("cl:security:openmantrapdoors", function(num) 
    if openedDoor ~= num then 
        OpenMantrapDoor(num) 
        openedDoor = num
    end
end)

RegisterNetEvent("cl:security:closemantrapdoors")
AddEventHandler("cl:security:closemantrapdoors", function(num)
    CloseMantrapDoor(num)
end)

RegisterNetEvent("cl:casinoheist:mantrap:syncvaultbombs")
AddEventHandler("cl:casinoheist:mantrap:syncvaultbombs", function(side)
    if side == 1 then 
        RemoveBlip(blip[1])
        leftExplosives = true
        print(side)
    else 
        RemoveBlip(blip[2])
        rightExplosives = true
        print(side)
    end
end)

RegisterNetEvent("test:cl:vaultroom")
AddEventHandler("test:cl:vaultroom", function()
    canPlantExplosive = true
    SetupCheckpoint()
end)

RegisterNetEvent("test:cl:mantrap:syncdoors")
AddEventHandler("test:cl:mantrap:syncdoors", function()
    SetVaultDoorStatus(2)
    local prop = GetClosestObjectOfType(2505.54, -238.53, -71.65, 10.0, GetHashKey("ch_prop_ch_vault_wall_damage"), false, false, false)
    SetEntityVisible(prop, false)
end)

CreateThread(function()
    while true do 
        Wait(10)
        if doorOpen then 
            if doorNr == 1 then 
                local distance = #(GetEntityCoords(PlayerPedId()) - mantrapEntryDoorsCoords[1])
                if distance > 10 then 
                    SetVaultDoorStatus(2)
                    CloseMantrapDoor(1)
                    Wait(100)
                else 
                    Wait(100)
                end
            elseif doorNr == 3 then
                local distance = #(GetEntityCoords(PlayerPedId()) - mantrapEntryDoorsCoords[3])
                if distance > 5 then 
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
            if openedDoor == 1 then 
                print("test")
                local distance = #(GetEntityCoords(PlayerPedId()) - mantrapEntryDoorsCoords[3])
                if distance < 2.5 then 
                    SetupCheckpoint()
                    canPlantExplosive = true 
                    TriggerServerEvent("sv:casinoheist:security:openmantrapdoors", 3)
                    --OpenMantrapDoor(3)
                    isInMantrap = false
                    --isInVault = true
                    --if heistType == 1 then 
                    --end
                else 
                    Wait(100)
                end
            elseif openedDoor == 3 then   
                local distance = #(GetEntityCoords(PlayerPedId()) - mantrapEntryDoorsCoords[1])
                if distance < 2.5 then 
                    --OpenMantrapDoor(1)
                    TriggerServerEvent("sv:casinoheist:security:openmantrapdoors", 1)
                    isInMantrap = false
                else 
                    Wait(100)
                end
            else 
                Wait(50)
            end
        else 
            Wait(500)
        end        
    end
end)

CreateThread(function()
    while true do 
        Wait(0)
        if canPlantExplosive then 
            SubtitleMsg("Plant the ~g~explosives.", 510)
            if not blipActive then 
                AddBlipsVaultCheckpoint()
                blipActive = true 
            end
            local distanceOne = #(GetEntityCoords(PlayerPedId()) - vector3(2503.75, -236.85, -70.74))
            local distanceTwo = #(GetEntityCoords(PlayerPedId()) - vector3(2504.24, -239.98, -70.71))
            
            if distanceOne < 1.5 and not leftExplosives then 
                HelpMsg("Press ~INPUT_CONTEXT~ to plant explosives on the left side.", 500)
                if IsControlPressed(0, 38) then 
                    PlantBombsLeft()
                    TriggerServerEvent("sv:casinoheist:mantrap:syncvaultbombs", 1)
                    --RemoveBlip(blip[1])
                    --leftExplosives = true
                else 
                    Wait(50)
                end
            elseif distanceTwo < 1.5 and not rightExplosives then 
                HelpMsg("Press ~INPUT_CONTEXT~ to plant explosives on the right side.", 500)
                if IsControlPressed(0, 38) then 
                    PlantBombsRight()
                    TriggerServerEvent("sv:casinoheist:mantrap:syncvaultbombs", 2)
                    --RemoveBlip(blip[2])
                    --rightExplosives = true
                else 
                    Wait(50)
                end
            elseif leftExplosives and rightExplosives then 
                canPlantExplosive = false 
                local exBlip = AddBlipForRadius(2502.51, -238.75, -70.2, 5.0)
                SetBlipColour(exBlip, 76)
                SetBlipAlpha(exBlip, 175)
                SubtitleMsg("Leave the ~r~blast radius.", 6000)
                Wait(5000)
                VaultAnim()
                RemoveBlip(exBlip)
                Wait(2000)
                SetVaultDoors()
                loot = 2
                if loot == 2 then 
                    AddArtBlips()
                else 
                    print("no art :(")
                end
                isInVault = true
            else 
                Wait(500)
            end
        else 
            Wait(5000)
        end
    end
end)

RegisterCommand("test_mt", function()
    isInMantrap = true
end, false)