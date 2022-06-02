local secondKeycard = false

local playerOne = 0
local playerTwo = 0
local ply = 0
local doors = 0

local function CheckSwipe(src, door)
    if secondKeycard then 
        TriggerClientEvent("cl:casinoheist:security:keycardswipesucceeded", src)
        TriggerClientEvent("cl:casinoheist:security:keycardswipesucceeded", playerTwo)
        Wait(1000)
        --OpenMantrapDoors(door)
        TriggerEvent("sv:casinoheist:security:openmantrapdoors", door)
        secondKeycard = false
    else 
        TriggerClientEvent("cl:casinoheist:security:keycardswipefailed", src, math.random(0, 2))
        TriggerClientEvent("cl:casinoheist:security:keycardswipefailed", playerTwo, math.random(0, 2))
    end
end

local function StartTimer(src, door) 
    Wait(3000)
    CheckSwipe(src, door)
    ply = 0
end

RegisterNetEvent("sv:casinoheist:security:swipecard")
AddEventHandler("sv:casinoheist:security:swipecard", function(door)
    ply = ply + 1

    if ply == 2 then 
        secondKeycard = true
        playerTwo = source
    else
        if door == 1 or door == 2 then 
            doors = 1
            StartTimer(source, doors)
            --print(door)
        else 
            doors = 3
        end
    end
end)

RegisterNetEvent("sv:casinoheist:security:openmantrapdoors")
AddEventHandler("sv:casinoheist:security:openmantrapdoors", function(door)
    TriggerClientEvent("cl:security:openmantrapdoors", -1, door)
end)

RegisterCommand("test_sec_blip", function()
    TriggerClientEvent("test:cl:casinoheist:keycardswipe", -1)
end, false)