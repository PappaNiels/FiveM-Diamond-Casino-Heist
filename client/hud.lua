showTeamLives = false 
showTake = false 
showTimer = false 

local test = false

local teamlivesColour = {255, 255, 255, 255}

local amountSize = 0.5
local height = 0.903
local tw = 1.35
local takef = ""

local timeExpired = 0
local min = 0
local ten = 0
local sec = 0
local timerColour = {255, 255, 255, 500}
local endScreen = {}
local txtTake = {
    "POTENTIAL TAKE",
    "ACTUAL TAKE",
    "% CUT OF THE TAKE",
    "TOTAL CASH EARNED"
}

local function StartTimer()
    local timerActive = true
    local timeTot = hacker[selectedHacker][3 + alarmTriggered]

    min = math.floor(timeTot / 60)
    ten = math.floor((timeTot - (min * 60)) / 10)
    sec = math.floor(timeTot - (min * 60) - (ten * 10))
    
    CreateThread(function()
        while timerActive do 
            Wait(1000)

            if sec == 0 then 
                sec = 9
                if ten == 0 then 
                    ten = 5
                    min = min - 1
                else    
                    ten = ten - 1
                end
            else 
                sec = sec - 1
            end

            if min == 0 and ten == 0 and sec < 5 then 
                timerColour = {201, 37, 37, 255}
                if sec == 0 then 
                    timerActive = false
                    VaultCheck()
                end
            end
        end
    end)
end

local function FormatTake()
    local len = string.len(tostring(take))

    if len == 4 then 
        takef = string.sub(take, 1, 1) .. "," .. string.sub(take, 2, 4)
        height = 0.903
        amountSize = 0.5
    elseif len == 5 then 
        takef = string.sub(take, 1, 2) .. "," .. string.sub(take, 3, 5)
        height = 0.903
        amountSize = 0.5
    elseif len == 6 then 
        takef = string.sub(take, 1, 3) .. "," .. string.sub(take, 4, 6)
        height = 0.903
        amountSize = 0.5
    elseif len == 7 then 
        takef = string.sub(take, 1, 1) .. "," .. string.sub(take, 2, 4) .. "," .. string.sub(take, 5, 7)
        height = 0.908
        amountSize = 0.4
    end
end

local function ClearField(i, k)
    BeginScaleformMovieMethod(endScreen[i], "CLEARUP")
    ScaleformMovieMethodAddParamInt(k)
    EndScaleformMovieMethod()
end

local function SetMoney(i, start, limit, k)

    BeginScaleformMovieMethod(endScreen[i], "ADD_INCREMENTAL_CASH_WON_STEP")
    ScaleformMovieMethodAddParamInt(1)
    ScaleformMovieMethodAddParamInt(20)
    ScaleformMovieMethodAddParamInt(start)
    ScaleformMovieMethodAddParamInt(limit)
    if k == 3 then 
        ScaleformMovieMethodAddParamPlayerNameString("50" .. txtTake[k])
    else
        ScaleformMovieMethodAddParamPlayerNameString(txtTake[k])
    end
    ScaleformMovieMethodAddParamPlayerNameString("")
    ScaleformMovieMethodAddParamPlayerNameString("")
    ScaleformMovieMethodAddParamInt(3)
    ScaleformMovieMethodAddParamInt(3)
    EndScaleformMovieMethod()
end

function ShowTimerbars(bool)
    DrawTeamlives()

    if bool then 
        DrawTake()
    end
end

function HideTimerBars()
    showTeamLives = false 
    showTake = false
end

RegisterNetEvent("cl:casinoheist:syncteamlives", function(lives)
    teamlives = lives

    if teamlives < 1 then 
        tw = 1.347
        teamlivesColour = {201, 35, 37, 255}
    end
end)

RegisterNetEvent("cl:casinoheist:synctake", function(_take)
    take = _take
    FormatTake()
end)

function DrawTeamlives()
    LoadTexture("timerbars")
    showTeamLives = true

    CreateThread(function()
        while showTeamLives do 
            Wait(GetFrameTime())

            SetTextColour(teamlivesColour[1], teamlivesColour[2], teamlivesColour[3], teamlivesColour[4])
            SetTextScale(0.28, 0.28)
            BeginTextCommandDisplayText("STRING")
            AddTextComponentSubstringPlayerName("TEAM LIVES")
            EndTextCommandDisplayText(GetXTextPlace(1.126), 0.954)

            SetTextColour(teamlivesColour[1], teamlivesColour[2], teamlivesColour[3], teamlivesColour[4])
            SetTextScale(0.47, 0.47)
            BeginTextCommandDisplayText("STRING")
            AddTextComponentSubstringPlayerName(tostring(teamlives))
            EndTextCommandDisplayText(GetXTextPlace(tw), 0.945)

            if teamlives > 1 then 
                DrawSpriteCut("timerbars", "all_red_bg", 1.094, 0.962, 600.0, 65.0, 255)
            else 
                DrawSpriteCut("timerbars", "all_black_bg", 1.232, 0.962, 300.0, 65.0, 140)
            end 
        end
    end)
