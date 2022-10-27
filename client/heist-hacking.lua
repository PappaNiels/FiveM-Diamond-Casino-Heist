local scaleformBar = 0
local progress = 1
local position = 1
local lives = 6
local barNum = 30
local layout = 0 
local msgType = 0 
local isChecking = 0
local sId = 0

local rectX = 0.401
local rectW = 0.0

local min = 4 
local tenSec = 0
local sec = 0
local tenthSec = 0
local hundredthSec = 0

local ratio = GetAspectRatio(0) 
local ratioR = 1.778 / ratio

local msg = ""

local fingerprints = {1, 2, 1} 

local dicts = {
    "mphackinggamebg", 
    "mpfclone_decor", 
    "mphackinggame", 
    "mphackinggamewin", 
    "mphackinggamewin2", 
    "mphackinggamewin3", 
    "mpfclone_common", 
    "mphackinggameoverlay", 
    "mphackinggameoverlay1", 
    "mpfclone_print0", 
    "mpfclone_print1", 
    "mpfclone_print2", 
    "mpfclone_print3" 
}

local partA = { 120, 120, 120, 120, 120, 120, 120, 120, 0 }

local bars = { 0.0025, 0.0136, 0.0247, 0.0358, 0.0469, 0.0580, 0.0691, 0.0802, 0.0913, 0.1024, 0.1135, 0.1246, 0.1357, 0.1468, 0.1579, 0.1690, 0.1801, 0.1912, 0.2023, 0.2134, 0.2245, 0.2356, 0.2467, 0.2578, 0.2689, 0.2790, 0.2901, 0.3012, 0.3123, 0.3234, 0.3345 }

local livesPos = { 0.2551, 0.3083, 0.3615, 0.4147, 0.4679, 0.5211 }

local smallSelector = { 0.539, 0.662, 0.0 }

local selector = { 
    {0.106, 0.315}, 
    {0.2393, 0.315}, 
    {0.106, 0.440}, 
    {0.2393, 0.440}, 
    {0.106, 0.569}, 
    {0.2393, 0.569}, 
    {0.106, 0.697}, 
    {0.2393, 0.697} 
}

local selectedA = { 120, 120, 120, 120, 120, 120, 120, 120 }

local test = {
    {
        0.106, 
        0.2393,
        0.106, 
        0.2393,
        0.106, 
        0.2393,
        0.106, 
        0.2393,
    },
    {
        0.315,
        0.315,
        0.440,
        0.440,
        0.569,
        0.569,
        0.697,
        0.697
    }
}

local combinations = {{{{7, true}, {3, false}, {6, true}, {1, true}, {4, true}, {8, false}, {5, false}, {2, false}},{{1, true},{5, false}, {8, false}, {6, true}, {4, true}, {2, false}, {3, false}, {7, true}, }}, {{{1, true}, {2, true}, {8, false}, {7, false}, {5, false}, {4, true}, {6, false}, {3, true}}, {{5, false}, {6, false}, {4, true}, {3, true}, {2, true}, {1, true}, {8, false}, {7, false}}},{{{2, true}, {8, false}, {1, true}, {5, false}, {3, true}, {7, false}, {4, true}, {6, false}}, {{8, false}, {3, true}, {6, false}, {4, true}, {1, true}, {2, true}, {5, false}, {7, false}}}, {{{5, false}, {3, true}, {1, true}, {7, false}, {6, false}, {2, true}, {8, false}, {4, true}}, {{7, false}, {5, false}, {2, true}, {1, true}, {6, false}, {4, true}, {8, false}, {3, true}}}}

local function DrawSpriteCut(dict, name, x, y, width, height, a)
    DrawSprite(dict, name, (0.5 - ((0.5 - x) / ratio)), y, (width / 1920.0) * ratioR, height / 1920, 0.0, 255, 255, 255, a, 0)
end

