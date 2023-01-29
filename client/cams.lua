local currentRoom = 0
local sId = 0

local seen = {0, 0, 0, 0}

local camPlace = {
    {   -- Big Cams
        vector4(2501.200, -279.2152, -69.42602, 90.0),
        vector4(2506.87181, -279.2152, -66.25569, 90.0),

        vector4(2515.37964, -273.2429, -57.4545764, 0.0),
        vector4(2501.84839, -263.377228, -55.53636, 90.0)
    },

    {   -- Small cam
        vector4(2544.31177, -284.4564, -57.09241364, 270.0),

        vector4(2484.30957, -282.1182, -68.55002, 90.0),
        vector4(2484.30957, -268.790466, -68.55002, 90.0)
    }
}

local camRot = {
    {
        {
            40.0,
            140.0
        },
        {
            110.0,
            70.0
        },
        {
            290.0,
            70.0,
        },
        {
            120.0,
            60.0
        }
    },
    {
        {
            200.0,
            330.0
        },
        {
            90.0,
            270.0,
        },
        {
            270.0,
            90.0,
        },
    }
}

local camModels = {
    "ch_prop_ch_cctv_wall_atta_01a",
    "ch_prop_ch_cctv_cam_02a", 
    "xm_prop_x17_server_farm_cctv_01"
}

local rooms = {
    {
        {1, 3},
        {1, 4},
        {2, 1},
    },
    {
        {1, 1},
        {1, 2},
        {2, 2},
        {2, 3}
    }
}

local obj = {}

local cams = {
    {},
    {}
}

local blips = {{}, {}}

local function Helper(vec)
    local var = Vmag(vec)

    if var ~= 0.0 then 
        return vec * (-8.2 / var)
    end
end

local function RemoveAllBlips()
    N_0x8410c5e0cd847b9d()

    for i = 1, 2 do 
        for j = 1, #blips[i] do 
            SetBlipShowCone(blips[i][j], false, 11)
            N_0x35a3cd97b2c0a6d2(blips[i][j])
            RemoveBlip(blips[i][j])
        end
    end
end

local function GetColour(i, j)
    if (approach == 2 and ((i == 1 and j == 4) or (i == 2 and j == 1))) or selectedEntryDisguise == 3 then 
        return 0
    else
        return 1 
    end 
end

local function GetCamEntities()
    for i = 1, 2 do 
        for j = 1, #camPlace[i] do 
            if i == 1 then 
                cams[1][j] = GetClosestObjectOfType(camPlace[1][j].xyz, 2.0, GetHashKey(camModels[2]), false, false, false)
            else 
                cams[2][j] = GetClosestObjectOfType(camPlace[2][j].xyz, 1.0, GetHashKey(camModels[3]), false, false, false)
            end
        end
    end
end

local function SpawnCams()
    for i = 1 , 3 do 
        LoadModel(camModels[i])
    end
    
    for i = 1, 2 do 
        for j = 1, #camPlace[i] do 
            if i == 1 then 
                obj[j] = CreateObject(GetHashKey(camModels[1]), camPlace[1][j].xyz, true, false, false)
                SetEntityHeading(obj[j], camPlace[1][j].w)
                cams[1][j] = CreateObject(GetHashKey(camModels[2]), camPlace[1][j].xyz - (GetEntityOffset(obj[j], false) * 0.37) + vector3(0.0, 0.0, 0.05), true, false, false)
            else
                cams[2][j] = CreateObject(GetHashKey(camModels[3]), camPlace[2][j].xyz, true, false, false)
            end
            
            SetEntityHeading(cams[i][j], camRot[i][j][1])
        end
    end
    
    for i = 1, 3 do 
        SetModelAsNoLongerNeeded(camModels[i])
    end
    
    --SetRoom(1)
end

local function CheckCamVision(i, j)
    local coords = GetEntityCoords(cams[i][j])
    if GetBlipColour(blips[i][j]) == 1 and HasEntityClearLosToEntity(cams[i][j], PlayerPedId(), 17) and IsEntityInAngledArea(PlayerPedId(), coords, Helper(GetEntityForwardVector(cams[i][j])) + coords - vector3(0.0, 0.0, 5.0), 3.0, true, true, 0) then 
        print("seen", j, seen[j])

        if HasSoundFinished(sId) then 
            sId = GetSoundId()
            PlaySoundFromEntity(sId, "CCTV_Alarm", cams[i][j], "dlc_vw_casino_finale_sounds", true, 0)
        end

        seen[j] = seen[j] + 1
        if seen[j] > 6 then 
            TriggerServerEvent("sv:casinoheist:alarm")
            print("Alarm!")
            seen[j] = 0
            Wait(1000)
            StopSound(sId)
            ReleaseSoundId(sId)
        end
    elseif seen[j] ~= 0 then 
        StopSound(sId)
        ReleaseSoundId(sId)
        sId = 0
        seen[j] = 0
    end
end

local function BlipLoop(i, j)
    SetBlipSquaredRotation(blips[i][j], GetEntityHeading(cams[i][j]))
    Citizen.InvokeNative(0xf83d0febe75e62c9, blips[i][j], -1.0, 1.0, 0.36, 1.0, 8.2, ((GetEntityHeading(cams[i][j]) + 180.00) * 0.017453292), 0, 11)