end

function DrawTake()
    FormatTake()
    showTake = true

    CreateThread(function()
        while showTake do 
            Wait(GetFrameTime())

            SetTextScale(0.28, 0.28)
            BeginTextCommandDisplayText("STRING")
            AddTextComponentSubstringPlayerName("TAKE")
            EndTextCommandDisplayText(GetXTextPlace(1.174), 0.915)

            BeginTextCommandGetWidth("STRING")
            AddTextComponentSubstringPlayerName("$" .. takef) -- 1.2
            w = EndTextCommandGetWidth(1)

            SetTextScale(0.0, amountSize)
            BeginTextCommandDisplayText("STRING")
            AddTextComponentSubstringPlayerName("$" .. takef)
            EndTextCommandDisplayText(GetXTextPlace(-0.5226 * w + 1.3458), height)

            DrawSpriteCut("timerbars", "all_black_bg", 1.232, 0.922, 300.0, 65.0, 140)
        end
    end)
end

function DrawTimer()
    showTimer = true
    StartTimer()

    CreateThread(function()
        while showTimer do 
            Wait(GetFrameTime())
            
            SetTextColour(timerColour[1], timerColour[2], timerColour[3], timerColour[4])
            SetTextScale(0.28, 0.28)
            BeginTextCommandDisplayText("STRING")
            AddTextComponentSubstringPlayerName("TIME")
            EndTextCommandDisplayText(0.8815, 0.875)

            SetTextColour(timerColour[1], timerColour[2], timerColour[3], timerColour[4])

            BeginTextCommandGetWidth("STRING")
            AddTextComponentSubstringPlayerName("0" .. min .. ":" .. ten .. sec)
            w = EndTextCommandGetWidth(1)

            SetTextScale(0.5, 0.5)
            BeginTextCommandDisplayText("STRING")
            AddTextComponentSubstringPlayerName("0" .. min .. ":" .. ten .. sec)
            EndTextCommandDisplayText(GetXTextPlace(-0.8097 * w + 1.3673181), 0.864)

            DrawSpriteCut("timerbars", "all_black_bg", 1.232, 0.882, 300.0, 65.0, 140)
        end
    end)
end

