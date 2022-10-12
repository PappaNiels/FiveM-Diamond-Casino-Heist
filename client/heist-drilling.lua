local scaleformDrill = 0
local cam = 0
local drillObj = 0
local progress = 1
local temp = 0
local speed = 0
local position = 0

local isDrilling = false

local animDict = ""
local drillName = ""

local drillAnims = { -- Laser: "anim_heist@hs3f@ig9_vault_drill@laser_drill@", "ch_prop_laserdrill_01a" Regular: "anim_heist@hs3f@ig9_vault_drill@drill@", "hei_prop_heist_drill"
    {   -- Ped, Drill, Bag, Cam
        {"intro", "intro_drill_bit", "bag_intro", "intro_cam"},
        {"drill_straight_start", "drill_straight_start_drill_bit", "bag_drill_straight_start", "drill_straight_start_cam"},
        {"drill_straight_idle", "drill_straight_idle_drill_bit", "bag_drill_straight_idle", "drill_straight_idle_cam"},
        {"drill_straight_end", "drill_straight_end_drill_bit", "bag_drill_straight_end", "drill_straight_end_cam"},
        {"drill_straight_end_idle", "drill_straight_end_idle_drill_bit", "bag_drill_straight_end_idle", "drill_straight_end_idle_cam"},
        {"drill_straight_fail", "drill_straight_fail_drill_bit", "bag_drill_straight_fail", "drill_straight_fail_cam"},
        {"exit", "exit_drill_bit", "bag_exit", "exit_cam"}
    },
    {}
}

local function LoadDrilling()
    if not HasScaleformMovieLoaded(scaleformDrill) then 
        if approach == 1 then 
            scaleformDrill = RequestScaleformMovie("VAULT_LASER")
            RequestScriptAudioBank("DLC_HEIST3/HEIST_FINALE_LASER_DRILL", false, -1)
            animDict = "anim_heist@hs3f@ig9_vault_drill@laser_drill@"
            drillName = "ch_prop_laserdrill_01a"
        else
            scaleformDrill = RequestScaleformMovie("VAULT_DRILL")
            RequestScriptAudioBank("DLC_MPHEIST/HEIST_FLEECA_DRILL", false, -1)
		    RequestScriptAudioBank("DLC_MPHEIST/HEIST_FLEECA_DRILL_2", false, -1)
            animDict = "anim_heist@hs3f@ig9_vault_drill@drill@"
            drillName = "hei_prop_heist_drill"
        end

        LoadAnim(animDict)
        LoadModel(drillName)

        repeat Wait(10) until HasScaleformMovieLoaded(scaleformDrill)
    end
end

