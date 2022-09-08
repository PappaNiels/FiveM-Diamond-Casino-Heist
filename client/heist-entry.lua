--local startCoords = {
--    {vector3(), },
--    {vector3(), },
--    {vector3(), },
--    {vector3(), }
--}

local cargobob = {}

local function FlyToPos()
    TaskHeliMission(cargobob[2], cargobob[1], 0, 0, cargobobFinalCoords, 4, 10.0, 0.0, 300.0, 9, 7, -1.0, 25280)
    
    while #(GetEntityCoords(cargobob[1]) - cargobobFinalCoords) > 500 do 
        Wait(100)
    end
    
    DoScreenFadeOut(800)
    
    while not IsScreenFadedOut() do 
        Wait(500)
    end

    DeleteVehicle(cargobob[1])
    DeleteEntity(cargobob[2])
    RemoveBlip(cargobob[3])

    cargobob[1] = CreateVehicle(GetHashKey("cargobob2"), cargobobFinalCoords, 250.47, true, false)
    SetVehicleColours(cargobob[1], 0, 0)
    
    cargobob[2] = CreatePed(0, GetHashKey("s_m_y_pilot_01"), cargobobFinalCoords, 0, false, false)
    SetPedIntoVehicle(cargobob[2], cargobob[1], -1)
    SetVehicleEngineOn(cargobob[1], true, true, true)
    
    SetModelAsNoLongerNeeded("cargobob2")
    SetModelAsNoLongerNeeded("s_m_y_pilot_01")

    SetVehicleDoorOpen(cargobob[1], 2, false, true)

    FreezeEntityPosition(cargobob[1], true)
    
    Wait(5000)


    SetEntityCoords(PlayerPedId(), 1305.6, -70.52, 298.0, true, false, false, false)
    SetEntityHeading(PlayerPedId(), 69.19)
    
    DoScreenFadeIn(1000)
    FreezeEntityPosition(cargobob[1], false)
end

local function IsAllPlayersInHeli()
    local bool = true
    while bool do 
        DisableControlAction(0, 23, true)
        
        if IsPedInAnyHeli(GetPlayerPed(GetPlayerFromServerId(hPlayer[1]))) and IsPedInAnyHeli(GetPlayerPed(GetPlayerFromServerId(hPlayer[2]))) and IsPedInAnyHeli(GetPlayerPed(GetPlayerFromServerId(hPlayer[3]))) and IsPedInAnyHeli(GetPlayerPed(GetPlayerFromServerId(hPlayer[4]))) then 
            FlyToPos()
            bool = false 
        end
    end 
end

local function SetupCargobob()
    LoadModel("cargobob2")
    LoadModel("s_m_y_pilot_01")
    
    print(hPlayer[2])

    cargobob[1] = CreateVehicle(GetHashKey("cargobob2"), cargobobCoords, 328.34, true, false)
    SetVehicleColours(cargobob[1], 0, 0)
    
    --SetCarBootOpen(cargobob[1])
    --SetVehicleEngineOn(cargob, true, true, false)

    cargobob[2] = CreatePed(0, GetHashKey("s_m_y_pilot_01"), cargobobCoords, 0, false, false)
    SetEntityForAll(cargobob[2])
    SetPedIntoVehicle(cargobob[2], cargobob[1], -1)
    SetEntityInvincible(cargobob[2], true)
    SetPedRelationshipGroupHash(cargobob[2], GetHashKey("PLAYER"))

    cargobob[3] = AddBlipForEntity(cargobob[1])
    SetBlipSprite(cargobob[3], 422)
    SetBlipColour(cargobob[3], 54)
    SetBlipHighDetail(cargobob[3], true)

    --SetModelAsNoLongerNeeded("cargobob2")
    --SetModelAsNoLongerNeeded("s_m_y_pilot_01")

    while not IsPedInAnyHeli(PlayerPedId()) do 
        Wait(0)
        --print("tick")
        if #(vector3(1060.1, -288.31, 50.81) - GetEntityCoords(PlayerPedId())) < 4 and IsControlJustPressed(0, 23) then 
            for i = 0, 4 do 
                if IsVehicleSeatFree(cargobob[1], i) then 
                    TaskEnterVehicle(PlayerPedId(), cargobob[1], 1.0, i, 2.0, 0, 0)
                    break
                end
            end
        end
    end

    Wait(3000)
    
    FlyToPos()
end


function StartHeist()
    local player = GetCurrentHeistPlayer()
    
    SetPedRelationshipGroupHash(PlayerPedId(), GetHashKey("PLAYER"))
    AddRelationshipGroup("GUARDS")
    SetRelationshipBetweenGroups(0, GetHashKey("GUARDS"), GetHashKey("GUARDS"))
    SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("GUARDS"))
    SetRelationshipBetweenGroups(5, GetHashKey("GUARDS"), GetHashKey("PLAYER"))

    SetPedComponents(1)

    FadeTeleport(startCoords[player][1].x, startCoords[player][1].y, startCoords[player][1].z, startCoords[player][2])

    
end

RegisterCommand("test_vehicle", function()
    --LoadModel("adder")
--
    --veh = CreateVehicle(GetHashKey("adder"), GetEntityCoords(PlayerPedId()), 0, true, false)
--
    --SetPedIntoVehicle(PlayerPedId(), veh, -1)
    --SetVehicleColours(veh, 7, 7)
    SetupCargobob()
    --FlyToPos()
end, false)

RegisterCommand("test_marker", function()
    CreateThread(function()
        while true do 
            Wait(0)
            for i = 1, #entryCoords do 
                DrawMarker(1, entryCoords[i], 0, 0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.75, 58, 230, 242, 160, false, false, 2, false)
            end
        end
    end)
end, false)