local isCardSwiped = false 
local canOpen = false
local secondKeycard = false

local pos = 0

_source = {}

RegisterNetEvent("sv:casinoheist:security:swipecard")
AddEventHandler("sv:casinoheist:security:swipecard", function()
    --sources[posE] = _source
    print(pos)
    if pos == 3 then 
        secondKeycard = true
        --_source[1] = source
        --return
    else
        StartTimer(source)
        --pos = 3
        
        print("AAAAAA")
        --_source[2] = source
    end
    --CheckSwipe()
    
end)

function StartTimer(src)
    --canOpen = true 
    Wait(3000)
    --canOpen = false 
    CheckSwipe(src)
    --pos = 0
end

function CheckSwipe(src)
    if secondKeycard then 
        print("callback " .. tostring(secondKeycard))
        TriggerClientEvent("cl:casinoheist:security:keycardswipesucceeded", src)
        pos = 0
        secondKeycard = false
        --TriggerClientEvent("cl:casinoheist:keycardswipesucceeded", sources[2])
        --callback(true, 0)
    else 
        --local num = 
        print("callback " .. tostring(secondKeycard), src)
        TriggerClientEvent("cl:casinoheist:security:keycardswipefailed", src, math.random(0, 2))
        print(pos)
        pos = 0
        --TriggerClientEvent("cl:casinoheist:keycardswipefailed", sources[2], math.random(0, 2))
        --callback("false")
    end
end

function OpenMantrapDoors(num)
    TriggerClientEvent("cl:security:openmantrapdoors", -1, num)
end

RegisterCommand("test_callback", function()
    TriggerEvent("sv:security:swipecard", 1, function(bool)
        if bool then print("succes") end
    end)
end, false)

RegisterCommand("test_sec_blip", function()
    TriggerClientEvent("test:cl:casinoheist:keycardswipe", -1)
end, false)