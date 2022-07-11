local camCoords = {
    [1] = {2712.87, -372.6, -54.23},
    [2] = {2709.8, -369.5, -54.23},
    [3] = {2712.95, -366.3, -54.23}
}
local camHeading = {0.0, 270.0, 180.0}
local boardCam = 0
local boardUsing = 0
local setupRow  = 3
local setupLine = 1

local boardType = {
    RequestScaleformMovie("CASINO_HEIST_BOARD_SETUP"),
    RequestScaleformMovie("CASINO_HEIST_BOARD_PREP"),
    RequestScaleformMovie("CASINO_HEIST_BOARD_FINAL")
}

local todoList = {
    [1] = {
        {"Scope Out Casino", false},
        {"Scope Out Vault Contents", false},
        {"Select Approach", false}
    },
    [2] = {
        [1] = {},
        [2] = {},
        [3] = {}
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
        [1] = {},
        [2] = {},
        [3] = {}
    },
    [3] = {
        {"Decoy Gunman", false},
        {"Clean Vehicle", false},
        {"Exit Disquise", false}
    }
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
        {true, 12, 11}, 
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
    [5] = {5, 6, 7, 0, 4} -- 4 = [5]
}

function StartCamWhiteboard(board)
    boardCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", camCoords[board][1], camCoords[board][2], camCoords[board][3], 0, 0, camHeading[board], 20.0, true, 2)
    RenderScriptCams(true, false, 1000, true, false)

    while not HasScaleformMovieLoaded(boardType[board]) do 
        Wait(1)
    end

    DisplayRadar(false)
    SetupBoardInfo(board)
    boardUsing = board
end

local function ToDoList(board, i)
    BeginScaleformMovieMethod(boardType[board], "ADD_TODO_LIST_ITEM")
    ScaleformMovieMethodAddParamPlayerNameString(todoList[board][i][1])
    ScaleformMovieMethodAddParamBool(todoList[board][i][2])
    EndScaleformMovieMethod()
end

local function OptionalList(board, i)
    BeginScaleformMovieMethod(boardType[board], "ADD_OPTIONAL_LIST_ITEM")
    ScaleformMovieMethodAddParamPlayerNameString(optionalList[board][i][1])
    ScaleformMovieMethodAddParamBool(optionalList[board][i][2])
    EndScaleformMovieMethod()
end

local function Lock(i)
    BeginScaleformMovieMethod(boardType[1], "SET_PADLOCK")
    ScaleformMovieMethodAddParamInt(i + 4)
    ScaleformMovieMethodAddParamBool(lockList[i])
    EndScaleformMovieMethod()
end

local function SetImage(board, i)
    if images[board][i][1] then 
        BeginScaleformMovieMethod(boardType[board], "SET_BUTTON_IMAGE")
        ScaleformMovieMethodAddParamInt(images[board][i][2])
        ScaleformMovieMethodAddParamInt(images[board][i][3])
        EndScaleformMovieMethod()
        print(images[board][i][3]) 
    else 
        BeginScaleformMovieMethod(boardType[board], "SET_BUTTON_GREYED_OUT")
        ScaleformMovieMethodAddParamInt(images[board][i][2])
        ScaleformMovieMethodAddParamBool(not images[board][i][1])
        EndScaleformMovieMethod()
    end
end

local function SetArrows(board, i)
    BeginScaleformMovieMethod(boardType[board], "SET_SELECTION_ARROWS_VISIBLE")
    ScaleformMovieMethodAddParamInt(i + 10)
    ScaleformMovieMethodAddParamBool(arrowsVisible[board][i])
    EndScaleformMovieMethod()
end

local function SetMarker(board, row, line)
    if board == 1 then 
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
    elseif board == 2 then 
        BeginScaleformMovieMethod(boardType[2], "SET_CURRENT_SELECTION")
        ScaleformMovieMethodAddParamInt()
        EndScaleformMovieMethod()
    elseif board == 3 then 
        BeginScaleformMovieMethod(boardType[3], "SET_CURRENT_SELECTION")
        ScaleformMovieMethodAddParamInt()
        EndScaleformMovieMethod()
    end
end

local function tt()
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
--]]

testint = 1

