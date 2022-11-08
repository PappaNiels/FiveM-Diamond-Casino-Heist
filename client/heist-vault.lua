cartLayout = 0
vaultLayout = 0

isBusy = false

status = {
    {
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false
    },
    {
        false,
        false,
        false,
        false,
        false,
        false,
        false,
    }
}

local test = {}
local takeObjs = {}
local paintingObjs = {}
local slideDoorObjs = {}
local blips = {}

local paintingNames = {
    "ch_prop_vault_painting_01a",
    "ch_prop_vault_painting_01d",
    "ch_prop_vault_painting_01f",
    "ch_prop_vault_painting_01g",
    "ch_prop_vault_painting_01h",
    "ch_prop_vault_painting_01i",
}

local cartType = {
    {"ch_prop_ch_cash_trolly_01a", "ch_prop_ch_cash_trolly_01b", "ch_prop_ch_cash_trolly_01c"},
    {"ch_prop_gold_trolly_01a", "ch_prop_gold_trolly_01b", "ch_prop_gold_trolly_01c"},
    {},
    {"ch_prop_diamond_trolly_01a", "ch_prop_diamond_trolly_01b", "ch_prop_diamond_trolly_01c"} 
}

local cartAnims = {
    {
        {"intro", "bag_intro"},
        {"grab", "bag_grab", "cart_cash_dissapear"},
        {"grab_idle", "bag_grab_idle"},
        {"exit", "bag_exit"}
    },
    {}
}

local function CartType(i)
    j = 0
    if i > 3 and i < 7 then 
        j = i - 3 
    elseif i > 6 then 
        j = i - 6
    else 
        j = i
    end

    return j
end

RegisterCommand("test_doorslide", function() 
    OpenSlideDoors("A", 1, "ch_prop_ch_vault_slide_door_lrg")
end, false)

local function GetVaultObjs()
    if loot == 3 then 
        for i = 1, #artCabinets do 
            takeObjs[i] = GetClosestObjectOfType(artCabinets[i].x, artCabinets[i].y, artCabinets[i].z, 1.0, GetHashKey("ch_prop_ch_sec_cabinet_02a"), false, false, false)
            paintingObjs[i] = GetClosestObjectOfType(paintings[i], 1.0, GetHashKey(paintingNames[i]), false, false, false)
            
            blips[i] = AddBlipForEntity(artCabinetObjs[i])
            SetBlipSprite(blips[i], 534 + i)
            SetBlipScale(blips[i], 0.8)
            SetBlipColour(blips[i], 3)
        end 
    else 
        for i = 1, #carts[cartLayout] do 
            local j = CartType(i)

            takeObjs[i] = GetClosestObjectOfType(carts[cartLayout][i].x, carts[cartLayout][i].y, carts[cartLayout][i].z, 1.0, GetHashKey(cartType[loot][j]), false, false, false)
            
            blips[i] = AddBlipForCoord(carts[cartLayout][i].x, carts[cartLayout][i].y, carts[cartLayout][i].z)
            SetBlipSprite(blips[i], 534 + i)
            SetBlipColour(blips[i], 2)
            SetBlipScale(blips[i], 0.8)
        end
    end
end