local function EnterPosition(num)
    if not drillAnims[2][1] then 

        drillObj = CreateObject(GetHashKey(drillName), GetEntityCoords(PlayerPedId()), true, false, false)
        bagObj = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), GetEntityCoords(PlayerPedId()), true, false, false)

        for i = 1, #drillAnims[1] do 
            drillAnims[2][i] = NetworkCreateSynchronisedScene(0, 0, 0, 0, 0, 0, 2, true, false, 1065353216, 0, 1.3)
            NetworkAddPedToSynchronisedScene(PlayerPedId(), drillAnims[2][i], animDict, drillAnims[1][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
            NetworkAddEntityToSynchronisedScene(drillObj, drillAnims[2][i], animDict, drillAnims[1][i][2], 1.0, -1.0, 114886080)
            NetworkAddEntityToSynchronisedScene(bagObj, drillAnims[2][i], animDict, drillAnims[1][i][3], 1.0, -1.0, 114886080)
        end

        NetworkStartSynchronisedScene(drillAnims[2][1])

        --AUDIO::PLAY_SOUND_FROM_ENTITY(-1, "laser_power_up", iVar0, "dlc_ch_heist_finale_laser_drill_sounds", true, 20);
        --AUDIO::PLAY_SOUND_FROM_ENTITY(-1, "laser_power_down", iVar0, "dlc_ch_heist_finale_laser_drill_sounds", true, 20);
    end
end

local function SetDrillPos()
    local disc = {0.115, 0.27, 0.425, 0.58, 0.735, 0.89, 1.0}

    if position >= (disc[progress] + 0.07) then
        if approach == 1 then
            PlaySoundFrontend(-1, "laser_pin_break", "dlc_ch_heist_finale_laser_drill_sounds", true)
        else 
            PlaySoundFrontend(-1, "Drill_Pin_Break", "DLC_HEIST_FLEECA_SOUNDSET", true)
        end
        progress = progress + 1
        position = disc[progress]
    else 
        position = position + 0.001
    end

    BeginScaleformMovieMethod(scaleformDrill, "SET_DRILL_POSITION")
    ScaleformMovieMethodAddParamFloat(position)
    EndScaleformMovieMethod()
end

local function SetTempAndSpeed(bool)
    if bool then 
        temp = temp + 0.02
        if speed <= 0.5 then 
            speed = speed + 0.4
        end
    end

    CallScaleformMovieMethodWithNumber(scaleformDrill, "SET_TEMPERATURE", temp, -1.0, -1.0, -1.0, -1,0)
    --CallScaleformMovieMethodWithNumber(scaleformDrill, "SET_SPEED", speed, -1.0, -1.0, -1.0, -1.0)
end

local function SetLaser(bool)
    isDrilling = bool
    
    BeginScaleformMovieMethod(scaleformDrill, "SET_LASER_VISIBLE")
    ScaleformMovieMethodAddParamBool(bool)
    EndScaleformMovieMethod()
    CallScaleformMovieMethodWithNumber(scaleformDrill, "SET_TEMPERATURE", 0.0, -1.0, -1.0, -1.0, -1.0)
end

local function StartKeypress(cb)
    local sId = GetSoundId()
    
    PlaySoundFromEntity(-1, "laser_drill_power_up", drillObj, "dlc_ch_heist_finale_laser_drill_sounds", true, 20)
    
    CreateThread(function()
        CallScaleformMovieMethod(scaleformDrill, "REVEAL")
        CallScaleformMovieMethodWithNumber(scaleformDrill, "SET_DRILL_POSITION", 0.115, -1.0, -1.0, -1.0, -1.0)
        CallScaleformMovieMethodWithNumber(scaleformDrill, "SET_POSITION", 1.0, 0.725, -1.0, -1.0, -1.0)
        CallScaleformMovieMethodWithNumber(scaleformDrill, "SET_SPEED", 0.2, -1.0, -1.0, -1.0, -1.0)
        CallScaleformMovieMethodWithNumber(scaleformDrill, "SET_NUM_DISCS", 6.0, -1.0, -1.0, -1.0, -1.0)
        position = 0.115
        
        while position < 1.0 do
            Wait(0) 
            DrawScaleformMovieFullscreen(scaleformDrill, 255, 255, 255, 255, 0)
        end
        
        Wait(1000)
        SetScaleformMovieAsNoLongerNeeded(scaleformDrill)
        cb(true)
        progress = 1
        position = 0.115
        temp = 0
        speed = 0
        DeleteEntity(drillObj)
    end)
    
    
    CreateThread(function()
        if approach == 1 then 
            PlaySoundFromEntity(sId, "laser_drill", drillObj, "dlc_ch_heist_finale_laser_drill_sounds", true, 0)
            SetVariableOnSound(sId, "DrillHeat", temp)
            SetVariableOnSound(sId, "DrillState", speed)
        else
            PlaySoundFromEntity(sId, "Drill", drillObj, "DLC_HEIST_FLEECA_SOUNDSET", true, 0)
            SetVariableOnSound(sId, "DrillState", 0.0)
        end
        
        while position < 1.0 do 
            Wait(10) 
            if IsControlPressed(0, 38) and temp < 1.0 then 
                SetLaser(true)
                SetDrillPos()
                SetTempAndSpeed(true)
            elseif temp >= 1.0 then 
                local id = GetSoundId()
                if approach == 1 then 
                    PlaySoundFromEntity(id, "laser_overheat", drillObj, "dlc_ch_heist_finale_laser_drill_sounds", true, 20)
                else 
                    PlaySoundFromEntity(id, "Drill_Jam", drillObj, "DLC_HEIST_FLEECA_SOUNDSET", true, 20)
                end
                SetLaser(false)
                repeat Wait(10) SetTempAndSpeed(false) until temp < 0.5
                StopSound(id)
            else
                SetLaser(false)
                SetTempAndSpeed(false)
            end
        end
        StopSound(sId)
        PlaySoundFromEntity(-1, "laser_drill_power_down", drillObj, "dlc_ch_heist_finale_laser_drill_sounds", true, 20)
    end)
    
    
    CreateThread(function()
        while position < 1.0 do 
            Wait(20)
            if temp >= 0 then
                temp = temp - 0.007
                
                if temp < 0 then 
                    temp = 0
                end
            end
            
            if speed >= 0 then 
                speed = speed - 0.1
                
                if speed < 0 then 
                    speed = 0
                end
            end
        end
    end)

    CreateThread(function()
        while position < 1.0 do 
            Wait(200)

            if approach == 1 then 
                SetVariableOnSound(sId, "DrillHeat", temp)
                SetVariableOnSound(sId, "DrillState", speed)
            elseif position < 0.33 then 
                SetVariableOnSound(sId, "DrillState", 0.0)
            elseif position < 0.67 then 
                SetVariableOnSound(sId, "DrillState", 0.5)
            else 
                SetVariableOnSound(sId, "DrillState", 1.0)
                break
            end
        end
    end)
end

function StartDrilling(cb)
    repeat Wait(10) print("tick") until RequestScriptAudioBank("DLC_HEIST3/HEIST_FINALE_LASER_DRILL", false, -1)
    --RequestScriptAudioBank("DLC_MPHEIST/HEIST_FLEECA_DRILL", false, -1)
    --repeat Wait(10) print("tick") until RequestScriptAudioBank("DLC_MPHEIST/HEIST_FLEECA_DRILL_2", false, -1)

    

    LoadDrilling()

    drillObj = CreateObject(GetHashKey(drillName), GetEntityCoords(PlayerPedId()), true, false, false)
    --EnterPosition(num)

    scene = NetworkCreateSynchronisedScene(GetEntityCoords(PlayerPedId()), GetEntityRotation(PlayerPedId()), 2, true, false, 0, 0, 1.3)
    NetworkAddPedToSynchronisedScene(PlayerPedId(), scene, animDict, "drill_straight_idle", 4.0, -4.0, 1033, 0, 1000.0, 0)
    NetworkAddEntityToSynchronisedScene(drillObj, scene, animDict, "drill_straight_idle_drill_bit", 1.0, -1.0, 114886080)

    NetworkStartSynchronisedScene(scene)

    StartKeypress(function(bool) 
        if bool then 
            print("true")
            cb(true)
        end
    end) 
       
end

RegisterCommand("scaleform_max", function()
    StartDrilling(function(bool)
        print(bool)
    end)
end, false)