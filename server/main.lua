hPlayer = {1}
heistInProgress = false

local approach = 0
local loot = 0

local selectedGunman = 0         
local selectedLoadout = 0         
local selectedDriver = 0          
local selectedVehicle = 0         
local selectedHacker = 0          
local selectedKeycard = 0
local selectedEntrance = 1        
local selectedExit = 0            
local selectedBuyer = 0          
local selectedEntryDisguise = 1      
local selectedExitDisguise = 1 

local boughtCleanVehicle = false
local boughtDecoy = false

local vaultLayout = 0
local cartLayout = 0

local cuts = {}
local invitedPlayers = {}

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

RegisterNetEvent("sv:casinoheist:setHeistLeader", function(bool)
    if not hPlayer[1] and bool then 
        hPlayer[1] = source
        --print(source)
    elseif not bool then
        hPlayer = {}
    else 
        TriggerClientEvent("cl:casinoheist:infoMessage", source, "Someone else is already the heist leader.")
    end
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

RegisterNetEvent("sv:casinoheist:alarm", function()
    for i = 1, #hPlayer do 
        TriggerClientEvent("cl:casinoheist:alarm", hPlayer[i])
    end
end)

RegisterNetEvent("sv:casinoheist:startHeist", function(obj)
    --if GetInvokingResource() ~= "Diamond-Casino-Heist" then return end 
    if heistInProgress then return end


    if not heistInProgress then
        invitedPlayers = {} 
        heistInProgress = true
        hPlayer = obj[1]
        approach = obj[2]
        loot = obj[3]
        cuts = obj[4]
        selectedGunman = obj[5]
        selectedLoadout = obj[6]         
        selectedDriver = obj[7]          
        selectedVehicle = obj[8]         
        selectedHacker = obj[9]          
        selectedKeycard = obj[10]
        selectedEntrance = obj[11]        
        selectedExit = obj[12]            
        selectedBuyer = obj[13]          
        selectedEntryDisguise = obj[14]      
        selectedExitDisguise = obj[15] 

        boughtCleanVehicle = obj[16]
        boughtDecoy = obj[17]

        vaultLayout = obj[18]
        cartLayout = obj[19]

        for i = 2, #hPlayer do 
            TriggerClientEvent("cl:casinoheist:startHeist", hPlayer[i], obj)
        end 
    end
end)

--print(" _______  __   __  _______    ______   ___   _______  __   __  _______  __    _  ______     _______  _______  _______  ___   __    _  _______    __   __  _______  ___   _______  _______ \n|       ||  | |  ||       |  |      | |   | |   _   ||  |_|  ||       ||  |  | ||      |   |     __||   _   ||       ||   | |  |  | ||       |  |  | |  ||       ||   | |       ||       |\n|_     _||  |_|  ||    ___|  |  __   ||   | |  |_|  ||       ||   _   ||   |_| ||  __   |  |    |   |  |_|  ||  _____||   | |   |_| ||   _   |  |  |_|  ||    ___||   | |  _____||_     _|\n  |   |  |       ||   |___   | |  |  ||   | |       ||       ||  | |  ||       || |  |  |  |    |   |       || |_____ |   | |       ||  | |  |  |       ||   |___ |   | | |_____   |   |  \n  |   |  |   _   ||    ___|  | |__|  ||   | |   _   || || || ||  |_|  ||  _    || |__|  |  |    |   |   _   ||_____  ||   | |  _    ||  |_|  |  |   _   ||    ___||   | |_____  |  |   |  \n  |   |  |  | |  ||   |___   |       ||   | |  | |  || ||_|| ||       || | |   ||       |  |    |__ |  | |  | _____| ||   | | | |   ||       |  |  | |  ||   |___ |   |  _____| |  |   |  \n  |___|  |__| |__||_______|  |______| |___| |__| |__||_|   |_||_______||_|  |__||______|   |_______||__| |__||_______||___| |_|  |__||_______|  |__| |__||_______||___| |_______|  |___|  ")