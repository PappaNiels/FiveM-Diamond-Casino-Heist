local vault = GetInteriorAtCoords(2488.348, -267.3637, -71.64563)

function SetLoot()
    loot = math.random(1, 4)
    print(loot)

    if loot == 1 then 
        local remove = {
            "painting_prop_1",
            "painting_prop_2",
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
            "painting_prop_2"
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

RegisterCommand("setlootd", function()
    
    
    DeactivateInteriorEntitySet(vault, "money_prop_1")
    DeactivateInteriorEntitySet(vault, "money_prop_2")
    DeactivateInteriorEntitySet(vault, "painting_prop_1")
    DeactivateInteriorEntitySet(vault, "painting_prop_2")
    DeactivateInteriorEntitySet(vault, "gold_prop_1")
    DeactivateInteriorEntitySet(vault, "gold_prop_2")
    ActivateInteriorEntitySet(vault, "diamonds_prop_1")
    ActivateInteriorEntitySet(vault, "diamonds_prop_2")
    RefreshInterior(vault)
end, false)
CreateThread(function()
    RequestIpl("ch_h3_casino_cameras")

    --local vault = GetInteriorAtCoords(2488.348, -267.3637, -71.64563)

    --ActivateInteriorEntitySet(vault, )

    --DeactivateInteriorEntitySet(vault,  "test")
    --ActivateInteriorEntitySet(vault, "cabinet")
    ActivateInteriorEntitySet(vault, "standard_props")
    ActivateInteriorEntitySet(vault, "cabinet_1")
    
    DeactivateInteriorEntitySet(vault, "cabinet_2")
    
    --if loot == 1 then 
    --    DeactivateInteriorEntitySet(vault, "money_prop_1")
    --    ActivateInteriorEntitySet(vault, "money_prop_2")
    --    DeactivateInteriorEntitySet(vault, "painting_prop_1")
    --    DeactivateInteriorEntitySet(vault, "painting_prop_2")
    --    DeactivateInteriorEntitySet(vault, "gold_prop_1")
    --    DeactivateInteriorEntitySet(vault, "gold_prop_2")
    --    DeactivateInteriorEntitySet(vault, "diamonds_prop_1")
    --    DeactivateInteriorEntitySet(vault, "diamonds_prop_2")
    --elseif loot == 2 then 
    --    DeactivateInteriorEntitySet(vault, "money_prop_1")
    --    DeactivateInteriorEntitySet(vault, "money_prop_2")
    --    ActivateInteriorEntitySet(vault, "painting_prop_1")
    --    ActivateInteriorEntitySet(vault, "painting_prop_2")
    --    DeactivateInteriorEntitySet(vault, "gold_prop_1")
    --    DeactivateInteriorEntitySet(vault, "gold_prop_2")
    --    DeactivateInteriorEntitySet(vault, "diamonds_prop_1")
    --    DeactivateInteriorEntitySet(vault, "diamonds_prop_2")
    --elseif loot == 3 then
    --    DeactivateInteriorEntitySet(vault, "money_prop_1")
    --    DeactivateInteriorEntitySet(vault, "money_prop_2") 
    --    ActivateInteriorEntitySet(vault, "gold_prop_1")
    --    ActivateInteriorEntitySet(vault, "gold_prop_2")
    --    DeactivateInteriorEntitySet(vault, "painting_prop_1")
    --    DeactivateInteriorEntitySet(vault, "painting_prop_2")
    --    DeactivateInteriorEntitySet(vault, "diamonds_prop_1")
    --    DeactivateInteriorEntitySet(vault, "diamonds_prop_2")
    --elseif loot == 4 then
    --    DeactivateInteriorEntitySet(vault, "money_prop_1")
    --    DeactivateInteriorEntitySet(vault, "money_prop_2")
    --    DeactivateInteriorEntitySet(vault, "painting_prop_1")
    --    DeactivateInteriorEntitySet(vault, "painting_prop_2")
    --    DeactivateInteriorEntitySet(vault, "gold_prop_1")
    --    DeactivateInteriorEntitySet(vault, "gold_prop_2")
    --    ActivateInteriorEntitySet(vault, "diamonds_prop_1")
    --    ActivateInteriorEntitySet(vault, "diamonds_prop_2")
    --    
    --    --print("tick")
    --end
    --print("loop")
    RefreshInterior(vault)
end)