local function SetVaultObjs()
    loot = 1
    if loot == 3 then        
        LoadModel("ch_prop_ch_sec_cabinet_02a")

        for i = 1, #paintingNames do 
            LoadModel(paintingNames[i])
        end 

        for i = 1, #artCabinets do 
            takeObjs[i] = CreateObject(GetHashKey("ch_prop_ch_sec_cabinet_02a"), artCabinets[i].x, artCabinets[i].y, artCabinets[i].z, true, false, false)
            SetEntityHeading(takeObjs[i], artCabinets[i].w)
            paintingObjs[i] = CreateObject(GetHashKey(paintingNames[i]), paintings[i], true, false, false)
            SetEntityHeading(paintingObjs[i], artCabinets[i].w)

            blips[i] = AddBlipForEntity(artCabinetObjs[i])
            SetBlipSprite(blips[i], 534 + i)
            SetBlipScale(blips[i], 0.8)
            SetBlipColour(blips[i], 3)
        end

        for i = 1, #paintingNames do 
            SetModelAsNoLongerNeeded(paintingNames[i]) 
        end

        SetModelAsNoLongerNeeded("ch_prop_ch_sec_cabinet_02a") 
    else 
        loot = 1
        cartLayout = 1
            
        for i = 1, #cartType[loot] do 
            LoadModel(cartType[loot][i])
        end
        
        for i = 1, #carts[cartLayout] do 
            local j = CartType(i)
            
            takeObjs[i] = CreateObject(GetHashKey(cartType[loot][j]), carts[cartLayout][i].x, carts[cartLayout][i].y, carts[cartLayout][i].z, true, false, false)
            SetEntityHeading(takeObjs[i], carts[cartLayout][i].w)

            blips[i] = AddBlipForCoord(carts[cartLayout][i].x, carts[cartLayout][i].y, carts[cartLayout][i].z)
            SetBlipSprite(blips[i], 534 + i)
            SetBlipColour(blips[i], 2)
            SetBlipScale(blips[i], 0.8)
        end
        
        for i = 1, #cartType[loot] do 
            SetModelAsNoLongerNeeded(cartType[loot][i])
        end
    end
end

local function SetVaultLayout()
    local layouts = {
        {2, 3, 5, 7},
        {1, 5, 7},
        {2, 3, 4, 5},
        {1, 5, 7},
        {2, 3, 4},
        {4, 5},
        {2, 3, 4, 5},
        {1, 6, 7},
        {2, 3, 5},
        {5, 7}
    }
    
    --if loot == 3 then 
    --    vaultLayout = math.random(7, 10)
    --else
    --    vaultLayout = math.random(1, 6)
    --    
    --    if vaultLayout < 3 then 
    --        cartLayout = 1
    --    else 
    --        cartLayout = 2
    --    end
    --end

    vaultLayout = 1

    for i = 1, 7 do 
        if i < 4 then 
            slideDoorObjs[i] = GetClosestObjectOfType(slideDoors[i], 1.0, GetHashKey("ch_prop_ch_vault_slide_door_lrg"), false, false, false)
        else
            slideDoorObjs[i] = GetClosestObjectOfType(slideDoors[i], 1.0, GetHashKey("ch_prop_ch_vault_slide_door_sm"), false, false, false)
        end
    end 

    for i = 1, #layouts[vaultLayout] do 
        local coords = GetEntityCoords(slideDoorObjs[layouts[vaultLayout][i]])

        SetEntityCoords(slideDoorObjs[layouts[vaultLayout][i]], coords + (GetEntityOffset(slideDoorObjs[layouts[vaultLayout][i]], true) * 2), true, false, false, false)
        status[2][layouts[vaultLayout][i]] = true
    end

    for i = 1, 7 do 
        print(status[2][i])
    end
end

