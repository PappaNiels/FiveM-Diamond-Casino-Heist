local initRoutes = false
local currentRoom = 0
local tick = 0

local seen = {0, 0, 0, 0, 0}
local netIds = {{}, {}}

local guards = {
    {   -- Staff Lobby
        {
            "s_m_y_westsec_02",
            {
                vector4(2504.27, -275.15, -58.72, 265.97),
                vector4(2521.94, -275.69, -58.72, 274.35),
                vector4(2509.05, -283.30, -58.72, 88.79)
            },
            nil, 
            0
        },
        {
            "s_m_y_westsec_02",
            {
                vector4(2532.07, -268.82, -58.72, 266.67),
                vector4(2541.72, -279.02, -58.72, 173.05),
                vector4(2541.51, -290.50, -58.72, 90.0),
                vector4(2504.21, -291.23, -58.72, 270.0),
                vector4(2541.51, -290.50, -58.72, 90.0),
                vector4(2541.72, -279.02, -58.72, 173.05)
            },
            nil, 
            0
        },
        {
            "s_m_m_highsec_03",
            {
                vector4(2530.33, -279.09, -58.72, 92.07)
            }
        },
        {
            "s_m_m_highsec_03",
            {
                vector4(2538.1, -278.06, -58.72, 267.94)
            }
        },
        {
            "s_m_y_westsec_02",
            {
                vector4(2524.25, -270.12, -58.72, 20.99)
            }
        },
        {
            "s_m_y_westsec_02",
            {
                vector4(2523.76, -269.03, -58.72, 208.04)
            }
        },
        {
            "s_m_y_westsec_02",
            {
                vector4(2532.96, -286.37, -58.72, 157.57)
            }
        },
        {
            "s_m_y_westsec_02",
            {
                vector4(2532.41, -287.82, -58.72, 328.35)
            }
        },

        
    },
    {   -- Security Lobby 
        {  
            "s_m_m_highsec_03", -- Suit
            {
                vector4(2487.84, -275.14, -70.69, 240.0),
                vector4(2480.99, -273.13, -70.69, 0.0)
            },
            "WORLD_HUMAN_GUARD_STAND",
            nil 
        },
        {
            "s_m_m_highsec_03", -- Suit
            {
                vector4(2467.97, -267.99, -70.69, 0.0),
                vector4(2472.53, -270.24, -70.69, 0.0)
            },
            nil,
            nil
        },
        {
            "s_m_y_westsec_02", -- Work
            {
                vector4(2477.85, -270.57, -70.69, 0.0),
                vector4(2524.24, -281.16, -70.69, 0.0),
                vector4(2477.79, -279.78, -70.69, 0.0)
            },
            nil,
            0
        },
        {
            "s_m_y_westsec_02", -- Work
            {
                vector4(2491.72, -276.4, -70.69, 0.0),
                vector4(2524.24, -281.16, -70.69, 0.0),
                vector4(2477.79, -279.78, -70.69, 0.0)
            },
            nil,
            0
        },
        {
            "s_m_y_westsec_02", -- Work
            {
                vector4(2491.9, -262.01, -70.69, 145.0)
            },

        }
    }

    --"s_m_m_highsec_03",
    --"s_m_y_westsec_02"
}

