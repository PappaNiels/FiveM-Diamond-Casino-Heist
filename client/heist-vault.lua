cartLayout = 0
vaultLayout = 0

isBusy = false

local test = {}
local takeObjs = {}
local paintingObjs = {}
local slideDoorObjs = {}
local blips = {}

local status = {
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

local function OpenSlideDoors(size, num, hash)
    if not IsDoorRegisteredWithSystem(GetHashKey("WHOUSE_DOOR_RANCHO_" .. tostring(num) .. size)) then
        AddDoorToSystem(GetHashKey("WHOUSE_DOOR_RANCHO_" .. tostring(num) .. size), GetHashKey(hash), slideDoors[num], false, false, false)
    end

    DoorSystemSetDoorState(GetHashKey("WHOUSE_DOOR_RANCHO_" .. tostring(num) .. size), 0, false, false)
    
    print(#(GetEntityCoords(slideDoorObjs[num]) - (slideDoors[num] + (GetEntityOffset(slideDoorObjs[num], true) * 2)) ) < 1.0) 
    --repeat 
    --    Wait(10) 
    --    print("loop")
    --until #(GetEntityCoords(slideDoorObjs[num]) - (slideDoors[num] + (GetEntityOffset(slideDoorObjs[num], true) * 1.75)) < 1.0)
    
    Wait(4000)

    
    RemoveDoorFromSystem(GetHashKey("WHOUSE_DOOR_RANCHO_" .. tostring(num) .. size))
    FreezeEntityPosition(slideDoorObjs[num], true)
    --DoorSystemSetDoorState(GetHashKey("WHOUSE_DOOR_RANCHO_" .. tostring(num) .. size), 1, false, false)
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
        
        --LoadModel("prop_weed_01")
        
        for i = 1, #carts[cartLayout] do 
            local j = CartType(i)
            
            takeObjs[i] = CreateObject(GetHashKey(cartType[loot][j]), carts[cartLayout][i].x, carts[cartLayout][i].y, carts[cartLayout][i].z, true, false, false)
            SetEntityHeading(takeObjs[i], carts[cartLayout][i].w)

            --test[i] = CreateObject(GetHashKey("prop_weed_01"), GetEntityCoords(takeObjs[i]) + GetEntityOffset(takeObjs[i], false) * 0.5, false, false, false)
            --SetEntityHeading(test[i], carts[cartLayout][i].w)
            
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
        --print(DoesEntityExist(slideDoorObjs[layouts[vaultLayout][i]]))
        local coords = GetEntityCoords(slideDoorObjs[layouts[vaultLayout][i]])
        --local heading = GetEntityHeading(slideDoorObjs[layouts[vaultLayout][i]]) / 180 * math.pi
        --local plus = vector3(math.cos(heading), math.sin(heading), 0.0)
        
        SetEntityCoords(slideDoorObjs[layouts[vaultLayout][i]], coords + (GetEntityOffset(slideDoorObjs[layouts[vaultLayout][i]], true) * 2), true, false, false, false)
        status[2][layouts[vaultLayout][i]] = true
    end

    for i = 1, 7 do 
        print(status[2][i])
    end
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
        "cut the painting.",
        "Press ~INPUT_CONTEXT~ to begin grabbing the diamonds."
    }
    
    SetVaultLayout()

    if player == 1 then 
        SetVaultObjs()
    else 
        Wait(100)
        GetVaultObjs()
    end

    --if loot == 3 then 
    --    lootObj = artCabinets
    --else 
    --    lootObj = carts[cartLayout]
    --end

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
                            Wait(10)
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
                               HackKeypad(3, k, OpenSlideDoors)
                            end
                        end
                    else 
                        Wait(10)
                    end
                end

                --for i = 1, #keypads[3] do 
                --    if not status[2][i] then 
                --        print(i, keypads[3][i])
                --        local distance = #(GetEntityCoords(PlayerPedId()) - keypads[3][i])
--
                --        if distance < 1 then 
                --            HelpMsg("Press ~INPUT_CONTEXT~ to hack the keypad")
                --            if IsControlPressed(0, 38) then 
                --                HackKeyPad(3, i)
                --            end
                --        end
                --    end
                --end
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