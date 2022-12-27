local guards = {
    "s_m_m_highsec_03",
    "s_m_y_westsec_02"
}

local activeGuards = {}

local function SpawnPed()
    LoadModel(guards[1])

    activeGuards[#activeGuards + 1] = CreatePed(1, GetHashKey(guards[1]), 2490.72, -273.24, -70.69, 180.0, false --[[test]], false)
end

function StartNav(num) 
    --num = 1 
    SpawnPed()

    TaskFollowNavMeshToCoord(activeGuards[1], 2523.55, -278.8, -70.71, 1, -1, 1.0, true, 1)
end

RegisterCommand("test_nav", function()
    StartNav(1)
end, false)

