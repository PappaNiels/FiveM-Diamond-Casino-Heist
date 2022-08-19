local camCoords = {
    vector3(2712.87, -372.6, -54.23),
    vector3(2709.8, -369.5, -54.23), 
    vector3(2712.95, -366.3, -54.23)
}

local boardCoords = {
    vector3(2713.3, -366.2, -54.23418),
    vector3(2716.27, -369.93, -54.23418),
    vector3(2712.58, -372.65, -54.23418)
}

local camHeading = {0.0, 270.0, 180.0}

local boardCam = 0
local boardUsing = 0
local setupRow  = 3
local setupLine = 1
local prepRow = 1
local prepLine = 1
local finalRow = 1
local finalLine = 1
local boards = 1

local setupLists = false
local prepLists = false
local finalLists = false
local camIsUsed = false
local isInGarage = false  
local doorOpen = false
local isInBuilding = false
local entryIsAvailable = false

local boardType = {
    RequestScaleformMovie("CASINO_HEIST_BOARD_SETUP"),
    RequestScaleformMovie("CASINO_HEIST_BOARD_PREP"),
    RequestScaleformMovie("CASINO_HEIST_BOARD_FINALE")
}

local todoList = {
    [1] = {
        {"Scope Out Casino", true},
        {"Scope Out Vault Contents", false},
        {"Select Approach", false}
    },
    [2] = {
        [1] = { -- Silent and Sneaky
            {"Unmarked Weapons", false},
            {"Getaway Vehicles", false},
            {"Hacking Device", false},
            {"Vault Keycards", false},
            {"Nano Drone", false},
            {"Vault Laser", false}
        },
        [2] = { -- The Big Con
            {"Unmarked Weapons", false},
            {"Getaway Vehicles", false},
            {"Hacking Device", false},
            {"Vault Keycards", false},
            {"Entry Disguise", false},
            {"Vault Drills", false}
        },
        [3] = { -- Aggressive
            {"Unmarked Weapons", false},
            {"Getaway Vehicles", false},
            {"Hacking Device", false},
            {"Vault Keycards", false},
            {"Thermal Charges", false},
            {"Vault Explosives", false}
        }
    },
    [3] = {
        {"Entry Disquise", false},
        {"Exit", false},
        {"Buyer", false},
        {"Player Cuts", true}
    }
}

local optionalList = {
    [1] = {    
        {"Scope All P.O.I", false},
        {"Scope All Access Points", false},
        {"Purchase Casino Model", false},
        {"Purchase Security Keypad", false},
        {"Purchase Vault Door", false}
    },
    [2] = {
        [1] = { -- Silent and Sneaky
            {"Patrol Routes", false},
            {"Duggan Shipments", false},
            {"Security Intel", false},
            {"Power Drills", false},
            {"Security Passes", false},
            {"Acquire Masks", false},
            {"Steal EMP", false},
            {"Infiltration Suits", false}
        },
        [2] = { -- The Big Con
            {"Patrol Routes", false},
            {"Duggan Shipments", false},
            {"Security Intel", false}, 
            {"Power Drills", false}, 
            {"Security Passes", false}, 
            {"Acquire Masks", false},
            {"Exit Disguise", false}
        },
        [3] = { -- Aggressive
            {"Patrol Routes", false},
            {"Duggan Shipments", false},
            {"Security Intel", false},
            {"Power Drills", false},
            {"Security Passes", false},
            {"Acquire Masks", false},
            {"Reinforced Armor", false},
            {"Boring Machine", false}
        }
    },
    [3] = {
        {"Decoy Gunman", false},
        {"Clean Vehicle", false},
        {"Exit Disguise", false}
    }
}

local approachSpecificPreps = {
    [1] = {
        {14, 5, "NANO DRONE", false, true},
        {15, 7, "VAULT LASER", false, true},
        {16, 6, "EMP DEVICE", false, false},
        {17, 8, "INFILTRATION SUITS", false, false}
    },
    [2] = {
        {14, 13, "BUGSTARS GEAR", false, true, "ENRTY DISGUISE"},
        {15, 12, "VAULT DRILLS", false, true},
        {16, 0, "", false, false},
        {17, 16, "FIREFIGHTER GEAR", false, false, "EXIT DISGUISE"},
    },
    [3] = {
        {14, 3, "THERMAL CHARGES", false, true},
        {15, 4, "VAULT EXPLOSIVES", false, true},
        {16, 1, "REINFORCED ARMOR", false, false},
        {17, 2, "BORING MACHINE", false, false},
    },
}

local lockList = {
    false,
    false,
    false
}

local extremeList = {
    false, 
    false, 
    false
}

local lootString = {
    "CASH",
    "GOLD",
    "ARTWORK",
    "DIAMONDS"
}

local approachString = {
    "SILENT & SNEAKY",
    "THE BIG CON",
    "AGGRESSIVE"
}

local entranceString = {
    [1] = {
        "ENTRANCE",
        "STAFF LOBBY",
        "WASTE DISPOSAL",
        "S.E. ROOF TERRACE",
        "S.W. ROOF TERRACE",
        "N.E. ROOF TERRACE",
        "N.W. ROOF TERRACE",
        "SOUTH HELIPAD",
        "NORTH HELIPAD"
    },
    [2] = {
        [11] = "STAFF LOBBY",
        [1] = "WASTE DISPOSAL",
        [2] = "MAIN ENTRANCE",
        [6] = "SECURITY TUNNEL"
    },
    [3] = {
        
    }
}

local exitString = {
    [1] = {
        "EXIT",
        "STAFF LOBBY",
        "WASTE DISPOSAL",
        "N.E. ROOF TERRACE",
        "N.W. ROOF TERRACE",
        "S.E. ROOF TERRACE",
        "S.W. ROOF TERRACE",
        "SOUTH HELIPAD",
        "NORTH HELIPAD"
    },
    [2] = {
        "EXIT",
        "STAFF LOBBY",
        "WASTE DISPOSAL",
        "N.E. ROOF TERRACE",
        "N.W. ROOF TERRACE",
        "S.E. ROOF TERRACE",
        "S.W. ROOF TERRACE",
        "SOUTH HELIPAD",
        "NORTH HELIPAD"
    },
    [3] = {
        
    }
}

local buyerString = {
    "BUYER",
    "LOW LEVEL",
    "MID LEVEL",
    "HIGH LEVEL"
}

local entryDisguiseString = {
    "ENTRY DISGUISE",
    "BUGSTARS",
    "MAINTENANCE",
    "GRUPPE SECHS",
    "YUNG ANCESTOR"
}

local exitDisguiseString = {
    "EXIT DISGUISE",
    "FIRE FIGHTER",
    "NOOSE",
    "HIGH ROLLER"
} 

local boardString = {
    "Setup Board",
    "Prep Board",
    "Finale Board"
}

local canZoomIn = {
    [1] = {
        false, 
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false, 
        true, 
        true, 
        true, 
        true, 
        true,
        true
    },
    [2] = {
        false, 
        false, 
        false,
        false,
        true, 
        true,
        false,
        false,
        false,
        true, 
        true, 
        true, 
        true,
        true,
        false,
        false,
        false,
        false
    },
    [3] = {
        false, 
        true,
        true,
        true,
        true,
        false, 
        false, 
        true,
        true,
        true,
        true,
        false,
        true,
        true        
    }
}

