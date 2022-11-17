RegisterCommand("testcut", function()
    --RequestCutscene("hs3f_int2", 8)
--
    --while not HasCutsceneLoaded() do 
    --    Wait(10)
    --end
    LoadCutscene("hs3f_int2")

    --SetCutsceneEntityStreamingFlags("MP_1", 0, 1)
    --RegisterEntityForCutscene(PlayerPedId(), "MP_1", 0, 0, 64)

    StartCutscene(0)
    print(GetCutsceneTotalDuration())
end, false)

-- Open Vault Without Guard
RegisterCommand("cut_openvault", function()
    RequestCutscene("hs3f_mul_vlt", 8)

    while not HasCutsceneLoaded() do 
        Wait(10)
    end

    SetCutsceneEntityStreamingFlags("MP_1", 0, 1)
    RegisterEntityForCutscene(PlayerPedId(), "MP_1", 0, 0, 64)

    StartCutscene(0)
    print(GetCutsceneTotalDuration())
end, false)

-- Gruppe Sechs Vault Entry
RegisterCommand("cut_sneak_ventry", function()
    RequestCutscene("hs3f_sub_vlt", 8)

    while not HasCutsceneLoaded() do 
        Wait(10)
    end

    SetCutsceneEntityStreamingFlags("MP_1", 0, 1)
    RegisterEntityForCutscene(PlayerPedId(), "MP_1", 0, 0, 64)

    StartCutscene(0)
    print(GetCutsceneTotalDuration())
end, false)

-- Yung Ancestor Entry
RegisterCommand("cut_ya_entry", function()
    RequestCutscene("hs3f_sub_cel", 8)

    while not HasCutsceneLoaded() do 
        Wait(10)
    end

    SetCutsceneEntityStreamingFlags("MP_1", 0, 1)
    RegisterEntityForCutscene(PlayerPedId(), "MP_1", 0, 0, 64)

    StartCutscene(0)
    print(GetCutsceneTotalDuration())
end, false)

-- Arrive Police
RegisterCommand("cut_arrivepolice", function()
    RequestCutscene("hs3f_all_esc", 8) -- hs3f_all_esc_b = without voices

    while not HasCutsceneLoaded() do 
        Wait(10)
    end

    SetCutsceneEntityStreamingFlags("MP_1", 0, 1)
    RegisterEntityForCutscene(PlayerPedId(), "MP_1", 0, 0, 64)

    StartCutscene(0)
    print(GetCutsceneTotalDuration())
end, false)

--Pair.__tostringx = function (p)
--    Pair.__tostring = nil    
--    local s = "Pair " .. tostring(p)                                                                                                                                                                                                    
--    Pair.__tostring = Pair.__tostringx
--    return s
--end

--Pair.__tostring = Pair.__tostringx

-- Dropoff End Heist
RegisterCommand("cut_dropoff", function(src, args)
    --print(p)
    local num = tonumber(args[2])
    local num2 = tonumber(args[3])

    RequestCutscene("hs3f_all_drp"..args[1], 8) -- hs3f_all_drp2 and hs3f_all_drp3 are a bit different, but they are all dropoffs 1 = Mid Level, 2 = Low Level, 3 = High Level

    while not HasCutsceneLoaded() do 
        Wait(10)
    end

    --TriggerScriptEvent2()

    SetCutsceneEntityStreamingFlags("MP_1", 0, 1)
    RegisterEntityForCutscene(PlayerPedId(), "MP_1", 0, 0, 64)
    SetCutsceneOrigin(meetingPoint[1][1], 100.0, 0)
    StartCutsceneAtCoords(meetingPoint[num][num2], 0)
    --StartCutscene(0)

    --SetCutsceneOrigin(GetEntityCoords(PlayerPedId()), 35.0, 0)
    while not DoesCutsceneEntityExist("MP_3") do 
        Wait(10)
    end 
    
    SetEntityVisible(GetEntityIndexOfCutsceneEntity("MP_2", 0), false, false)
    SetEntityVisible(GetEntityIndexOfCutsceneEntity("MP_3", 0), false, false)
    SetEntityVisible(GetEntityIndexOfCutsceneEntity("MP_4", 0), false, false)
    
    SetCutsceneOrigin(meetingPoint[num][num2], 200.0, 0)
    repeat print(meetingPoint[num][1]) Wait(1000) until HasCutsceneFinished()
    print(GetCutsceneTotalDuration())
end, false)

-- Aggressive entry
RegisterCommand("cut_agg_entry", function()
    RequestCutscene("hs3f_dir_ent", 8)

    while not HasCutsceneLoaded() do 
        Wait(10)
    end

    SetCutsceneEntityStreamingFlags("MP_1", 0, 1)
    RegisterEntityForCutscene(PlayerPedId(), "MP_1", 0, 0, 64)

    StartCutscene(0)
    print(GetCutsceneTotalDuration())
end, false)