function SetupBoardInfo(board)
    if board == 1 then 
        for i = 1, #todoList[1] do 
           ToDoList(1, i)
        end

        for i = 1, #optionalList[1] do 
            OptionalList(1, i)
        end

        for i = 1, #lockList do 
            Lock(i)
        end

        --for i = 1, #arrowsVisible do 
        --    SetArrows(1, i)
        --end

        for i = 1, #images[1] do 
            SetImage(1, i)
        end
        --BeginScaleformMovieMethod(boardType[1], "INITIALISE")
        --ScaleformMovieMethodAddParamInt(1)
        --EndScaleformMovieMethod()

        BeginScaleformMovieMethod(boardType[1], "SET_CURRENT_SELECTION")
        ScaleformMovieMethodAddParamInt(11)
        EndScaleformMovieMethod()

        BeginScaleformMovieMethod(boardType[1], "SET_CURRENT_SELECTION")
        ScaleformMovieMethodAddParamInt(startId)
        EndScaleformMovieMethod()

        BeginScaleformMovieMethod(boardType[1], "SET_BLUEPRINT_VISIBLE")
        ScaleformMovieMethodAddParamBool(true)
        EndScaleformMovieMethod()

        --BeginScaleformMovieMethod(boardType[1], "SET_BUTTON_IMAGE")
        --ScaleformMovieMethodAddParamInt(11)
        --ScaleformMovieMethodAddParamInt(testint)
        --EndScaleformMovieMethod()

        --print(test)

        BeginScaleformMovieMethod(boardType[1], "SET_TARGET_TYPE")
        ScaleformMovieMethodAddParamPlayerNameString("CASH")
        EndScaleformMovieMethod()

        --BeginScaleformMovieMethod(boardType[1], "TXD_HAS_LOADED")
        --ScaleformMovieMethodAddParamTextureNameString("casino_heist_board_setup")
        --ScaleformMovieMethodAddParamBool(true)
        --ScaleformMovieMethodAddParamInt(1)
        --testt = EndScaleformMovieMethodReturnValue()

        --print(testt)
        --BeginScaleformMovieMethod(boardType[1], "SHOW_OVERLAY")
        --ScaleformMovieMethodAddParamPlayerNameString("TITLE")
        --ScaleformMovieMethodAddParamPlayerNameString("MESSAGE")
        --ScaleformMovieMethodAddParamPlayerNameString("ACCEPT")
        --ScaleformMovieMethodAddParamPlayerNameString("CANCEL")
        --EndScaleformMovieMethod()
        

    elseif board == 2 then 
        for i = 1, #todoList[2] do 
            ToDoList(2, i)
        end

        for i = 1, #optionalList[2] do 
           OptionalList(2, i)
        end
    elseif board == 3 then 
        for i = 1, #todoList[3] do 
            ToDoList(3, i)
        end
 
        for i = 1, #optionalList[3] do 
            OptionalList(3, i)
        end
    end
end

CreateThread(function()
    while true do 
        Wait(0)
        if boardUsing == 1 then 
            --DrawScaleformMovie(boardType[1], 0.5101, 0.5, 0.58, 0.78, 255, 255, 255, 255)
            DrawScaleformMovie_3dSolid(boardType[1], 2713.3, -366.2, -54.23418, 0.0, 0.0, camHeading[1], 1.0, 1.0, 1.0, 3.0, 1.7, 1.0, 0)
        elseif boardUsing == 2 then 
            DrawScaleformMovie(boardType[2], 0.5101, 0.5, 0.58, 0.78, 255, 255, 255, 255)
        elseif boardUsing == 3 then 
            DrawScaleformMovie(boardType[3], 0.5101, 0.5, 0.58, 0.78, 255, 255, 255, 255)
        else 
            Wait(1000)
        end
    end
end)

CreateThread(function()
    while true do 
        Wait(0)
        if boardUsing == 1 or boardUsing == 2 or boardUsing == 3 then 
            --DisableAllControlActions(2)
        else 
            Wait(1000)
        end
    end
end)

CreateThread(function()
    while true do 
        Wait(2)
        if boardUsing == 1 or boardUsing == 2 or boardUsing == 3 then 
            if IsDisabledControlJustPressed(0, 32) then -- W
                --print('w')
                if setupRow ~= 1 then
                    SetMarker(1, -1, 0)
                end
            elseif IsDisabledControlJustPressed(0, 33) then -- S
                --print('s')
                if setupRow ~= 5 then 
                    SetMarker(1, 1, 0)
                end
            elseif IsDisabledControlJustPressed(0, 34) then -- A
                --print('a')
                if setupLine ~= 1 then 
                    SetMarker(1, 0, -1)
                end
            elseif IsDisabledControlJustPressed(0, 35) then -- D
                --print('d')
                if setupLine ~= 5 then 
                    SetMarker(1, 0, 1)
                end
            end
        else 
            Wait(1000)
        end
    end
end)

RegisterCommand("camarcade", function(src, args)
    StartCamWhiteboard(tonumber(args[1]))
end, false)

RegisterCommand("test_scale", function()
    boardUsing = 1
end, false)