local arrowsVisible = {
    [1] = {
        false,
        true,
        false,
        true,
        false,
        true
    },
    [2] = {},
    [3] = {}
}

local missions = {
    {5, 1, "Guns"},
    {6, 1, "Getaway Vehicle"},
    {7, 1, "Hacking Device"},
}

local images = {
    [1] = {    
        {true, 3, 3},
        {true, 4, 2},
        {false, 8, 1},
        {true, 11, 2}, 
        {true, 12, 1}, 
        {true, 13, 7}, 
        {true, 14, 3}, 
        {true, 15, 6}, 
        {true, 16, 4}  
    }, 
    [2] = {},
    [3] = {}
}

local imageOrder = {
    [2] = {
        [1] = {
            [10] = {1, 3, 5, 2, 4},
            [11] = {1, 4, 2, 3, 5},
            [12] = {1, 3, 2, 5, 4}
        },
        [2] = {
            [10] = {1, 3, 5, 2, 4},
            [11] = {1, 4, 2, 3, 5},
            [12] = {1, 3, 2, 5, 4}
        },
        [3] = {
            [10] = {1, 3, 5, 2, 4},
            [11] = {1, 4, 2, 3, 5},
            [12] = {1, 3, 2, 5, 4}
        }
    },
    [3] = {
        [1] = {
            [2] = {11, 1, 3},
            [3] = {11, 1, 3, 5, 8, 10, 9, 4},
            [4] = {1, 2, 3}
        },
        [2] = {
            [2] = {},
            [3] = {11, 1, 3, 5, 8, 10, 9, 4},
            [4] = {1, 2, 3},
            [13] = {1, 2, 3, 4},
            [14] = {1, 2, 3}
        },
        [3] = {
            [2] = {2, 11, 3, 5, 8, 10, 4, 9},
            [3] = {11, 1, 3, 5, 8, 10, 9, 4},
            [4] = {1, 2, 3}
        }
    }
}

local imageOrderNum = {
    [2] = {
        [10] = 2,
        [11] = 2,
        [12] = 2
    },
    [3] = {
        [2] = 1, -- Entry
        [3] = 1, -- Exit
        [4] = 1, -- Buyer
        [13] = 1, -- Entry Disguise
        [14] = 1 -- Exit Disguise
    }
}

local notSelected = {2, 3, 4, 13, 14}
local untick = {2, 3, 4, 8, 9, 13}

local weapons = {
    [1] = {2, 8, 14, 4, 11},
    [2] = {1, 7, 13, 5, 10},
    [3] = {3, 9, 15, 6, 12}
}

function StartCamWhiteboard()
    boardCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", camCoords[boardUsing], 0, 0, camHeading[boardUsing], 20.0, true, 2)
    RenderScriptCams(true, false, 1000, true, false)

    --print(boardUsing)
    --while not HasScaleformMovieLoaded(boardType[boardUsing]) do 
    --    Wait(1)
    --end

    DisplayRadar(false)
    --SetupBoardInfo()
    SetEntityVisible(PlayerPedId(), false)
    
    camIsUsed = true
end

local function ChangeCam(change)
    boardUsing = boardUsing + change 
    
    SetCamCoord(boardCam, camCoords[boardUsing])
    SetCamRot(boardCam, 0, 0, camHeading[boardUsing], 2)
end

local function ExitBoard()
    boardUsing = 0
    camIsUsed = false
    DestroyAllCams()
    RenderScriptCams(false, false, 1000, true, false)
    DisplayRadar(true)
    SetEntityVisible(PlayerPedId(), true)
end

local function GetButtonId()
    BeginScaleformMovieMethod(boardType[boardUsing], "GET_CURRENT_SELECTION")
    selection = EndScaleformMovieMethodReturnValue()

    while not IsScaleformMovieMethodReturnValueReady(selection) do 
        Wait(0)
    end

    pos = GetScaleformMovieMethodReturnValueInt(selection)
    print(pos)
    return pos
end

