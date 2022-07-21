local camCoords = {
    vector3(2712.87, -372.6, -54.23),
    vector3(2709.8, -369.5, -54.23), 
    vector3(2712.95, -366.3, -54.23)
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

local camIsUsed = false
local isInGarage = false  
local doorOpen = false
local isInBuilding = false

local boardType = {
    RequestScaleformMovie("CASINO_HEIST_BOARD_SETUP"),
    RequestScaleformMovie("CASINO_HEIST_BOARD_PREP"),
    RequestScaleformMovie("CASINO_HEIST_BOARD_FINALE")
}

local todoList = {
    [1] = {
        {"Scope Out Casino", false},
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
        {"Player Cuts", false}
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
        {"Exit Disquise", false}
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
        {true, 8, 1},
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

local setupBoardPlacement = {
    [1] = {9, 9, 9, 9, 9},
    [2] = {10, 10, 10, 10, 10},
    [3] = {11, 12, 13, 8, 2},
    [4] = {14, 15, 16, 8, 3},
    [5] = {5, 6, 7, 0, 4} 
}

local prepBoardPlacement = {
    [1] = {10, 11, 12, 0, 14, 15},
    [2] = {5, 6, 7, 18, 16, 17},
    [3] = {9, 3, 4, 2, 8, 13}
}

local finalBoardPlacement = {
    [1] = {
        [1] = {2, 0, 8},
        [2] = {3, 0, 9},
        [3] = {4, 7, 10},
        [4] = {0, 6, 11},
        [5] = {12, 12, 12, 12}
    },
    [2] = {
        [1] = {2, 13, 8},
        [2] = {3, 14, 9},
        [3] = {4, 7, 10},
        [4] = {0, 6, 11},
        [5] = {12, 12, 12, 12}
    },
    [3] = {
        [1] = {2, 0, 8},
        [2] = {3, 0, 9},
        [3] = {4, 7, 10},
        [4] = {0, 6, 11},
        [5] = {12, 12, 12, 12}
    }
}

function StartCamWhiteboard()
    boardCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", camCoords[boardUsing], camCoords[boardUsing], camCoords[boardUsing], 0, 0, camHeading[boardUsing], 20.0, true, 2)
    RenderScriptCams(true, false, 1000, true, false)

    --while not HasScaleformMovieLoaded(boardType[boardUsing]) do 
    --    Wait(1)
    --end

    DisplayRadar(false)
    SetupBoardInfo()
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
    canUsing = false
    DestroyAllCams()
    RenderScriptCams(false, false, 1000, true, false)
    DisplayRadar(true)
    SetEntityVisible(PlayerPedId(), true)
end

local function ToDoList(i, num)
    if num == 2 then 
        BeginScaleformMovieMethod(boardType[2], "ADD_TODO_LIST_ITEM")
        ScaleformMovieMethodAddParamPlayerNameString(todoList[2][approach][i][1])
        ScaleformMovieMethodAddParamBool(todoList[2][approach][i][2])
        EndScaleformMovieMethod()
    else
        BeginScaleformMovieMethod(boardType[boardUsing], "ADD_TODO_LIST_ITEM")
        ScaleformMovieMethodAddParamPlayerNameString(todoList[boardUsing][i][1])
        ScaleformMovieMethodAddParamBool(todoList[boardUsing][i][2])
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
        BeginScaleformMovieMethod(boardType[boardUsing], "ADD_OPTIONAL_LIST_ITEM")
        ScaleformMovieMethodAddParamPlayerNameString(optionalList[boardUsing][i][1])
        ScaleformMovieMethodAddParamBool(optionalList[boardUsing][i][2])
        EndScaleformMovieMethod()
    end
end

local function Lock(i)
    BeginScaleformMovieMethod(boardType[1], "SET_PADLOCK")
    ScaleformMovieMethodAddParamInt(i + 4)
    ScaleformMovieMethodAddParamBool(lockList[i])
    EndScaleformMovieMethod()
end

local function SetImage(i)
    if images[boardUsing][i][1] then 
        BeginScaleformMovieMethod(boardType[boardUsing], "SET_BUTTON_IMAGE")
        ScaleformMovieMethodAddParamInt(images[boardUsing][i][2])
        ScaleformMovieMethodAddParamInt(images[boardUsing][i][3])
        EndScaleformMovieMethod()
        print(images[boardUsing][i][3]) 
    else 
        BeginScaleformMovieMethod(boardType[boardUsing], "SET_BUTTON_GREYED_OUT")
        ScaleformMovieMethodAddParamInt(images[boardUsing][i][2])
        ScaleformMovieMethodAddParamBool(not images[boardUsing][i][1])
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
    BeginScaleformMovieMethod(boardType[boardUsing], "SET_TARGET_TYPE")
    ScaleformMovieMethodAddParamPlayerNameString(lootString[1])
    EndScaleformMovieMethod()
end

local function SetMarker(row, line)
    if boardUsing == 1 then 
        if setupRow == 5 and setupLine == 3 and line == 1 then 
            setupLine = 5
        elseif setupRow == 5 and setupLine == 5 and line == -1 then 
            setupLine = 3
        else 
            setupLine = setupLine + line
            setupRow = setupRow + row
        end
        
        BeginScaleformMovieMethod(boardType[1], "SET_CURRENT_SELECTION")
        ScaleformMovieMethodAddParamInt(setupBoardPlacement[setupRow][setupLine])
        EndScaleformMovieMethod()
    elseif boardUsing == 2 then 
        if prepRow == 1 and prepLine == 3 and line == 1 then 
            prepLine = 5
        elseif prepRow == 1 and prepLine == 5 and line == -1 then 
            prepLine = 3
        else 
            prepRow = prepRow + row
            prepLine = prepLine + line
        end

        BeginScaleformMovieMethod(boardType[2], "SET_CURRENT_SELECTION")
        ScaleformMovieMethodAddParamInt(prepBoardPlacement[prepRow][prepLine])
        EndScaleformMovieMethod()
    elseif boardUsing == 3 then 
        if (finalRow == 1 or finalRow == 2) and finalLine == 1 and line == 1 and approach == 2 then 
            finalLine = 3
            print("test1")
        elseif (finalRow == 1 or finalRow == 2) and finalLine == 3 and line == -1 and approach == 2 then
            finalLine = 1
            print("test2")
        else 
            finalRow = finalRow + row
            finalLine = finalLine + line
            print("test3")
        end
        BeginScaleformMovieMethod(boardType[3], "SET_CURRENT_SELECTION")
        ScaleformMovieMethodAddParamInt(finalBoardPlacement[approach][finalRow][finalLine])
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
    ScaleformMovieMethodAddParamInt(7 + player)
    ScaleformMovieMethodAddParamInt(cut)
    EndScaleformMovieMethod()
end

local function SetDataFinal(entrance, exit, buyer, outfitin, outfitout)
    BeginScaleformMovieMethod(boardType[3], "SET_HEADINGS")
    ScaleformMovieMethodAddParamPlayerNameString(approachString[approach])
    ScaleformMovieMethodAddParamPlayerNameString(lootString[loot])
    ScaleformMovieMethodAddParamInt(25000)
    ScaleformMovieMethodAddParamInt(potential[difficulty][loot])
    ScaleformMovieMethodAddParamInt(100000)
    ScaleformMovieMethodAddParamPlayerNameString("ENTRANCE")
    ScaleformMovieMethodAddParamPlayerNameString("EXIT")
    ScaleformMovieMethodAddParamPlayerNameString("BUYER")
    ScaleformMovieMethodAddParamPlayerNameString("OUTFITIN")
    ScaleformMovieMethodAddParamPlayerNameString("OUTFITOUT")
    EndScaleformMovieMethod()
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

    ButtonId
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

    ImageId 

    ButtonId 2-3
    1  = Waste Disposal
    2  = Main Door
    3  = Roof Terrace 1
    4  = Roof 1 North
    5  = Roof Terrace 2 
    6  = Security Tunnel
    7  = Sewer
    8  = Roof Terrace 3
    9  = Roof 2 South
    10 = Roof Terrace 4
    11 = Staff Lobby

    ButtonId 4
    1 = Low Level
    2 = Mid Level
    3 = High Level

    ButtonId 13
    1 = Bugstar
    2 = Maintenance
    3 = Gruppe Sechs
    4 = Yung Ancestor

    ButtonId 14 
    1 = Fire Fighter
    2 = NOOSE
    3 = High Roller
--]]

testint = 1

function SetupBoardInfo()
    if boardUsing == 1 then 
        for i = 1, #todoList[1] do 
           ToDoList(i, 1)
        end
        
        for i = 1, #todoList[2][approach] do 
            ToDoList(i, 2)
        end 

        for i = 1, #optionalList[1] do 
            OptionalList(i, 1)
        end

        for i = 1, #optionalList[2][approach] do 
            OptionalList(i, 2)
        end

        for i = 1, #lockList do 
            Lock(i)
        end

        for i = 1, #images[1] do 
            SetImage(i)
        end

        SetLootString()

        BeginScaleformMovieMethod(boardType[1], "SET_BLUEPRINT_VISIBLE")
        ScaleformMovieMethodAddParamBool(true)
        EndScaleformMovieMethod()

    --elseif boardUsing == 2 then 
        --for i = 1, 6 do 
        --    ToDoList(i)
        --end

        --for i = 1, 8 do 
        --   OptionalList(i)
        --end

        SetLootAndApproach()
        for i = 1, 4 do 
            SetSpecificPreps(i)
        end

        SetPoster(-1)

        BeginScaleformMovieMethod(boardType[2], "SET_CURRENT_SELECTION")
        ScaleformMovieMethodAddParamInt(19)
        EndScaleformMovieMethod()

    elseif boardUsing == 3 then 
        for i = 1, #todoList[3] do 
            ToDoList(i, 3)
        end
        
        for i = 1, #optionalList[3] do 
            OptionalList(i, 3)
        end

        SetDataFinal(0, 0, 0, 0, 0)

        SetCrewCut(1, 100)

        BeginScaleformMovieMethod(boardType[3], "SET_CURRENT_SELECTION")
        ScaleformMovieMethodAddParamInt(finalBoardPlacement[approach][finalRow][finalLine])
        EndScaleformMovieMethod()

        BeginScaleformMovieMethod(boardType[3], "SET_NOT_SELECTED_VISIBLE")
        ScaleformMovieMethodAddParamInt(13)
        ScaleformMovieMethodAddParamBool(true)
        EndScaleformMovieMethod()

        BeginScaleformMovieMethod(boardType[3], "SET_BUTTON_VISIBLE")
        ScaleformMovieMethodAddParamInt(13)
        ScaleformMovieMethodAddParamBool(false)
        EndScaleformMovieMethod()

        BeginScaleformMovieMethod(boardType[3], "SET_BUTTON_VISIBLE")
        ScaleformMovieMethodAddParamInt(14)
        ScaleformMovieMethodAddParamBool(false)
        EndScaleformMovieMethod()

        BeginScaleformMovieMethod(boardType[3], "SET_BUTTON_VISIBLE")
        ScaleformMovieMethodAddParamInt(9)
        ScaleformMovieMethodAddParamBool(false)
        EndScaleformMovieMethod()

        BeginScaleformMovieMethod(boardType[3], "SET_BUTTON_VISIBLE")
        ScaleformMovieMethodAddParamInt(10)
        ScaleformMovieMethodAddParamBool(false)
        EndScaleformMovieMethod()

        BeginScaleformMovieMethod(boardType[3], "SET_BUTTON_VISIBLE")
        ScaleformMovieMethodAddParamInt(11)
        ScaleformMovieMethodAddParamBool(false)
        EndScaleformMovieMethod()
    end
end

CreateThread(function()
    while true do 
        Wait(0)
        if isInGarage then 
            DrawScaleformMovie_3dSolid(boardType[1], 2713.3, -366.2, -54.23418, 0.0, 0.0, camHeading[1], 1.0, 1.0, 1.0, 3.0, 1.7, 1.0, 0)
            DrawScaleformMovie_3dSolid(boardType[2], 2716.27, -369.93, -54.23418, 0.0, 0.0, camHeading[2] - 180, 1.0, 1.0, 1.0, 3.1, 1.7, 1.0, 0)
            DrawScaleformMovie_3dSolid(boardType[3], 2712.58, -372.65, -54.23418, 0.0, 0.0, camHeading[3], 1.0, 1.0, 1.0, 3.0, 1.7, 1.0, 0)
        else 
            Wait(1000)
        end
    end
end)

CreateThread(function()
    while true do 
        Wait(0)
        if camIsUsed then 
            DisableAllControlActions(2)
        else 
            Wait(1000)
        end
    end
end)

CreateThread(function()
    while true do 
        Wait(2)
        if boardUsing == 1 and camIsUsed then 
            if IsDisabledControlJustPressed(0, 32) then -- W
                if setupRow ~= 1 then
                    SetMarker(-1, 0)
                end
            elseif IsDisabledControlJustPressed(0, 33) then -- S
                if setupRow ~= 5 then 
                    SetMarker(1, 0)
                end
            elseif IsDisabledControlJustPressed(0, 34) then -- A
                if setupLine ~= 1 then 
                    SetMarker(0, -1)
                end
            elseif IsDisabledControlJustPressed(0, 35) then -- D
                if setupLine ~= 5 then 
                    SetMarker(0, 1)
                end
            elseif IsDisabledControlJustPressed(0, 38) then -- E
                ChangeCam(1)
            elseif IsDisabledControlJustPressed(0, 191) then -- Enter

            elseif IsDisabledControlJustPressed(0, 200) then -- Esc
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
        if boardUsing == 2 and camIsUsed then 
            if IsDisabledControlJustPressed(0, 32) then -- W
                --print(prepRow)
                if prepRow ~= 1 then 
                    SetMarker(-1, 0)
                end
            elseif IsDisabledControlJustPressed(0, 33) then -- S
                if prepRow ~= 3 then 
                    SetMarker(1, 0)
                end
            elseif IsDisabledControlJustPressed(0, 34) then -- A
                if prepLine ~= 1 then 
                    --print(prepLine)
                    SetMarker(0, -1)
                end
            elseif IsDisabledControlJustPressed(0, 35) then -- D
                if prepLine ~= 6 then 
                    SetMarker(0, 1)
                end
            elseif IsDisabledControlJustPressed(0, 44) then -- Q
                ChangeCam(-1)
            elseif IsDisabledControlJustPressed(0, 38) then -- E
                ChangeCam(1)
            elseif IsDisabledControlJustPressed(0, 191) then -- Enter

            elseif IsDisabledControlJustPressed(0, 200) then -- Esc
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
        if boardUsing == 3 and camIsUsed then 
            if IsDisabledControlJustPressed(0, 32) then -- W
                if finalRow ~= 1 --[[and (finalRow ~= 2 and finalLine ~= 2)]] then 
                    SetMarker(-1, 0)
                end
            elseif IsDisabledControlJustPressed(0, 33) then -- S
                if finalRow ~= 5 then 
                    SetMarker(1, 0)
                end
            elseif IsDisabledControlJustPressed(0, 34) then -- A
                if finalLine ~= 1 then 
                    --print(finalLine)
                    SetMarker(0, -1)
                end
            elseif IsDisabledControlJustPressed(0, 35) then -- D
                if finalLine ~= 3 then 
                    SetMarker(0, 1)
                end
            elseif IsDisabledControlJustPressed(0, 44) then -- Q
                ChangeCam(-1)
            elseif IsDisabledControlJustPressed(0, 191) then -- Enter

            elseif IsDisabledControlJustPressed(0, 200) then -- Esc
                ExitBoard()
            elseif IsDisabledControlJustPressed(0, 204) then -- Tab

            end
        else 
            Wait(1000)
        end
    end
end)

RegisterCommand("camarcade", function(src, args)
    boardUsing = tonumber(args[1])
    StartCamWhiteboard()
end, false)

RegisterCommand("test_scale", function(src, args)
    boardUsing = tonumber(args[1])
    SetupBoardInfo()
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