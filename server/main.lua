hPlayer = {1}
invitedPlayers = {}
heistInProgress = false

RegisterCommand("test_h", function(source, args)
    print(source, args[1], GetPlayerPed(source))
    hPlayer[tonumber(args[1])] = source
    print(hPlayer[1], hPlayer[2])
end, false)

RegisterCommand("invite", function(src, args)
    if args[1] == nil then 
        TriggerClientEvent("cl:casinoheist:infomessage", src, "no id")
    elseif tonumber(args[1]) == src then 
        TriggerClientEvent("cl:casinoheist:infomessage", src, "same")
    else
        invitedPlayers[#invitedPlayers + 1] = tonumber(args[1]) 
        TriggerClientEvent("cl:casinoheist:infomessageextra", tonumber(args[1]), src)
        TriggerClientEvent("cl:casinoheist:infomessage", src, "You have sent an invite to %s", tonumber(args[1]))
    end

    --for i = 1, #invitedPlayers do 
    --    print(invitedPlayers[i])
    --end
    --print(src)
    --print(source)
end, false)

RegisterCommand("join_casinoheist", function(src)
    if not heistInProgress then 
        for i = 1, #invitedPlayers do 
            if invitedPlayers[i] == src then 
                hPlayer[#hPlayer + 1] = src 
                for i = 1, #hPlayer do 
                    TriggerClientEvent("cl:casinoheist:updateHeistPlayers", i, hPlayer)
                end

                for i = 1, #hPlayer - 1 do 
                    TriggerClientEvent("cl:casinoheist:infomessage", i, "%s has joined the crew", src)
                end

                TriggerClientEvent("cl:casinoheist:infomessage", src, "You joined the crew of %s", hPlayer[1])
                break
            elseif invitedPlayers[i] ~= src and i == #invitedPlayers then -- Needs tweaking
                TriggerClientEvent("cl:casinoheist:infomessage", src, "You haven't received an invite for the Diamond Casino Heist...") 
            end
        end
    end
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
