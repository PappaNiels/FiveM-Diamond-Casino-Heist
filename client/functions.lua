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
    AddTextEntry("SubtitleMsg", msg)
    BeginTextCommandPrint("SubtitleMsg")
    DrawSubtitleTimed(time, true)
end

function GetHeistPlayerPed(id)
    return GetPlayerPed(GetPlayerFromServerId(id))
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
    Wait(1500)
    DoScreenFadeIn(1000)
end

function LoadCutscene(name)
    RequestCutscene(name, 8)

    while not HasCutsceneLoaded() do 
        Wait(10)
    end

    SetCutsceneEntityStreamingFlags("MP_1", 0, 1)
    RegisterEntityForCutscene(GetHeistPlayerPed(hPlayer[1]), "MP_1", 0, 0, 64)

    SetCutsceneEntityStreamingFlags("MP_2", 0, 1)
    RegisterEntityForCutscene(GetHeistPlayerPed(hPlayer[2]), "MP_2", 0, 0, 64)

    SetCutsceneEntityStreamingFlags("MP_3", 0, 1)
    RegisterEntityForCutscene(GetHeistPlayerPed(hPlayer[3]), "MP_3", 0, 0, 64)

    SetCutsceneEntityStreamingFlags("MP_4", 0, 1)
    RegisterEntityForCutscene(GetHeistPlayerPed(hPlayer[4]), "MP_4", 0, 0, 64)
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

local function IsCorrectModel()
    local ped = PlayerPedId()
    if GetEntityModel(ped) ~= GetHashKey("mp_m_freemode_01") then 
        print("false")
        return false 
    else
        print("true")
        return true 
    end
end

local function SetPedModel()
    local model = "mp_m_freemode_01"
    LoadModel(model)
    SetPlayerModel(PlayerId(), GetHashKey(model))
    SetModelAsNoLongerNeeded(model)
end

function SetPedComponents(stage)
    local ped = PlayerPedId()
    local num = GetCurrentHeistPlayer()
    local index = 1

    if not IsCorrectModel() then 
        SetPedModel()
    end

    ClearAllPedProps(ped)
    SetPedDefaultComponentVariation(ped)

    if approach == 2 then 
            if stage == 1 then 
                SetPedPropIndex(ped, clothes[2][1][selectedEntryDisguise][num][1][1], clothes[2][1][selectedEntryDisguise][num][1][2], clothes[2][1][selectedEntryDisguise][num][1][3], true)
            elseif stage == 2 and selectedExitDisguise ~= 3 then 
                SetPedPropIndex(ped, clothes[2][2][selectedExitDisguise][num][1][1], clothes[2][2][selectedExitDisguise][num][1][2], clothes[2][2][selectedExitDisguise][num][1][3], true)
                index = 2
            end 

        if stage == 1 then 
            for i = 2, #clothes[2][1][selectedEntryDisguise][num] do 
                SetPedComponentVariation(ped, clothes[2][1][selectedEntryDisguise][num][i][1], clothes[2][1][selectedEntryDisguise][num][i][2], clothes[2][1][selectedEntryDisguise][num][i][3], 0)
            end
        elseif stage == 2 then 
            for i = index, #clothes[2][2][selectedExitDisguise][num] do 
                SetPedComponentVariation(ped, clothes[2][2][selectedExitDisguise][num][i][1], clothes[2][2][selectedExitDisguise][num][i][2], clothes[2][2][selectedExitDisguise][num][i][3], 0)
            end
        end

    else
        if approach == 1 then 
            SetPedPropIndex(ped, 0, 147, 0, 0)
        end 

        for i = 1, #clothes[approach][1] do 
            SetPedComponentVariation(ped, clothes[approach][num][i][1], clothes[approach][num][i][2], clothes[approach][num][i][3], 0)
        end
    end
end

function IsNotClose(distance)
    for i = 1, #hPlayer do 
        if #(GetEntityCoords(GetHeistPlayerPed(hPlayer[i])) - entryCoords[selectedEntrance]) < distance then 
            return false  
        end
    end

    return true
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