local function GrabLoot(i)
    local animTime = 0.0
    local grabbing = false
    local quit = false
    local animDict = "anim@heists@ornate_bank@grab_cash"
    local bag = "hei_p_m_bag_var22_arm_s"
    local propType = {
        "ch_prop_20dollar_pile_01a",
        "ch_prop_gold_bar_01a",
        "",
        "ch_prop_dimaondbox_01a"
    }
    local lootStrings = {
        "cash",
        "gold",
        "",
        "diamonds"
    }
    
    isBusy = true
    
    local cartCoords = GetEntityCoords(takeObjs[i])
    local cartHeading = GetEntityHeading(takeObjs[i]) / 180 * math.pi
    local camCoords = (1.25 * vector3(math.cos(cartHeading + ((14 / 12) * math.pi)), math.sin(cartHeading + ((14 / 12) * math.pi)), 1.0)) + cartCoords


    LoadAnim(animDict)
    LoadModel(propType[loot])
    LoadModel(bag)
        
    if loot == 2 or loot == 4 then 
        animTime = 0.5037
    end

    bagObj = CreateObject(GetHashKey(bag), GetEntityCoords(PlayerPedId()), true, false, false)
    boxObj = CreateObject(propType[loot], GetEntityCoords(PlayerPedId()), true, false, false)

    AttachEntityToEntity(boxObj, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
    SetEntityVisible(boxObj, false, false)
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    --AttachCamToEntity(cam, trollyObj, 1.0, 1.0, 1.0, true)
    SetCamCoord(cam, camCoords)
    PointCamAtCoord(cam, cartCoords.xy, cartCoords.z + 0.5)
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 1000, true, false)
    
    
    y = NetworkCreateSynchronisedScene(cartCoords, GetEntityRotation(takeObjs[i]), 2, true, false, 1.0, animTime, 0.0)
    NetworkAddEntityToSynchronisedScene(takeObjs[i], y, animDict, "cart_cash_dissapear", 1000.0, -4.0, 1)
    ForceEntityAiAndAnimationUpdate(takeObjs[i])
    NetworkStartSynchronisedScene(y)
    
    x = NetworkCreateSynchronisedScene(cartCoords, GetEntityRotation(takeObjs[i]), 2, true, false, 1.0, 0.0, 1.0)
    NetworkAddEntityToSynchronisedScene(bagObj, x, animDict, "bag_intro", 1000.0, -1000.0, 0)
    ForceEntityAiAndAnimationUpdate(bagObj)
    NetworkAddPedToSynchronisedScene(PlayerPedId(), x, animDict, "intro", 1.5, -8.0, 13, 16, 1.5, 0)
    ForcePedAiAndAnimationUpdate(PlayerPedId(), false, true)
    NetworkStartSynchronisedScene(x)
    
    Wait(2000)
    
    z = NetworkCreateSynchronisedScene(cartCoords, GetEntityRotation(takeObjs[i]), 2, false, true, 1.0, 0.0, 1.0)
    NetworkAddEntityToSynchronisedScene(bagObj, z, animDict, "bag_grab_idle", 1000.0, -1000.0, 0)
    ForceEntityAiAndAnimationUpdate(bagObj)
    NetworkAddPedToSynchronisedScene(PlayerPedId(), z, animDict, "grab_idle", 2.0, -8.0, 13, 16, 1000.0, 0)
    ForcePedAiAndAnimationUpdate(PlayerPedId(), false, true)
    NetworkStartSynchronisedScene(z)
    
    Wait(1000)
    
    CreateThread(function()
        while animTime < 1.0 or not quit do 
            Wait(5)
            HelpMsg("Repeatedly tap ~INPUT_CURSOR_ACCEPT~ to quickly grab the \n" .. lootStrings[loot] .. ". Press ~INPUT_CURSOR_CANCEL~ to stop grabbing the \n" .. lootStrings[loot] .. ".")
        end
    end)
    
    while animTime < 1.0 do 
        Wait(100)


        if IsControlPressed(0, 237) and not grabbing then 
            grabbing = true
            
            a = NetworkCreateSynchronisedScene(cartCoords, GetEntityRotation(takeObjs[i]), 2, true, false, 1.0, animTime, 1.0)
            NetworkAddEntityToSynchronisedScene(bagObj, a, animDict, "bag_grab", 1000.0, -1000.0, 0)
            ForceEntityAiAndAnimationUpdate(bagObj)
            NetworkAddPedToSynchronisedScene(PlayerPedId(), a, animDict, "grab", 4.0, -4.0, 13, 16, 1000.0, 0)
            NetworkAddEntityToSynchronisedScene(takeObjs[i], a, animDict, "cart_cash_dissapear", 1000.0, -4.0, 1)
            ForceEntityAiAndAnimationUpdate(takeObjs[i])
            NetworkStartSynchronisedScene(a)
            
            while not HasAnimEventFired(PlayerPedId(), GetHashKey("CASH_APPEAR")) do 
                Wait(1)
            end
            
            SetEntityVisible(boxObj, true, false)            

            while not HasAnimEventFired(PlayerPedId(), GetHashKey("RELEASE_CASH_DESTROY")) do 
                Wait(1)
            end
            
            SetEntityVisible(boxObj, false, false)            
            
            SetSynchronizedSceneRate(NetworkGetLocalSceneFromNetworkId(a), 0)
            animTime = GetSynchronizedScenePhase(NetworkGetLocalSceneFromNetworkId(a))
            
            grabbing = false
        elseif IsControlPressed(0, 238) then 
            quit = true
            break
        else
            y = NetworkCreateSynchronisedScene(cartCoords, GetEntityRotation(takeObjs[i]), 2, true, false, 1.0, animTime, 0.0)
            NetworkAddEntityToSynchronisedScene(takeObjs[i], y, animDict, "cart_cash_dissapear", 1000.0, -4.0, 1)
            ForceEntityAiAndAnimationUpdate(takeObjs[i])
            NetworkStartSynchronisedScene(y)
            
            z = NetworkCreateSynchronisedScene(cartCoords, GetEntityRotation(takeObjs[i]), 2, false, true, 1.0, 0.0, 1.0)
            NetworkAddEntityToSynchronisedScene(bagObj, z, animDict, "bag_grab_idle", 1000.0, -1000.0, 0)
            ForceEntityAiAndAnimationUpdate(bagObj)
            NetworkAddPedToSynchronisedScene(PlayerPedId(), z, animDict, "grab_idle", 2.0, -8.0, 13, 16, 1000.0, 0)
            ForcePedAiAndAnimationUpdate(PlayerPedId(), false, true)
            NetworkStartSynchronisedScene(z)
        end
    end 

    y = NetworkCreateSynchronisedScene(cartCoords, GetEntityRotation(takeObjs[i]), 2, true, false, 1.0, animTime, 0.0)
    NetworkAddEntityToSynchronisedScene(takeObjs[i], y, animDict, "cart_cash_dissapear", 1000.0, -4.0, 1)
    ForceEntityAiAndAnimationUpdate(takeObjs[i])
    NetworkStartSynchronisedScene(y)


    exit = NetworkCreateSynchronisedScene(cartCoords, GetEntityRotation(takeObjs[i]), 2, false, false, 1.0, animTime, 1.0)
    NetworkAddEntityToSynchronisedScene(bagObj, exit, animDict, "bag_exit", 1000.0, -1000.0, 0)
    ForceEntityAiAndAnimationUpdate(bagObj)
    NetworkAddPedToSynchronisedScene(PlayerPedId(), exit, animDict, "exit", 4.0, -1.5, 13, 16, 1000.0, 0)
    ForcePedAiAndAnimationUpdate(PlayerPedId(), false, true)
    NetworkStartSynchronisedScene(exit)
    
    RenderScriptCams(false, true, 2000, true, false)
    DeleteEntity(bagObj)
    DeleteEntity(boxObj)

    if animTime >= 1 then 
        status[1][i] = true
        RemoveBlip(blips[i])
    end
    
    isBusy = false