local function LoadHackDicts()
    for i = 1, #dicts do
        RequestStreamedTextureDict(dicts[i])
    end 
    
    RequestScriptAudioBank("DLC_HEIST3/Fingerprint_Match", false, -1)

    while not HasStreamedTextureDictLoaded(dicts[#dicts]) do 
        Wait(10)
    end
end

local function UnloadHackDicts()
    for i = 1, #dicts do
        SetStreamedTextureDictAsNoLongerNeeded(dicts[i])
    end 

    ReleaseNamedScriptAudioBank("DLC_HEIST3/Fingerprint_Match")
end

local function GetSelected()
    local obj = {}
    
    for i = 1, 8 do 
        if selectedA[i] ~= 120 then 
            obj[#obj + 1] = i
        end
    end
    
    return obj
end

local function GetSelectedAmount()
    local num = 0
    
    for i = 1, 8 do 
        if selectedA[i] ~= 120 then 
            num = num + 1
        end
    end

    return num
end

local function SelectPart()
    if selectedA[position] == 120 then 
        PlaySoundFrontend(-1, "Select_Print_Tile", "DLC_H3_Cas_Finger_Minigame_Sounds", true)
        selectedA[position] = 250
    else
        PlaySoundFrontend(-1, "Deselect_Print_Tile", "DLC_H3_Cas_Finger_Minigame_Sounds", true)
        selectedA[position] = 120
    end
end

local function ProgressBar(bool)
    local soundName = ""
    
    if sId == 0 then 
        sId = GetSoundId()
    end
    
    if bool then 
        msg = "correct"
        soundName = "Target_Match"
    else
        msg = "incorrect"
        soundName = "No_Match"
    end
    
    PlaySoundFrontend(sId, "Processing", "DLC_H3_Cas_Finger_Minigame_Sounds", true)
    
    while rectW < 380 do
        rectX = rectX + 0.00099
        rectW = rectW + 3.8
        Wait(20)
    end
    
    isChecking = 2
    StopSound(sId)
    PlaySoundFrontend(sId, soundName, "DLC_H3_Cas_Finger_Minigame_Sounds", true)
    
    for i = 1, 6 do 
        if msgType == 0 then 
            msgType = 1
        else
            msgType = 0
        end
        
        Wait(415)
    end
    
    msg = ""
    StopSound(sId)
end

local function CheckPrint()
    isChecking = 1
    local obj = GetSelected()
    
    print(combinations[fingerprints[progress]][layout][obj[1]][2] , combinations[fingerprints[progress]][layout][obj[2]][2] , combinations[fingerprints[progress]][layout][obj[1]][2] , combinations[fingerprints[progress]][layout][obj[4]][2])
    
    for i = 1, #obj do 
        print(obj[i])
    end
    
    if combinations[fingerprints[progress]][layout][obj[1]][2] and combinations[fingerprints[progress]][layout][obj[2]][2] and combinations[fingerprints[progress]][layout][obj[1]][2] and combinations[fingerprints[progress]][layout][obj[4]][2] then
        ProgressBar(true)
        
        if progress < 3 then 
            PlaySoundFrontend(-1, "Print_Appears", "DLC_H3_Cas_Finger_Minigame_Sounds", true)
        end
        
        progress = progress + 1
    else
        ProgressBar(false)
        
        lives = lives - 1
    end
    
    for i = 1, #selectedA do 
        selectedA[i] = 120
    end
    
    isChecking = 0
    rectX = 0.401
    rectW = 0.0
end

function StartHack(cb)
    LoadHackDicts()
    
    for i = 1, 2 do 
        fingerprints[i] = math.random(1, 4)
    end
    
    if fingerprints[1] == fingerprints[2] then 
        if fingerprints[1] < 4 then 
            fingerprints[2] = fingerprints[2] + 1 
        else 
            fingerprints[2] = fingerprints[2] - 1
        end 
    end
    
    layout = math.random(1, 2)
    
    --print(fingerprints[1], fingerprints[2])
    
    --fingerprints[1] = 1
    --fingerprints[2] = 2
    --layout = 1 --math.random(1, 2)
    --msg = "correct"
    
    introBink = SetBinkMovie("intro_fc")
    PlayBinkMovie(introBink)
    
    StartAudioScene("DLC_H3_Fingerprint_Hack_Scene")
    
    PlaySoundFrontend(-1, "Startup_Sequence", "DLC_H3_Cas_Finger_Minigame_Sounds", true)
    
    while GetBinkMovieTime(introBink) <= 99 do 
        Wait(0)
        DrawBinkMovie(introBink, 0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
    end
    
    ReleaseBinkMovie(introBink)
    
    backHum = GetSoundId()
    
    PlaySoundFrontend(backHum, "Background_hum", "DLC_H3_Cas_Finger_Minigame_Sounds", true)
    PlaySoundFrontend(-1, "Print_Appears", "DLC_H3_Cas_Finger_Minigame_Sounds", true)
    
    CreateThread(function()
        while progress < 3 and lives >= 0 and not (min <= 0 and tenSec <= 0 and sec <= 0) do
            Wait(3)
            
            DrawSpriteCut("mphackinggamebg", "bg", 0.5, 0.5, 1920.0, 1920.0, 255)
            DrawSpriteCut("mphackinggamewin", "tech_3_0", 0.090, 0.489, 980.0, 1000.0, 255)
            DrawSpriteCut("mphackinggamewin3", "tech_4_1", 0.065, 0.670, 950.0, 1000.0, 255)
            DrawSpriteCut("mphackinggamewin2", "tech_2_0", 0.950, 0.642, 840.0, 800.0, 255)
            DrawSpriteCut("mpfclone_common", "background_layout", 0.5, 0.5, 1264.0, 1600.0, 250)
            
            for i = 1, barNum do                 
                DrawSpriteCut("mphackinggame", "Scrambler_Fill_Segment", bars[i] + 0.01, 0.835, 12.0, 120.0, 250)
            end
            
            -- Colons
            DrawSpriteCut("mphackinggame", "Numbers_Colon", 0.122, 0.159, 40.0, 110.0, 250)
            DrawSpriteCut("mphackinggame", "Numbers_Colon", 0.215, 0.159, 40.0, 110.0, 250)
            
            -- Minutes
            DrawSpriteCut("mphackinggame", "numbers_0", 0.06, 0.159, 40.0, 110.0, 250)
            DrawSpriteCut("mphackinggame", "numbers_".. min, 0.091, 0.159, 40.0, 110.0, 250)
            
            -- Seconds
            DrawSpriteCut("mphackinggame", "numbers_".. tenSec, 0.153, 0.159, 40.0, 110.0, 250)
            DrawSpriteCut("mphackinggame", "numbers_".. sec, 0.184, 0.159, 40.0, 110.0, 250)
            
            -- Milliseconds
            DrawSpriteCut("mphackinggame", "numbers_".. tenthSec, 0.246, 0.159, 40.0, 110.0, 250)
            DrawSpriteCut("mphackinggame", "numbers_".. hundredthSec, 0.277, 0.159, 40.0, 110.0, 250)
            
            -- Lives
            for i = 1, lives, 1 do
                DrawSpriteCut("mphackinggame", "Life", 0.9825, livesPos[i], 60.0, 101.0, 250)
            end
            
            -- Fingerprints Not Used
            DrawSpriteCut("mpfclone_common", "disabled_signal", 0.785, 0.818, 120.0, 210.0, 255)
            DrawSpriteCut("mpfclone_common", "disabled_signal", 0.908, 0.818, 120.0, 210.0, 255)
            
            -- Fingerprints Small
            DrawSpriteCut("mpfclone_common", "decypher_" .. fingerprints[1], 0.539, 0.818, 120.0, 210.0, 255)
            DrawSpriteCut("mpfclone_common", "decypher_" .. fingerprints[2], 0.662, 0.818, 120.0, 210.0, 255)
            
            -- Selector Small Fingerprints
            DrawSpriteCut("mpfclone_common", "Decyphered_Selector", smallSelector[progress], 0.818, 170.0, 290.0, 255)
            
            -- Pixels
            DrawSpriteCut("mphackinggameoverlay", "grid_rgb_pixels", 0.5, 0.5, 1920.0, 1920.0, 150)
            
            for i = 1, 8 do 
                DrawSpriteCut("mpfclone_print" .. fingerprints[progress] - 1, "fp" .. fingerprints[progress] .. "_comp_" .. combinations[fingerprints[progress]][layout][i][1], test[1][i], test[2][i], 128.0, 220.0, selectedA[i])
            end
            
            -- Selector
            DrawSpriteCut("mpfclone_common", "component_selector", selector[position][1], selector[position][2], 180.0, 305.0, 250)
            
            -- Large Fingerprint
            for i = 1, 8 do 
                DrawSpriteCut("mpfclone_print" .. fingerprints[progress] - 1, "fp" .. fingerprints[progress] .. "_" .. i, 0.674, 0.382, 400.0, 850.0, partA[i])
            end
            
            -- Success / Failed Message
            if isChecking == 1 then 
                DrawSpriteCut("mphackinggame", "loading_window", 0.5, 0.5, 475.0, 220.0, 255)
                DrawRect(rectX, 0.517, (rectW / 1920.0) * ratioR, 0.03125, 255, 255, 255, 220)
            elseif isChecking == 2 then 
                DrawSpriteCut("mphackinggame", msg .. "_" .. msgType, 0.5, 0.5, 600.0, 220.0, 255)
            end
        end
        
        StopSound(backHum)
        
        if lives >= 0 and min >= 0 and tenSec >= 0 and sec >= 0 then 
            successBink = SetBinkMovie("success_fc")
            PlayBinkMovie(successBink)
            PlaySoundFrontend(-1, "Hack_Success", "DLC_H3_Cas_Finger_Minigame_Sounds", true)
            
            while GetBinkMovieTime(successBink) <= 99 do 
                Wait(0)
                DrawBinkMovie(successBink, 0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
            end
            
            ReleaseBinkMovie(successBink)
            StopAudioScene("DLC_H3_Fingerprint_Hack_Scene")
            UnloadHackDicts()
            
            cb(true)
        else
            failBink = SetBinkMovie("fail_fc")
            PlayBinkMovie(failBink)
            PlaySoundFrontend(-1, "Hack_Failed", "DLC_H3_Cas_Finger_Minigame_Sounds", true)
            
            while GetBinkMovieTime(failBink) <= 99 do 
                Wait(0)
                DrawBinkMovie(failBink, 0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
            end
            
            ReleaseBinkMovie(failBink)
            StopAudioScene("DLC_H3_Fingerprint_Hack_Scene")
            UnloadHackDicts()


            cb(false)
        end
    end)
    
    CreateThread(function()
        while progress < 3 and lives >= 0 and not (min <= 0 and tenSec <= 0 and sec <= 0) do 
            Wait(0)
            
            if isChecking == 0 then 
                if IsDisabledControlJustPressed(0, 172) then -- Up
                    if position ~= 1 and position ~= 2 then 
                        PlaySoundFrontend(-1, "Cursor_Move", "DLC_H3_Cas_Finger_Minigame_Sounds", true)
                        position = position - 2
                    end
                elseif IsDisabledControlJustPressed(0, 173) then -- Down
                    if position ~= 7 and position ~= 8 then 
                        PlaySoundFrontend(-1, "Cursor_Move", "DLC_H3_Cas_Finger_Minigame_Sounds", true)
                        position = position + 2
                    end
                elseif IsDisabledControlJustPressed(0, 174) then -- Left
                    if position ~= 1 and position ~= 3 and position ~= 5 and position ~= 7 then 
                        PlaySoundFrontend(-1, "Cursor_Move", "DLC_H3_Cas_Finger_Minigame_Sounds", true)
                        position = position - 1
                    end
                elseif IsDisabledControlJustPressed(0, 175) then -- Right
                    if position ~= 2 and position ~= 4 and position ~= 6 and position ~= 8 then 
                        PlaySoundFrontend(-1, "Cursor_Move", "DLC_H3_Cas_Finger_Minigame_Sounds", true)
                        position = position + 1
                    end
                elseif IsDisabledControlJustPressed(0, 191) then -- Enter 
                    SelectPart()
                elseif GetSelectedAmount() == 4 then 
                    if IsDisabledControlJustPressed(0, 192) then -- Tab
                        CheckPrint()
                    end
                end
            else 
                Wait(1000)
            end
        end
    end)
    
    CreateThread(function()
        while progress < 3 and lives >= 0 and not (min <= 0 and tenSec <= 0 and sec <= 0) do
            Wait(10)
            
            if hundredthSec == 0 then 
                hundredthSec = 9
                if tenthSec == 0 then 
                    tenthSec = 9
                    if sec == 0 then 
                        sec = 9 
                        if tenSec == 0 then 
                            tenSec = 5

                            min = min - 1
                        else 
                            tenSec = tenSec - 1
                        end
                    else
                        sec = sec - 1
                    end
                else
                    tenthSec = tenthSec - 1
                end
            else 
                hundredthSec = hundredthSec - 1
            end
        end
    end)

    CreateThread(function()
        while progress < 3 and lives >= 0 and not (min <= 0 and tenSec <= 0 and sec <= 0) do
            Wait(0)

            DisableAllControlActions(0)
        end
    end)
end

--function StartHack()
--    LoadHackDicts()
--    
--    StartHackKeyPress()
--    
--end

RegisterCommand("test_hack", function()
    StartHack(function(result)
        bool = result
        
        print("done")

        Wait(1000)

        progress = 1
        position = 1
        lives = 6
        min = 4
    end)
end, false)  