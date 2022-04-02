RegisterCommand("testcut", function()
    RequestCutscene("hs3f_int2", 8)

    while not HasCutsceneLoaded() do 
        Wait(10)
    end
    LoadCutscene("hs3f_int2")

    SetCutsceneEntityStreamingFlags("MP_1", 0, 1)
    RegisterEntityForCutscene(PlayerPedId(), "MP_1", 0, 0, 64)

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

-- Dropoff End Heist
RegisterCommand("cut_dropoff", function()
    RequestCutscene("hs3f_all_drp1", 8) -- hs3f_all_drp2 and hs3f_all_drp3 are a bit different, but they are all dropoffs

    while not HasCutsceneLoaded() do 
        Wait(10)
    end

    SetCutsceneEntityStreamingFlags("MP_1", 0, 1)
    RegisterEntityForCutscene(PlayerPedId(), "MP_1", 0, 0, 64)

    StartCutscene(0)
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