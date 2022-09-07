--local startCoords = {
--    {vector3(), },
--    {vector3(), },
--    {vector3(), },
--    {vector3(), }
--}

local cargobob = {}

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

    cargobob[1] = CreateVehicle(GetHashKey("cargobob2"), cargobobCoords, 328.34, true, false)
    SetVehicleColours(cargobob[1], 0, 0)
    
    --SetCarBootOpen(cargobob[1])
    --SetVehicleEngineOn(cargob, true, true, false)

    cargobob[2] = CreatePed(0, GetHashKey("s_m_y_pilot_01"), GetEntityCoords(cargobob[1]), 0, false, false)
    SetEntityForAll(cargobob[2])
    SetPedIntoVehicle(cargobob[2], cargobob[1], -1)
    SetEntityInvincible(cargobob[2], true)
    SetPedRelationshipGroupHash(cargobob[2], GetHashKey("PLAYER"))

    cargobob[3] = AddBlipForEntity(cargobob[1])
    SetBlipSprite(cargobob[3], 422)
    SetBlipColour(cargobob[3], 54)
    SetBlipHighDetail(cargobob[3], true)

    SetVehicleDoorOpen(cargobob[1], 2, false, true)
    
    Wait(3000)

--
    --TaskHeliMission(cargobob[2], cargobob[1], 0, 0, cargobobFinalCoords, 4, 5.0, 0.0, 300.0, 9, 7, -1.0, 25280)
--
    --while #(GetEntityCoords(cargobob[1]) - cargobobFinalCoords) > 5 do 
    --    Wait(100)
    --end
--
    --SetEntityCoords(cargobob[1], cargobobFinalCoords, true, false, false, false)
    --SetEntityHeading(cargobob[1], 278.47)
    --FreezeEntityPosition(cargobob[1], true)
    SetVehicleDoorOpen(cargobob[1], 3, false, true)

    --TASK_HELI_MISSION(iVar1, iVar0, 0, 0, ENTITY::GET_ENTITY_COORDS(iVar0, true) + ENTITY::GET_ENTITY_FORWARD_VECTOR(iVar0) * Vector(150f, 150f, 150f) + Vector(10f, 0f, 0f), 4, 5f, 0f, ENTITY::GET_ENTITY_HEADING(iVar0), 9, 7, -1f, 25280);
    --while not IsPedInAnyHeli(PlayerPedId()) do 
    --    if #(cargobobCoords - GetEntityCoords(PlayerPedId())) < 5 and IsControlJustPressed(0, 23) then 
    --        for i = 0, 4 do 
    --            if IsVehicleSeatFree(cargobob[1], i) then 
    --                TaskEnterVehicle(PlayerPedId(), cargobob[1], 1.0, i, 2.0, 0, 0)
    --                break
    --            end
    --        end
    --    end
    --end

    --IsAllPlayersInHeli()
    --TaskEnterVehicle(PlayerPedId(), cargobob[1], 1.0, 1, 2.0, 0, 0)
    --print(GetVehicleDoorsLockedForPlayer(cargobob[1]))
end

local function FlyToPos()
    
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
end, false)