end

function OpenSlideDoors(size, num, hash)
    if not IsDoorRegisteredWithSystem(GetHashKey("WHOUSE_DOOR_RANCHO_" .. tostring(num) .. size)) then
        AddDoorToSystem(GetHashKey("WHOUSE_DOOR_RANCHO_" .. tostring(num) .. size), GetHashKey(hash), slideDoors[num], false, false, false)
    end
    
    DoorSystemSetDoorState(GetHashKey("WHOUSE_DOOR_RANCHO_" .. tostring(num) .. size), 0, false, false)
    
    Wait(4000)
    
    RemoveDoorFromSystem(GetHashKey("WHOUSE_DOOR_RANCHO_" .. tostring(num) .. size))
    FreezeEntityPosition(slideDoorObjs[num], true)
end

function Vault()
    loot = 1
    vaultLayout = 1
    cartLayout = 1
    player = 1 

    --local lootObj = {}
    local txt = {
        "Press ~INPUT_CONTEXT~ to begin grabbing the cash.",
        "Press ~INPUT_CONTEXT~ to begin grabbing the gold.",
        "Press ~INPUT_CONTEXT~ to cut the paintings.",
        "Press ~INPUT_CONTEXT~ to begin grabbing the diamonds."
    }
    
    SetVaultLayout()

    if player == 1 then 
        SetVaultObjs()
    else 
        Wait(100)
        GetVaultObjs()
    end

    --iVar1 = NETWORK::NETWORK_CREATE_SYNCHRONISED_SCENE(ENTITY::GET_ENTITY_COORDS(bParam1, true), ENTITY::GET_ENTITY_ROTATION(bParam1, 2), 2, true, false, 1f, fVar0, 0f);
	--	if (ENTITY::DOES_ENTITY_EXIST(bParam1))
	--	{
	--		NETWORK::NETWORK_ADD_ENTITY_TO_SYNCHRONISED_SCENE(bParam1, iVar1, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 1000f, -4f, 1);
	--		ENTITY::FORCE_ENTITY_AI_AND_ANIMATION_UPDATE(bParam1);
	--	}
	--	NETWORK::NETWORK_START_SYNCHRONISED_SCENE(iVar1);

    LoadAnim("anim@heists@ornate_bank@grab_cash")

    

    if loot == 3 then 
        CreateThread(function()
            while true do 
                Wait(5)

                if not isBusy then 
                    for k, v in pairs(artCabinets) do 
                        if not status[1][k] then 
                            local distance = #(GetEntityCoords(PlayerPedId()) - v.xyz)

                            if distance < 1 then 
                                HelpMsg("Press ~INPUT_CONTEXT~ to cut the paintings.")
                                if IsControlPressed(0, 38) then 
                                    CutPainting(k)
                                end
                            end
                        else 
                            Wait(100)
                        end
                    end
                else 
                    Wait(1000)
                end
            end
        end)
    elseif loot == 1 then 
        CreateThread(function()
            while true do 
                Wait(5)
                if not isBusy then
                    for k, v in pairs(carts[cartLayout]) do 
                        if not status[1][k] then 
                            local distance = #(GetEntityCoords(PlayerPedId()) - (v.xyz + GetEntityOffset(takeObjs[k], false)))

                            --print(distance)

                            if distance < 1.2 then
                                HelpMsg(txt[loot])
                                if IsControlPressed(0, 38) then 
                                    GrabLoot(k)
                                end
                            end
                        else 
                            Wait(10)
                        end
                    end
                else 
                    Wait(1000)
                end
            end
        end)
    end

    CreateThread(function()
        while true do 
            Wait(5)

            if not isBusy then 
                for k, v in pairs(keypads[3]) do
                    if not status[2][k] then 
                        --print(k, v[k])
                        local distance = #(GetEntityCoords(PlayerPedId()) - v)
                        if distance < 1.0 then 
                            HelpMsg("Press ~INPUT_CONTEXT~ to hack the keypad")
                            if IsControlPressed(0, 38) then 
                               HackKeypad(3, k, true)
                            end
                        end
                    else 
                        Wait(10)
                    end
                end
            else 
                Wait(1000)
            end
        end
    end)
end

RegisterNetEvent("cl:casinoheist:syncAccessibleLoot", function(num)
    status[1][num] = true
end) 

RegisterNetEvent("cl:casinoheist:syncSlideDoors", function(num)
    status[2][num] = true
end)

RegisterCommand("test_offset", Vault, false)