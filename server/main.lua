hPlayer = {1, 1, 1, 1}

RegisterCommand("test_h", function(source, args)
    print(source, args[1], GetPlayerPed(source))
    hPlayer[tonumber(args[1])] = source
    print(hPlayer[1], hPlayer[2])
end, false)

RegisterNetEvent("sv:casino:setHeistPlayers")
AddEventHandler("sv:casino:setHeistPlayers", function(player, num)
    hPlayer[num] = player
    print(player, num) 
    TriggerClientEvent("cl:casinoheist:updateHeistPlayers", -1, hPlayer[1], hPlayer[2], hPlayer[3], hPlayer[4])
    print(hPlayer[num])
end)

RegisterNetEvent("sv:casinoheist:loadCutscene")
AddEventHandler("sv:casinoheist:loadCutscene", function(cutscene)
    TriggerClientEvent("cl:casinoheist:startCutscene", -1, cutscene)
end)