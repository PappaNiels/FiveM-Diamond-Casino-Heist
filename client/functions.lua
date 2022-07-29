function HelpMsg(text, time)
    AddTextEntry("HelpMsg", text)
    BeginTextCommandDisplayHelp("HelpMsg")
    EndTextCommandDisplayHelp(0, false, true)
end

function InfoMsg(text, id)
    if id ~= nil then 
        BeginTextCommandThefeedPost("STRING")
        AddTextComponentSubstringPlayerName(string.format(text, GetPlayerName(GetPlayerFromServerId(id))))
        EndTextCommandThefeedPostTicker(true, true)
    else 
        BeginTextCommandThefeedPost("STRING")
        AddTextComponentSubstringPlayerName(text)
        EndTextCommandThefeedPostTicker(true, true)
    end
end

function InfoMsgExtra(senderId)
    local txd = GetPedMugshot(senderId)
    
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(GetPlayerName(GetPlayerFromServerId(senderId)) .. " has invited you to join his crew for the Diamond Casino Heist!")
    EndTextCommandThefeedPostMessagetext(txd, txd, false, 0, GetPlayerName(GetPlayerFromServerId(senderId)), "Diamond Casino Heist")
end 

function SubtitleMsg(msg, time)
    --SetTextEntry_2("STRING")
    --AddTextComponentString(msg)
    AddTextEntry("SubtitleMsg", msg)
    BeginTextCommandPrint("SubtitleMsg")
    DrawSubtitleTimed(time, true)
end

function ShowAlertMessage(bool, title, msg, background)
    local setup = true
    AddTextEntry("warning_message_first_line", "confirm")
    AddTextEntry("warning_message_second_line", msg)
    if bool then 
        CreateThread(function() 
            while setup do 
                Wait(0)
                SetWarningMessageWithAlert("warning_message_first_line", "warning_message_second_line", 4, 32, "", 0, -1, 0, "", "", background, 0)
            end
        end)
    else 
        setup = false 
    end
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

    SetCutsceneEntityStreamingFlags("MP_1", 0, 1)
    RegisterEntityForCutscene(GetPlayerPed(GetPlayerFromServerId(hPlayer[1])), "MP_1", 0, 0, 64)

    SetCutsceneEntityStreamingFlags("MP_2", 0, 1)
    RegisterEntityForCutscene(GetPlayerPed(GetPlayerFromServerId(hPlayer[2])), "MP_2", 0, 0, 64)

    SetCutsceneEntityStreamingFlags("MP_3", 0, 1)
    RegisterEntityForCutscene(GetPlayerPed(GetPlayerFromServerId(hPlayer[3])), "MP_3", 0, 0, 64)

    SetCutsceneEntityStreamingFlags("MP_4", 0, 1)
    RegisterEntityForCutscene(GetPlayerPed(GetPlayerFromServerId(hPlayer[4])), "MP_4", 0, 0, 64)
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

function LoadTexture(ytd)
    RequestStreamedTextureDict(ytd)
    
    while not HasStreamedTextureDictLoaded(ytd) do 
        Wait(1)
    end
end

function GetPedMugshot(id)
    local pedheadshotint = RegisterPedheadshot(GetPlayerPed(GetPlayerFromServerId(id)))

    while not IsPedheadshotReady(pedheadshotint) or not IsPedheadshotValid(pedheadshotint) do 
        Wait(0)
    end

    return GetPedheadshotTxdString(pedheadshotint)
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

RegisterNetEvent("cl:casinoheist:infoMessage", InfoMsg)
RegisterNetEvent("cl:casinoheist:infoMessageExtra", InfoMsgExtra)
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
