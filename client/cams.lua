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
            RemoveBlip(blips[i][j])
        end
    end
end

local function GetRoom()
    if isInStaff then 
        return 1
    elseif isInSecurity then 
        return 2
    end
    return 2
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
    
    local obj = {{}, {}}
    
    for i = 1, 2 do 
        for j = 1, #camPlace[i] do 
            if i == 1 then 
                obj[1][j] = CreateObject(GetHashKey(camModels[1]), camPlace[1][j].xyz, false, false, false)
                SetEntityHeading(obj[1][j], camPlace[1][j].w)
                cams[1][j] = CreateObject(GetHashKey(camModels[2]), camPlace[1][j].xyz - (GetEntityOffset(obj[1][j], false) * 0.37) + vector3(0.0, 0.0, 0.05), false, false, false)
            else
                cams[2][j] = CreateObject(GetHashKey(camModels[3]), camPlace[2][j].xyz, false, false, false)
            end
            
            SetEntityHeading(cams[i][j], camRot[i][j][1])
        end
        --SetEntityHeading(obj[2], 100.0)
        --N_0x9097eb6d4bb9a12a(PlayerId(), obj[i])
        --SetObjectTargettable(obj, true)
    end
    
    for i = 1, 3 do 
        SetModelAsNoLongerNeeded(camModels[i])
    end
    
    AddBlipsForSelectedRoom(2)
    --for i = 1, 2 do 
    --    for j = 1, #camPlace[i] do 
    --        CreateThread(function()
    --            test(i, j)
    --        end)
    --    end
    --end
end

local function CheckCamVision(i, j)
    local coords = GetEntityCoords(cams[i][j])
    if HasEntityClearLosToEntity(cams[i][j], PlayerPedId(), 17) and IsEntityInAngledArea(PlayerPedId(), coords, Helper(GetEntityForwardVector(cams[i][j])) + coords - vector3(0.0, 0.0, 5.0), 3.0, true, true, 0) then 
        print("seen", j)
    end
end

local function CamLoop(i, j)
    local delta = (camRot[i][j][2] - camRot[i][j][1]) / 300
    
    if delta < 0 then delta = -0.33 else delta = 0.33 end
    
    --ApplyForceToEntity(cams[i][j], 3, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0, false, false, false, false, true)
    --ApplyForceToEntity(cams[i][j], 3, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1, false, false, false, false, true)
    --ApplyForceToEntity(cams[i][j], 3, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 2, false, false, false, false, true)
    repeat
        SetEntityHeading(cams[i][j], GetEntityHeading(cams[i][j]) + delta)

        SetBlipSquaredRotation(blips[i][j], GetEntityHeading(cams[i][j]))
        N_0xf83d0febe75e62c9(blips[i][j], -1.0, 1.0, 0.36, 1.0, 8.2, ((GetEntityHeading(cams[i][j]) + 180.00) * 0.017453292), 1, 6)
        Wait(10)
    until math.ceil(GetEntityHeading(cams[i][j])) == camRot[i][j][2] or math.ceil(GetEntityHeading(cams[i][j])) == camRot[i][j][2] - 360
    
    Wait(5000)
    
    repeat
        SetEntityHeading(cams[i][j], GetEntityHeading(cams[i][j]) - delta)
        
        SetBlipSquaredRotation(blips[i][j], GetEntityHeading(cams[i][j]))
        N_0xf83d0febe75e62c9(blips[i][j], -1.0, 1.0, 0.36, 1.0, 8.2, ((GetEntityHeading(cams[i][j]) + 180.00) * 0.017453292), 1, 6)
        Wait(10)
    until math.ceil(GetEntityHeading(cams[i][j])) == camRot[i][j][1] or math.ceil(GetEntityHeading(cams[i][j])) == camRot[i][j][1] - 360

    Wait(math.random(1000, 3000))
end

function AddBlipsForSelectedRoom(room)
    RemoveAllBlips()

    if not DoesEntityExist(cams[1][1]) then 
        if player == 1 then 
            SpawnCams()
        else
            GetCamEntities()
        end
    end

    if approach == 3 then return end

    if room == 2 and false then 
        isInSecurity = true 
        isInStaff = false 
    elseif false then 
        isInSecurity = false 
        isInStaff = true 
    end

    for i = 1, #rooms[room] do 
        local one = rooms[room][i][1]
        local two = rooms[room][i][2]
        local fvec = -GetEntityForwardVector(cams[one][two])
        local te = Atan2(fvec.x, -fvec.y)

        blips[one][two] = AddBlipForEntity(cams[one][two])
        SetBlipSprite(blips[one][two], 604)
        SetBlipScale(blips[one][two], 1.0)
        SetBlipColour(blips[one][two], GetColour(room, i))
        print("tick")
        SetBlipNameFromTextFile(blips[one][two], "CSH_BLIP_CCTV")
        ShowHeightOnBlip(blips[one][two], false)
        SetBlipAsShortRange(blips[one][two], true)
        SetBlipPriority(blips[one][two], 12)
        SetBlipSquaredRotation(blips[one][two], te)
        
        N_0xf83d0febe75e62c9(blips[one][two], -1.0, 1.0, 0.36, 1.0, 8.2, ((te + 180.00) * 0.017453292), 1, 6)
        SetBlipShowCone(blips[one][two], true, 6)

        CreateThread(function()
            while GetRoom() == room and not IsEntityDead(cams[one][two]) do 
                CamLoop(one, two)
                Wait(1000)
            end


            N_0x35a3cd97b2c0a6d2(blips[one][two])
            RemoveBlip(blips[one][two])
        end)
        CreateThread(function()
            while GetRoom() == room and not IsEntityDead(cams[one][two]) and alarmTriggered == 0 do 
                Wait(100)
                CheckCamVision(one, two)
            end
        end)

        Wait(math.random(100, 1000))
    end
end

AddEventHandler("onResourceStop", function(rs)
    if res ~= GetCurrentResourceName() then return end 

    for i = 1, 2 do 
        for j = 1, #camPlace[i] do 
            DeleteEntity(cams[i][j])
        end
    end

end)

AddEventHandler("onResourceStart", function(rs)
    if rs ~= "Diamond-Casino-Heist" then return end 
    print(vector3(1.0, 1.0, 1.0) * 3)
    SpawnCams()
    --SetFacilityObjects(1)
    --Scale()
end)

