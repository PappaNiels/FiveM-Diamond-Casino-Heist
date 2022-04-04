local entrypointTunnel = vector3(2517.22, -326.99, -71.2)
local sewerEntry = vector3(893.29, -176.47, 22.58)

RegisterCommand("sewer", function()
    
    --print(hPlayer[1])
    --RequestCutscene("hs3f_dir_sew", 8)

    --while not HasCutsceneLoaded() do 
    --    Wait(10)
    --end

    --SetCutsceneEntityStreamingFlags("MP_2", 0, 1)
    --RegisterEntityForCutscene(PlayerPedId(), "MP_2", 0, 0, 64)

    LoadCutscene("hs3f_dir_sew")

    StartCutscene(0)
    --print(hPlayer[1])
    print(GetCutsceneTotalDuration())
    Wait(12800)
    DeletePeds()
end, false)

RegisterCommand("cut_sew", function()
    local animDict = "anim_heist@hs3f@ig7_plant_bomb@male@"

    LoadAnim(animDict)
    LoadModel("ch_prop_ch_ld_bomb_01a")
    --RequestAnimDict(animDict)
    --while not HasAnimDictLoaded(animDict) do 
    --    Wait(10)
    --end

    ClearPedTasksImmediately(PlayerPedId())
    --print(GetAnimDuration(animDict, animName))

    local pos = GetEntityCoords(PlayerPedId())
    local bomb = CreateObject(GetHashKey("ch_prop_ch_ld_bomb_01a"),pos.x, pos.y,pos.z, true, true, true)
    --TaskPlayAnim(PlayerPedId(), animDict, animName, 8.0, -8.0, 2000, 49, 0, 1, 1, 1)

    --AttachEntityToEntity(moneyBag, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), -0.17, 0.13, 0.0, 180.0, 270.0, 180.0, false, false, false, false, 2, true)
    AttachEntityToEntity(bomb, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 0xE5F2), 0.05, -0.12, -0.180, 180.0, 185.0, 15.0, false, false, false, false, 2, true)
    TaskPlayAnimAdvanced(PlayerPedId(), animDict, "plant_bomb", 2480.1, -293.33, -70.67, 0.0, 0.0, 0.0, 8.0, -8.0, 2000, 8, 0, 0, 0)
    Wait(2000)
    DetachEntity(bomb, false, true)
    FreezeEntityPosition(bomb, true)
    Wait(1300)
    ExecuteCommand("sewer")
    DeleteEntity(bomb)

end, false)

local inTunnel = false
local isReady = false

CreateThread(function()
    while true do 
        Wait(0)
        if isReady then
            local distance = #(GetEntityCoords(PlayerPedId()) - sewerEntry)
            if distance < 20 then 
                DrawMarker(1, sewerEntry.x, sewerEntry.y, sewerEntry.z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.50, 0.75, 229, 202, 23, 100, false, false, 2, false, nil, nil, false)
                if not inTunnel and isReady and distance < 4 then 
                    HelpMsg("Press ~INPUT_CONTEXT~ to enter the tunnel", 110)
                    if IsControlJustPressed(0, 38) then
                        --EnterTunnel()
                        FadeTeleport(2517.22, -326.99, -71.2, 84.0)
                        --print("tunnel")
                        inTunnel = true
                    end
                else
                    --Wait(500)
                end
            else
                Wait(100)
            end
        else 
            Wait(500)
        end
    end
end)

CreateThread(function()
    while true do 
        Wait(0) 
        if inTunnel then 
            local distance = #(GetEntityCoords(PlayerPedId()) - vector3(2480.1, -293.33, -70.67))
            if distance < 10 then 
                DrawMarker(1, 2480.1, -293.33, -71.7, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.50, 0.75, 229, 202, 23, 100, false, false, 2, false, nil, nil, false)
                --print("marker")
                if distance < 1 then 
                    HelpMsg("Press ~INPUT_CONTEXT~ to plant the bomb")
                    
                    if IsControlJustPressed(0, 38) then 
                        ExecuteCommand("cut_sew")
                        inTunnel = false
                    end
                end
            else 
                Wait(100)
            end
        else 
            Wait(500)
        end
    end
end)



--function EnterTunnel()
--    DoScreenFadeOut(800)
--
--    while not IsScreenFadedOut() do 
--        Wait(500)
--    end
--
--    SetEntityCoords(PlayerPedId(), entrypointTunnel.x, entrypointTunnel.y, entrypointTunnel.z)
--    SetEntityHeading(PlayerPedId(), 84.0)
--    DoScreenFadeIn(800)
--end

RegisterCommand("sew_back", function() 
    SetEntityCoords(PlayerPedId(), sewerEntry)
    isReady = true
end, false)
