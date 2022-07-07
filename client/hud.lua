loadTeamlives = false 
loadTake = false 
loadTimer = false 

local test = false

local teamlivesColour = {255, 255, 255, 500}

local amountSize = 0.5
local wide = 0
local height = 0
local takef = ""

local timeExpired = 0
local minutes = ""
local seconds = ""
local timerColour = {255, 255, 255, 500}

AddTextEntry("team", "TEAM LIVES")
AddTextEntry("lives", "~1~")

AddTextEntry("taketxt", "TAKE")
AddTextEntry("takenr", "$~a~")

AddTextEntry("timertxt", "TIME")
AddTextEntry("timeleft", "~a~:~a~")

local function StartTimer()
    local vaultTime = GetGameTimer()

    local timerActive = true

    CreateThread(function()
        while timerActive do 
            Wait(1000)
            timeExpired = timeExpired + 1000

            if timeExpired >= hacker[hackerSelected][3 + alarmTriggered] - 5000 then 
                timerColour = {201, 37, 37, 255}
                if timeExpired == hacker[hackerSelected][3 + alarmTriggered] then 
                    timerActive = false
                end
            end
        end
    end)
end

local function FormatTimer()
    local time = math.floor((hacker[hackerSelected][3 + alarmTriggered] - timeExpired)/ 1000) 

    if time < 60 then 
        minutes = "00"
        if time < 10 then 
            seconds = "0"..tostring(time)
        else 
            seconds = tostring(time)
        end
    elseif time >= 60 and time < 120 then 
        minutes = "01"
        if time - 60 < 10 then 
            seconds = "0"..tostring(time - 60)
        else 
            seconds = tostring(time - 60)
        end
    elseif time >= 120 and time < 180 then 
        minutes = "02"
        if time - 120 < 10 then 
            seconds = "0"..tostring(time - 120)
        else 
            seconds = tostring(time - 120)
        end
    elseif time >= 180 then 
        minutes = "03"
        if time - 180 < 10 then 
            seconds = "0"..tostring(time - 180)
        else 
            seconds = tostring(time - 180)
        end
    end
end

local function FormatTake()
    local len = string.len(tostring(take))

    if len == 4 then 
        takef = string.sub(take, 1, 1) .. "," .. string.sub(take, 2, 4)
    elseif len == 5 then 
        takef = string.sub(take, 1, 2) .. "," .. string.sub(take, 3, 5)
        wide = 0.007
    elseif len == 6 then 
        takef = string.sub(take, 1, 3) .. "," .. string.sub(take, 4, 6)
        wide = 2 * 0.007
    elseif len == 7 then 
        takef = string.sub(take, 1, 1) .. "," .. string.sub(take, 2, 4) .. "," .. string.sub(take, 5, 7)
        wide = 0.012
        height = 0.005
        amountSize = 0.4
    end
end

--function hud for one

local function DrawTeamlives() 
    SetTextColour(teamlivesColour[1], teamlivesColour[2], teamlivesColour[3], teamlivesColour[4])
    SetTextScale(0.28, 0.28)
    BeginTextCommandDisplayText("team")
    EndTextCommandDisplayText(0.853, 0.954)

    SetTextColour(teamlivesColour[1], teamlivesColour[2], teamlivesColour[3], teamlivesColour[4])
    SetTextScale(0.47, 0.47)
    BeginTextCommandDisplayText("lives")
    AddTextComponentInteger(teamlives)
    EndTextCommandDisplayText(0.977, 0.945)
    
    if teamlives < 1 then 
        DrawSprite("timerbars", "all_red_bg", 0.8455, 0.962, 0.29, 0.035, 0.0, 79, 12, 12, 300)
    else 
        DrawSprite("timerbars", "all_black_bg", 0.915, 0.962, 0.15, 0.035, 0.0, 100, 100, 100, 150)
    end 
end

local function DrawTake()
    --FormatTake()
    SetTextScale(0.28, 0.28)
    BeginTextCommandDisplayText("taketxt")
    EndTextCommandDisplayText(0.88, 0.915)

    SetTextScale(0.0, amountSize)
    BeginTextCommandDisplayText("takenr")
    AddTextComponentSubstringPlayerName(takef)
    EndTextCommandDisplayText(0.938 - wide, 0.903 + height)

    DrawSprite("timerbars", "all_black_bg", 0.915, 0.922, 0.15, 0.035, 0.0, 100, 100, 100, 150)
end

local function DrawTimer()
    FormatTimer()
    SetTextColour(timerColour[1], timerColour[2], timerColour[3], timerColour[4])
    SetTextScale(0.28, 0.28)
    BeginTextCommandDisplayText("timertxt")
    EndTextCommandDisplayText(0.8815, 0.875)

    SetTextColour(timerColour[1], timerColour[2], timerColour[3], timerColour[4])
    SetTextScale(0.5, 0.5)
    BeginTextCommandDisplayText("timeleft")
    AddTextComponentSubstringPlayerName(minutes)
    AddTextComponentSubstringPlayerName(seconds)
    EndTextCommandDisplayText(0.945, 0.864)

    DrawSprite("timerbars", "all_black_bg", 0.915, 0.882, 0.15, 0.035, 0.0, 100, 100, 100, 150)
end

RegisterNetEvent("cl:casinoheist:syncteamlives", function(lives)
    teamlives = lives

    if teamlives < 1 then 
        teamlivesColour = {201, 37, 37, 255}
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
    FormatTimer()
    --test = true
    loadTeamlives = true 
    loadTake = true 
    loadTimer = true
    StartTimer()
 end, false)