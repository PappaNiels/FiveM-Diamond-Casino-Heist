local initRoutes = false
local currentRoom = 0
local tick = 0

local seen = {0, 0, 0, 0, 0}

local guards = {
    {   -- Staff Lobby
        {

        }
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

local blips = {{}, {}}
local activeGuards = {{}, {}}

local function SpawnPed()
    LoadModel(guards[2][1][1])
    LoadModel(guards[2][3][1])
    
    for i = 2, 2 do 
        for j = 1, #guards[i] do
            activeGuards[i][j] = CreatePed(1, GetHashKey(guards[i][j][1]), guards[i][j][2][1], false --[[test]], false)

            --blips[i][j] = AddBlipForEntity(activeGuards[i][j])
            --SetBlipScale(blips[i][j], 0.75)
            --SetBlipSprite(blips[i][j], 270)
            --SetBlipColour(blips[i][j], 1)
            --SetBlipPriority(blips[i][j], 7)

            SetPedHasAiBlipWithColor(activeGuards[i][j], true, 1)
            SetPedAiBlipGangId(activeGuards[i][j], 1)
            SetPedAiBlipNoticeRange(activeGuards[i][j], 100.0)
            SetPedAiBlipSprite(activeGuards[i][j], 270)
            SetPedAiBlipForcedOn(activeGuards[i][j], true)

            -- Cone

            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName("Guard")
            EndTextCommandSetBlipName(blips[i][j])
        end
    end 
    
    SetModelAsNoLongerNeeded(guards[2][1][1])
    SetModelAsNoLongerNeeded(guards[2][3][1])

    Wait(1000)

    for i = 2, 2 do 
        for j = 1, #guards[i] -1 do
            TaskPatrol(activeGuards[i][j], "MISS_PATROL_" .. j - 1, 1, false, true)
        end
    end
end
    
function SetGuardVision(room)
    currentRoom = room
    for i = 1, #activeGuards[room] do 
        CreateThread(function()
            while currentRoom == room and not IsPedDeadOrDying(activeGuards[room][i]) and alarmTriggered == 0 do 
                Wait(100)

                if IsPedFacingPed(activeGuards[room][i], PlayerPedId(), 60.0) then 
                    print("seen", j, seen[j])
                    
                    seen[i] += 1

                    if seen > 6 then 
                        TriggerServerEvent("sv:casinoheist:alarm")
                    end
                elseif seen[i] ~= 0 then 
                    seen[i] = 0
                end
            end
        end)
    end
end

function InitRoutes()
    if initRoutes then return end
    
    initRoutes = true

    for i = 2, 2 do 
        for j = 1, i + 2 do 
            OpenPatrolRoute("MISS_PATROL_" .. tick)
            for k = 1, #guards[i][j][2] do 
                AddPatrolRouteNode(k, guards[i][j][3], guards[i][j][2][k].xyz, guards[i][j][2][k].xyz, guards[i][j][4] or math.random(3000, 5000))
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

    SpawnPed()
end

function DeletePaths()
    for i = 1, tick do
        DeletePatrolRoute("MISS_PATROL_" .. i)
    end
    
    initRoutes = false
end

function SetGuardAgg()

end

RegisterCommand("test_nav", function()
    InitRoutes()
end, false)