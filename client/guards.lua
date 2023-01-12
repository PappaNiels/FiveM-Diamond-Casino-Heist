local isInSecurity = true
local guards = {
    {   -- Security Lobby 
        {  
            "s_m_m_highsec_03", -- Suit
            ["coords"] = {
                vector4(2488.01, -274.31, -70.69, 0.0),
                vector4(2480.99, -273.13, -70.69, 0.0)
            },

            ["tick"] = 2
        },
        {
            "s_m_m_highsec_03", -- Suit
            ["coords"] = {
                vector4(2467.97, -267.99, -70.69, 0.0),
                vector4(2472.53, -270.24, -70.69, 0.0)
            },

            ["tick"] = 2
        },
        {
            "s_m_y_westsec_02", -- Work
            ["coords"] = {
                vector4(2477.85, -270.57, -70.69, 0.0),
                vector4(2524.24, -281.16, -70.69, 0.0),
                vector4(2477.79, -279.78, -70.69, 0.0)
            },

            ["tick"] = 2
        },
        {
            "s_m_y_westsec_02", -- Work
            ["coords"] = {
                vector4(2491.72, -276.4, -70.69, 0.0),
                vector4(2524.24, -281.16, -70.69, 0.0),
                vector4(2477.79, -279.78, -70.69, 0.0)
            },

            ["tick"] = 2
        },
        {
            "s_m_y_westsec_02", -- Work
            ["coords"] = {
                vector4(2491.9, -262.01, -70.69, 145.0)
            },

            ["anim"] = {
                
            }
        }
    }

    --"s_m_m_highsec_03",
    --"s_m_y_westsec_02"
}

local blips = {}
local activeGuards = {}
local aiBlips = {}

local function SpawnPed()
    LoadModel(guards[1][1][1])
    LoadModel(guards[1][3][1])

    for i = 1, 1 do 
        activeGuards[i] = CreatePed(1, GetHashKey(guards[1][i][1]), guards[1][i]["coords"][1], false --[[test]], false)
        --blips[i] = AddBlipForEntity(activeGuards[i])
        --SetBlipScale(blips[i], 0.75)
        --SetBlipSprite(blips[i], 270)
        --SetBlipColour(blips[i], 1)
        --SetBlipPriority(blips[i], 7)
        --N_0xf83d0febe75e62c9(blips[i], -1.0, 1.0, 0.36, 1.0, 8.2, (250.0 * 0.017453292), 1, 11)
        --SetBlipShowCone(blips[i], true, 11)


        SetPedHasAiBlipWithColor(activeGuards[i], true, 1) -- SetPedHasAiBlip()
        --SetPedAiBlipGangId(activeGuards[i], 1)
        --SetPedAiBlipNoticeRange(activeGuards[i], 10.0)
        --SetPedAiBlipSprite(activeGuards[i], 270) -- 
        SetPedAiBlipForcedOn(activeGuards[i], true)
        SetPedAiBlipHasCone(activeGuards[i], true)
        blips[i] = GetAiBlip_2(activeGuards[i])

        repeat Wait(10) print("tick") until DoesBlipExist(blips[i]) 


        --
        --if DoesPedHaveAiBlip(activeGuards[i]) then 
        --    blips[i] = N_0x7cd934010e115c2c(activeGuards[i]) -- HUD::GET_AI_PED_PED_BLIP_INDEX
        --    blips[i + 1] = GetAiBlip(activeGuards[i]) --
        --    blips[i + 2] = GetAiBlip_2(activeGuards[i]) --
        --    print(GetBlipFromEntity(activeGuards[i]))
        --    blips[4] = N_0x56176892826a4fe8(activeGuards[i])
        --    print(DoesBlipExist(blips[i]), DoesBlipExist(blips[i + 1]), DoesBlipExist(blips[i + 2]), blips[4])
        --    SetBlipNameFromTextFile(blips[i], "SMBLIP_ENEMY")
        --end
        
        print(DoesBlipExist(blips[i]), blips[i])

        --SetPedVisualFieldMaxAngle(activeGuards[i], 60.0)
        --SetPedVisualFieldMinAngle(activeGuards[i], -60.0)

        --SetPedHasAiBlipWithColor(guard, true, 1)
--
        --if DoesPedHaveAiBlip(guard) then 
        --    blips1 = N_0x7cd934010e115c2c(guard) -- HUD::GET_AI_PED_PED_BLIP_INDEX
        --    blips2 = GetAiBlip(guard) 
        --    blips3 = GetAiBlip_2(guard) 
        --    blips4 = GetAiPedPedBlipIndex(guard)
--
        --    print(DoesBlipExist(blips1), DoesBlipExist(blips2), DoesBlipExist(blips3))
        --end
        
        SetBlipNameFromTextFile(blips[i], "SMBLIP_ENEMY")
        --SetBlipAsShortRange(blips[i], true)
        --SetBlipPriority(blips[i], 12)
        --SetBlipSquaredRotation(blips[i], 70.0)


        --SetBlipShowCone(blips[i], true)


    end 

    --[[ gxt camera "CSH_BLIP_CCTV" scale = 1.0
         SetBlipAsShortRange(blips[i], true)
        SetBlipPriority(blips[i], 12)
        SetBlipSquaredRotation(blips[i], 70.0)

        N_0xf83d0febe75e62c9(blips[i], -1.0, 1.0, 0.36, 1.0, 8.2, 250.0 * 0.017453292, 1, 11)
    ]]

    --[[
        PED::SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(bParam0->f_9, false);
		func_1160(bParam0->f_9, bParam0->f_8, 1);
		PED::SET_PED_VISUAL_FIELD_MIN_ELEVATION_ANGLE(bParam0->f_9, -75f);
		PED::SET_PED_VISUAL_FIELD_MAX_ELEVATION_ANGLE(bParam0->f_9, 60f);
		PED::SET_PED_HEARING_RANGE(bParam0->f_9, 60f);

    ]]
end

function StartNav(num) 
    --num = 1 
    SpawnPed()
    --StartWalking()
end

function StartWalking()
    for i = 1, 4 do 
        CreateThread(function()
            local j = i

            while not IsPedDeadOrDying(activeGuards[j]) and isInSecurity do
                TaskFollowNavMeshToCoord(activeGuards[j], guards[1][j]["coords"][guards[1][j]["tick"]].xyz, 1.0, -1, 1.0, true, 2.0)

                repeat Wait(1000) until not IsPedWalking(activeGuards[j])

                if guards[1][j]["tick"] == #guards[1][j]["coords"] then 
                    guards[1][j]["tick"] = 1 
                else
                    guards[1][j]["tick"] = guards[1][j]["tick"] + 1
                end

                Wait(2000)
            end
        end)
    end
end

function AddGuardsForSelectedRoom(room)

end

RegisterCommand("test_nav", function()
    StartNav(1)
end, false)