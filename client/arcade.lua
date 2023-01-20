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
local boards = 1
local keys = 0
local barMenu = 0 

local setupLists = false
local prepLists = false
local finalLists = false
local camIsUsed = false
local isInGarage = false  
local doorOpen = false
local isInBuilding = false
local entryIsAvailable = false
local isFocusedBoard = false

local boardType = {}

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
            {"Entry Disguise", true},
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
        {"Entrance", false},
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
            {"Exit Disguise", true}
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
        {14, 13, "BUGSTARS GEAR", true, true, "ENRTY DISGUISE"},
        {15, 12, "VAULT DRILLS", false, true},
        {16, 0, "", false, false},
        {17, 16, "FIREFIGHTER GEAR", true, false, "EXIT DISGUISE"},
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
        "N.E. ROOF TERRACE",
        "N.W. ROOF TERRACE",
        "S.E. ROOF TERRACE",
        "S.W. ROOF TERRACE",
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
        "ENTRANCE",
        "MAIN DOOR",
        "SEWER",
        "STAFF LOBBY",
        "WASTE DISPOSAL",
        "N.E. ROOF TERRACE",
        "N.W. ROOF TERRACE",
        "S.E. ROOF TERRACE",
        "S.W. ROOF TERRACE"
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
        "EXIT",
        "STAFF LOBBY",
        "WASTE DISPOSAL",
        "N.E. ROOF TERRACE",
        "N.W. ROOF TERRACE",
        "S.E. ROOF TERRACE",
        "S.W. ROOF TERRACE",
        "SOUTH HELIPAD",
        "NORTH HELIPAD"
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
    "GRUPPE SECHS",
    "LS WATER & POWER",
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
        false,
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
            [5] = {},
            [6] = {},
            [10] = {1, 3, 5, 2, 4},
            [11] = {1, 4, 2, 3, 5},
            [12] = {1, 3, 2, 5, 4},
            [13] = {1, 2}
        },
        [2] = {
            [5] = {},
            [6] = {},
            [10] = {1, 3, 5, 2, 4},
            [11] = {1, 4, 2, 3, 5},
            [12] = {1, 3, 2, 5, 4},
            [13] = {1, 2},
            [14] = {13, 15, 14, 9},
            [17] = {16, 17, 18}
        },
        [3] = {
            [5] = {},
            [6] = {},
            [10] = {1, 3, 5, 2, 4},
            [11] = {1, 4, 2, 3, 5},
            [12] = {1, 3, 2, 5, 4},
            [13] = {1, 2}
        }, 
    },
    [3] = {
        [1] = {
            [2] = {11, 1, 3, 5, 8, 10,  9, 4},
            [3] = {11, 1, 3, 5, 8, 10, 9, 4},
            [4] = {1, 2, 3}
        },
        [2] = {
            [2] = {},
            [3] = {11, 1, 3, 5, 8, 10, 9, 4},
            [4] = {1, 2, 3},
            [13] = {1, 3, 2, 4},
            [14] = {1, 2, 3}
        },
        [3] = {
            [2] = {2, 7, 11, 1},
            [3] = {11, 1, 3, 5, 8, 10, 9, 4},
            [4] = {1, 2, 3}
        }
    }
}

