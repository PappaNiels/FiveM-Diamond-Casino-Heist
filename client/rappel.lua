RegisterCommand("rappel", function(source)
    Start()
end, false)

RegisterCommand("rope", function()
    RopeStart()
end, false)

local rope = false

local coords1 = { -- func_11488
    vector3(2572.225, -254.2, -64.8),
    vector3(2573.575, -254.2, -64.8),
    vector3(2571.0, -254.2, -64.8),
    vector3(2574.8, -254.2, -64.8)
}

local coords2 = { -- func_11487
    vector3(2572.35, -255.4523, -73.3),
    vector3(2573.575, -255.4523, -73.3),
    vector3(2571.0, -255.4523, -73.3),
    vector3(2574.8, -255.4523, -73.3)
}

function Start()
    RequestCutscene("hs3f_mul_rp1", 8)

    while not HasCutsceneLoaded() do
        Wait(10)
        
    end 

    SetCutsceneEntityStreamingFlags("MP_1", 0, 1)
    RegisterEntityForCutscene(PlayerPedId(), "MP_1", 0, 0, 64)
    --SetCutsceneEntityStreamingFlags("MP_2", 0, 1)
    --RegisterEntityForCutscene(0, "MP_2", 0, 0, 64)

    SetCutsceneCanBeSkipped(true)
    StartCutscene(0)
    
    Wait(11966)
    RopeStart()
end

local function HideCutProps(bool)
    while not DoesCutsceneEntityExist("MP_3") do 
        Wait(10)
    end

    local arr = {}
    if playerAmount == 2 then 
        arr = {"MP_3", "Player_Rope_3", "Player_Pulley_3", "MP_4", "Player_Rope_4", "Player_Pulley_4"}
    elseif playerAmount == 3 then 
        arr = {"MP_4", "Player_Rope_4", "Player_Pulley_4"}
    end
    
    if #arr > 0 then 
        for i = 1, #arr do 
            SetEntityVisible(GetEntityIndexOfCutsceneEntity(arr[i], 0), false, false)
        end
    end 

    --if bool then 
    --    repeat Wait(100) until HasCutsceneFinished()
    --else
        repeat Wait(100) until GetCutsceneTotalDuration() - GetCutsceneTime() < 500
    --end
end

function RopeStart()
    player = 1
    print("data sets")
    LoadCutscene("hs3f_mul_rp1")
    StartCutscene(0)

    HideCutProps(true)
    RemoveCutscene()

    DoScreenFadeOut(500)

    while not IsScreenFadedOut() do 
        Wait(10)
    end

    Wait(1000)

    RopeLoadTextures()

    var3 = coords1[player]
    var4 = coords2[player]
    var6 = 78.0
    var8 = vector3(-90.0, 90.0, -90.0)

    if GetCamViewModeForContext(0) == 4 then 
        SetCamViewModeForContext(0, 0)
    end

    SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)
    
    local ropeId = AddRope(var3, var8, var6, 7, var6, var6, 1.2, false, true, true, 10.0, false, 0)
    N_0xa1ae736541b0fca3(ropeId, true)
    
    SetEntityCoords(PlayerPedId(), var4, true, false, false, true)
    SetEntityHeading(PlayerPedId(), 178.5)
    
    DoScreenFadeIn(500)

    TaskRappelDownWall(PlayerPedId(), var3, var3, -143.0, ropeId, "clipset@anim_heist@hs3f@ig1_rappel@male", 1)
    PinRopeVertex(ropeId, (GetRopeVertexCount(ropeId) - 1), var3)
    RopeSetUpdateOrder(ropeId, 0)
    SetGameplayCamRelativeRotation(0.0, 0.0, 180.0)
    
    while GetEntityCoords(GetHeistPlayerPed(hPlayer[1])).z > -140 or GetEntityCoords(GetHeistPlayerPed(hPlayer[2])).z > -136 or GetEntityCoords(GetHeistPlayerPed(hPlayer[3])).z > -136 or GetEntityCoords(GetHeistPlayerPed(hPlayer[4])).z > -136 do
        DisableControlAction(0, 0, true)
        --DisableControlAction(0, 1, true)
        DisableControlAction(0, 26, true)
        DisableControlAction(0, 37, true)
        DisableControlAction(0, 260, true)

        Wait(0)
    end

    
    LoadCutscene("hs3f_mul_rp2")
    StartCutscene(0)
    
    DeleteRope(ropeId)
    RopeUnloadTextures()

    HideCutProps(false)
    RemoveCutscene()

    DoScreenFadeOut(500)

    while not IsScreenFadedOut() do 
        Wait(10)
    end

    SetEntityCoords(PlayerPedId(), rappelEntry[2][player].x, rappelEntry[2][player].y, rappelEntry[2][player].z, true, false, false, false)
    SetEntityHeading(PlayerPedId(), rappelEntry[2][player].w)
    Basement()

    Wait(1000)

    DoScreenFadeIn(1000)
end

CreateThread(function() 
    while true do 
        Wait(50)
        if rope then 
            local coords = GetEntityCoords(PlayerPedId())
            if coords.z < -136 then 
               ShowCutscene()
                rope = false
            end
        end        
    end
end)