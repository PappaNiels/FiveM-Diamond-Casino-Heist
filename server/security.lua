local secondKeycard = false

local playerOne = 0
local playerTwo = 0
local ply = 0
local doors = 0

RegisterNetEvent("sv:casinoheist:security:swipecard")
AddEventHandler("sv:casinoheist:security:swipecard", function(door)
    ply = ply + 1

    if ply == 2 then 
        secondKeycard = true
        playerTwo = source
    else
        StartTimer(source)
        doors = door
    end
end)

function StartTimer(src) 
    Wait(3000)
    CheckSwipe(src)
    ply = 0
end

function CheckSwipe(src)
    if secondKeycard then 
        TriggerClientEvent("cl:casinoheist:security:keycardswipesucceeded", src)
        TriggerClientEvent("cl:casinoheist:security:keycardswipesucceeded", playerTwo)
        Wait(1000)
        OpenMantrapDoors()
        secondKeycard = false
    else 
        TriggerClientEvent("cl:casinoheist:security:keycardswipefailed", src, math.random(0, 2))
        TriggerClientEvent("cl:casinoheist:security:keycardswipefailed", playerTwo, math.random(0, 2))
    end
end

function OpenMantrapDoors()
    TriggerClientEvent("cl:security:openmantrapdoors", -1, doors)
end

RegisterCommand("test_sec_blip", function()
    TriggerClientEvent("test:cl:casinoheist:keycardswipe", -1)
end, false)