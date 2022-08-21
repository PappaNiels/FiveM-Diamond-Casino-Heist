local arcadeGarage = GetInteriorAtCoords(2704.21, -363.68, -55.19)
local vault = GetInteriorAtCoords(2488.348, -267.3637, -71.64563)
local arcade = GetInteriorAtCoords(2731.66, -382.94, -49.38)

local arcadeprops = {
    --"casino_prop",
    "master_terminal",
    "hacker_terminal",
    "weapon_terminal",
    "vehicle_tools",
    "basic_after_setup",
    "living_quarters_after_setup",
    "garage_lights",
    "lester_whiteboard",
    "casino_map",
    "builder_hat",
    "vault_keycard"
}

local garageSets = {
    [1] = {
        "stealth_clothing",
        "hack_device",
        "broken_drone",
        "laser_drill",
    },
    [2] = {
        "cockroach_tub",
        "hack_device",
        "gruppe_sechs_clothing",
        "regular_drill",
    },
    [3] = {
        "vault_explosive",
        "hack_device"
    }
}

RegisterCommand("set_loot", function(source, args)
    local num = tonumber(args[1])
    SetLoot(num)
end)

function SetVaultDoorStatus(num)
    if num == 1 then 
        ActivateInteriorEntitySet(vault, "vault_door_normal")
        DeactivateInteriorEntitySet(vault, "vault_door_broken")
    elseif num == 2 then 
        DeactivateInteriorEntitySet(vault, "vault_door_normal")
        DeactivateInteriorEntitySet(vault, "vault_door_broken")
    elseif num == 3 then 
        ActivateInteriorEntitySet(vault, "vault_door_broken")
    elseif num == 4 then 
        ActivateInteriorEntitySet(vault, "vault_door_normal")
        SetEntityHeading(GetClosestObjectOfType(2504.58, -240.4, -70.71, 2.0, GetHashKey("ch_prop_ch_vaultdoor01x"), false, false, false), 132.0)
    end
    RefreshInterior(vault)
    Wait(100)
end

function SetCasinoModel(bool)
    if bool then 
        ActivateInteriorEntitySet(arcadeGarage, "casino_prop")
    else
        DeactivateInteriorEntitySet(arcadeGarage, "casino_prop")
    end
    RefreshInterior(arcadeGarage)
end 

function SetHackKeypadModel(bool)
    if bool then 
        ActivateInteriorEntitySet(arcadeGarage, "fingerprint_exercise")
    else
        DeactivateInteriorEntitySet(arcadeGarage, "fingerprint_exercise")
    end
    RefreshInterior(arcadeGarage)
end 

function SetVaultModel(bool)
    if bool then 
        ActivateInteriorEntitySet(arcadeGarage, "vault_exercise")
    else
        DeactivateInteriorEntitySet(arcadeGarage, "vault_exercise")
    end
    RefreshInterior(arcadeGarage)
end 

function SetApproachSets()
    if approach == 1 then 
        for i = 1, #garageSets[2] do 
            DeactivateInteriorEntitySet(arcadeGarage, garageSets[i])
        end
        
        for i = 1, #garageSets[3] do 
            DeactivateInteriorEntitySet(arcadeGarage, garageSets[i])
        end

        for i = 1, #garageSets[1] do 
            ActivateInteriorEntitySet(arcadeGarage, garageSets[i])
        end
    elseif approach == 2 then 
        for i = 1, #garageSets[1] do 
            DeactivateInteriorEntitySet(arcadeGarage, garageSets[i])
        end
        
        for i = 1, #garageSets[3] do 
            DeactivateInteriorEntitySet(arcadeGarage, garageSets[i])
        end

        for i = 1, #garageSets[2] do 
            ActivateInteriorEntitySet(arcadeGarage, garageSets[i])
        end
    elseif approach == 3 then 
        for i = 1, #garageSets[1] do 
            DeactivateInteriorEntitySet(arcadeGarage, garageSets[i])
        end
        
        for i = 1, #garageSets[2] do 
            DeactivateInteriorEntitySet(arcadeGarage, garageSets[i])
        end

        for i = 1, #garageSets[3] do 
            ActivateInteriorEntitySet(arcadeGarage, garageSets[i])
        end
    end
end

function SetLoot(loot)
    --loot = math.random(1, 4)
    
    if loot == 1 then 
        _loot = "cash"
    elseif loot == 2 then
        _loot = "art"
    elseif loot == 3 then 
        _loot = "gold"
    elseif loot == 4 then 
        _loot = "diamonds"
    end 

    
    print(_loot)

    if loot == 1 then 
        local remove = {
            "painting_prop_1",
            "painting_prop_2",
            "painting_prop_cabinet",
            "gold_prop_1",
            "gold_prop_2",
            "diamonds_prop_1",
            "diamonds_prop_2"
        }

        local add = {
            "money_prop_1",
            --"money_prop_2"
        }

        for i = 1, #remove, 1 do 
            DeactivateInteriorEntitySet(vault, remove[i])
        end

        for i = 1, #add, 1 do 
            ActivateInteriorEntitySet(vault, add[i])
        end 
    elseif loot == 2 then 
        local remove = {
            "money_prop_1",
            "money_prop_2",
            "gold_prop_1",
            "gold_prop_2",
            "diamonds_prop_1",
            "diamonds_prop_2"
        }

        local add = { 
            "painting_prop_1",
            "painting_prop_2",
            "painting_prop_cabinet"
        }
        
        for i = 1, #remove, 1 do 
            DeactivateInteriorEntitySet(vault, remove[i])
        end
        
        for i = 1, #add, 1 do 
            ActivateInteriorEntitySet(vault, add[i])
        end 
    elseif loot == 3 then
        local remove = {
            "money_prop_1",
            "money_prop_2",
            "painting_prop_1",
            "painting_prop_2",
            "painting_prop_cabinet",
            "diamonds_prop_1",
            "diamonds_prop_2"
        }
        
        local add = {
            "gold_prop_1",
            --"gold_prop_2"
        }
        
        for i = 1, #remove, 1 do 
            DeactivateInteriorEntitySet(vault, remove[i])
        end
        
        for i = 1, #add, 1 do 
            ActivateInteriorEntitySet(vault, add[i])
        end 
    elseif loot == 4 then
        local remove = {
            "money_prop_1",
            "money_prop_2",
            "painting_prop_1",
            "painting_prop_2",
            "painting_prop_cabinet",
            "gold_prop_1",
            "gold_prop_2"
            
        }

        local add = { 
            "diamonds_prop_1",
            "diamonds_prop_2"
        }

        for i = 1, #remove, 1 do 
            DeactivateInteriorEntitySet(vault, remove[i])
        end

        for i = 1, #add, 1 do 
            ActivateInteriorEntitySet(vault, add[i])
        end 
    end
    RefreshInterior(vault)
end 

CreateThread(function()
    RequestIpl("ch_h3_casino_cameras")
    RequestIpl("ch_mph3_add")

    ActivateInteriorEntitySet(vault, "standard_props")
    ActivateInteriorEntitySet(vault, "cabinet_1")
    ActivateInteriorEntitySet(vault, "cabinet_art")
    
    DeactivateInteriorEntitySet(vault, "cabinet_2")

    for i = 1, 12 do 
        ActivateInteriorEntitySet(arcadeGarage, arcadeprops[i])
    end
    
    ActivateInteriorEntitySet(arcade, "interior_exposed_hipster")

    RefreshInterior(vault)
    RefreshInterior(arcadeGarage)
end)
