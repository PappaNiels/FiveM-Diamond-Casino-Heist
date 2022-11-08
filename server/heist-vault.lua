RegisterNetEvent("sv:casinoheist:syncLStatus", function(key, time)
    if key < 9 and time <= 1.1 then 
        for i = 1, #hPlayer do 
            TriggerClientEvent("cl:casinoheist:syncLStatus", hPlayer[i], key, time)
        end
    end
end)