function EndScreen()
    AnimpostfxStop("MP_Celeb_Win")
    AnimpostfxPlay("MP_Celeb_Win", 1000, true)

    StopCutscene(false)
    --Citizen.InvokeNative(0x8D9DF6ECA8768583, GetThread())

    Wait(1000)

    endScreen[1] = RequestScaleformMovie("HEIST_CELEBRATION_BG")
    endScreen[2] = RequestScaleformMovie("HEIST_CELEBRATION_FG")
    endScreen[3] = RequestScaleformMovie("HEIST_CELEBRATION")
    
    while not HasScaleformMovieLoaded(endScreen[1]) do 
        Wait(10)
    end
    while not HasScaleformMovieLoaded(endScreen[2]) do 
        Wait(10)
    end
    while not HasScaleformMovieLoaded(endScreen[3]) do 
        Wait(10)
    end
    
    local txt = {
        "PLATINUM",
        "GOLD",
        "SILVER",
        "BRONZE"
    }
    
    --playerCount = 4
    
    --CAM::_0x5A43C76F7FC7BA5F()
    --Citizen.InvokeNative(0x5A43C76F7FC7BA5F)
    
    
    for i = 1, 3 do 
        
        ClearField(i, 1)
        
        BeginScaleformMovieMethod(endScreen[i], "CREATE_STAT_WALL")
        ScaleformMovieMethodAddParamInt(1)
        ScaleformMovieMethodAddParamPlayerNameString("HUD_COLOUR_HSHARD")
        ScaleformMovieMethodAddParamInt(1)
        EndScaleformMovieMethod()
        
        BeginScaleformMovieMethod(endScreen[i], "ADD_BACKGROUND_TO_WALL")
        ScaleformMovieMethodAddParamInt(1)
        ScaleformMovieMethodAddParamInt(80)
        ScaleformMovieMethodAddParamInt(8)
        EndScaleformMovieMethod()
        
        BeginScaleformMovieMethod(endScreen[i], "ADD_MISSION_RESULT_TO_WALL")
        ScaleformMovieMethodAddParamInt(1)
        ScaleformMovieMethodAddParamPlayerNameString("Diamond Casino Heist")
        ScaleformMovieMethodAddParamPlayerNameString("PASSED")
        ScaleformMovieMethodAddParamPlayerNameString("")
        ScaleformMovieMethodAddParamBool(true)
        ScaleformMovieMethodAddParamBool(true)
        ScaleformMovieMethodAddParamBool(true)
        EndScaleformMovieMethod()
        
        BeginScaleformMovieMethod(endScreen[i], "CREATE_STAT_TABLE")
        ScaleformMovieMethodAddParamInt(1)
        ScaleformMovieMethodAddParamInt(10)
        EndScaleformMovieMethod()
        
        for j = 1, 4 do 
            BeginScaleformMovieMethod(endScreen[i], "ADD_STAT_TO_TABLE")
            ScaleformMovieMethodAddParamInt(1)
            ScaleformMovieMethodAddParamInt(10)
            ScaleformMovieMethodAddParamPlayerNameString("~w~" .. GetPlayerName(PlayerId()))
            
            ScaleformMovieMethodAddParamPlayerNameString("~HUD_COLOUR_" .. txt[j] .. "~" .. txt[j])
            ScaleformMovieMethodAddParamBool(true)
            ScaleformMovieMethodAddParamBool(true)
            ScaleformMovieMethodAddParamBool(false)
            ScaleformMovieMethodAddParamBool(false)
            ScaleformMovieMethodAddParamInt(0)
            EndScaleformMovieMethod()
        end 
        
        BeginScaleformMovieMethod(endScreen[i], "ADD_STAT_TABLE_TO_WALL")
        ScaleformMovieMethodAddParamInt(1)
        ScaleformMovieMethodAddParamInt(10)
        EndScaleformMovieMethod()
        
        BeginScaleformMovieMethod(endScreen[i], "CREATE_INCREMENTAL_CASH_ANIMATION")
        ScaleformMovieMethodAddParamInt(1)
        ScaleformMovieMethodAddParamInt(20)
        EndScaleformMovieMethod()
        
        SetMoney(i, 0, 200000, 1)
        SetMoney(i, 200000, 100000, 2)
        SetMoney(i, 100000, 50000, 3)
        SetMoney(i, 50000, 50000, 4)
        
        BeginScaleformMovieMethod(endScreen[i], "ADD_JOB_POINTS_TO_WALL")
        ScaleformMovieMethodAddParamInt(1)
        ScaleformMovieMethodAddParamInt(15)
        ScaleformMovieMethodAddParamInt(2)
        EndScaleformMovieMethod()
        
        BeginScaleformMovieMethod(endScreen[i], "ADD_REP_POINTS_AND_RANK_BAR_TO_WALL")
        ScaleformMovieMethodAddParamInt(1)
        ScaleformMovieMethodAddParamInt(3500)
        ScaleformMovieMethodAddParamInt(5000)
        ScaleformMovieMethodAddParamInt(6000)
        ScaleformMovieMethodAddParamInt(8000)
        ScaleformMovieMethodAddParamInt(68)
        ScaleformMovieMethodAddParamInt(69)
        ScaleformMovieMethodAddParamPlayerNameString("LEVEL UP")
        ScaleformMovieMethodAddParamPlayerNameString("RANK")
        EndScaleformMovieMethod()
        
        BeginScaleformMovieMethod(endScreen[i], "SHOW_STAT_WALL")
        ScaleformMovieMethodAddParamInt(1)
        EndScaleformMovieMethod()
        
        ClearField(i, 1)
    end

    PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", 1)
    
    draw = true
    
    CreateThread(function()
        while draw do 
            Wait(GetFrameTime())

            DisableAllControlActions(0)
            DrawScaleformMovieFullscreenMasked(endScreen[1], endScreen[2], 255, 255, 255, 255)
            DrawScaleformMovieFullscreen(endScreen[3], 255, 255, 255, 255, 0)
        end
    end)
    
    Wait(29000)
    
    draw = false
    AnimpostfxStop("MP_Celeb_Win")

    for i = 1, 3 do 
        SetScaleformMovieAsNoLongerNeeded(endScreen[i])
    end
end

RegisterCommand("test_cend", EndScreen, false)

RegisterCommand("test_sec", function() 
    --FormatTimer()
    --test = true
    DrawTeamlives()
    DrawTake()
    DrawTimer()
    --loadTeamlives = true 
    --loadTake = true 
    --loadTimer = true
    --StartTimer()
 end, false)