local imageOrderNum = {
    [2] = {
        [5] = 2,
        [6] = 2,
        [10] = 2,
        [11] = 2,
        [12] = 2,
        [13] = 2,
        [14] = 2,
        [17] = 2
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
local weaponLoadoutStrings = {}

local weapons = {
    [1] = {2, 8, 14, 4, 11},
    [2] = {1, 7, 13, 5, 10},
    [3] = {3, 9, 15, 6, 12}
}

function StartCamWhiteboard()
    boardCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", camCoords[boardUsing], 0, 0, camHeading[boardUsing], 20.0, true, 2)
    RenderScriptCams(true, false, 1000, true, false)

    DisplayRadar(false)
    SetEntityVisible(PlayerPedId(), false)
    
    camIsUsed = true
end

local function AddButtonToBar(i, key, string)
    BeginScaleformMovieMethod(barMenu, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(i)
    ScaleformMovieMethodAddParamPlayerNameString(key)
    ScaleformMovieMethodAddParamPlayerNameString(string)
    EndScaleformMovieMethod()
end

local function SetBarButtons(btnId)
    --RemoveAllKeys()

    BeginScaleformMovieMethod(barMenu, "CLEAR_ALL")
    EndScaleformMovieMethod()

    if boardUsing == 1 and not isFocusedBoard then 
        AddButtonToBar(0, "~INPUT_FRONTEND_ACCEPT~", "Select")
        AddButtonToBar(1, "~INPUT_FRONTEND_CANCEL~", "Quit")
        if loot ~= 0 and approach ~= 0 then 
            AddButtonToBar(2, "~INPUT_CONTEXT~", "Prep Board")
        end
        AddButtonToBar(3, GetControlGroupInstructionalButton(2, 20, true), "Navigate")
    elseif boardUsing == 2 and not isFocusedBoard then 
        AddButtonToBar(0, "~INPUT_FRONTEND_ACCEPT~", "Select")
        AddButtonToBar(1, "~INPUT_FRONTEND_CANCEL~", "Quit")
        if selectedGunman ~= 0 and selectedDriver ~= 0 and selectedHacker ~= 0 then 
            AddButtonToBar(2, "~INPUT_CONTEXT~", "Finale Board")
        end
        AddButtonToBar(3, "~INPUT_COVER~", "Setup Board")
        AddButtonToBar(4, GetControlGroupInstructionalButton(2, 20, true), "Navigate")
    elseif boardUsing == 3 and not isFocusedBoard then 
        AddButtonToBar(0, "~INPUT_FRONTEND_ACCEPT~", "Select")
        AddButtonToBar(1, "~INPUT_FRONTEND_CANCEL~", "Quit")
        AddButtonToBar(2, "~INPUT_COVER~", "Prep Board")
        AddButtonToBar(3, GetControlGroupInstructionalButton(2, 20, true), "Navigate")
    elseif isFocusedBoard then 
        local string = ""
        AddButtonToBar(0, "~INPUT_FRONTEND_ACCEPT~", "Set")
        AddButtonToBar(1, "~INPUT_FRONTEND_CANCEL~", "Cancel")
        if boardUsing == 2 then 
            if btnId == 5 then 
                string = "Loadout"
            elseif btnId == 6 then 
                string = "Getaway Vehicle"
            elseif btnId == 10 then 
                string = "Gunman"
            elseif btnId == 11 then 
                string = "Driver"
            elseif btnId == 12 then 
                string = "Hacker"
            elseif btnId == 14 then 
                string = "Entry Disguise"
            elseif btnId == 17 then 
                string = "Exit Disguise"
            end
        elseif boardUsing == 3 then 
            if btnId == 2 then 
                string = "Entrance"
            elseif btnId == 3 then 
                string = "Exit"
            elseif btnId == 4 then 
                string = "Buyer"
            elseif btnId == 13 then 
                string = "Entry Disguise"
            elseif btnId == 14 then 
                string = "Exit Disguise"
            end
        end
        AddButtonToBar(2, GetControlGroupInstructionalButton(2, 5, true), "Change " .. string)
    end

    BeginScaleformMovieMethod(barMenu, "DRAW_INSTRUCTIONAL_BUTTONS")
    ScaleformMovieMethodAddParamInt(4)
    EndScaleformMovieMethod()
end

local function ChangeCam(change)
    if boardUsing + change <= boards then 
        boardUsing = boardUsing + change 
        
        SetCamCoord(boardCam, camCoords[boardUsing])
        SetCamRot(boardCam, 0, 0, camHeading[boardUsing], 2)
        SetBarButtons()
    end
end

local function RemoveAllKeys()
    for i = 0, keys do 
        BeginScaleformMovieMethod(barMenu, "SET_DATA_SLOT_EMPTY")
        ScaleformMovieMethodAddParamInt(i)
        EndScaleformMovieMethod()
    end
end

local function ExitBoard()
    boardUsing = 0
    camIsUsed = false
    DestroyAllCams()
    RenderScriptCams(false, false, 1000, true, false)
    DisplayRadar(true)
    SetEntityVisible(PlayerPedId(), true)
    SetPauseMenuActive(true)
end

local function GetButtonId()
    BeginScaleformMovieMethod(boardType[boardUsing], "GET_CURRENT_SELECTION")
    selection = EndScaleformMovieMethodReturnValue()

    while not IsScaleformMovieMethodReturnValueReady(selection) do 
        Wait(0)
    end

    pos = GetScaleformMovieMethodReturnValueInt(selection)
    return pos
end

local function CanChangeImage(num, change)
    if #imageOrder[boardUsing][approach][num] == imageOrderNum[boardUsing][num] - 1 and change == 1 then    
        return false
    elseif imageOrderNum[boardUsing][num] <= 2 and change == -1 then 
        return false
    else
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
    local cut = (potential[difficulty][loot] * 0.05) + (potential[difficulty][loot] * gunman[selectedGunman][4]) + (potential[difficulty][loot] * driver[selectedDriver][4]) + (potential[difficulty][loot] * hacker[selectedHacker][6])
    BeginScaleformMovieMethod(boardType[3], "SET_HEADINGS")
    ScaleformMovieMethodAddParamPlayerNameString(approachString[approach])
    ScaleformMovieMethodAddParamPlayerNameString(lootString[loot])
    ScaleformMovieMethodAddParamInt(25000)
    ScaleformMovieMethodAddParamInt(potential[difficulty][loot])
    ScaleformMovieMethodAddParamInt(math.floor(cut))
    if approach == 2 and entryIsAvailable and imageOrderNum[3][2] ~= 1 then 
        ScaleformMovieMethodAddParamPlayerNameString(entranceString[approach][imageOrder[3][approach][2][imageOrderNum[3][2] - 1]])
    elseif approach == 2 then 
        ScaleformMovieMethodAddParamPlayerNameString("ENTRANCE")
    else
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
    if list == 1 then 
        if boardUsing == 1 then 
            todoList[boardUsing][button][2] = true 

            for i = 1, #todoList[1] do 
                ToDoList(i, 1)
            end
        elseif boardUsing == 2 then 
            todoList[boardUsing][approach][button][2] = true 

            for i = 1, #todoList[2][approach] do 
                ToDoList(i, 2)
            end
        elseif boardUsing == 3 then
            print(boardUsing, button, todoList[3][2])
            todoList[boardUsing][button][2] = true 

            --if approach == 2 then 
                for i = 1, #todoList[3] do 
                    ToDoList(i, 3)
                end
            --else 
                --for i = 2, #todoList[3] do 
                --    ToDoList(i, 3)
                --end 
            --end
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

            if approach == 2 then 
                for i = 1, #optionalList[3] do 
                    OptionalList(i, 3)
                end
            else
                for i = 1, #optionalList[3] - 1 do 
                    OptionalList(i, 3)
                end
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
    if board == nil then 
        BeginScaleformMovieMethod(boardType[boardUsing], "SET_TICK")
        ScaleformMovieMethodAddParamInt(i)
        ScaleformMovieMethodAddParamBool(true)
        EndScaleformMovieMethod()
    else 
        BeginScaleformMovieMethod(boardType[board], "SET_TICK")
        ScaleformMovieMethodAddParamInt(untick[i])
        ScaleformMovieMethodAddParamBool(bool)
        EndScaleformMovieMethod()
    end
end

local function SetMissionCompletion(btnId)
    BeginScaleformMovieMethod(boardType[2], "SET_MISSION_COMPLETION")
    ScaleformMovieMethodAddParamInt(btnId)
    ScaleformMovieMethodAddParamBool(true)
    ScaleformMovieMethodAddParamInt(1)
    ScaleformMovieMethodAddParamInt(1)
    EndScaleformMovieMethod()
end

local function SetMission(btnId, image, text)
    BeginScaleformMovieMethod(boardType[2], "SET_MISSION")
    ScaleformMovieMethodAddParamInt(btnId)
    ScaleformMovieMethodAddParamInt(image)
    ScaleformMovieMethodAddParamPlayerNameString(text)
    EndScaleformMovieMethod()
end

local function InsertEntry()
    for i = 1, #imageOrder[3][approach][2] do 
        imageOrder[3][approach][2][i] = 0
    end

    if imageOrderNum[3][13] == 2 then
        imageOrder[3][2][2] = {11, 1}
    elseif imageOrderNum[3][13] == 4 then
        imageOrder[3][2][2] = {11, 1}
    elseif imageOrderNum[3][13] == 3 then
        imageOrder[3][2][2] = {6}
    elseif imageOrderNum[3][13] == 5 then
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
    ScaleformMovieMethodAddParamPlayerNameString(lootString[loot])
    EndScaleformMovieMethod()
end

local function SetSpecificPreps(btnId, image, title, isCompleted, isRequired, tapeLabel)
    BeginScaleformMovieMethod(boardType[2], "ADD_APPROACH")
    ScaleformMovieMethodAddParamInt(btnId)
    ScaleformMovieMethodAddParamInt(image)
    ScaleformMovieMethodAddParamPlayerNameString(title)
    ScaleformMovieMethodAddParamBool(isCompleted)
    ScaleformMovieMethodAddParamBool(isRequired)
    ScaleformMovieMethodAddParamPlayerNameString(tapeLabel)
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
    if imageOrderNum[boardUsing][num] == 1 and not (boardUsing == 2 and (num == 5 or num == 6 or num == 10 or num == 11 or num == 12)) then 
        if boardUsing == 3 then 
            BeginScaleformMovieMethod(boardType[3], "SET_NOT_SELECTED_VISIBLE")
            ScaleformMovieMethodAddParamInt(num)
            ScaleformMovieMethodAddParamBool(false)
            EndScaleformMovieMethod()
        end
        
        BeginScaleformMovieMethod(boardType[boardUsing] ,"SET_BUTTON_IMAGE")
        ScaleformMovieMethodAddParamInt(num)
        ScaleformMovieMethodAddParamInt(imageOrder[boardUsing][approach][num][1])
        EndScaleformMovieMethod()
        
        imageOrderNum[boardUsing][num] = imageOrderNum[boardUsing][num] + change
    elseif boardUsing == 2 and (num == 5 or num == 6 or num == 10 or num == 11 or num == 12 or num == 14 or num == 17) then 
        imageOrderNum[boardUsing][num] = imageOrderNum[boardUsing][num] + change
        local sec = imageOrderNum[2][num] - 1
        if num == 5 then 
            SetMission(5, imageOrder[2][approach][5][sec], weaponLoadoutStrings[sec])
        elseif num == 6 then
            SetMission(6, imageOrder[2][approach][6][sec], availableVehicles[selectedDriver][1][sec][2])
        elseif num == 10 then 
            SetHireableCrew(10, gunman[sec][1], gunman[sec][2], gunman[sec][3], math.floor(gunman[sec][4] * 100), weapons[approach][sec])
        elseif num == 11 then  
            SetHireableCrew(11, driver[sec][1], driver[sec][2], driver[sec][3], math.floor(driver[sec][4] * 100), weapons[approach][imageOrderNum[2][10] - 1])
        elseif num == 12 then 
            SetHireableCrew(12, hacker[sec][1], hacker[sec][2], hacker[sec][5], math.floor(hacker[sec][6] * 100), weapons[approach][imageOrderNum[2][10] - 1])
        elseif num == 14 then 
            SetSpecificPreps(14, imageOrder[2][2][14][sec], entryDisguiseString[sec + 1] .. " GEAR", approachSpecificPreps[2][1][4], true, "ENRTY DISGUISE")
        elseif num == 17 then 
            SetSpecificPreps(17, imageOrder[2][2][17][sec], exitDisguiseString[sec + 1] .. " GEAR", approachSpecificPreps[2][4][4], false, "EXIT DISGUISE")
        end 
    else 
        imageOrderNum[boardUsing][num] = imageOrderNum[boardUsing][num] + change

        BeginScaleformMovieMethod(boardType[boardUsing], "SET_BUTTON_IMAGE")
        ScaleformMovieMethodAddParamInt(num)
        ScaleformMovieMethodAddParamInt(imageOrder[boardUsing][approach][num][imageOrderNum[boardUsing][num] - 1])
        EndScaleformMovieMethod()
    end        

    if boardUsing == 3 then
        if num == 3 and not todoList[3][2][2]then 
            UpdateList(1, 2)
        elseif num == 4 then 
            selectedBuyer = selectedBuyer + change 
            MapMarkers()
            if not todoList[3][3][2] then 
                UpdateList(1, 3)
            end
        elseif num == 13 then 
            if entryIsAvailable then 
                imageOrderNum[3][2] = 1

                BeginScaleformMovieMethod(boardType[3], "SET_NOT_SELECTED_VISIBLE")
                ScaleformMovieMethodAddParamInt(2)
                ScaleformMovieMethodAddParamBool(true)
                EndScaleformMovieMethod()
            end

            UpdateList(1, 1)
            InsertEntry()
            entryIsAvailable = true 
        elseif num == 14 then 
            UpdateList(2, 3)
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

    for i = 1, #todoList[3] do 
        if not todoList[3][i][2] then 
            return false 
        end
    end

    return true
end

local function ShowWarningMessage(msg)
    AddTextEntry("warning_message_second_line", msg)
    while true do 
        Wait(0)
        SetWarningMessageWithAlert("warning_message_first_line", "warning_message_second_line", 36, 0, "", 0, -1, 0, "FM_NXT_RAC", "QM_NO_1", true, 0)
        if IsDisabledControlJustPressed(2, 215) then -- Enter
            return true 
        elseif IsDisabledControlJustPressed(2, 200) then -- Escape   
            return false
        end
    end  
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
        elseif i == 5 and approach == 0 then -- Silent and Sneaky
            if ShowWarningMessage("Are you sure that you want to use Silent and Sneaky approach for this heist?") then 
                SetTick(5)
                UpdateList(1, 3)
                approach = 1

                SetApproachSets()

                if (loot ~= 0 and approach ~= 0) then 
                    PrepBoardInfo()
                    TriggerServerEvent("sv:casinoheist:setHeistLeader", true)
                    SetBarButtons()
                end
            end
        elseif i == 6 and approach == 0 then -- The Big Con
            if ShowWarningMessage("Are you sure that you want to use The Big Con approach for this heist?") then 
                SetTick(6)
                UpdateList(1, 3)
                approach = 2
                canZoomIn[2][14] = true
                canZoomIn[2][17] = true

                todoList[3][1][1] = "Entry Disguise"

                BeginScaleformMovieMethod(boardType[2], "SET_SELECTION_ARROWS_VISIBLE")
                ScaleformMovieMethodAddParamInt(14)
                ScaleformMovieMethodAddParamBool(false)
                EndScaleformMovieMethod()

                BeginScaleformMovieMethod(boardType[2], "SET_SELECTION_ARROWS_VISIBLE")
                ScaleformMovieMethodAddParamInt(17)
                ScaleformMovieMethodAddParamBool(false)
                EndScaleformMovieMethod()

                SetApproachSets()

                if (loot ~= 0 and approach ~= 0) then 
                    PrepBoardInfo()
                    TriggerServerEvent("sv:casinoheist:setHeistLeader")
                    SetBarButtons()
                end
            end
        elseif i == 7 and approach == 0 then -- Aggressive
            if ShowWarningMessage("Are you sure that you want to use Aggressive approach for this heist?") then 
                SetTick(7)
                UpdateList(1, 3)
                approach = 3

                SetApproachSets()

                if (loot ~= 0 and approach ~= 0) then 
                    PrepBoardInfo()
                    TriggerServerEvent("sv:casinoheist:setHeistLeader")
                    SetBarButtons()
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
                    PrepBoardInfo()
                    TriggerServerEvent("sv:casinoheist:setHeistLeader")
                    SetBarButtons()
                end
            end
        end
    elseif boardUsing == 2 then 
        if i == 2 then 
            UpdateList(2, 3)
            SetTick(i)
        elseif i == 3 then 
            UpdateList(2, 1)
            SetTick(i)
        elseif i == 4 then 
            UpdateList(2, 2)
            SetTick(i)
        elseif i == 5 and selectedLoadout == 0 then 
            if ShowWarningMessage("Are you sure you wish to choose the " .. weaponLoadoutStrings[imageOrderNum[2][5] - 1] .. " as your weapon loadout?") then 
                SetTick(5)
                UpdateList(1, 1)
                selectedLoadout = imageOrderNum[2][5]
                canZoomIn[2][5] = false 

                if (selectedLoadout ~= 0 and selectedVehicle ~= 0 and selectedHacker ~= 0) then 
                    FinalBoardInfo()
                    SetBarButtons()
                end
            end
        elseif i == 6 and selectedVehicle == 0 then 
            if ShowWarningMessage("Are you sure you wish to choose the " .. availableVehicles[selectedDriver][1][imageOrderNum[2][6] - 1][2] .. " as your getaway vehicle?") then
                SetTick(6)
                UpdateList(1, 2)
                selectedVehicle = imageOrderNum[2][6]
                canZoomIn[2][6] = false 

                if (selectedLoadout ~= 0 and selectedVehicle ~= 0 and selectedHacker ~= 0) then 
                    FinalBoardInfo()
                    SetBarButtons()
                end
            end
        elseif i == 7 then --
            UpdateList(1, 3)
            SetTick(i)
        elseif i == 8 then --
            UpdateList(2, 4)
            SetTick(i)
        elseif i == 9 then --
            UpdateList(1, 4)
            SetTick(i)
        elseif i == 10 and selectedGunman == 0 then 
            if ShowWarningMessage("Are you sure you wish to recruit " .. gunman[imageOrderNum[2][10] - 1][1] .. " as your gunman?") then 
                BeginScaleformMovieMethod(boardType[2], "SET_CREW_MEMBER_HIRED")
                ScaleformMovieMethodAddParamInt(i)
                ScaleformMovieMethodAddParamBool(true)
                EndScaleformMovieMethod()
                UnFocusOnButton()
                SetCrewSpecials(5, true)
                isFocusedBoard = false
                selectedGunman = imageOrderNum[2][i] - 1
                canZoomIn[2][i] = false

                if approach == 1 then 
                    if selectedGunman == 1 then 
                        imageOrder[2][approach][5] = {11, 12} -- 1
                        weaponLoadoutStrings = {"Micro SMG Loadout", "Machine Pistol Loadout"}
                    elseif selectedGunman == 2 then
                        imageOrder[2][approach][5] = {13, 14} -- 2
                        weaponLoadoutStrings = {"SMG Loadout", "Shotgun Loadout"}
                    elseif selectedGunman == 3 then
                        imageOrder[2][approach][5] = {15, 16} -- 3
                        weaponLoadoutStrings = {"SMG Loadout", "Rifle Loadout"}
                    elseif selectedGunman == 4 then
                        imageOrder[2][approach][5] = {17, 18} -- 4
                        weaponLoadoutStrings = {"Rifle Loadout", "Shotgun Loadout"}
                    elseif selectedGunman == 5 then
                        imageOrder[2][approach][5] = {19, 20} -- 5
                        weaponLoadoutStrings = {"Shotgun Loadout", "Rifle Loadout"}
                    end
                elseif approach == 2 then 
                    if selectedGunman == 1 then 
                        imageOrder[2][approach][5] = {21, 22} -- 1
                        weaponLoadoutStrings = {"Micro SMG Loadout", "Shotgun Loadout"}
                    elseif selectedGunman == 2 then
                        imageOrder[2][approach][5] = {23, 24} -- 2
                        weaponLoadoutStrings = {"Machine Pistol Loadout", "Shotgun Loadout"}
                    elseif selectedGunman == 3 then
                        imageOrder[2][approach][5] = {25, 26} -- 3
                        weaponLoadoutStrings = {"Shotgun Loadout", "Rifle Loadout"}
                    elseif selectedGunman == 4 then
                        imageOrder[2][approach][5] = {27, 28} -- 4
                        weaponLoadoutStrings = {"Rifle Loadout", "Shotgun Loadout"}
                    elseif selectedGunman == 5 then
                        imageOrder[2][approach][5] = {29, 30} -- 5
                        weaponLoadoutStrings = {"SMG Loadout", "Rifle Loadout"}
                    end
                elseif approach == 3 then 
                    if selectedGunman == 1 then 
                        imageOrder[2][approach][5] = {1, 2} -- 1
                        weaponLoadoutStrings = {"Shotgun Loadout", "Revolver Loadout"}
                    elseif selectedGunman == 2 then
                        imageOrder[2][approach][5] = {3, 4} -- 2
                        weaponLoadoutStrings = {"SMG Loadout", "Shotgun Loadout"}
                    elseif selectedGunman == 3 then
                        imageOrder[2][approach][5] = {5, 6} -- 3
                        weaponLoadoutStrings = {"Shotgun Loadout", "Rifle Loadout"}
                    elseif selectedGunman == 4 then
                        imageOrder[2][approach][5] = {7, 8} -- 4
                        weaponLoadoutStrings = {"Rifle Loadout", "Shotgun Loadout"}
                    elseif selectedGunman == 5 then
                        imageOrder[2][approach][5] = {9, 10} -- 5
                        weaponLoadoutStrings = {"Shotgun Loadout", "Rifle Loadout"}
                    end
                end

                SetMission(5, imageOrder[2][approach][5][1], weaponLoadoutStrings[1])
            end
        elseif i == 11 and selectedDriver == 0 then 
            if ShowWarningMessage("Are you sure you wish to recruit " .. driver[imageOrderNum[2][11] - 1][1] .. " as your getaway driver?") then 
                BeginScaleformMovieMethod(boardType[2], "SET_CREW_MEMBER_HIRED")
                ScaleformMovieMethodAddParamInt(i)
                ScaleformMovieMethodAddParamBool(true)
                EndScaleformMovieMethod()
                UnFocusOnButton()
                SetCrewSpecials(6, true)
                isFocusedBoard = false
                selectedDriver = imageOrderNum[2][i] - 1
                canZoomIn[2][i] = false

                if selectedDriver == 1 then 
                    imageOrder[2][approach][6] = {1, 2, 3, 4}
                elseif selectedDriver == 2 then
                    imageOrder[2][approach][6] = {13, 14, 15, 16}
                elseif selectedDriver == 3 then
                    imageOrder[2][approach][6] = {5, 6, 7, 8}
                elseif selectedDriver == 4 then
                    imageOrder[2][approach][6] = {9, 10, 11, 12}
                elseif selectedDriver == 5 then
                    imageOrder[2][approach][6] = {17, 18, 19, 20}
                end

                SetMission(6, imageOrder[2][approach][6][1], availableVehicles[driver[selectedDriver][3]][1][1][2])
            end
        elseif i == 12 and selectedHacker == 0 then 
            if ShowWarningMessage("Are you sure you wish to recruit " .. hacker[imageOrderNum[2][12] - 1][1] .. " as your hacker?") then 
                BeginScaleformMovieMethod(boardType[2], "SET_CREW_MEMBER_HIRED")
                ScaleformMovieMethodAddParamInt(i)
                ScaleformMovieMethodAddParamBool(true)
                EndScaleformMovieMethod()
                UnFocusOnButton()
                SetCrewSpecials(7, true)
                isFocusedBoard = false
                selectedHacker = imageOrderNum[2][i] - 1
                canZoomIn[2][i] = false

                if (selectedLoadout ~= 0 and selectedVehicle ~= 0 and selectedHacker ~= 0) then 
                    FinalBoardInfo()
                    SetBarButtons()
                end
            end
        elseif i == 13 then 
            if ShowWarningMessage("Are you sure you wish to equip the level " .. imageOrderNum[2][13] -1 .. " security pass? (mission does not exist (yet))") then 
                UpdateList(2, 5)

                BeginScaleformMovieMethod(boardType[2], "SET_SECURITY_PASS_VISIBLE")
                ScaleformMovieMethodAddParamInt(imageOrderNum[2][13] - 1)
                EndScaleformMovieMethod()

                selectedKeycard = imageOrderNum[2][13] - 1
            end
        elseif i == 14 then 
            UpdateList(1, 5)
            SetTick(i)
        elseif i == 15 then 
            UpdateList(1, 6)
            SetTick(i)
        elseif i == 16 then 
            if approach ~= 2 then
                UpdateList(2, 7)
                SetTick(i)
            else
                SetPoster(1)
            end
        elseif i == 17 then
            if approach == 2 then 
                UpdateList(2, 7)
            else
                UpdateList(2, 8)
            end
            SetTick(i)
        elseif i == 18 then 
            UpdateList(2, 6)
            SetTick(i)
        end
    elseif boardUsing == 3 then 
        if i == 2 then 
            UpdateList(1, 1)        
        elseif i == 6 and not boughtDecoy then -- Decoy 
            if ShowWarningMessage("Are you sure you wish to purchase the gunman decoy for $" .. decoyPrice .. "?") then 
                SetTick(6)
                UpdateList(2, 1)
                boughtDecoy = true
            end
        elseif i == 7 and not boughtCleanVehicle then  -- Clean Vehicle 
            if ShowWarningMessage("Are you sure you wish to purchase the clean vehicle for $" .. cleanVehiclePrice .. "?") then 
                SetTick(7)
                UpdateList(2, 2)
                boughtCleanVehicle = true
            end
        elseif i == 12 then -- Start Heist
            if #hPlayer < 1 then 
                InfoMsg("You need at least two people the play the Diamond Casino Heist. Invite someone for you to help.")
            elseif CheckTodoList() then
                selectedEntrance = imageOrder[3][approach][2][imageOrderNum[3][2] - 1]
                selectedExit = imageOrder[3][approach][3][imageOrderNum[3][3] - 1]
                selectedBuyer = imageOrder[3][approach][4][imageOrderNum[3][4] - 1]
                selectedLoadout = selectedLoadout - 1
                selectedVehicle = selectedVehicle - 1

                if approach == 2 then 
                    selectedEntryDisguise = imageOrder[3][approach][13][imageOrderNum[3][13] - 1]
                    selectedExitDisguise = imageOrder[3][approach][14][imageOrderNum[3][14] - 1]
                end

                if loot == 3 then 
                    vaultLayout = math.random(7, 10)
                else
                    vaultLayout = math.random(1, 6)
        
                    if vaultLayout < 3 then 
                        cartLayout = 1
                    else 
                        cartLayout = 2
                    end
                end

                print("Heist Leader " .. hPlayer[1] .. "\n", "Approach " .. approach .. "\n", "Loot " .. loot  .. "\n", "Cut " .. playerCut[#hPlayer][1]  .. "\n", "Gunman " .. selectedGunman   .. "\n", "Loadout " .. selectedLoadout  .. "\n", "Driver " .. selectedDriver  .. "\n", "Vehicle " .. selectedVehicle  .. "\n", "Hacker " .. selectedHacker  .. "\n", "Keycard " .. selectedKeycard  .. "\n","Entrance " .. selectedEntrance  .. "\n", "Exit " .. selectedExit  .. "\n", "Buyer " .. selectedBuyer  .. "\n", "Entry Disguise " ..  selectedEntryDisguise  .. "\n", "Exit Disguise " .. selectedExitDisguise  .. "\n", "Clean Vehicle " ..  tostring(boughtCleanVehicle)  .. "\n", "Decoy " .. tostring(boughtDecoy))

                TriggerServerEvent("sv:casinoheist:startHeist", {hPlayer, approach, loot, playerCut[#hPlayer], selectedGunman, selectedLoadout, selectedDriver, selectedVehicle, selectedHacker, selectedKeycard, selectedEntrance, selectedExit, selectedBuyer, selectedEntryDisguise, selectedExitDisguise, boughtCleanVehicle, boughtDecoy, vaultLayout, cartLayout})
                heistInProgress = true
                isInGarage = false

                for i = 1, 3 do 
                    SetScaleformMovieAsNoLongerNeeded(boardType[i])
                end

                ExitBoard()
                StartHeist()
            else
                InfoMsg("You can not start the Diamond Casino Heist just yet. See all the to do items")
            end
        elseif i == 13 then 
            UpdateList(1, 1)
        end
    end 
end

local function MoveMarker(direction)
    BeginScaleformMovieMethod(boardType[boardUsing], "SET_INPUT_EVENT")
    ScaleformMovieMethodAddParamInt(direction) 
    EndScaleformMovieMethod()
end

function PlayerJoinedCrew(i)
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

function SetupBoardInfo(num)
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

    SetLootString()        

    BeginScaleformMovieMethod(boardType[1], "SET_BLUEPRINT_VISIBLE")
    ScaleformMovieMethodAddParamBool(true)
    EndScaleformMovieMethod()
end

function PrepBoardInfo()
    boards = 2
    prepLists = true
    
    if approach == 2 then 
        canZoomIn[2][14] = true
        canZoomIn[2][17] = true
    end

    for i = 1, #todoList[2][approach] do 
        ToDoList(i, 2)
    end 

    for i = 1, #optionalList[2][approach] do 
        OptionalList(i, 2)
    end
    
    for i = 1, 4 do 
        SetSpecificPreps(approachSpecificPreps[approach][i][1], approachSpecificPreps[approach][i][2], approachSpecificPreps[approach][i][3], approachSpecificPreps[approach][i][4], approachSpecificPreps[approach][i][5], approachSpecificPreps[approach][i][6])
    end
    
    if approach == 2 then 
        SetPoster(-1)
    end
    
    for i = 1, #untick do 
        SetTick(i, 2, false)
    end
    
    BeginScaleformMovieMethod(boardType[2], "SET_CURRENT_SELECTION")
    ScaleformMovieMethodAddParamInt(1)
    EndScaleformMovieMethod()
    
    BeginScaleformMovieMethod(boardType[2], "SET_BUTTON_IMAGE")
    ScaleformMovieMethodAddParamInt(13)
    ScaleformMovieMethodAddParamInt(1)
    EndScaleformMovieMethod()

    BeginScaleformMovieMethod(boardType[2], "SET_SECURITY_PASS_VISIBLE")
    ScaleformMovieMethodAddParamInt(0)
    EndScaleformMovieMethod()

    if selectedGunman == 0 then 
        SetHireableCrew(10, gunman[imageOrderNum[2][10] - 1][1], gunman[imageOrderNum[2][10] - 1][2], gunman[imageOrderNum[2][10] - 1][3], math.floor(gunman[imageOrderNum[2][10] - 1][4] * 100), weapons[approach][1]) -- 1 = big con. 2 = silent, 3 = aggressive
        SetCrewSpecials(5, false)
    end 

    if selectedDriver == 0 then
        SetHireableCrew(11, driver[imageOrderNum[2][11] - 1][1], driver[imageOrderNum[2][11] - 1][2], driver[imageOrderNum[2][11] - 1][3], math.floor(driver[imageOrderNum[2][11] - 1][4] * 100), 1)
        SetCrewSpecials(6, false)
    end  

    if selectedHacker == 0 then    
        SetHireableCrew(12, hacker[imageOrderNum[2][12] - 1][1], hacker[imageOrderNum[2][12] - 1][2], hacker[imageOrderNum[2][12] - 1][5], math.floor(hacker[imageOrderNum[2][12] - 1][6] * 100), 1)
        SetCrewSpecials(7, false)
    end 

    SetLootAndApproach()
end

function FinalBoardInfo()
    boards = 3
    finalLists = true

    if approach ~= 2 then
        for i = 1, 2 do 
            OptionalList(i, 3)
        end

        todoList[3][1][1] = "Entrance"
    else 
        for i = 1, #optionalList[3] do 
            OptionalList(i, 3)
        end
    end

    for i = 1, #todoList[3] do 
        ToDoList(i, 3)
    end

    BeginScaleformMovieMethod(boardType[3], "SET_CURRENT_SELECTION")
    ScaleformMovieMethodAddParamInt(2)
    EndScaleformMovieMethod()

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

RegisterNetEvent("cl:casinoheist:syncHeistPlayerScaleform", PlayerJoinedCrew)
RegisterNetEvent("cl:casinoheist:readyUp", hfdsjkfh)

local function CamSettings()
    CreateThread(function()
        while camIsUsed do 
            Wait(GetFrameTime())

            DisableAllControlActions(2)
            SetPauseMenuActive(false) 
        end
    end)
end

local function FocusThread()
    CreateThread(function()
        while isInGarage and boardUsing == 0 do 
            Wait(GetFrameTime())

            for i = 1, boards do 
                local distance = #(GetEntityCoords(PlayerPedId()) - boardCoords[i])

                if distance < 1.5 then 
                    HelpMsg("Press ~INPUT_CONTEXT~ to use the " .. boardString[i])
                    if IsControlPressed(0, 38) then 
                        boardUsing = i
                        SetBarButtons()
                        StartCamWhiteboard()
                        CamSettings()
                        KeypressUnfocused()
                    end
                else
                    Wait(10)
                end
            end
        end
    end)
end

local function ScaleformThread()
    FocusThread()

    CreateThread(function()
        while isInGarage do 
            Wait(GetFrameTime())

            DrawScaleformMovie_3dSolid(boardType[1], 2713.3, -366.2, -54.23418, 0.0, 0.0, camHeading[1], 1.0, 1.0, 1.0, 3.0, 1.7, 1.0, 0)
            
            if loot ~= 0 and approach ~= 0 then
                DrawScaleformMovie_3dSolid(boardType[2], 2716.27, -369.93, -54.23418, 0.0, 0.0, camHeading[2] - 180, 1.0, 1.0, 1.0, 3.1, 1.7, 1.0, 0)
            end
            
            if selectedLoadout ~= 0 and selectedVehicle ~= 0 and selectedHacker ~= 0 then 
                DrawScaleformMovie_3dSolid(boardType[3], 2712.58, -372.65, -54.23418, 0.0, 0.0, camHeading[3], 1.0, 1.0, 1.0, 3.0, 1.7, 1.0, 0)
            end

            if boardUsing ~= 0 then
                DrawScaleformMovieFullscreen(barMenu, 255, 255, 255, 255)
            end
        end
    end)
end

-- 187 down, 188 right, 189 left, 190 up

function KeypressUnfocused()
    CreateThread(function()
        while boardUsing ~= 0 and camIsUsed and not isFocusedBoard do 
            Wait(2)
            
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
                    GreyOut(boardUsing, num, false)
                    SetFocusOnButton()
                    KeypressFocused()
                    SetBarButtons(num)
                else
                    ExecuteButtonFunction(num)
                end
            elseif IsDisabledControlJustPressed(0, 200) then -- Esc
                GreyOut(3, GetButtonId(), true)
                ExitBoard()
                FocusThread()
            elseif IsDisabledControlJustPressed(0, 204) then -- Tab

            end
        end
    end)
end

function KeypressFocused()
    CreateThread(function()
        while isFocusedBoard do 
            Wait(2)

            if IsDisabledControlJustPressed(0, 174) then -- <--
                if boardUsing == 1 then 

                elseif boardUsing == 2 then 
                    if CanChangeImage(GetButtonId(), -1) then 
                        PlaySoundFrontend(-1, "Paper_Shuffle", "DLC_HEIST_PLANNING_BOARD_SOUNDS", true)
                        ChangeImage(GetButtonId(), -1)
                    end
                elseif boardUsing == 3 then
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
                PlaySoundFrontend(-1, "Highlight_Accept", "DLC_HEIST_PLANNING_BOARD_SOUNDS", true)
                ExecuteButtonFunction(GetButtonId())
                UnFocusOnButton()
                KeypressUnfocused()
                isFocusedBoard = false 
                SetBarButtons()
            elseif IsDisabledControlJustPressed(0, 200) then -- Esc
                PlaySoundFrontend(-1, "Back", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
                GreyOut(boardUsing, GetButtonId(), true)
                UnFocusOnButton()
                KeypressUnfocused()
                isFocusedBoard = false 
                SetBarButtons()
            elseif IsDisabledControlJustPressed(0, 204) then -- Tab

            end
        end
    end)
end

-- vector3(2737.99, -374.45, -48.5)

CreateThread(function()
    while true do 
        Wait(GetFrameTime())
        if not heistInProgress then 
            if not isInGarage then 
                local distance = #(GetEntityCoords(PlayerPedId()) - vector3(759.08, -816.05, 25.3))
                if distance < 10 then 
                    DrawMarker(1, 759.08, -816.05, 25.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.75, 0.75, 0.5, 73, 200, 250, 204, false, false, 2, false)

                    if distance < 1.3 then 
                        HelpMsg("Press ~INPUT_CONTEXT~ to enter the arcade")
                        if IsControlPressed(0, 38) then 
                            --FadeTeleport(2737.99, -374.45, -49.0, 175.0)

                            DoScreenFadeOut(1000)
                            
                            while not IsScreenFadedOut() do
                                Wait(10)
                            end

                            SetEntityCoords(PlayerPedId(), 2737.99, -374.45, -49.0, true, false, false, false)
                            SetEntityHeading(PlayerPedId(), 175.0)

                            --NetworkConcealPlayer(PlayerId(), true, true)
                            
                            RequestScriptAudioBank("DLC_MPHEIST/HEIST_PLANNING_BOARD", false, -1)
                            boardType[1] = RequestScaleformMovie("CASINO_HEIST_BOARD_SETUP")
                            boardType[2] = RequestScaleformMovie("CASINO_HEIST_BOARD_PREP")
                            boardType[3] = RequestScaleformMovie("CASINO_HEIST_BOARD_FINALE")
                            barMenu = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS")
                            hPlayer = {GetPlayerServerId(PlayerId())} 
                            print(hPlayer[1])

                            while not HasScaleformMovieLoaded(boardType[3]) do 
                                Wait(10)
                            end
                            
                            SetupBoardInfo()

                            isInGarage = true
                            if approach ~= 0 and loot ~= 0 then
                                PrepBoardInfo()
                            end 
                        
                            if selectedGunman ~= 0 and selectedDriver ~= 0 and selectedHacker ~= 0 then 
                                FinalBoardInfo()
                            end

                            Wait(3000)

                            DoScreenFadeIn(2000)
                            ScaleformThread()
                        end
                    end
                else 
                    Wait(2000)
                end
            else
                local distance = #(GetEntityCoords(PlayerPedId()) - vector3(2737.99, -374.45, -48.5))
                if distance < 5 then 
                    DrawMarker(1, 2737.99, -374.45, -49.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.75, 0.75, 0.5, 73, 200, 250, 204, false, false, 2, false)

                    if distance < 1.0 then 
                        HelpMsg("Press ~INPUT_CONTEXT~ to exit the arcade")
                        if IsControlPressed(0, 38) then 
                            FadeTeleport(759.08, -816.05, 25.3, 275.0)
                            ReleaseNamedScriptAudioBank("DLC_MPHEIST/HEIST_PLANNING_BOARD")
                            TriggerServerEvent("sv:casinoheist:setHeistLeader", false)
                            
                            hPlayer = {} 
                            for i = 1, 3 do 
                                SetScaleformMovieAsNoLongerNeeded(boardType[i])
                            end
                            
                            SetScaleformMovieAsNoLongerNeeded(barMenu)

                            isInGarage = false
                        end
                    end
                else 
                    Wait(2000)
                end
            end
        else 
            Wait(10000)
        end
    end
end)

RegisterCommand("test_scale", function(src, args)
    --boardUsing = tonumber(args[1])
    RequestScriptAudioBank("DLC_MPHEIST/HEIST_PLANNING_BOARD", false, -1)
    boardType[1] = RequestScaleformMovie("CASINO_HEIST_BOARD_SETUP")
    boardType[2] = RequestScaleformMovie("CASINO_HEIST_BOARD_PREP")
    boardType[3] = RequestScaleformMovie("CASINO_HEIST_BOARD_FINALE")
    
    while not HasScaleformMovieLoaded(boardType[3]) do 
        Wait(10)
    end
    
    SetupBoardInfo()

    isInGarage = true
    if approach ~= 0 and loot ~= 0 then
        PrepBoardInfo()
    end 
                        
    if selectedGunman ~= 0 and selectedDriver ~= 0 and selectedHacker ~= 0 then 
        FinalBoardInfo()
    end


    ScaleformThread()
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

RegisterCommand("test_sevent", function()
    TriggerServerEvent("sv:casinoheist:startHeist", {hPlayer, approach, loot, playerCut[#hPlayer], selectedGunman, selectedLoadout, selectedDriver, selectedVehicle, selectedHacker, selectedKeycard, selectedEntrance, selectedExit, selectedBuyer, selectedEntryDisguise, selectedExitDisguise, boughtCleanVehicle, boughtDecoy})
end, false)