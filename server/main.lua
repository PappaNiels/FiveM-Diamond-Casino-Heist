hPlayer = {1, 2}
invitedPlayers = {}
inMarker = {}
heistInProgress = false

RegisterCommand("test_h", function(source, args)
    print(source, args[1], GetPlayerPed(source))
    hPlayer[tonumber(args[1])] = source
    print(hPlayer[1], hPlayer[2])
end, false)

RegisterCommand("invite_casinoheist", function(src, args)
    if src == hPlayer[1] then 
        if args[1] == nil then 
            TriggerClientEvent("cl:casinoheist:infoMessage", src, "You need to add an id in order to invite someone for the Diamond Casino Heist")
        elseif tonumber(args[1]) == src then 
            TriggerClientEvent("cl:casinoheist:infoMessage", src, "You can not invite yourself")
        else
            invitedPlayers[#invitedPlayers + 1] = tonumber(args[1]) 
            TriggerClientEvent("cl:casinoheist:infoMessageExtra", tonumber(args[1]), src)
            TriggerClientEvent("cl:casinoheist:infoMessage", src, "You have sent an invite to %s", tonumber(args[1]))
        end
    else 
        TriggerClientEvent("cl:casinoheist:infoMessage", src, "You are not a heist leader for the Diamond Casino Heist")
    end
end, false)

RegisterCommand("join_casinoheist", function(src)
    if not heistInProgress then 
        if #invitedPlayers ~= 0 then 
            for i = 1, #invitedPlayers do
                if invitedPlayers[i] == src then 
                    hPlayer[#hPlayer + 1] = src 
                    for i = 1, #hPlayer do 
                        TriggerClientEvent("cl:casinoheist:updateHeistPlayers", hPlayer[i], hPlayer)
                        --TriggerClientEvent("cl:casinoheist:syncHeistPlayerScaleform", hPlayer[i])
                    end

                    for i = 1, #hPlayer - 1 do 
                        TriggerClientEvent("cl:casinoheist:infoMessage", i, "%s has joined the crew", src)
                    end

                    TriggerClientEvent("cl:casinoheist:infoMessage", src, "You joined the crew of %s", hPlayer[1])
                    break
                elseif i == #invitedPlayers then
                    TriggerClientEvent("cl:casinoheist:infoMessage", src, "You haven't received an invite for the Diamond Casino Heist...") 
                end
            end
        else 
            TriggerClientEvent("cl:casinoheist:infoMessage", src, "You haven't received an invite for the Diamond Casino Heist...") 
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
    for i = 1, #hPlayer do 
        TriggerClientEvent("cl:casinoheist:startCutscene", hPlayer[i], cutscene)
    end
end)

RegisterNetEvent("sv:casinoheist:playerIsInMarker", function(string)
    inMarker[#inMarker + 1] = source 

    if #inMarker == #hPlayer then
        for i = 1, #hPlayer do 
            TriggerClientEvent(string, hPlayer[i])
        end 
    else 
        TriggerClientEvent("cl:casinoheist:subtitleMsg", source, string, true)
    end
end)

RegisterNetEvent("sv:casinoheist:playerLeftMarker", function() 
    for i = 1, #inMarker do 
        if inMarker[i] == source then 
            inMarker[i] = nil 
        end
    end
end)

RegisterNetEvent("test:sv:casinoheist:openvaultdoors", function()
    TriggerClientEvent("test:cl:casinoheist:openvaultdoors", -1)
    return true
end)

RegisterNetEvent("sv:casinoheist:syncNetIds", function(ids)
    for i = 2, #hPlayer do 
        TriggerClientEvent("cl:casinoheist:setNetIds", hPlayer[i], ids)
    end
end)

RegisterCommand("sv_tunnel", function()
    for i = 1, #hPlayer do 
        TriggerClientEvent("cl:casinoheist:startHeist", hPlayer[i])
    end
end, false)