local spawnCoords = {
    {
        vector4(2526.38, -261.33, -58.72, 180.0),
        vector4(2543.86, -266.57, 58.72, 130.0), 
        vector4(2530.79, -301.04, -58.72, 353.32),
        vector4(2516.34, -300.83, -58.72, 302.85),
        vector4(2502.25, -270.98, -58.72, 280.99),
        vector4(2526.55, -283.29, -58.72, 356.11)
    },
    {
        vector4(2534.01, -276.96, -70.69, 82.03),
        vector4(2534.01, -281.0, -70.69, 82.03),
        vector4(2486.44, -286.64, -70.69, 270.0),
        vector4(2479.62, -266.24, -70.67, 270.0),
        vector4(2487.74, -259.04, -70.69, 270.0),
        vector4(2467.45, -267.83, -70.69, 240.0)
    },
    {
        vector4(2486.86, -257.22, -59.11, 196.25),
        vector4(2495.12, -257.16, -59.11, 147.89),
        vector4(2511.09, -251.79, -59.31, 218.75),
        vector4(2503.75, -244.5, -59.31, 46.31),
        vector4(2485.1, -231.08, -60.11, 177.77),
        vector4(2472.41, -241.92, -60.11, 254.58),
        vector4(2510.78, -215.5, -60.31, 178.72),
        vector4(2537.91, -244.37, -60.91, 94.76),
        vector4(2510.23, -234.14, -60.32, 340.57),
        vector4(2513.71, -241.36, -60.32, 152.31),
    }
}

--local blips = {{}, {}}
local activeGuards = {{}, {}}
local aggrGuards2 = {}

local function IsUsingSuppressor(ped)
    if approach == 2 then 
        return false
    end 

    if GetCurrentPedWeapon(ped, GetHashKey(weaponLoadout[approach][selectedGunman][selectedLoadout][1][1]), 1) and HasPedGotWeaponComponent(ped, GetHashKey(weaponLoadout[approach][selectedGunman][selectedLoadout][1][1]), GetHashKey(weaponLoadout[approach][selectedGunman][selectedLoadout][1][2])) then 
        return true 
    end
    return false
end

local function IsAnyPedLookingAtCoord(coord)
    for i = 1, #hPlayer do 
        if IsPedHeadingTowardsPosition(GetHeistPlayerPed(hPlayer[i]), coord, 1.0) then 
            return true
        end
    end
    return false
end

local function HasAnyPedShot()
    for i = 1, #hPlayer do 
        if IsPedShooting(GetHeistPlayerPed(hPlayer[i])) and not IsUsingSuppressor(GetHeistPlayerPed(hPlayer[i])) then 
            return true 
        end
    end

    for i = 1, 2 do 
        for j = 1, #guards[i] do 
            if IsPedShooting(activeGuards[i][j]) then
                return true 
            end
        end
    end 

    return false
end

local function SpawnPed()
    LoadModel(guards[2][1][1])
    LoadModel(guards[2][3][1])
    
    for i = 1, 2 do 
        for j = 1, #guards[i] do
            activeGuards[i][j] = CreatePed(1, GetHashKey(guards[i][j][1]), guards[i][j][2][1], true, false)

            SetPedRelationshipGroupHash(activeGuards[i][j], GetHashKey("GUARDS"))

            SetPedAlertness(activeGuards[i][j], 0)
            SetPedHearingRange(activeGuards[i][j], 30.0)

            SetPedAccuracy(activeGuards[i][j], 70.0) -- Lookup
            GiveWeaponToPed(activeGuards[i][j], GetHashKey("weapon_combatpistol"), 2000, false, false)
            SetPedDropsWeaponsWhenDead(activeGuards[i][j], false)
            SetPedCombatMovement(activeGuards[i][j], 3)
            SetPedCombatRange(activeGuards[i][j], 0)

            SetPedSeeingRange(activeGuards[i][j], 20.0)
            --blips[i][j] = AddBlipForEntity(activeGuards[i][j])
            --SetBlipScale(blips[i][j], 0.75)
            --SetBlipSprite(blips[i][j], 270)
            --SetBlipColour(blips[i][j], 1)
            --SetBlipPriority(blips[i][j], 7)

            SetPedHasAiBlip(activeGuards[i][j], true)
            SetPedAiBlipGangId(activeGuards[i][j], 0--[[GetCamBlipColour()]])
            SetPedAiBlipNoticeRange(activeGuards[i][j], 100.0)
            SetPedAiBlipSprite(activeGuards[i][j], 270)
            SetPedAiBlipForcedOn(activeGuards[i][j], true)
            SetPedAiBlipHasCone(activeGuards[i][j], true)

            -- Cone
            
            -- Blip Name
            --BeginTextCommandSetBlipName("STRING")
            --AddTextComponentSubstringPlayerName("Guard")
            --EndTextCommandSetBlipName(blips[i][j])
        end
    end 

    SetModelAsNoLongerNeeded(guards[2][1][1])
    SetModelAsNoLongerNeeded(guards[2][3][1])

    Wait(1000)

    --for i = 1, 2 do 
    --    for j = 1, #guards[i] do 
    --        SetPedHasAiBlipWithColor(activeGuards[i][j], true, 0)
    --    end
    --end
    --SetPedAiBlipGangId(activeGuards[1][1], 3)

    local tick2 = 0
    for i = 1, 2 do 
        for j = 1, #guards[i] do
            if #guards[i][j][2] > 1 then
                TaskPatrol(activeGuards[i][j], "MISS_PATROL_" .. tick2, 1, false, true)
                tick2 += 1
            end
        end
    end

    --SetGuardVision(1)
