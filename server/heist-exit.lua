RegisterNetEvent("sv:casinoheist:syncMeet", function(meet)
    if not meet then 
        local num = math.random(1, 3)
        for i = 1, #hPlayer do 
            TriggerClientEvent("cl:casinoheist:syncMeet", hPlayer[i], num)
        end
    end

end)

RegisterNetEvent("sv:casinoheist:syncClotingBlips", function(k)
    for i = 1, #hPlayer do 
        TriggerClientEvent("cl:casinoheist:syncClotingBlips", hPlayer[i], k)
    end
end)