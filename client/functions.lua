barColour = {255, 255, 255, 500}
amountSize = 0.45
wide = 0

function HelpMsg(text, time)
    AddTextEntry("help", text)
    BeginTextCommandDisplayHelp("help")
    EndTextCommandDisplayHelp(0, false, true, time .. .0)
end

function SubtitleMsg(msg, time)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(msg)
    DrawSubtitleTimed(time, true)
end

function DrawTeamlives()
    --while true do 
        SetTextColour(barColour[1], barColour[2], barColour[3], barColour[4])
        SetTextScale(0.28, 0.28)
        BeginTextCommandDisplayText("team")
        EndTextCommandDisplayText(0.853, 0.951)

        SetTextColour(barColour[1], barColour[2], barColour[3], barColour[4])
        SetTextScale(0.45, 0.45)
        BeginTextCommandDisplayText("lives")
        EndTextCommandDisplayText(0.976, 0.946)

        DrawSprite("commonmenu", "header_gradient_script", 0.912, 0.962, 0.155, 0.040, 90.0, 201, 37, 37, 500)
    --end
end

function DrawTake()
    --while true do 
    -- .. "," .. string.sub(take, 3, 5) ))
    SetTextScale(0.28, 0.28)
    BeginTextCommandDisplayText("taketxt")
    EndTextCommandDisplayText(0.88, 0.915)

    SetTextScale(0.4, 0.4)
    BeginTextCommandDisplayText("takenr")
    EndTextCommandDisplayText(0.958 - wide, 0.907)

    DrawSprite("commonmenu", "header_gradient_script", 0.912, 0.922, 0.155, 0.030, 90.0, barColour[1], barColour[2], barColour[3], 255)
    --end
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

    
    local players = GetHeistPlayer()

    local cutPlayer = {
        --ClonePedEx(hPlayer[1], 0.0, false, true, 1),
        --ClonePedEx(hPlayer[2], 0.0, false, true, 1),
        --ClonePedEx(hPlayer[3], 0.0, false, true, 1),
        --ClonePedEx(hPlayer[4], 0.0, false, true, 1)
    }

    for i = 1, 4 do 
        cutPlayer[i] = ClonePedEx(hPlayer[i], 0.0, false, true, 1)
    end
    --print(hPlayer[2])

    SetCutsceneEntityStreamingFlags("MP_1", 0, 1)
    RegisterEntityForCutscene(cutPlayer[1], "MP_1", 0, 0, 64)

    SetCutsceneEntityStreamingFlags("MP_2", 0, 1)
    RegisterEntityForCutscene(cutPlayer[2], "MP_2", 0, 0, 64)

    SetCutsceneEntityStreamingFlags("MP_3", 0, 1)
    RegisterEntityForCutscene(cutPlayer[3], "MP_3", 0, 0, 64)

    SetCutsceneEntityStreamingFlags("MP_4", 0, 1)
    RegisterEntityForCutscene(cutPlayer[4], "MP_4", 0, 0, 64)
end

function LoadModel(model)
    RequestModel(model)

    --print(IsModelInCdimage(model))

    while not HasModelLoaded(model) do 
        Wait(10)
    end
end

function LoadAnim(animDict)
    RequestAnimDict(animDict)

    --print(DoesAnimDictExist())

    while not HasAnimDictLoaded(animDict) do
        Wait(10)
    end
end

function SetEntityForAll(entity)
    NetworkRegisterEntityAsNetworked(entity)
    netId = NetworkGetNetworkIdFromEntity(entity)
    SetNetworkIdCanMigrate(netId, true)
    SetNetworkIdExistsOnAllMachines(netId, true)
end


RegisterNetEvent("cl:casinoheist:startCutscene", function(cutscene)
    if source == hPlayer[1] or source == hPlayer[2] or source == hPlayer[3] or source == hPlayer[4] then  
        LoadCutscene(cutscene)
    end
end)


--RegisterCommand("test_anim", function()
--    HackKeypad(4, 0)
--end, false)
--
-- -- NEEDS TESTING
--
--
--
--
--RegisterCommand("swipe_test", function()
--    SwipeKeycardMantrap(4)
--end, false)