end

local function SetAiBlip(ped, cone)
    print(DoesEntityExist(ped))

    SetPedHasAiBlip(ped, true)
    SetPedAiBlipGangId(ped, 0--[[GetCamBlipColour()]])
    SetPedAiBlipNoticeRange(ped, 100.0)
    SetPedAiBlipSprite(ped, 270)
    SetPedAiBlipForcedOn(ped, true)
    SetPedAiBlipHasCone(ped, cone)

    print(DoesPedHaveAiBlip(ped))
end

local function SetAggrPed(ped)
    SetPedRelationshipGroupHash(ped, GetHashKey("GUARDS"))

    SetPedAlertness(ped, 3)
    SetPedHearingRange(ped, 30.0)
    
    SetPedAccuracy(ped, 70.0) -- Lookup
    GiveWeaponToPed(ped, GetHashKey("weapon_combatpistol"), 2000, false, false)
    SetPedDropsWeaponsWhenDead(ped, false)
    SetPedCombatMovement(ped, 3)
    SetPedCombatRange(ped, 2)
    SetPedAsEnemy(ped, true)
    
    
    TaskCombatPed(ped, PlayerPedId(), 0, 16)
    TaskCombatPed(ped, GetHeistPlayerPed(2), 0, 16)
end

local function SpawnAggrPed(room, loc)
    local aggrGuards = CreatePed(0, GetHashKey(guards[1][math.random(1, 2)][1]), spawnCoords[room][loc], true, false)
    SetAggrPed(aggrGuards)

    NetworkRegisterEntityAsNetworked(aggrGuards)
        
    local aggrNetIds = PedToNet(aggrGuards)
    SetNetworkIdExistsOnAllMachines(aggrNetIds, true)
    SetNetworkIdCanMigrate(aggrNetIds, true)

    TriggerServerEvent("sv:casinoheist:guardBlips", aggrNetIds)
    --SetAiBlip(aggrGuards[i])
end

local function InitAggrPeds(room)
    local aggrNetIds = {} 
    for i = 1, #spawnCoords[room] do 
        local aggrGuards = CreatePed(0, GetHashKey(guards[1][math.random(1, 2)][1]), spawnCoords[room][i], true, false)
        SetAggrPed(aggrGuards)
        --SetAiBlip(aggrGuards[i])

        NetworkRegisterEntityAsNetworked(aggrGuards)

        aggrNetIds[i] = PedToNet(aggrGuards)

        SetNetworkIdExistsOnAllMachines(aggrNetIds[i], true)
        SetNetworkIdCanMigrate(aggrNetIds[i], true)

        repeat Wait(0) print("tick") until NetworkDoesEntityExistWithNetworkId(aggrNetIds[i])
    end

    TriggerServerEvent("sv:casinoheist:initGuardBlips", aggrNetIds)
end

