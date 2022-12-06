RegisterNetEvent("sv:casinoheist:vaultExplosion", function()
    for i = 1, #hPlayer do 
        TriggerClientEvent("cl:casinoheist:vaultExplosion", hPlayer[i])
    end
end)

RegisterNetEvent("sv:casinoheist:syncVault", function(key, value)
    if (key == 1 and value <= 2) or (key == 2 and value <= 3) then 
        for i = 1, #hPlayer do 
            TriggerClientEvent("cl:casinoheist:syncVault", hPlayer[i], key)
        end
    end
end)

RegisterCommand("test_vaultExp", function()
    TriggerClientEvent("cl:testt", -1)
end, false)