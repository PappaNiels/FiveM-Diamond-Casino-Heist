aggHeist = false
isInCasino = false

local showBlip = false

local blipCoords = vector3(2525.77, -251.71, -60.31)

local blip

RegisterCommand("aggr", function()
    SetEntityCoords(PlayerPedId(), 923.76, 47.2, 81.11)
    aggHeist = true
end, false)


RegisterCommand("wat", function()
    
    
end, false)

CreateThread(function()
    while true do 
        Wait(2)
        if aggHeist then 
            local distance = #(GetEntityCoords(PlayerPedId()) - vector3(923.76, 47.2, 81.11))
            if distance < 10 then 
                DrawMarker(1, 923.76, 47.2, 80.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 1.0, 30, 30, 30, 100, false, false, 2, false, nil, nil, false)
                if distance < 1.8 then 
                    HelpMsg("Press ~INPUT_CONTEXT~ to enter the Casino", 110)
                    if IsControlJustPressed(0, 38) then
                        AggrHeistEntry()
                        aggHeist = false
                    end
                end
            else 
                Wait(100)
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
    isInCasino = true
end

local function AddCasinoBlip()
    showBlip = true
    blip = AddBlipForCoord(blipCoords)
    SetBlipSprite(blip, 1)
    SetBlipColour(blip, 5)
    SetBlipHighDetail(blip, true)
end

CreateThread(function()
    while true do
        Wait(0) 
        if isInCasino then
            if not showBlip then 
                AddCasinoBlip()
                Wait(100)
            else 
                SubtitleMsg("Go to the ~y~staff lobby~s~.", 120)
                local distance = #(GetEntityCoords(PlayerPedId()) - blipCoords)
                if distance < 10 then 
                    DrawMarker(1, 2525.77, -251.71, -61.31, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 1.0, 30, 30, 30, 100, false, false, 2, false, nil, nil, false)
                    if distance < 2 then 
                        if IsControlJustPressed(0, 38) then 
                            RemoveBlip(blip)
                            FadeTeleport(2525.3, -256.46, -60.32, 181.9425)
                            isInCasino = false
                            isInStaff = true
                        end
                    else 
                        Wait(10)
                    end
                else 
                    Wait(100)
                end
            end
        else 
            Wait(1000)
        end 
    end
end)

--local x = 1

--CreateThread(function()
--    while true do 
--        Wait(0)
--        if showBlip then
--            SubtitleMsg("Go to the ~y~staff lobby~s~.", 60)
--            local 
--            if distance < 2 then     
--                if blipCoords[x + 1] == nil then 
--                    RemoveBlip(blip)
--                    showBlip = false 
--                    print("end") 
--                else
--                    x = x + 1
--                    SetBlipCoords(blip, blipCoords[x])                    
--                end
--            else 
--                Wait(50)              
--            end
--        else 
--            Wait(1000)
--        end
--    end
--end)
