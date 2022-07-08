local camCoords = {
    [1] = {2712.87, -372.6, -54.23},
    [2] = {2709.8, -369.5, -54.23},
    [3] = {2712.95, -366.3, -54.23}
}
local camHeading = {0.0, 270.0, 180.0}
local boardCam = 0
local boardUsing = 0

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
    [2] = {},
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
    [2] = {},
    [3] = {
        {"Decoy Gunman", false},
        {"Clean Vehicle", false},
        {"Exit Disquise", false}
    }
}

local lootString = {
    "CASH",
    "ARTWORK",
    "GOLD",
    "DIAMONDS"
}

function StartCamWhiteboard(board)
    boardCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", camCoords[board][1], camCoords[board][2], camCoords[board][3], 0, 0, camHeading[board], 20.0, true, 2)
    RenderScriptCams(true, false, 1000, true, false)

    while not HasScaleformMovieLoaded(boardType[board]) do 
        Wait(1)
    end

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


function SetupBoardInfo(board)
    if board == 1 then 
        for i = 1, #todoList[1] do 
           ToDoList(1, i)
        end

        for i = 1, #optionalList[1] do 
            OptionalList(1, i)
        end

        BeginScaleformMovieMethod(boardType[1], "SET_CURRECT_SELECTION")
        ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(2, 38, true))
        EndScaleformMovieMethod()

        BeginScaleformMovieMethod(boardType[1], "SET_BLUEPRINT_VISIBLE")
        ScaleformMovieMethodAddParamBool(true)
        EndScaleformMovieMethod()

        BeginScaleformMovieMethod(boardType[1], "GET_CURRENT_SELECTION")
        --ScaleformMovieMethodAddParamInt(1)
        --ScaleformMovieMethodAddParamBool(false)
        test = EndScaleformMovieMethodReturnValue()

        print(test)

        BeginScaleformMovieMethod(boardType[1], "SET_TARGET_TYPE")
        ScaleformMovieMethodAddParamPlayerNameString("ARTWORK")
        EndScaleformMovieMethod()

        BeginScaleformMovieMethod(boardType[1], "SET_INPUT_EVENT")
        ScaleformMovieMethodAddParamInt(1)
        --ScaleformMovieMethodAddParamBool(true)
        EndScaleformMovieMethod()

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
            DrawScaleformMovie(boardType[1], 0.5101, 0.5, 0.58, 0.78, 255, 255, 255, 255)
        elseif boardUsing == 2 then 
            DrawScaleformMovie(boardType[2], 0.5101, 0.5, 0.58, 0.78, 255, 255, 255, 255)
        elseif boardUsing == 3 then 
            DrawScaleformMovie(boardType[3], 0.5101, 0.5, 0.58, 0.78, 255, 255, 255, 255)
        else 
            Wait(1000)
        end
    end
end)

RegisterCommand("camarcade", function(src, args)
    StartCamWhiteboard(tonumber(args[1]))
end, false)

function ButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

function Button(ControlButton)
    N_0xe83a3e3557a56640(ControlButton)
end

function setupScaleform(scaleform)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end

    -- draw it once to set up layout
    DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 0, 0)

    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(0)
    Button(GetControlInstructionalButton(2, 191, true))
    ButtonMessage("This is enter!")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(1)
    Button(GetControlInstructionalButton(2, 194, true)) -- The button to display
    ButtonMessage("This is backspace!") -- the message to display next to it
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(2)
    Button(GetControlInstructionalButton(2, 193, true))
    ButtonMessage("This is space!")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(3)
    Button(GetControlInstructionalButton(2, 192, true))
    ButtonMessage("This is tab!")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()

    return scaleform
end