function HelpMsg(text)
    AddTextEntry("bomb", text)
    BeginTextCommandDisplayHelp( "bomb")
    EndTextCommandDisplayHelp(0, false, -1)
end

function SubtitleMsg(msg, time)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(msg)
    DrawSubtitleTimed(time, true)
end

function FadeTeleport(x, y, z, h)
    DoScreenFadeOut(800)

    while not IsScreenFadedOut() do 
        Wait(500)
    end

    if x ~= nil then
        SetEntityCoords(PlayerPedId(), x, y, z)
        SetEntityHeading(PlayerPedId(), h)
        
    end
    DoScreenFadeIn(800)
end

function LoadCutscene(name)
    RequestCutscene(name, 8)

    while not HasCutsceneLoaded() do 
        Wait(10)
    end

    
    local hPlayer = GetHeistPlayer()

    --print(hPlayer[2])

    SetCutsceneEntityStreamingFlags("MP_1", 0, 1)
    RegisterEntityForCutscene(hPlayer[2], "MP_1", 0, 0, 64)

    SetCutsceneEntityStreamingFlags("MP_2", 0, 1)
    RegisterEntityForCutscene(PlayerPedId(), "MP_2", 0, 0, 64)

    SetCutsceneEntityStreamingFlags("MP_3", 0, 1)
    RegisterEntityForCutscene(hPlayer[3], "MP_3", 0, 0, 64)

    SetCutsceneEntityStreamingFlags("MP_4", 0, 1)
    RegisterEntityForCutscene(hPlayer[4], "MP_4", 0, 0, 64)
end

function LoadModel(model)
    RequestModel(model)

    while not HasModelLoaded(model) do 
        Wait(10)
    end
end

function LoadAnim(animDict)
    RequestAnimDict(animDict)

    while not HasAnimDictLoaded(animDict) do
        Wait(10)
    end
end

RegisterCommand("tp", function(source, args)
    local x, y, z, h = args[1], args[2], args[3], args[4]
    print(x, y, z, h)
    FadeTeleport(x, y, z, h)
end, false)