local function CanChangeImage(num, change)
    --local num = GetButtonId()
    print(num)
    print(#imageOrder[boardUsing][approach][num], imageOrderNum[boardUsing][num])
    if #imageOrder[boardUsing][approach][num] == imageOrderNum[boardUsing][num] - 1 and change == 1 then 
        print("too high")
        return false
    elseif imageOrderNum[boardUsing][num] <= 2 and change == -1 then 
        print("too low")
        print(change)
        return false
    else
        print("can")
        return true
    end
end

local function SumTake()
    if #hPlayer == 1 then 
        return playerCut[1][1]
    elseif #hPlayer == 2 then
        return playerCut[2][1] + playerCut[2][2]
    elseif #hPlayer == 3 then
        return playerCut[3][1] + playerCut[3][2] + playerCut[3][3]
    elseif #hPlayer == 4 then
        return playerCut[4][1] + playerCut[4][2] + playerCut[4][3] + playerCut[4][4]
    end
end

local function IsMinCut(player)
    if playerCut[#hPlayer][player] == 15 then 
        return true 
    end
end

local function CanChangeCut(player, change)
    print(SumTake())
    if change < 0 and not IsMinCut(player) then 
        return true 
    elseif SumTake() < 100 and change > 0 then 
        return true 
    elseif IsMinCut() and change < 0 then 
        return false
    else
        return false
    end 
end

local function SetDataFinal(i)
    local cut = (potential[difficulty][loot] * 0.05) + (potential[difficulty][loot] * gunman[selectedGunman][5]) + (potential[difficulty][loot] * driver[selectedDriver][5]) + (potential[difficulty][loot] * hacker[selectedHacker][6])
    --local num = GetButtonId()

    BeginScaleformMovieMethod(boardType[3], "SET_HEADINGS")
    ScaleformMovieMethodAddParamPlayerNameString(approachString[approach])
    ScaleformMovieMethodAddParamPlayerNameString(lootString[loot])
    ScaleformMovieMethodAddParamInt(25000)
    ScaleformMovieMethodAddParamInt(potential[difficulty][loot])
    ScaleformMovieMethodAddParamInt(math.floor(cut))
    if approach == 2 and entryIsAvailable and imageOrderNum[3][2] ~= 1 then 
        print(1)
        ScaleformMovieMethodAddParamPlayerNameString(entranceString[approach][imageOrder[3][approach][2][imageOrderNum[3][2] - 1]])
    elseif approach == 2 then 
        ScaleformMovieMethodAddParamPlayerNameString("ENTRANCE")
        print(2)
    else
        print(3)
        ScaleformMovieMethodAddParamPlayerNameString(entranceString[approach][imageOrderNum[3][2]])
    end
    ScaleformMovieMethodAddParamPlayerNameString(exitString[approach][imageOrderNum[3][3]])
    ScaleformMovieMethodAddParamPlayerNameString(buyerString[imageOrderNum[3][4]])
    ScaleformMovieMethodAddParamPlayerNameString(entryDisguiseString[imageOrderNum[3][13]])
    ScaleformMovieMethodAddParamPlayerNameString(exitDisguiseString[imageOrderNum[3][14]])
    EndScaleformMovieMethod()
end

local function ToDoList(i, num)
    if num == 2 then 
        BeginScaleformMovieMethod(boardType[2], "ADD_TODO_LIST_ITEM")
        ScaleformMovieMethodAddParamPlayerNameString(todoList[2][approach][i][1])
        ScaleformMovieMethodAddParamBool(todoList[2][approach][i][2])
        EndScaleformMovieMethod()
    else
        BeginScaleformMovieMethod(boardType[num], "ADD_TODO_LIST_ITEM")
        ScaleformMovieMethodAddParamPlayerNameString(todoList[num][i][1])
        ScaleformMovieMethodAddParamBool(todoList[num][i][2])
        EndScaleformMovieMethod()
    end
end

local function ClearLists(list)
    if list == 1 then 
        BeginScaleformMovieMethod(boardType[boardUsing], "CLEAR_TODO_LIST")
        EndScaleformMovieMethod()
    else
        BeginScaleformMovieMethod(boardType[boardUsing], "CLEAR_OPTIONAL_LIST")
        EndScaleformMovieMethod()
    end
end

local function OptionalList(i, num)
    if num == 2 then 
        BeginScaleformMovieMethod(boardType[2], "ADD_OPTIONAL_LIST_ITEM")
        ScaleformMovieMethodAddParamPlayerNameString(optionalList[2][approach][i][1])
        ScaleformMovieMethodAddParamBool(optionalList[2][approach][i][2])
        EndScaleformMovieMethod()
    else 
        BeginScaleformMovieMethod(boardType[num], "ADD_OPTIONAL_LIST_ITEM")
        ScaleformMovieMethodAddParamPlayerNameString(optionalList[num][i][1])
        ScaleformMovieMethodAddParamBool(optionalList[num][i][2])
        EndScaleformMovieMethod()
    end
end

local function UpdateList(list, button)
    ClearLists(list)
    --print("length todo : " .. #todoList[1])
    if list == 1 then 
        if boardUsing == 1 then 
            todoList[boardUsing][button][2] = true 

            for i = 1, #todoList[1] do 
                ToDoList(i, 1)
                --print("tick")
            end
        elseif boardUsing == 2 then 
            todoList[boardUsing][approach][button][2] = true 

            for i = 1, #todoList[2][approach] do 
                ToDoList(i, 2)
            end
        elseif boardUsing == 3 then
            todoList[boardUsing][button][2] = true 

            if approach == 2 then 
                for i = 1, #todoList[3] do 
                    ToDoList(i, 3)
                end
            else 
                for i = 2, #todoList[3] do 
                    ToDoList(i, 3)
                end 
            end
        end
    else 
        if boardUsing == 1 then 
            optionalList[boardUsing][button][2] = true 

            for i = 1, #optionalList[1] do 
                OptionalList(i, 1)
            end
        elseif boardUsing == 2 then 
            optionalList[boardUsing][approach][button][2] = true 

            for i = 1, #optionalList[2][approach] do 
                OptionalList(i, 2)
            end
        elseif boardUsing == 3 then
            optionalList[boardUsing][button][2] = true 

            for i = 1, #optionalList[3] do 
                OptionalList(i, 3)
            end
        end
    end
end

local function Lock(i)
    BeginScaleformMovieMethod(boardType[1], "SET_PADLOCK")
    ScaleformMovieMethodAddParamInt(i + 4)
    ScaleformMovieMethodAddParamBool(lockList[i])
    EndScaleformMovieMethod()
end

local function SetTick(i, board, bool)
    if board = nil then 
        BeginScaleformMovieMethod(boardType[boardUsing], "SET_TICK")
        ScaleformMovieMethodAddParamInt(i)
        ScaleformMovieMethodAddParamBool(true)
        EndScaleformMovieMethod()
    else 
        BeginScaleformMovieMethod(boardType[board], "SET_TICK")
        ScaleformMovieMethodAddParamInt(i)
        ScaleformMovieMethodAddParamBool(bool)
        EndScaleformMovieMethod()
    end
end

local function SetMission(i)
    BeginScaleformMovieMethod(boardType[2], "SET_MISSION")
    ScaleformMovieMethodAddParamInt(missions[i][1])
    ScaleformMovieMethodAddParamInt(missions[i][2])
    ScaleformMovieMethodAddParamPlayerNameString(missions[i][3])
    EndScaleformMovieMethod()
end

local function InsertEntry()
    for i = 1, #imageOrder[3][approach][2] do 
        imageOrder[3][approach][2][i] = 0
    end

    print(imageOrderNum[3][13])

    if imageOrderNum[3][13] == 1 then
        --imageOrder[3][2][2][1] = 11
        --imageOrder[3][2][2][2] = 1
        imageOrder[3][2][2] = {11, 1}
    elseif imageOrderNum[3][13] == 2 then
        imageOrder[3][2][2] = {11, 1}
    elseif imageOrderNum[3][13] == 3 then
        imageOrder[3][2][2] = {6}
    elseif imageOrderNum[3][13] == 4 then
        imageOrder[3][2][2] = {2}
    end

    SetDataFinal()
end

local function SetImage(i, num)
    if images[num][i][1] then 
        BeginScaleformMovieMethod(boardType[num], "SET_BUTTON_IMAGE")
        ScaleformMovieMethodAddParamInt(images[num][i][2])
        ScaleformMovieMethodAddParamInt(images[num][i][3])
        EndScaleformMovieMethod()
        --print(images[num][i][3]) 
    else 
        BeginScaleformMovieMethod(boardType[num], "SET_BUTTON_GREYED_OUT")
        ScaleformMovieMethodAddParamInt(images[num][i][2])
        ScaleformMovieMethodAddParamBool(not images[num][i][1])
        EndScaleformMovieMethod()
    end
end

local function SetArrows(i)
    BeginScaleformMovieMethod(boardType[boardUsing], "SET_SELECTION_ARROWS_VISIBLE")
    ScaleformMovieMethodAddParamInt(i + 10)
    ScaleformMovieMethodAddParamBool(arrowsVisible[boardUsing][i])
    EndScaleformMovieMethod()
end

local function SetLootString()
    if loot ~= 0 then 
        BeginScaleformMovieMethod(boardType[1], "SET_TARGET_TYPE")
        ScaleformMovieMethodAddParamPlayerNameString(lootString[loot])
        EndScaleformMovieMethod()
    else 
        BeginScaleformMovieMethod(boardType[1], "SET_TARGET_TYPE")
        ScaleformMovieMethodAddParamPlayerNameString("???")
        EndScaleformMovieMethod()
    end
end

local function SetLootAndApproach()
    BeginScaleformMovieMethod(boardType[2], "SET_HEADINGS")
    ScaleformMovieMethodAddParamPlayerNameString(approachString[approach])
    ScaleformMovieMethodAddParamPlayerNameString(lootString[1])
    EndScaleformMovieMethod()
end

local function SetSpecificPreps(i)
    BeginScaleformMovieMethod(boardType[2], "ADD_APPROACH")
    ScaleformMovieMethodAddParamInt(approachSpecificPreps[approach][i][1])
    ScaleformMovieMethodAddParamInt(approachSpecificPreps[approach][i][2])
    ScaleformMovieMethodAddParamPlayerNameString(approachSpecificPreps[approach][i][3])
    ScaleformMovieMethodAddParamBool(approachSpecificPreps[approach][i][4])
    ScaleformMovieMethodAddParamBool(approachSpecificPreps[approach][i][5])
    ScaleformMovieMethodAddParamPlayerNameString(approachSpecificPreps[approach][i][6])
    EndScaleformMovieMethod()
end

local function SetCrewSpecials(btnId, bool)
    BeginScaleformMovieMethod(boardType[2], "SET_BUTTON_VISIBLE")
    ScaleformMovieMethodAddParamInt(btnId)
    ScaleformMovieMethodAddParamBool(bool)
    EndScaleformMovieMethod()
end

local function SetPoster(tickPlus)
    if approach == 2 then 
        local tick = tickPlus + 1
        BeginScaleformMovieMethod(boardType[2], "SET_POSTER_VISIBLE")
        ScaleformMovieMethodAddParamInt(16)
        ScaleformMovieMethodAddParamBool(true)
        ScaleformMovieMethodAddParamInt(tick)
        ScaleformMovieMethodAddParamInt(2)
        EndScaleformMovieMethod()
    end
end

local function SetCrewCut(player, cut)
    BeginScaleformMovieMethod(boardType[3], "SET_CREW_CUT")
    ScaleformMovieMethodAddParamInt(player + 7)
    ScaleformMovieMethodAddParamInt(cut)
    EndScaleformMovieMethod()
end

local function SetState(player, ready, headsetState)
    BeginScaleformMovieMethod(boardType[3], "SET_CREW_MEMBER_STATE")
    ScaleformMovieMethodAddParamInt(7 + player)
    ScaleformMovieMethodAddParamBool(ready)
    ScaleformMovieMethodAddParamBool(headsetState)
    EndScaleformMovieMethod()
end

local function SetHireableCrew(id, name, skill, image, cut, weapon)
    BeginScaleformMovieMethod(boardType[2], "SET_CREW_MEMBER")
    ScaleformMovieMethodAddParamInt(id)
    ScaleformMovieMethodAddParamPlayerNameString(name)
    ScaleformMovieMethodAddParamPlayerNameString(skill)
    ScaleformMovieMethodAddParamInt(image)
    ScaleformMovieMethodAddParamInt(cut)
    ScaleformMovieMethodAddParamInt(weapon)
    EndScaleformMovieMethod()
end

local function MapMarkers()
    BeginScaleformMovieMethod(boardType[3], "SET_MAP_MARKERS")
    ScaleformMovieMethodAddParamInt(selectedBuyer)
    EndScaleformMovieMethod()
end

local function ChangeImage(num, change)
    if imageOrderNum[boardUsing][num] == 1 and boardUsing == 3 then 
        
        BeginScaleformMovieMethod(boardType[3], "SET_NOT_SELECTED_VISIBLE")
        ScaleformMovieMethodAddParamInt(num)
        ScaleformMovieMethodAddParamBool(false)
        EndScaleformMovieMethod()
        
        BeginScaleformMovieMethod(boardType[boardUsing] ,"SET_BUTTON_IMAGE")
        ScaleformMovieMethodAddParamInt(num)
        ScaleformMovieMethodAddParamInt(imageOrder[boardUsing][approach][num][1])
        EndScaleformMovieMethod()
        
        imageOrderNum[boardUsing][num] = imageOrderNum[boardUsing][num] + change
    elseif boardUsing == 2 and (num == 10 or num == 11 or num == 12) then 
        imageOrderNum[boardUsing][num] = imageOrderNum[boardUsing][num] + change
        local sec = imageOrderNum[2][num] - 1
        if num == 10 then 
            SetHireableCrew(10, gunman[sec][1], gunman[sec][2], gunman[sec][4], math.floor(gunman[sec][5] * 100), weapons[approach][sec])
        elseif num == 11 then  
            SetHireableCrew(11, driver[sec][1], driver[sec][2], driver[sec][4], math.floor(driver[sec][5] * 100), weapons[approach][imageOrderNum[2][10] - 1])
        elseif num == 12 then 
            SetHireableCrew(12, hacker[sec][1], hacker[sec][2], hacker[sec][5], math.floor(hacker[sec][6] * 100), weapons[approach][imageOrderNum[2][10] - 1])
        end 

        BeginScaleformMovieMethod(boardType[2], "SET_BUTTON_IMAGE")
        ScaleformMovieMethodAddParamInt(num)
        ScaleformMovieMethodAddParamInt(imageOrder[2][approach][num][sec])
        EndScaleformMovieMethod()
        --SetHireableCrew(10, 1, 1, 1, 1, 1)

        --SetHireableCrew(10, gunman[imageOrderNum[2][10] - 2][1], gunman[imageOrderNum[2][10] - 2][2], imageOrder[2][approach][10][imageOrderNum[2][10]], gunman[imageOrderNum[2][10] - 2][4], 1)
    else 
        imageOrderNum[boardUsing][num] = imageOrderNum[boardUsing][num] + change

        BeginScaleformMovieMethod(boardType[boardUsing], "SET_BUTTON_IMAGE")
        ScaleformMovieMethodAddParamInt(num)
        ScaleformMovieMethodAddParamInt(imageOrder[boardUsing][approach][num][imageOrderNum[boardUsing][num] - 1])
        EndScaleformMovieMethod()
    end

    if boardUsing == 2 then 
        

    elseif boardUsing == 3 then
        if num == 3 and not todoList[3][2][2]then 
            UpdateList(1, 2)
        end

        if num == 4 then 
            selectedBuyer = selectedBuyer + change 
            MapMarkers()
            if not todoList[3][3][2] then 
                UpdateList(1, 3)
            end
        end

        if num == 13 and not entryIsAvailable then 
            UpdateList(1, 1)
            entryIsAvailable = true 
        end

        SetDataFinal()
    end
end

local function NotSelected(i)
    BeginScaleformMovieMethod(boardType[3], "SET_NOT_SELECTED_VISIBLE")
    ScaleformMovieMethodAddParamInt(notSelected[i])
    ScaleformMovieMethodAddParamBool(true)
    EndScaleformMovieMethod()
end

local function SetFocusOnButton()
    local button = GetButtonId()
    
    BeginScaleformMovieMethod(boardType[boardUsing], "SET_SELECTION_ARROWS_VISIBLE")
    ScaleformMovieMethodAddParamInt(button)
    ScaleformMovieMethodAddParamBool(true)
    EndScaleformMovieMethod()
    
    isFocusedBoard = true
end

local function UnFocusOnButton()
    local button = GetButtonId()

    BeginScaleformMovieMethod(boardType[boardUsing], "SET_SELECTION_ARROWS_VISIBLE")
    ScaleformMovieMethodAddParamInt(button)
    ScaleformMovieMethodAddParamBool(false)
    EndScaleformMovieMethod()

    BeginScaleformMovieMethod(boardType[boardUsing], "SET_BUTTON_GREYED_OUT")
    ScaleformMovieMethodAddParamInt(button)
    ScaleformMovieMethodAddParamBool(true)
    EndScaleformMovieMethod()
end

local function AppearanceButtons(i, bool)
    BeginScaleformMovieMethod(boardType[3], "SET_BUTTON_VISIBLE")
    ScaleformMovieMethodAddParamInt(i + 7)
    ScaleformMovieMethodAddParamBool(bool)
    EndScaleformMovieMethod()
end

local function GreyOut(board, i, bool)
    if not (board == 3 and i == 12) then 
        BeginScaleformMovieMethod(boardType[board], "SET_BUTTON_GREYED_OUT")
        ScaleformMovieMethodAddParamInt(i)
        ScaleformMovieMethodAddParamBool(bool)
        EndScaleformMovieMethod()
    end
end

local function CheckTodoList()
    local count = 0
    if approach == 2 then 
        count = 11
    else 
        count = 10
    end

    for i = 1, count do 
        if i == 1 then 
            if not todoList[1][3][2] then 
                return false 
            end
        elseif i < 8  then 
            if not todoList[2][approach][i][2] then 
                return false 
            end
        else
            if not todoList[3][approach][i][2] then 
                return false 
            end
        end
    end
end

local function ShowWarningMessage(msg)
    AddTextEntry("warning_message_second_line", msg)
    --CreateThread(function()
        while true do 
            Wait(0)
            SetWarningMessageWithAlert("warning_message_first_line", "warning_message_second_line", 36, 0, "", 0, -1, 0, "FM_NXT_RAC", "QM_NO_1", true, 0)

            if IsDisabledControlJustPressed(2, 215) then -- Enter
                --boughtDecoy = true 
                return true 
                --break
            elseif IsDisabledControlJustPressed(2, 200) then -- Escape   
                return false
                --break  
            end
        end  
    --end)
end

local function ExecuteButtonFunction(i)
    Wait(100)
    if boardUsing == 1 then 
        if i == 2 and not boughtCasinoModel then -- Buy Casino Model
            if ShowWarningMessage("Are you sure you wish to buy the Casino model for $" .. casinoModelPrice .. "?") then 
                SetCasinoModel(true)
                SetTick(2)
                UpdateList(2, 3)
                boughtCasinoModel = true
            end
        elseif i == 3 and not boughtDoorSecurity then -- Buy Door Security
            if ShowWarningMessage("Are you sure you wish to buy the Door Security for $" .. hackKeypadModelPrice .. "?") then 
                SetHackKeypadModel(true)
                SetTick(3)
                UpdateList(2, 4)
                boughtDoorSecurity = true
            end
        elseif i == 4 and not boughtVault then -- Buy Vault
            if ShowWarningMessage("Are you sure you wish to buy the Vault Door for $" .. vaultModelPrice .. "?") then 
                SetVaultModel(true)
                SetTick(4)
                UpdateList(2, 5)
                boughtVault = true
            end
        elseif i == 5 --[[and approach == 0]] then -- Silent and Sneaky
            if ShowWarningMessage("Are you sure that you want to use Silent and Sneaky approach for this heist?") then 
                SetTick(5)
                UpdateList(1, 3)
                approach = 1

                if (loot ~= 0 and approach ~= 0) then 
                    SetupBoardInfo()
                end
            end
        elseif i == 6 --[[and approach == 0]] then -- The Big Con
            if ShowWarningMessage("Are you sure that you want to use The Big Con approach for this heist?") then 
                SetTick(6)
                UpdateList(1, 3)
                approach = 2

                if (loot ~= 0 and approach ~= 0) then 
                    SetupBoardInfo()
                end
            end
        elseif i == 7 --[[and approach == 0]] then -- Aggressive
            if ShowWarningMessage("Are you sure that you want to use Aggressive approach for this heist?") then 
                SetTick(7)
                UpdateList(1, 3)
                approach = 3

                if (loot ~= 0 and approach ~= 0) then 
                    SetupBoardInfo()
                end
            end
        elseif i == 10 then 
            if ShowWarningMessage("This will randomize the loot, since there is no scope mission (yet). Continue?") then 
                local num = math.random(lootChances[1] + lootChances[2] + lootChances[3] + lootChances[4])

                if num <= lootChances[1] then 
                    loot = 1
                elseif num <= lootChances[1] + lootChances[2] and num > lootChances[1] then 
                    loot = 2
                elseif num <= lootChances[1] + lootChances[2] + lootChances[3] and num > lootChances[1] + lootChances[2] then 
                    loot = 3
                elseif num <= lootChances[1] + lootChances[2] + lootChances[3] + lootChances[4] and num > lootChances[1] + lootChances[2] + lootChances[3] then 
                    loot = 4
                end
                loot = 1

                images[1][3] = {true, 8, loot}

                BeginScaleformMovieMethod(boardType[1], "SET_BUTTON_VISIBLE")
                ScaleformMovieMethodAddParamInt(8)
                ScaleformMovieMethodAddParamBool(true)
                EndScaleformMovieMethod()

                SetImage(3, 1)
                SetTick(10)
                UpdateList(1, 2)
                SetLootString()
                
                if (loot ~= 0 and approach ~= 0) then 
                    SetupBoardInfo()
                end
            end
        end
    elseif boardUsing == 2 then 
        if i == 2 then 

        elseif i == 3 then 

        elseif i == 4 then 
        
        elseif i == 5 then 

        elseif i == 6 then 
        
        elseif i == 7 then 

        elseif i == 8 then 

        elseif i == 9 then 
            
        elseif i == 10 and selectedGunman == 0 then 
            if ShowWarningMessage("Are you sure you wish to recruit " .. gunman[imageOrderNum[2][10] - 1][1] .. " as your gunman?") then 
                BeginScaleformMovieMethod(boardType[2], "SET_CREW_MEMBER_HIRED")
                ScaleformMovieMethodAddParamInt(i)
                ScaleformMovieMethodAddParamBool(true)
                EndScaleformMovieMethod()
                --GreyOut(boardUsing, GetButtonId(), true)
                UnFocusOnButton()
                SetCrewSpecials(5, true)
                isFocusedBoard = false
                selectedGunman = imageOrderNum[2][i] - 1
                canZoomIn[2][i] = false

                if (selectedGunman ~= 0 and selectedDriver ~= 0 and selectedHacker ~= 0) then 
                    SetupBoardInfo()
                end
            end
        elseif i == 11 and selectedDriver == 0 then 
            if ShowWarningMessage("Are you sure you wish to recruit " .. driver[imageOrderNum[2][11] - 1][1] .. " as your getaway driver?") then 
                BeginScaleformMovieMethod(boardType[2], "SET_CREW_MEMBER_HIRED")
                ScaleformMovieMethodAddParamInt(i)
                ScaleformMovieMethodAddParamBool(true)
                EndScaleformMovieMethod()
                --GreyOut(boardUsing, GetButtonId(), true)
                UnFocusOnButton()
                SetCrewSpecials(6, true)
                isFocusedBoard = false
                selectedDriver = imageOrderNum[2][i] - 1
                canZoomIn[2][i] = false

                if (selectedGunman ~= 0 and selectedDriver ~= 0 and selectedHacker ~= 0) then 
                    SetupBoardInfo()
                end
            end
        elseif i == 12 and selectedHacker == 0 then 
            if ShowWarningMessage("Are you sure you wish to recruit " .. hacker[imageOrderNum[2][12] - 1][1] .. " as your hacker?") then 
                BeginScaleformMovieMethod(boardType[2], "SET_CREW_MEMBER_HIRED")
                ScaleformMovieMethodAddParamInt(i)
                ScaleformMovieMethodAddParamBool(true)
                EndScaleformMovieMethod()
                --GreyOut(boardUsing, GetButtonId(), true)
                UnFocusOnButton()
                SetCrewSpecials(7, true)
                isFocusedBoard = false
                selectedHacker = imageOrderNum[2][i] - 1
                canZoomIn[2][i] = false

                if (selectedGunman ~= 0 and selectedDriver ~= 0 and selectedHacker ~= 0) then 
                    SetupBoardInfo()
                end
            end
        elseif i == 13 then 

        elseif i == 14 then 

        elseif i == 15 then 

        elseif i == 16 then 

        elseif i == 17 then
        
        end
    elseif boardUsing == 3 then 
        if i == 6 and not boughtDecoy then -- Decoy 
            if ShowWarningMessage("Are you sure you wish to purchase the gunman decoy for $" .. decoyPrice .. "?") then 
                SetTick(6)
                UpdateList(2, 6)
                boughtDecoy = true
            end
        elseif i == 7 and not boughtCleanVehicle then  -- Clean Vehicle 
            if ShowWarningMessage("Are you sure you wish to purchase the clean vehicle for $" .. cleanVehiclePrice .. "?") then 
                SetTick(7)
                UpdateList(2, 7)
                boughtCleanVehicle = true
            end
        elseif i == 12 then -- Start Heist
            if CheckTodoList() then 
                StartHeist()
            else
                InfoMsg("You can not start the Diamond Casino Heist just yet. See all the todo items")
            end
        end
    end 
end

local function MoveMarker(direction)
    BeginScaleformMovieMethod(boardType[boardUsing], "SET_INPUT_EVENT")
    ScaleformMovieMethodAddParamInt(direction) 
    EndScaleformMovieMethod()
end

RegisterCommand("alertMsg", function()
    if ShowAlertMessage("Test", true) then 
        print("yes")
    else
        print("no")
    end
end, false)

function PlayerJoinedCrew(i)
        --print(hPlayer[i])
    --print(i)
    BeginScaleformMovieMethod(boardType[3], "SET_CREW_MEMBER")
    ScaleformMovieMethodAddParamInt(7 + i)
    ScaleformMovieMethodAddParamPlayerNameString(GetPlayerName(GetPlayerFromServerId(hPlayer[i])))
    ScaleformMovieMethodAddParamTextureNameString(GetPedMugshot(hPlayer[i]))
    EndScaleformMovieMethod()
    AppearanceButtons(#hPlayer, true)
    
    if #hPlayer == 2 then 
        for i = 1, 2 do 
            SetCrewCut(i, playerCut[2][i])
        end
    elseif #hPlayer == 3 then 
        for i = 1, 3 do 
            SetCrewCut(i, playerCut[3][i])
        end
    elseif #hPlayer == 4 then 
        for i = 1, 4 do 
            SetCrewCut(i, playerCut[4][i])
        end
    end
end

--[[ 
    Setup:

    SET_BUTTON_VISIBLE empty

    buttonId (interger)
    1  = nil
    2  = Casino Model
    3  = Door Security
    4  = Vault Door
    5  = Silent and Sneaky
    6  = The Big Con
    7  = Aggressive
    8  = Target
    9  = Scope Out Casino
    10 = Vault Contents
    11 = First Access Point
    12 = Second Access Point 
    13 = Third Access Point
    14 = Fourth Access Point 
    15 = Fifth Access Point 
    16 = Sixth Access Point

    imageId (interger)

    buttonId 2 to 4
    1 = Casino Model
    2 = Vault Door
    3 = Door Security

    buttonId 5 - 7
    1 = Silent and Sneaky
    2 = The Big Con
    3 = Aggressive

    buttonId 8 
    1 = Cash
    2 = Gold
    3 = Artwork
    4 = Diamonds

    buttonId 9 - 10
    No need to change

    buttonId 11 - 16
    1  = Waste Disposal
    2  = Main Door
    3  = Roof Terrace 1
    4  = Roof 1
    5  = Roof Terrace 2 
    6  = Security Tunnel
    7  = Sewer
    8  = Roof Terrace 3
    9  = Roof 2
    10 = Roof Terrace 4
    11 = Staff Lobby

    Prep:

    buttonId
    1 = Gunman?
    2 = Security Intel
    3 = Patrol Routes
    4 = Duggan Shipments
    5 = Guns
    6 = Getaway Vehicles
    7 = Hacking Device
    8 = Power Drills
    9 = Vault Keycards
    10 = Gunman
    11 = Driver
    12 = Hacker
    13 = Security Keycards
    14 = Specific Prep 1
    15 = Specific Prep 2
    16 = Specific Prep 3
    17 = Specific Prep 4
    18 = Masks

    imageId

    buttonId 10
    1 = Karl Abolaji
    2 = Gustavo Mota
    3 = Charlie Reed
    4 = Chester McCoy
    5 = Patick McReary

    buttonId 11 
    1 = Karim Denz
    2 = Taliana Martinez
    3 = Eddie Toh
    4 = Zach Nelson
    5 = Chester McCoy

    buttonId 12
    1 = Rickie Lukens
    2 = Christian Feltz
    3 = Yohan Blair
    4 = Avi Schwartzman
    5 = Paige Harris

    buttonId 14 - 17
    1 = Reinforced Armor
    2 = Boring Machine
    3 = Thermal Charges
    4 = Vault Explosives
    5 = Nano Drone
    6 = EMP
    7 = Vault Laser
    8 = Infiltration Suits
    9 = Yung Ancestor (Entry)
    10 = Yung Ancestor? (Entry)
    11 = Yung Ancestor? (Entry)
    12 = Vault Drill
    13 = Bugstars (Entry)
    14 = Maintenance (Entry)
    15 = Gruppe Sechs (Entry)
    16 = Firefighter (Exit)
    17 = NOOSE (Exit)
    18 = High Roller (Exit)
    19 = Bugstar (1) (Entry)
    20 = Bugstar (2) (Entry)
    21 = Gruppe Sechs (1) (Entry)
    22 = Gruppe Sechs (2) (Entry)
    23 = Maintenance (1) (Entry)
    24 = Maintenance (2) (Entry)

    Final:

    buttonId
    1 = nil
    2 = Entrance <--
    3 = Exit
    4 = Buyer
    5 = Entrance 
    6 = Gunman Decoy
    7 = Clean Vehicle
    8 = Player One
    9 = Player Two
    10 = Player Three
    11 = Player Four
    12 = Launch Heist
    13 = Entry Disguise
    14 = Exit Disguise

    imageId 

    buttonId 2-3
    1  = Waste Disposal
    2  = Main Door
    3  = Roof Terrace 1 South West?
    4  = Roof 1 North
    5  = Roof Terrace 2 North West?
    6  = Security Tunnel
    7  = Sewer
    8  = Roof Terrace 3 South East?
    9  = Roof 2 South
    10 = Roof Terrace 4 North East?
    11 = Staff Lobby

    buttonId 4
    1 = Low Level
    2 = Mid Level
    3 = High Level

    buttonId 13
    1 = Bugstar
    2 = Maintenance
    3 = Gruppe Sechs
    4 = Yung Ancestor

    buttonId 14 
    1 = Fire Fighter
    2 = NOOSE
    3 = High Roller
--]]

testint = 1

function SetupBoardInfo(num)
    if not setupLists then 
        setupLists = true
        for i = 1, #todoList[1] do 
           ToDoList(i, 1)
        end

        for i = 1, #optionalList[1] do 
            OptionalList(i, 1)
        end

        for i = 1, #lockList do 
            Lock(i)
        end

        for i = 1, #images[1] do 
            SetImage(i, 1)
        end

        BeginScaleformMovieMethod(boardType[1], "SET_BUTTON_VISIBLE")
        ScaleformMovieMethodAddParamInt(8)
        ScaleformMovieMethodAddParamBool(false)
        EndScaleformMovieMethod()

        BeginScaleformMovieMethod(boardType[1], "SET_CURRENT_SELECTION")
        ScaleformMovieMethodAddParamInt(12)
        EndScaleformMovieMethod()
    end

    SetLootString()        

    BeginScaleformMovieMethod(boardType[1], "SET_BLUEPRINT_VISIBLE")
    ScaleformMovieMethodAddParamBool(true)
    EndScaleformMovieMethod()

    if loot ~= 0 and approach ~= 0 then 
        boards = 2
        if not prepLists then
            prepLists = true
            

            for i = 1, #todoList[2][approach] do 
                ToDoList(i, 2)
            end 

            for i = 1, #optionalList[2][approach] do 
                OptionalList(i, 2)
            end

            BeginScaleformMovieMethod(boardType[2], "SET_CURRENT_SELECTION")
            ScaleformMovieMethodAddParamInt(19)
            EndScaleformMovieMethod()
            
            for i = 1, 4 do 
                SetSpecificPreps(i)
            end

            if approach == 2 then 
                SetPoster(-1)
            end

            for i = 1, 3 do 
                SetMission(i)
            end

            for i = 1, #untick do 
                SetTick(i, 2, false)
            end
        end

        

        if selectedGunman == 0 then 
            SetHireableCrew(10, gunman[imageOrderNum[2][10] - 1][1], gunman[imageOrderNum[2][10] - 1][2], gunman[imageOrderNum[2][10] - 1][4], math.floor(gunman[imageOrderNum[2][10] - 1][5] * 100), weapons[approach][1]) -- 1 = big con. 2 = silent, 3 = aggressive
            SetCrewSpecials(5, false)
        end 
        
        if selectedDriver == 0 then
            SetHireableCrew(11, driver[imageOrderNum[2][11] - 1][1], driver[imageOrderNum[2][11] - 1][2], driver[imageOrderNum[2][11] - 1][4], math.floor(driver[imageOrderNum[2][11] - 1][5] * 100), 1)
            SetCrewSpecials(6, false)
        end     
        if selectedHacker == 0 then    
            SetHireableCrew(12, hacker[imageOrderNum[2][12] - 1][1], hacker[imageOrderNum[2][12] - 1][2], hacker[imageOrderNum[2][12] - 1][5], math.floor(hacker[imageOrderNum[2][12] - 1][6] * 100), 1)
        end 

        SetLootAndApproach()
    end
    
    if selectedGunman ~= 0 and selectedDriver ~= 0 and selectedHacker ~= 0 then 
        boards = 3
        --print("test board 3")
        if not finalLists then 
            finalLists = true
            if approach ~= 2 then
                for i = 1, 2 do 
                    OptionalList(i, 3)
                end

                for i = 2, #todoList[3] do 
                    ToDoList(i, 3)
                end
            else 
                for i = 1, #optionalList[3] do 
                    OptionalList(i, 3)
                end

                for i = 1, #todoList[3] do 
                    ToDoList(i, 3)
                end
            end

            BeginScaleformMovieMethod(boardType[3], "SET_CURRENT_SELECTION")
            ScaleformMovieMethodAddParamInt(2)
            EndScaleformMovieMethod()
        end

        if approach ~= 2 then 
            AppearanceButtons(6, false)
            AppearanceButtons(7, false)
        end

        for i = 2, 4 do 
            AppearanceButtons(i, false)
        end

        for i = 1, 14 do 
            GreyOut(3, i, true)
        end
    
        SetDataFinal()
        SetCrewCut(1, 100)
        MapMarkers()
        SetState(1, false, true)

        for i = 1, #notSelected do 
            NotSelected(i)
        end

        PlayerJoinedCrew(1)

        BeginScaleformMovieMethod(boardType[3], "SET_NOT_SELECTED_VISIBLE")
        ScaleformMovieMethodAddParamInt(13)
        ScaleformMovieMethodAddParamBool(true)
        EndScaleformMovieMethod()
    end
end

RegisterNetEvent("cl:casinoheist:syncHeistPlayerScaleform", PlayerJoinedCrew)
RegisterNetEvent("cl:casinoheist:readyUp", hfdsjkfh)

CreateThread(function()
    while true do 
        Wait(0)
        if isInGarage then 
            DrawScaleformMovie_3dSolid(boardType[1], 2713.3, -366.2, -54.23418, 0.0, 0.0, camHeading[1], 1.0, 1.0, 1.0, 3.0, 1.7, 1.0, 0)
            
            if loot ~= 0 and approach ~= 0 then
                DrawScaleformMovie_3dSolid(boardType[2], 2716.27, -369.93, -54.23418, 0.0, 0.0, camHeading[2] - 180, 1.0, 1.0, 1.0, 3.1, 1.7, 1.0, 0)
            end
            
            if selectedGunman ~= 0 and selectedDriver ~= 0 and selectedHacker ~= 0 then 
                DrawScaleformMovie_3dSolid(boardType[3], 2712.58, -372.65, -54.23418, 0.0, 0.0, camHeading[3], 1.0, 1.0, 1.0, 3.0, 1.7, 1.0, 0)
            end
        else 
            Wait(3000)
        end
    end
end)

CreateThread(function()
    while true do 
        Wait(0)
        if camIsUsed then 
            DisableAllControlActions(2)
        else 
            Wait(3000)
        end
    end
end)

-- 187 down, 188 right, 189 left, 190 up

CreateThread(function()
    while true do 
        Wait(2)
        if boardUsing ~= 0 and camIsUsed and not isFocusedBoard then 
            if IsDisabledControlJustPressed(0, 32) then -- W
                PlaySoundFrontend(-1, "Highlight_Move", "DLC_HEIST_PLANNING_BOARD_SOUNDS", true)
                MoveMarker(188)
            elseif IsDisabledControlJustPressed(0, 33) then -- S
                PlaySoundFrontend(-1, "Highlight_Move", "DLC_HEIST_PLANNING_BOARD_SOUNDS", true)
                MoveMarker(187)
            elseif IsDisabledControlJustPressed(0, 34) then -- A
                PlaySoundFrontend(-1, "Highlight_Move", "DLC_HEIST_PLANNING_BOARD_SOUNDS", true)
                MoveMarker(189)
            elseif IsDisabledControlJustPressed(0, 35) then -- D
                PlaySoundFrontend(-1, "Highlight_Move", "DLC_HEIST_PLANNING_BOARD_SOUNDS", true)
                MoveMarker(190)
            elseif IsDisabledControlJustPressed(0, 44) then -- Q
                if boardUsing ~= 1 then
                    ChangeCam(-1)
                end
            elseif IsDisabledControlJustPressed(0, 38) then -- E
                if boardUsing ~= 3 then
                    ChangeCam(1)
                end
            elseif IsDisabledControlJustPressed(0, 191) then -- Enter
                PlaySoundFrontend(-1, "Highlight_Accept", "DLC_HEIST_PLANNING_BOARD_SOUNDS", true)
                local num = GetButtonId() 

                if canZoomIn[boardUsing][num] then 
                    GreyOut(boardUsing, GetButtonId(), false)
                    SetFocusOnButton()
                else
                    ExecuteButtonFunction(num)

                end
            elseif IsDisabledControlJustPressed(0, 200) then -- Esc
                GreyOut(3, GetButtonId(), true)
                ExitBoard()
            elseif IsDisabledControlJustPressed(0, 204) then -- Tab

            end
        else 
            Wait(1000)
        end
    end
end)

CreateThread(function()
    while true do 
        Wait(2)
        if isFocusedBoard then 
            if IsDisabledControlJustPressed(0, 174) then -- <--
                if boardUsing == 1 then 
                    
                elseif boardUsing == 2 then 
                    if CanChangeImage(GetButtonId(), -1) then 
                        PlaySoundFrontend(-1, "Paper_Shuffle", "DLC_HEIST_PLANNING_BOARD_SOUNDS", true)
                        ChangeImage(GetButtonId(), -1)
                    end
                elseif boardUsing == 3 then
                    --if GetButtonId() ~= 2 and imageOrderNum[3][13] ~= 0 and boardUsing == 3 then
                    if (GetButtonId() == 8 or GetButtonId() == 9 or GetButtonId() == 10 or GetButtonId() == 11) then   
                        if CanChangeCut(GetButtonId() - 7, -5) then 
                            local num = GetButtonId() - 7
                            playerCut[#hPlayer][num] = playerCut[#hPlayer][num] - 5 
                            SetCrewCut(num, playerCut[#hPlayer][num])
                        end
                    elseif CanChangeImage(GetButtonId(), -1) then 
                        PlaySoundFrontend(-1, "Paper_Shuffle", "DLC_HEIST_PLANNING_BOARD_SOUNDS", true)
                        ChangeImage(GetButtonId(), -1)
                    end
                end
            elseif IsDisabledControlJustPressed(0, 175) then -- -->
                if boardUsing == 1 then 
                    
                elseif boardUsing == 2 then 
                    if CanChangeImage(GetButtonId(), 1) then 
                        PlaySoundFrontend(-1, "Paper_Shuffle", "DLC_HEIST_PLANNING_BOARD_SOUNDS", true)
                        ChangeImage(GetButtonId(), 1)
                    end
                elseif boardUsing == 3 then
                    if (GetButtonId() == 8 or GetButtonId() == 9 or GetButtonId() == 10 or GetButtonId() == 11) then   
                        if CanChangeCut(GetButtonId() - 7, 5) then 
                            local num = GetButtonId() - 7
                            playerCut[#hPlayer][num] = playerCut[#hPlayer][num] + 5
                            SetCrewCut(num, playerCut[#hPlayer][num])
                        end
                    elseif CanChangeImage(GetButtonId(), 1) then 
                        PlaySoundFrontend(-1, "Paper_Shuffle", "DLC_HEIST_PLANNING_BOARD_SOUNDS", true)
                        ChangeImage(GetButtonId(), 1)
                    end
                end
            elseif IsDisabledControlJustPressed(0, 191) then -- Enter
                ExecuteButtonFunction(GetButtonId())
                UnFocusOnButton()
                isFocusedBoard = false 
            elseif IsDisabledControlJustPressed(0, 200) then -- Esc
                PlaySoundFrontend(-1, "Back", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
                GreyOut(boardUsing, GetButtonId(), true)
                UnFocusOnButton()
                isFocusedBoard = false 
            elseif IsDisabledControlJustPressed(0, 204) then -- Tab

            end
        else 
            Wait(1000)
        end
    end
end)

CreateThread(function()
    while true do 
        Wait(0)
        if isInGarage and boardUsing == 0 then 
            for i = 1, boards do 
                local distance = #(GetEntityCoords(PlayerPedId()) - boardCoords[i])

                if distance < 1.5 then 
                    HelpMsg("Press ~INPUT_CONTEXT~ to use the " .. boardString[i])
                    if IsControlPressed(0, 38) then 
                        boardUsing = i
                        StartCamWhiteboard()
                    end
                else
                    Wait(10)
                end
            end
        else 
            Wait(2000)
        end
    end
end)

--RegisterCommand("camarcade", function(src, args)
--    boardUsing = tonumber(args[1])
--    StartCamWhiteboard()
--end, false)

RegisterCommand("test_scale", function(src, args)
    --boardUsing = tonumber(args[1])
    isInGarage = true
    SetupBoardInfo()
end, false)

RegisterCommand("add_h", function(src, args)
    hPlayer[#hPlayer + 1] = tonumber(args[1])
    PlayerJoinedCrew(#hPlayer)
end, false)

-- Laptop 

local lesterdoorObj = 0
local lesterdoorCoords = vector3(2727.91138, -371.982025, -48.40004)
local lesterdoor = "ch_prop_arcade_fortune_door_01a"

local function OpenLesterDoorFromArcade()
    local networkScene = 0
    --local lesterdoor = ""
    local animDict = "anim_heist@arcade_property@fortune_teller@male@"

    --LoadModel(lesterdoor)
    LoadAnim(animDict)

    networkScene = NetworkCreateSynchronisedScene(lesterdoorCoords, GetEntityRotation(lesterdoorObj), 1, true, false, 1065353216, 0.0, 1.3)
    NetworkAddPedToSynchronisedScene(PlayerPedId(), networkScene, animDict, "coin_drop", 4.0, -4.0, 18, 0, 1000.0, 0)
    NetworkAddEntityToSynchronisedScene(lesterdoorObj, networkScene, animDict, "coin_drop_arcade_fortune_door", 1.0, -1.0, 114886080)

    NetworkStartSynchronisedScene(networkScene)
end

local function OpenLesterDoorFromGarage()
    LoadAnim("anim_heist@arcade_property@fortune_teller@male@")
    PlayEntityAnim(lesterdoorObj, "anim_heist@arcade_property@fortune_teller@male@", "coin_drop_arcade_fortune_door", 0.0, true, true, false, 0.0, 0x4000) 
end


CreateThread(function()
    while true do 
        if isInBuilding and not isInGarage and not doorOpen then 
            local distance = #(GetEntityCoords(PlayerPedId()) - lesterdoorCoords)
            if distance < 2 then 
                HelpMsg("Press ~INPUT_CONTEXT~ to access the basement", 1000)
                if IsControlPressed(0, 38) then 
                    OpenLesterDoorFromArcade()
                    isInGarage = true
                    doorOpen = true
                else
                    Wait(10)
                end
            else 
                Wait(100)
            end
        else 
            Wait(1000)
        end
    end
end)

CreateThread(function()
    while true do 
        if isInBuilding and isInGarage and not doorOpen then 
            local distance = #(GetEntityCoords(PlayerPedId()) - lesterdoorCoords)
            if distance < 5 then 
                OpenLesterDoorFromGarage()
                isInGarage = false
                doorOpen = true
            else 
                Wait(500)
            end
        else 
            Wait(1000)
        end
    end
end)

CreateThread(function()
    while true do 
        if isInBuilding and doorOpen then 
            local distance = #(GetEntityCoords(PlayerPedId()) - lesterdoorCoords)
            if distance > 3 then 
                isInGarage = not isInGarage 
                Wait(3000)
            else 
                Wait(700)
            end
        else 
            Wait(3000)
        end
    end
end)

RegisterCommand("lester_door", function()
    LoadModel("ch_prop_arcade_fortune_door_01a")
    ClearArea(GetEntityCoords(PlayerPedId()))
    lesterdoorObj = CreateObject(GetHashKey("ch_prop_arcade_fortune_door_01a"), lesterdoorCoords, false, false, false)
    --FadeTeleport()
    --isInBuilding = true
end, false)