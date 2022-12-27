local isInSecurity = true
local guards = {
    {   -- Security Lobby 
        {  
            "s_m_m_highsec_03", -- Suit
            ["coords"] = {
                vector4(2488.01, -274.31, -70.69, 0.0),
                vector4(2480.99, -273.13, -70.69, 0.0)
            },

            ["tick"] = 2
        },
        {
            "s_m_m_highsec_03", -- Suit
            ["coords"] = {
                vector4(2467.97, -267.99, -70.69, 0.0),
                vector4(2472.53, -270.24, -70.69, 0.0)
            },

            ["tick"] = 2
        },
        {
            "s_m_y_westsec_02", -- Work
            ["coords"] = {
                vector4(2477.85, -270.57, -70.69, 0.0),
                vector4(2524.24, -281.16, -70.69, 0.0),
                vector4(2477.79, -279.78, -70.69, 0.0)
            },

            ["tick"] = 2
        },
        {
            "s_m_y_westsec_02", -- Work
            ["coords"] = {
                vector4(2491.72, -276.4, -70.69, 0.0),
                vector4(2524.24, -281.16, -70.69, 0.0),
                vector4(2477.79, -279.78, -70.69, 0.0)
            },

            ["tick"] = 2
        },
        {
            "s_m_y_westsec_02", -- Work
            ["coords"] = {
                vector4(2491.9, -262.01, -70.69, 145.0)
            },

            ["anim"] = {
                
            }
        }
    }

    --"s_m_m_highsec_03",
    --"s_m_y_westsec_02"
}

local blips = {}
local activeGuards = {}
local aiBlips = {}

local function SpawnPed()
    LoadModel(guards[1][1][1])
    LoadModel(guards[1][3][1])

    for i = 1, 5 do 
        activeGuards[i] = CreatePed(1, GetHashKey(guards[1][i][1]), guards[1][i]["coords"][1], false --[[test]], false)
        blips[i] = AddBlipForEntity(activeGuards[i])
        SetBlipSprite(blips[i], 270)
        SetBlipColour(blips[i], 1)
        SetBlipScale(blips[i], 0.75)
        --SetBlipShowCone(blips[i], true)
    end 

    
end

function StartNav(num) 
    --num = 1 
    SpawnPed()
    StartWalking()
end

function StartWalking()
    for i = 1, 4 do 
        CreateThread(function()
            local j = i

            while not IsPedDeadOrDying(activeGuards[j]) and isInSecurity do
                TaskFollowNavMeshToCoord(activeGuards[j], guards[1][j]["coords"][guards[1][j]["tick"]].xyz, 1.0, -1, 1.0, true, 2.0)

                repeat Wait(1000) until not IsPedWalking(activeGuards[j])

                if guards[1][j]["tick"] == #guards[1][j]["coords"] then 
                    guards[1][j]["tick"] = 1 
                else
                    guards[1][j]["tick"] = guards[1][j]["tick"] + 1
                end

                Wait(2000)
            end
        end)
    end
end

RegisterCommand("test_nav", function()
    StartNav(1)
end, false)