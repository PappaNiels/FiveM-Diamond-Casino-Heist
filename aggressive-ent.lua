local aggHeist = false
CreateThread(function()
    while true do 
        Wait(2)
        if aggHeist then 
            local distance = #(GetEntityCoords(PlayerPedId()) - vector3(923.76, 47.2, 81.11))
            if distance < 10 then 
                DrawMarker(1, 923.76, 47.2, 80.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 1.0, 30, 30, 30, 100, false, false, 2, false, nil, nil, false)
                if distance < 1.8 then 
                    HelpMsg("Press ~INPUT_CONTEXT~ to enter the Casino")
                    if IsControlJustPressed(0, 38) then
                        AggrHeistEntry()
                        aggHeist = false
                    end
                end
            end
        else    
            Wait(1000)
        end
    end
end)

function AggrHeistEntry()
    FadeTeleport(2466.15, -281.06, -58.47)
    LoadCutscene("hs3f_dir_ent")
    StartCutscene(0)
    Wait(22433)
    DeletePeds()
    ExecuteCommand("wat")
end

RegisterCommand("aggr", function()
    SetEntityCoords(PlayerPedId(), 923.76, 47.2, 81.11)
    aggHeist = true
end, false)

local blipCoords = {
    vector3(2502.42, -229.31, -60.31),
    vector3(2498.65, -229.18, -55.12)
}

local showBlip = false
local blip
RegisterCommand("wat", function()
    
    showBlip = true
    blip = AddBlipForCoord(blipCoords[1])
    SetBlipSprite(blip, 1)
    SetBlipColour(blip, 5)
    SetBlipHighDetail(blip, true)
end, false)

local x = 1

CreateThread(function()
    while true do 
        Wait(0)
        if showBlip then
            SubtitleMsg("Go to the ~y~Management Office~s~", 60)
            local distance = #(GetEntityCoords(PlayerPedId()) - blipCoords[x])
            if distance < 2 then     
                if blipCoords[x + 1] == nil then 
                    RemoveBlip(blip)
                    showBlip = false 
                    print("end") 
                else
                    x = x + 1
                    SetBlipCoords(blip, blipCoords[x])                    
                end
            else 
                Wait(50)              
            end
        else 
            Wait(1000)
        end
    end
end)
