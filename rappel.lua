RegisterCommand("rappel", function(source)
    Start()
end, false)

RegisterCommand("rope", function()
    RopeStart()
end, false)

local rope = false

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

function RopeStart()
    local coords = vector3(2572.341, -254.9, -64.66)

    RopeLoadTextures()
    SetEntityCoords(PlayerPedId(), coords - vector3(0, 0, 10.0))

    local ropeId = AddRope(coords, -90.0, 90.0, -90.0, 80.0, 1, 80.0, 80.0, 1.2, false, false, true, 10.0, false, 0)

    TaskRappelDownWall(PlayerPedId(), coords, coords, -136.0, ropeId, "clipset@anim_heist@hs3f@ig1_rappel@male", 1)
    N_0xa1ae736541b0fca3(ropeId, true)
    PinRopeVertex(ropeId, (GetRopeVertexCount(ropeId) - 1), coords + vector3(0, 0, 1.0))
    RopeSetUpdateOrder(ropeId, 0)
    rope = true
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

--CreateThread(function()
--    while true do 
--        if rope then 
--            local Scale = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS")
--            
--            BeginScaleformMovieMethod(Scale, "CLEAR_ALL")
--            EndScaleformMovieMethod()
--            
--            BeginScaleformMovieMethod(Scale, "SET_DATA_SLOT")
--            ScaleformMovieMethodAddParamInt(1)
--            PushScaleformMovieMethodParameterString("~INPUT_SCRIPTED_FLY_UD~")
--            PushScaleformMovieMethodParameterString("Rappel Down")
--            EndScaleformMovieMethod()
--
--            BeginScaleformMovieMethod(Scale, "DRAW_INSTRUCTIONAL_BUTTONS");
--            ScaleformMovieMethodAddParamInt(0);
--            EndScaleformMovieMethod();
--
--            DrawScaleformMovieFullscreen(Scale, 255, 255, 255, 0, 0)
--
--        end
--    end
--end)

function ShowCutscene()
    RequestCutscene("hs3f_mul_rp2", 8)

    while not HasCutsceneLoaded() do
        Wait(10) 
    end

    SetCutsceneEntityStreamingFlags("MP_1", 0, 1)
    RegisterEntityForCutscene(PlayerPedId(), "MP_1", 0, 0, 64)

    StartCutscene(0)
end

RegisterCommand("test", function()
    RequestCutscene("hs4_lsa_land_nimb", 8)

    while not HasCutsceneLoaded() do
        Wait(10) 
    end

    SetCutsceneEntityStreamingFlags("MP_1", 0, 1)
    RegisterEntityForCutscene(PlayerPedId(), "MP_1", 0, 0, 64)

    StartCutscene(0)
end)


