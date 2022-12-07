RegisterNetEvent("sv:casinoheist:syncLStatus", function(key, time)
    if key < 9 and time <= 1.01 and time >= 0.001 then 
        for i = 1, #hPlayer do 
            TriggerClientEvent("cl:casinoheist:syncLStatus", hPlayer[i], key, time)
        end
    end
end)

RegisterNetEvent("sv:casinoheist:syncDStatus", function(key)
    for i = 1, #hPlayer do 
        TriggerClientEvent("cl:casinoheist:syncDStatus", hPlayer[i], key)
    end
end)

RegisterCommand("sv_vault", function()
    TriggerClientEvent("test:cl:vault", -1)
end, false)