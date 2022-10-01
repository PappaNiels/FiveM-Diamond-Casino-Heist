RegisterNetEvent("sv:casinoheist:vaultExplosion", function()
    for i = 1, #hPlayer do 
        TriggerClientEvent("cl:casinoheist:vaultExplosion", hPlayer[i])
    end
end)