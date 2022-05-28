isCardSwiped = false 
canOpen = false
secondKeycard = false

pos = 0

callback = {}

RegisterNetEvent("sv:security:swipecard")
AddEventHandler("sv:security:swipecard", function(posE, func)
    callback = func
    --isCardSwiped = true
    --Wait(3000) 
    print("kaas")
    --if pos == 0 then 
    --    StartTimer()
    --    pos = posE
    --    --return
    --else 
    --    secondKeycard = true
    --end
    CheckSwipe()
    
end)

function StartTimer()
    canOpen = true 
    Wait(1000)
    canOpen = false 
    CheckSwipe()
end

function CheckSwipe()
    if canOpen then 
        callback(true, 0)
        print("callback")
    else 
        callback(false, 0)
        print("callback")
    end
end

function OpenMantrapDoors(num)
    TriggerClientEvent("sv:security:openmantrapdoors", -1, num)
end

RegisterCommand("test_callback", function()
    TriggerEvent("sv:security:swipecard", 1, function(bool)
        if bool then print("succes") end
    end)
end, false)

RegisterCommand("test_sec_blip", function()
    TriggerClientEvent("test:cl:casinoheist:keycardswipe", -1)
end, false)