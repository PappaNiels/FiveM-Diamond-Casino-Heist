local scaleformDrill = 0
local cam = 0
local drillObj = 0
local progress = 1
local temp = 0
local speed = 0
local position = 0
local place = 2
local sparksFx = 0
local laserFx = 0
local bagColour = 0

local isDrilling = false

local animDict = ""
local drillName = ""
local bag = ""

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
            RequestNamedPtfxAsset("scr_ch_finale")
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

        bagColour = GetPedTextureVariation(PlayerPedId(), 5)
        bag = "ch_p_m_bag_var0" .. GetClothingModel(bagColour) .. "_arm_s"

        LoadAnim(animDict)
        LoadModel(drillName)
        LoadModel(bag)

        repeat Wait(10) until HasScaleformMovieLoaded(scaleformDrill)
    end
end

local function UnloadDrilling()
    SetScaleformMovieAsNoLongerNeeded(scaleformDrill)
    RemoveNamedPtfxAsset("scr_ch_finale")
    RemoveAnimDict(animDict)
    SetModelAsNoLongerNeeded(drillName)
    SetModelAsNoLongerNeeded(bag)
    SetModelAsNoLongerNeeded("ch_prop_ch_vaultdoor01x")
    
    if approach == 1 then 
        ReleaseNamedScriptAudioBank("DLC_HEIST3/HEIST_FINALE_LASER_DRILL")
    else 
        ReleaseNamedScriptAudioBank("DLC_MPHEIST/HEIST_FLEECA_DRILL")
        ReleaseNamedScriptAudioBank("DLC_MPHEIST/HEIST_FLEECA_DRILL_2")
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
end

local function SetLaser(bool)
    isDrilling = bool
    
    if approach == 1 then
        StopParticleFxLooped(laserFx, 0)
    end

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
        
        CreateThread(function()
            while position < 0.3 do 
                Wait(GetFrameTime())
                HelpMsg("Press ~INPUT_CONTEXT~ to drill the vault door")
            end
        end)

        while position < 1.0 do
            Wait(GetFrameTime()) 
            DrawScaleformMovieFullscreen(scaleformDrill, 255, 255, 255, 255, 0)
            DisableControlAction(0, 27, true)
            DisableControlAction(0, 1, true)
        end
        
        Wait(1000)
        PlaySoundFromEntity(-1, "laser_drill_power_down", drillObj, "dlc_ch_heist_finale_laser_drill_sounds", true, 20)
        UnloadDrilling()
        if approach == 1 then 
            StopParticleFxLooped(laserFx, false)
        end 

        StopParticleFxLooped(sparksFx, false)
        cb(true)
        progress = 1
        position = 0.115
        temp = 0
        speed = 0
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
                
                NetworkStartSynchronisedScene(drillAnims[2][6])
                SetLaser(false)
                repeat Wait(10) SetTempAndSpeed(false) until temp < 0.5
                StartParticleFxLoopedOnEntity("scr_ch_finale_laser", drillObj, -0.00375, -0.3, 0.015, 0.0, 0.0, -90.0, 1.0, false, false, false)
                StopSound(id)
            else
                SetLaser(false)
                SetTempAndSpeed(false)
            end
            
            SetParticleFxLoopedEvolution(sparksFx, "power", temp, false)
        end
        StopSound(sId)
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
            elseif position > 0.67 then
                NetworkStartSynchronisedScene(drillAnims[2][4])
            else 
                SetVariableOnSound(sId, "DrillState", 1.0)
                break
            end
        end
    end)
end

