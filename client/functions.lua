local ratio = GetAspectRatio(0) 
ratioR = 1.778 / ratio

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
    
    repeat Wait(0) until CanRequestAssetsForCutsceneEntity()
    
    SetCutsceneEntityStreamingFlags("MP_1", 0, 1)
    RegisterEntityForCutscene(GetHeistPlayerPed(hPlayer[1]), "MP_1", 0, 0, 64)
    
    SetCutsceneEntityStreamingFlags("MP_2", 0, 1)
    RegisterEntityForCutscene(GetHeistPlayerPed(hPlayer[2]), "MP_2", 0, 0, 64)
    
    if #hPlayer == 3 then 
        SetCutsceneEntityStreamingFlags("MP_3", 0, 1)
        RegisterEntityForCutscene(GetHeistPlayerPed(hPlayer[3]), "MP_3", 0, 0, 64)
    elseif #hPlayer == 4 then 
        SetCutsceneEntityStreamingFlags("MP_3", 0, 1)
        RegisterEntityForCutscene(GetHeistPlayerPed(hPlayer[3]), "MP_3", 0, 0, 64)
        
        SetCutsceneEntityStreamingFlags("MP_4", 0, 1)
        RegisterEntityForCutscene(GetHeistPlayerPed(hPlayer[4]), "MP_4", 0, 0, 64)
    end
    
    repeat Wait(0) until HasCutsceneLoaded() 
end

function LoadModel(model)
    if not HasModelLoaded(model) then 
       RequestModel(model)

       --print(IsModelInCdimage(model))

       while not HasModelLoaded(model) do 
           Wait(10)
       end
    end
end

function LoadAnim(animDict)
    if not HasAnimDictLoaded(animDict) then 
        RequestAnimDict(animDict)

        --print(DoesAnimDictExist())

        while not HasAnimDictLoaded(animDict) do
            Wait(10)
        end
    end
end

function LoadTexture(ytd)
    if not HasStreamedTextureDictLoaded(ytd) then 
        RequestStreamedTextureDict(ytd)
        
        while not HasStreamedTextureDictLoaded(ytd) do 
            Wait(1)
        end
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
    return netId
end

local function IsCorrectModel()
    local ped = PlayerPedId()
    if GetEntityModel(ped) ~= GetHashKey("mp_m_freemode_01") then 
        return false 
    else
        return true 
    end
end

function SetPedModel()
    local model = "mp_m_freemode_01"
    LoadModel(model)
    SetPlayerModel(PlayerId(), GetHashKey(model))
    SetModelAsNoLongerNeeded(model)
end

function SetPedComponents(stage)
    
    if not IsCorrectModel() then 
        SetPedModel()
        print(IsCorrectModel())
    end
    
    local ped = PlayerPedId()
    local num = 2 --math.random(1, 4) --GetCurrentHeistPlayer()
    local index = 1
    
    ClearAllPedProps(ped)
    SetPedDefaultComponentVariation(ped)    
    
    Wait(100)

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

function IsNotClose(coords, distance)
    if playerAmount == 2 then 
        if (#(GetEntityCoords(GetHeistPlayerPed(hPlayer[1])) - coords) > distance) or (#(GetEntityCoords(GetHeistPlayerPed(hPlayer[2])) - coords) > distance) then 
            return true 
        else 
            return false
        end
    elseif playerAmount == 3 then 
        if (#(GetEntityCoords(GetHeistPlayerPed(hPlayer[1])) - coords) > distance) or (#(GetEntityCoords(GetHeistPlayerPed(hPlayer[2])) - coords) > distance) or (#(GetEntityCoords(GetHeistPlayerPed(hPlayer[3])) - coords) > distance) then 
            return true 
        else 
            return false
        end
    elseif playerAmount == 4 then 
        if (#(GetEntityCoords(GetHeistPlayerPed(hPlayer[1])) - coords) > distance) or (#(GetEntityCoords(GetHeistPlayerPed(hPlayer[2])) - coords) > distance) or (#(GetEntityCoords(GetHeistPlayerPed(hPlayer[3])) - coords) > distance) or (#(GetEntityCoords(GetHeistPlayerPed(hPlayer[4])) - coords) > distance) then 
            return true 
        else 
            return false
        end
    end
end

function IsAnyCrewNear(coords, distance)
    if playerAmount == 2 then 
        if #(GetEntityCoords(GetHeistPlayerPed(hPlayer[1])) - coords) < distance or #(GetEntityCoords(GetHeistPlayerPed(hPlayer[2])) - coords) < distance then 
            return true 
        end
    elseif playerAmount == 3 then 
        if #(GetEntityCoords(GetHeistPlayerPed(hPlayer[1])) - coords) < distance or #(GetEntityCoords(GetHeistPlayerPed(hPlayer[2])) - coords) < distance or #(GetEntityCoords(GetHeistPlayerPed(hPlayer[3])) - coords) < distance then 
            return true 
        end
    elseif playerAmount == 4 then 
        if #(GetEntityCoords(GetHeistPlayerPed(hPlayer[1])) - coords) < distance or #(GetEntityCoords(GetHeistPlayerPed(hPlayer[2])) - coords) < distance or #(GetEntityCoords(GetHeistPlayerPed(hPlayer[3])) - coords) < distance or #(GetEntityCoords(GetHeistPlayerPed(hPlayer[4])) - coords) < distance then 
            return true 
        end
    end
    return false
end

function GetEntityOffset(entity, bool)
    local heading = GetEntityHeading(entity) / 180 * math.pi
    local plus = vector3(0.0, 0.0, 0.0)
    if bool then 
        plus = vector3(math.cos(heading), math.sin(heading), 0.0)
    else 
        plus = vector3(math.cos(heading + (0.5 * math.pi)), math.sin(heading + (0.5 * math.pi)), 0.0)
    end

    return plus
end

function DrawSpriteCut(dict, name, x, y, width, height, a)
    DrawSprite(dict, name, (0.5 - ((0.5 - x) / ratio)), y, (width / 1920.0) * ratioR, height / 1920, 0.0, 255, 255, 255, a, 0)
end

function GetXTextPlace(x, y)
    return (0.5 - ((0.5 - x) / ratio))
end

function GetClothingModel(num)
    if num == 13 then 
        return 5
    elseif num == 8 then 
        return 4
    elseif num == 3 then 
        return 3
    elseif num == 0 then 
        return 2
    elseif num == 9 then 
        return 1
    elseif num == 10 then 
        return 8
    elseif num == 11 then 
        return 9
    elseif num == 13 then 
        return 5
    elseif num == 7 then   
        return 3
    end  
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
