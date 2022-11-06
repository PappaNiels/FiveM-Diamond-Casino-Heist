loadTeamlives = false 
loadTake = false 
loadTimer = false 

local test = false

local teamlivesColour = {255, 255, 255, 500}

local amountSize = 0.5
local height = 0.903
local tw = 1.35
local takef = ""

local timeExpired = 0
local min = 1
local ten = 0
local sec = 0
local timerColour = {255, 255, 255, 500}

local function StartTimer()
    local timerActive = true

    CreateThread(function()
        while timerActive do 
            Wait(1000)
            timeExpired = timeExpired + 1000

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

            if timeExpired >= --[[hacker[hackerSelected][3 + alarmTriggered]] 60000 - 5000 then 
                timerColour = {201, 37, 37, 255}
                if timeExpired == --[[hacker[hackerSelected][3 + alarmTriggered]] 60000 then 
                    timerActive = false
                end
            end
        end
    end)
end

local function FormatTake()
    -- 4 = 1.285 5 = 1.2675 6 = 1.25 7 = 1.253
    --local take = 000
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

local function DrawTeamlives() 
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

local function DrawTake()
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

local function DrawTimer()
    SetTextColour(timerColour[1], timerColour[2], timerColour[3], timerColour[4])
    SetTextScale(0.28, 0.28)
    BeginTextCommandDisplayText("timertxt")
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

--CreateThread(function()
--    while true do 
--        Wait(4)
--
--
--            if loadTeamlives then 
--                DrawTeamlives()
--            end
--
--            if loadTake then 
--                DrawTake()
--            end
--
--            if loadTimer then 
--                DrawTimer()
--            end
--        else 
--            Wait(1000)
--
--    end
--end)

CreateThread(function()
    while true do 
        Wait(5)
        if loadTeamlives then 
            DrawTeamlives()
        else 
            Wait(500)
        end
    end
end)

CreateThread(function()
    while true do 
        Wait(5)
        if loadTake then 
            DrawTake()
        else 
            Wait(500)
        end
    end
end)

CreateThread(function()
    while true do 
        Wait(5)
        if loadTimer then 
            DrawTimer()
        else 
            Wait(500)
        end
    end
end)

RegisterCommand("test_sec", function() 
    LoadTexture("timerbars")
    FormatTake()
    --FormatTimer()
    --test = true
    loadTeamlives = true 
    loadTake = true 
    loadTimer = true
    StartTimer()
 end, false)