function SetGuardVision(room)
    if not DoesEntityExist(activeGuards[1][1]) then 
        InitRoutes()
    end

    if room == 1 then 
        for i = 1, #guards[1] do 
            SetPedAiBlipForcedOn(activeGuards[1][i], true)
        end
        for i = 1, #guards[2] do 
            SetPedAiBlipForcedOn(activeGuards[2][i], false)
        end
    elseif room == 2 then 
        for i = 1, #guards[1] do 
            SetPedAiBlipForcedOn(activeGuards[1][i], false)
        end
        for i = 1, #guards[2] do 
            SetPedAiBlipForcedOn(activeGuards[2][i], true)
        end
    else
        for i = 1, 2 do 
            for j = 1, #guards[i] do 
                SetPedAiBlipForcedOn(activeGuards[i][j], false)
            end
        end
    end

    currentRoom = room
    for i = 1, #activeGuards[room] do 
        CreateThread(function()
            while currentRoom == room and not IsPedDeadOrDying(activeGuards[room][i]) and alarmTriggered == 0 do 
                Wait(100)

                if HasAnyPedShot() then 
                    Wait(1000)
                    TriggerServerEvent("sv:casinoheist:alarm")
                end

                --print(GetCamBlipColour() == 1, IsPedFacingPed(activeGuards[room][i], PlayerPedId(), 60.0),HasEntityClearLosToEntity(activeGuards[room][i], PlayerPedId(), 17), #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(activeGuards[room][i])) < 8)

                if GetCamBlipColour() == 1 and IsPedFacingPed(activeGuards[room][i], PlayerPedId(), 60.0) and HasEntityClearLosToEntity(activeGuards[room][i], PlayerPedId(), 17) and #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(activeGuards[room][i])) < 8 then 
                    print("seen", i, seen[i], currentRoom == room, not IsPedDeadOrDying(activeGuards[room][i]), alarmTriggered == 0)
                    --print(GetBlipColour(blips[room][i]))

                    seen[i] += 1

                    if seen[i] > 6 then 
                        TriggerServerEvent("sv:casinoheist:alarm")
                        --SetGuardAgg()
                    end
                elseif seen[i] ~= 0 then 
                    seen[i] = 0
                end

            end
            print("end")
        end)
    end
end

function InitRoutes()
    if initRoutes or player ~= 1 then return end
    
    initRoutes = true

    for i = 1, 2 do 
        for j = 1, #guards[i] do 
            if #guards[i][j][2] > 1 then 
                OpenPatrolRoute("MISS_PATROL_" .. tick)
                for k = 1, #guards[i][j][2] do 
                    AddPatrolRouteNode(k, guards[i][j][3], guards[i][j][2][k].xyz, guards[i][j][2][k].xyz, guards[i][j][4] or math.random(3000, 5000))
                    print(k, j)
                end

                for k = 1, #guards[i][j][2] - 1 do
                    AddPatrolRouteLink(k, k + 1)
                end

                AddPatrolRouteLink(#guards[i][j][2], 1)
                ClosePatrolRoute()
                CreatePatrolRoute()

                tick += 1 
            end
        end
    end

    SpawnPed()
end

function DeletePaths()
    for i = 1, tick do
        DeletePatrolRoute("MISS_PATROL_" .. i)
    end
    
    initRoutes = false
end

function StopGuards()
    currentRoom = 0

    for i = 1, 2 do 
        for j = 1, #guards[i] do 
            SetPedAiBlipForcedOn(activeGuards[i][j], false)
        end
    end
end

function SetGuardColour(colour)
    for i = 1, 2 do 
        for j = 1, #guards[i] do 
            --SetPedAiBlipGangId(activeGuards[i][j], colour)
        end
    end
end

function RemoveGuards()
    for i = 1, 2 do 
        for j = 1, #guards[i] do 
            DeletePed(activeGuards[i][j])
        end
    end
end

function SetGuardAgg()
    SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("GUARDS"))
    SetRelationshipBetweenGroups(5, GetHashKey("GUARDS"), GetHashKey("PLAYER"))

    for i = 1, 2 do 
        for j = 1, #activeGuards[i] do 
            SetPedRelationshipGroupHash(activeGuards[i][j], GetHashKey("GUARDS"))
            SetPedCombatRange(activeGuards[i][j], 2)
            SetPedAiBlipHasCone(activeGuards[i][j], false)
            SetPedAsEnemy(activeGuards[i][j], true)
            SetPedSeeingRange(activeGuards[i][j], 100.0)
            --for i = 1, #hPlayer do 
            --    TaskCombatPed(activeGuards[i][j], GetHeistPlayer, 0, 16)
            --end
        end
    end
end

function StartGuardSpawn(room)
    if not HasModelLoaded(guards[2][1][1]) then 
        LoadModel(guards[2][1][1])
        LoadModel(guards[2][3][1]) 
    end
    
    local num = 0
    local sleep = 100

    currentRoom = room

    InitAggrPeds(room)

    CreateThread(function()
        while currentRoom == room do 
            Wait(sleep)

            --print("tick")

            num = math.random(1, #spawnCoords[room])

            if #aggrGuards2 < 5 then 
                sleep = 50
            elseif sleep == 50 then 
                sleep = 100
            end

            --print(#aggrGuards2 < 15, IsNotClose(spawnCoords[room][num].xyz, 15), not IsAnyPedLookingAtCoord(spawnCoords[room][num].xyz))

            if #aggrGuards2 < 15 and not IsAnyCrewNear(spawnCoords[room][num].xyz, 20) and not IsAnyPedLookingAtCoord(spawnCoords[room][num].xyz) then 
                SpawnAggrPed(room, num)
                print("guard spawned", "guard count: " .. #aggrGuards2)

            end
        end

        for i = 1, #aggrGuards2 do 
            DeletePed(aggrGuards2[i])
        end

        aggrGuards2 = {}
    end)
    CreateThread(function()
        while currentRoom == room do 
            Wait(500)

            for i = 1, #aggrGuards2 do 
                if IsPedDeadOrDying(aggrGuards2[i], true) then
                    table.remove(aggrGuards2, i)
                    print("removed: " .. i, "guard count: " .. #aggrGuards2)
                end
            end
        end
    end)
end

RegisterNetEvent("cl:casinoheist:initGuardBlips", function(netIds)
    print("test")
    for i = 1, #netIds do 
        repeat Wait(0) until NetworkDoesEntityExistWithNetworkId(netIds[i])
        aggrGuards2[i] = NetToPed(netIds[i])

        SetAiBlip(aggrGuards2[i], false)
        SetPedAsEnemy(aggrGuards2[i], true)
    end
end)

RegisterNetEvent("cl:casinoheist:guardBlips", function(netId)
    if netId == nil then return end
    
    repeat Wait(0) until NetworkDoesEntityExistWithNetworkId(netId)
    aggrGuards2[#aggrGuards2 + 1] = NetToPed(netId)

    SetAiBlip(aggrGuards2[#aggrGuards2], false)
    SetPedAsEnemy(aggrGuards2[#aggrGuards2], true)
end)

RegisterCommand("test_nav", function()
    SetPedRelationshipGroupHash(PlayerPedId(), GetHashKey("PLAYER"))
    AddRelationshipGroup("GUARDS")
    SetRelationshipBetweenGroups(0, GetHashKey("GUARDS"), GetHashKey("GUARDS"))
    SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("GUARDS"))
    SetRelationshipBetweenGroups(5, GetHashKey("GUARDS"), GetHashKey("PLAYER"))
    


    SetRoom(1)
end, false)

RegisterCommand("test_gs", function()
    SetPedRelationshipGroupHash(PlayerPedId(), GetHashKey("PLAYER"))
    AddRelationshipGroup("GUARDS")
    SetRelationshipBetweenGroups(0, GetHashKey("GUARDS"), GetHashKey("GUARDS"))
    SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("GUARDS"))
    SetRelationshipBetweenGroups(5, GetHashKey("GUARDS"), GetHashKey("PLAYER"))

    playerAmount = 2
    StartGuardSpawn(3)
end, false)