end

local function CamLoop(i, j)
    local delta = (camRot[i][j][2] - camRot[i][j][1]) / 300
    
    if delta < 0 then delta = -0.33 else delta = 0.33 end
    if i == 1 and j == 3 then delta = delta * -1 end
    
    repeat
        SetEntityHeading(cams[i][j], GetEntityHeading(cams[i][j]) + delta)

        BlipLoop(i, j)
        Wait(10)
    until math.ceil(GetEntityHeading(cams[i][j])) == camRot[i][j][2] or math.ceil(GetEntityHeading(cams[i][j])) == camRot[i][j][2] - 360
    
    Wait(5000)
    
    repeat
        SetEntityHeading(cams[i][j], GetEntityHeading(cams[i][j]) - delta)
        
        BlipLoop(i, j)
        Wait(10)
    until math.ceil(GetEntityHeading(cams[i][j])) == camRot[i][j][1] or math.ceil(GetEntityHeading(cams[i][j])) == camRot[i][j][1] - 360

    Wait(math.random(1000, 3000))
end

function GetRoom()
    return currentRoom
end

function GetCamBlipColour()
    --return 1
    return GetBlipColour(blips[1][3]) 
end

function AddBlipsForSelectedRoom(room)
    RemoveAllBlips()

    seen = {0, 0, 0, 0}
    RequestScriptAudioBank("DLC_VINEWOOD/VW_CASINO_FINALE", false, -1)

    currentRoom = room

    if not DoesEntityExist(cams[1][1]) then 
        if player == 1 then 
            SpawnCams()
        else
            Wait(100)
            GetCamEntities()
        end
    end

    print("test cams")

    if approach == 3 or alarmTriggered == 1 then return end

    for i = 1, #rooms[room] do 
        if not HasObjectBeenBroken(cams[rooms[room][i][1]][rooms[room][i][2]]) then 
            local one = rooms[room][i][1]
            local two = rooms[room][i][2]
            local heading = GetEntityHeading(cams[one][two])

            blips[one][two] = AddBlipForEntity(cams[one][two])
            SetBlipSprite(blips[one][two], 604)
            SetBlipScale(blips[one][two], 1.0)
            SetBlipColour(blips[one][two], GetColour(one, two))
            SetBlipNameFromTextFile(blips[one][two], "CSH_BLIP_CCTV")
            ShowHeightOnBlip(blips[one][two], false)
            SetBlipAsShortRange(blips[one][two], true)
            SetBlipPriority(blips[one][two], 12)
            SetBlipSquaredRotation(blips[one][two], heading)
            
            Citizen.InvokeNative(0xf83d0febe75e62c9, blips[one][two], -1.0, 1.0, 0.36, 1.0, 8.2, ((heading + 180.00) * 0.017453292), 0, 11)
            SetBlipShowCone(blips[one][two], true, 11)

            if player == 1 then 
                CreateThread(function()
                    while currentRoom == room and not IsEntityDead(cams[one][two]) do 
                        Wait(1000)

                        CamLoop(one, two)
                    end

                    N_0x35a3cd97b2c0a6d2(blips[one][two])
                    RemoveBlip(blips[one][two])
                end)
            else 
                CreateThread(function()
                    while currentRoom == room and not IsEntityDead(cams[one][two]) do 
                        Wait(0)
                    
                        BlipLoop(one, two)
                    end

                    N_0x35a3cd97b2c0a6d2(blips[one][two])
                    RemoveBlip(blips[one][two])
                end)
            end 

            CreateThread(function()
                while currentRoom == room and not HasObjectBeenBroken(cams[one][two]) and alarmTriggered == 0 do 
                    Wait(100)

                    CheckCamVision(one, two)
                end

            end)

            Wait(math.random(100, 1000))
        end
    end
end

function SetCamColour(colour)
    for i = 1, 2 do 
        for j = 1, #blips[i] do 
            SetBlipColour(blips[i][j], colour)
        end
    end
end

function StopCams()
    currentRoom = 0
end

function RemoveCams()
    for i = 1, #obj do 
        DeleteEntity(obj[i])
    end

    RemoveAllBlips()

    for i = 1, 2 do 
        for j = 1, #cams[i] do 
            DeleteEntity(cams[i][j])
        end
    end
end

-- Remove
AddEventHandler("onResourceStop", function(rs)
    if rs ~= GetCurrentResourceName() then return end 

    DisableAlarm()

    for i = 1, 2 do 
        for j = 1, #camPlace[i] do 
            DeleteEntity(cams[i][j])
        end
    end

    exports.spawnmanager:setAutoSpawn(true)

end)

AddEventHandler("onResourceStart", function(rs)
    if rs ~= "Diamond-Casino-Heist" then return end 
    
    --TriggerAlarm()
    
    --SpawnCams()

    --PrepareMusicEvent("CH_IDLE")
    --TriggerMusicEvent("CH_IDLE")

    --if PlayerId() == GetPlayerFromServerId(1) then 
    --    player = 1 
    --end
--
    --AddBlipsForSelectedRoom(1)
    --SetFacilityObjects(1)
    --Scale()
end)