RegisterCommand("timer_test", function()
    RequestStreamedTextureDict("timerbars")
    
    while not HasStreamedTextureDictLoaded("timerbars") do 
        Wait(1)
    end

    if teamlives < 1 then 
        barColour = {170, 40, 40, 255}
    end

    --local num = 85021
    
    print(string.sub(take, 1, 2) .. "," .. string.sub(take, 3, 5), len)
    
    
    local len = string.len(tostring(take))

    if len == 4 then 
        takef = string.sub(take, 1, 1) .. "," .. string.sub(take, 2, 4)
    elseif len == 5 then 
        takef = string.sub(take, 1, 2) .. "," .. string.sub(take, 3, 5)
        wide = 0.007
    elseif len == 6 then 
        takef = string.sub(take, 1, 3) .. "," .. string.sub(take, 4, 6)
        wide = 2 * 0.007
    elseif len == 7 then 
        takef = string.sub(take, 1, 1) .. "," .. string.sub(take, 2, 4) .. "," .. string.sub(take, 5, 7)
        wide = 0.012
        height = 0.005
        amountSize = 0.4
    end

    AddTextEntry("team", "TEAM LIVES")
    AddTextEntry("lives", "~1~")
    AddTextEntry("taketxt", "TAKE")
    AddTextEntry("takenr", "$~a~")
    

    --DrawTeamliwsves()

    CreateThread(function()
        while true do 
            Wait(4)
            DrawTeamlives()
            DrawTake()
        end
    end)
    

end, false)

RegisterCommand("scaleform", function()
    local scaleform = RequestScaleformMovie("SHOP_MENU_DLC")

    while not HasScaleformMovieLoaded(scaleform) do 
        Wait(1)
    end

    LoadTexture("shopui_title_heist")

    --BeginScaleformMovieMethod(scaleform, "SET_HEADER")
    --ScaleformMovieMethodAddParamPlayerNameString("test")
    ----ScaleformMovieMethodAddParamInt(2)
    --EndScaleformMovieMethod()

    BeginScaleformMovieMethod(scaleform, "SET_IMAGE")
    ScaleformMovieMethodAddParamPlayerNameString("shopui_title_heist")
    ScaleformMovieMethodAddParamPlayerNameString("shopui_title_heist")
    --ScaleformMovieMethodAddParamInt(5)
    EndScaleformMovieMethod()

    BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(1)
    EndScaleformMovieMethod()

    BeginScaleformMovieMethod(scaleform, "DRAW_MENU_LIST")
    EndScaleformMovieMethod()
    --BeginScaleformMovieMethod(scaleform, "SET_DESCRIPTION")
    --ScaleformMovieMethodAddParamPlayerNameString("test")
    --ScaleformMovieMethodAddParamPlayerNameString("test")
    --ScaleformMovieMethodAddParamPlayerNameString("test")
    --EndScaleformMovieMethod()

    while true do 
        Wait(0)
        DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
    end

end)

RegisterCommand("test_aggr_entry", function()

    LoadCutscene("hs3f_dir_ent")
    StartCutscene(0)

    while not DoesCutsceneEntityExist("Player_SMG_3", 0) do 
        Wait(0)
    end

    print("shit: " .. DoesCutsceneEntityExist("Player_SMG_1", 0))
    print("shit: " .. DoesCutsceneEntityExist("Player_SMG_2", 0))
    print("shit: " .. DoesCutsceneEntityExist("Player_SMG_3", 0))
    print("shit: " .. DoesCutsceneEntityExist("Player_SMG_4", 0))

    smg1 = GetEntityIndexOfCutsceneEntity("Player_Mag_3", 0)
    smg2 = GetEntityIndexOfCutsceneEntity("Player_Mag_4", 0)
    smg3 = GetEntityIndexOfCutsceneEntity("Player_SMG_3", 0)
    smg4 = GetEntityIndexOfCutsceneEntity("Player_SMG_4", 0)

    SetEntityVisible(smg1, false, false)
    SetEntityVisible(smg2, false, false)
    SetEntityVisible(smg3, false, false)
    SetEntityVisible(smg4, false, false)
end, false)

RegisterCommand("vl_exp", function() 
    SetVaultDoorStatus()
    VaultExplosion() 
end, false)

local vaultDoorAnim = {
    ["anims"] = {
        {"explosion_vault_01", "explosion_vault_02", "explosion_camera"}
    },
    ["networkScenes"] = {}
}

function VaultExplosion()
    local animDict = "anim_heist@hs3f@ig8_vault_door_explosion@"
    LoadAnim(animDict)

    vaultOne = GetClosestObjectOfType(2504.97, -240.3102, -70.17885, 1.0, GetHashKey("ch_prop_ch_vaultdoor01x"), false, false, false)
    vaultTwo = GetClosestObjectOfType(2504.97, -240.3102, -70.17885, 1.0, GetHashKey("ch_des_heist3_vault_end"), false, false, false)
    --vaultCam = GetClosestObjectOfType(, 1.0, GetHashKey(""), false, false, false)
    print(vaultOne, vaultTwo)
    --for i = 1, #vaultDoorAnim["anims"] do 
    vaultDoorAnim["networkScenes"][1] = NetworkCreateSynchronisedScene(GetEntityCoords(vaultOne), GetEntityRotation(vaultOne), 2, true, false, 1065353216, 0, 1.3)
    NetworkAddEntityToSynchronisedScene(vaultOne, vaultDoorAnim["networkScenes"][1], animDict, vaultDoorAnim["anims"][1][3], 1.0, -1.0, 114886080)
    --NetworkAddEntityToSynchronisedScene(vaultTwo, vaultDoorAnim["networkScenes"][1], animDict, vaultDoorAnim["anims"][1][2], 1.0, -1.0, 114886080)
    --print(NetworkIsEntity)
    --end
    --print(vaultDoorAnim["anims"][1][1], vaultDoorAnim["anims"][1][2])
    --print(NetworkGetEntityFromNetworkId(vaultDoorAnim["networkScenes"][1]))
    print(vaultDoorAnim["networkScenes"][1])
    NetworkStartSynchronisedScene(vaultDoorAnim["networkScenes"][1])
    


end