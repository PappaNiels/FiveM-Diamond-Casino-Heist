teamlives = 0
take = 0

RegisterNetEvent("sv:casinoheist:addtake", function()
    take += lootPerItem[loot]
    for i = 1, #hPlayer do 
        TriggerClientEvent("cl:casinoheist:synctake", hPlayer[i] , take)
    end
end)

RegisterNetEvent("sv:casinoheist:removeteamlive", function()
    if teamlives > 0 then 
        teamlives -= 1
        for i = 1, #hPlayer do 
            TriggerClientEvent("cl:casinoheist:syncteamlives", -1, teamlives)
        end
    end
end)