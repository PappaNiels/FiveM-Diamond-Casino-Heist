isInSecurity = false

local blipActive = false
local blipsThreeKeypad = false 
local blipOne
local blipTwo 
local blip = {1, 1}

RegisterCommand("sec_blips", function()
    AddSecurityBlips()
end, false)

function AddSecurityBlips()
    for i = 1, #blip, 1 do 
        blip[i] = AddBlipForCoord(lvlFourKeypad[1])    
        SetBlipSprite(blip[i], 733)
        SetBlipColour(blip[i], 2)
        SetBlipHighDetail(blip[i], true)
    end
end

CreateThread(function()
    while true do 
        if isInSecurity then 
            if not blipActive then 
                AddSecurityBlips()
                    Wait(100)
            else
                    
            end
        else 
                Wait(500)
        end
    end
end)