function StartDrilling(k)
    LoadModel("ch_prop_ch_vaultdoor01x")
    LoadDrilling()

    isBusy = true
    drillObj = CreateObject(GetHashKey(drillName), GetEntityCoords(PlayerPedId()), true, false, false)
    bagObj = CreateObject(GetHashKey("ch_p_m_bag_var0" .. GetClothingModel(bagColour) .. "_arm_s"), GetEntityCoords(PlayerPedId()), true, false, false)
    cam = CreateCam("DEFAULT_ANIMATED_CAMERA", true)
    SetPedComponentVariation(PlayerPedId(), 5, 0, 0, 0)

    if approach == 1 then 
        syncPos = vaultDrillPos[k] + vector3(-0.1, 0.0, 0.0)
    else 
        syncPos = vaultDrillPos[k]
    end

    for i = 1, #drillAnims[1] do 
        if i == 2 or i == 3 or i == 4 or i == 5 then 
            drillAnims[2][i] = NetworkCreateSynchronisedScene(syncPos, GetEntityRotation(vaultObjs[2]) + vector3(0.0, 0.0, 180.0), 2, false, true, 0, 0.0, 1.0)
            NetworkAddPedToSynchronisedScene(PlayerPedId(), drillAnims[2][i], animDict, drillAnims[1][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
            NetworkAddEntityToSynchronisedScene(drillObj, drillAnims[2][i], animDict, drillAnims[1][i][2], 1.0, -1.0, 114886080)
            NetworkAddEntityToSynchronisedScene(bagObj, drillAnims[2][i], animDict, drillAnims[1][i][3], 1.0, -1.0, 114886080)
        else
            drillAnims[2][i] = NetworkCreateSynchronisedScene(syncPos, GetEntityRotation(vaultObjs[2]) + vector3(0.0, 0.0, 180.0), 2, true, false, 0, 0.0, 1.0)
            NetworkAddPedToSynchronisedScene(PlayerPedId(), drillAnims[2][i], animDict, drillAnims[1][i][1], 4.0, -1.5, 13, 16, 1000.0, 0)
            NetworkAddEntityToSynchronisedScene(drillObj, drillAnims[2][i], animDict, drillAnims[1][i][2], 1000.0, -1000.0, 0)
            NetworkAddEntityToSynchronisedScene(bagObj, drillAnims[2][i], animDict, drillAnims[1][i][3], 1000.0, -1000.0, 0)
        end    
    end
    
    if approach == 1 then 
        PlaySoundFromEntity(-1, "laser_power_up", drillObj, "dlc_ch_heist_finale_laser_drill_sounds", true, 20)
    end
       
    RenderScriptCams(true, false, 0, true, false)

    PlayCamAnim(cam, drillAnims[1][1][4], animDict, syncPos, GetEntityRotation(vaultObjs[2]) + vector3(0.0, 0.0, 180.0), false, 2)
    NetworkStartSynchronisedScene(drillAnims[2][1])
    Wait(GetAnimDuration(animDict, "intro") * 1000)
    
    if approach == 1 then 
        UseParticleFxAsset("scr_ch_finale")
        laserFx = StartParticleFxLoopedOnEntity("scr_ch_finale_laser", drillObj, -0.00375, -0.3, 0.015, 0.0, 0.0, -90.0, 1.0, false, false, false)
    end
    
    local coords = vector3(vaultDrillPos[k].x - 0.02, GetEntityCoords(drillObj).y + 0.0125, vaultDrillPos[k].z + 0.011)
    local rot = vector3(0.0, 90.0, 90.0)
    UseParticleFxAsset("scr_ch_finale")
    sparksFx = StartParticleFxLoopedAtCoord("scr_ch_finale_laser_sparks", coords, rot, 1.0, false, false, false, true)
    SetParticleFxLoopedEvolution(sparks, "power", 0.0, false)
    
    PlayCamAnim(cam, drillAnims[1][2][4], animDict, syncPos, GetEntityRotation(vaultObjs[2]) + vector3(0.0, 0.0, 180.0), false, 2)
    NetworkStartSynchronisedScene(drillAnims[2][2])
    
    StartKeypress(function(bool) 
        if bool then 
            local v = 0
            
            PlayCamAnim(cam, drillAnims[1][7][4], animDict, syncPos, GetEntityRotation(vaultObjs[2]) + vector3(0.0, 0.0, 180.0), false, 2)
            NetworkStartSynchronisedScene(drillAnims[2][7])
            RenderScriptCams(false, true, 2000, true, false)
            DestroyCam(cam)

            if k == 1 then 
                v = 2
            else 
                v = 3
            end

            TriggerServerEvent("sv:casinoheist:syncVault", k, v)
            Wait(3000)

            DeleteEntity(drillObj)
            DeleteEntity(bagObj)
            SetPedComponentVariation(PlayerPedId(), 5, 82, bagColour, 0)

            isBusy = false
        end
    end)
end