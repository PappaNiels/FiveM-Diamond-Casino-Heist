isInStaff = false

local blipActive = false 
local blipEle
local blipSta
local blipSt = {1, 1}

RegisterCommand("st_blips", function()
    isInStaff = true
    --AddStaffBlips()
end, false)

function AddStaffBlips()
    blipEle = AddBlipForCoord(2520.97, -279.37, -58.72)
    blipSta = AddBlipForCoord(2514.67, -280.43, -58.72)

    blipSt[1] = blipEle 
    blipSt[2] = blipSta
    
    SetBlipSprite(blipSt[1], 63)
    SetBlipSprite(blipSt[2], 743)
    
    for i = 1, #blipSt, 1 do 
        SetBlipColour(blipSt[i], 5)
        SetBlipHighDetail(blipSt[i], true)
    end
    blipActive = true
    --SubtitleMsg("Go to the ~y~basement~s~.", 5000)
end

CreateThread(function()
    while true do
        Wait(0) 
        if isInStaff then 
            SubtitleMsg("Go to the ~y~basement~s~.", 110)
            if not blipActive then 
                AddStaffBlips()
                Wait(100)
            else
                local coords = GetEntityCoords(PlayerPedId())    
                if DoesBlipExist(blipEle) then    
                    if coords.z < -61 then 
                        RemoveBlip(blipEle)
                        --print(blipEle)
                    else 
                        Wait(50)
                    end
                else
                    if coords.z < -67 then 
                        RemoveBlip(blipSta)                       
                    else
                        Wait(50)
                    end
                end
                if #(coords - vector3(2514.21, -281.78, -70.72)) < 1 then 
                    isInStaff = false
                else 
                    Wait(50)
                end
            end 
        else 
            Wait(1000)
        end
    end
end)

