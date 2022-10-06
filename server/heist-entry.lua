RegisterNetEvent("sv:casinoheist:syncNetIds", function(ids)
    for i = 2, #hPlayer do 
        TriggerClientEvent("cl:casinoheist:setNetIds", hPlayer[i], ids)
    end
end)

RegisterNetEvent("sv:casinoheist:syncStockade", function(id, veh)
    --for i = 1, #hPlayer do 
        src = source
        TriggerClientEvent("cl:casinoheist:syncStockadeNet", -1, id, veh, src)
    --end
end)

RegisterCommand("sv_tunnel", function()
    for i = 1, #hPlayer do 
        TriggerClientEvent("cl:casinoheist:startHeist", hPlayer[i])
    end
end, false)

RegisterCommand("sv_aggr", function()
    for i = 1, #hPlayer do
        TriggerClientEvent("cl:casinoheist:testCut", i)
    end
end, false)