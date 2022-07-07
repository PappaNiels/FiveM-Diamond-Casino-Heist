hPlayer = {1, 1, 1, 1}
teamlives = 1
take = 0

RegisterCommand("test_h", function(source, args)
    print(source, args[1], GetPlayerPed(source))
    hPlayer[tonumber(args[1])] = source
    print(hPlayer[1], hPlayer[2])
end, false)

RegisterNetEvent("sv:casinoheist:setHeistPlayers", function(player, num)
    hPlayer[num] = source
    --print(player, num) 
    TriggerClientEvent("cl:casinoheist:updateHeistPlayers", -1, hPlayer[1]--[[[1], hPlayer[2], hPlayer[3], hPlayer[4] ]])
    --print(hPlayer[num])
end)

RegisterNetEvent("sv:casinoheist:loadCutscene", function(cutscene)
    TriggerClientEvent("cl:casinoheist:startCutscene", -1, cutscene)
end)

RegisterNetEvent("test:sv:casinoheist:openvaultdoors", function()
    TriggerClientEvent("test:cl:casinoheist:openvaultdoors", -1)
    return true
end)

RegisterNetEvent("sv:casinoheist:addtake", function(add)
    TriggerClientEvent("cl:casinoheist:synctake", -1 , take + add)
end)

RegisterNetEvent("sv:casinoheist:removeteamlive", function()
    TriggerClientEvent("cl:casinoheist:syncteamlives", -1, teamlives - 1)
end)