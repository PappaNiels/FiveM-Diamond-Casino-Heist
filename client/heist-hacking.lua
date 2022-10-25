local scaleformBar = 0
local progress = 1
local position = 1
local lives = 6
local barNum = 30
local layout = 0 

local min = 4 
local tenSec = 0
local sec = 0
local tenthSec = 0
local hundredthSec = 0

local ratio = GetAspectRatio(0) 
local ratioR = 1.778 / ratio

local fingerprints = {1, 2, 0} 

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

local partA = { 120, 120, 120, 120, 120, 120, 120, 120 }

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

local combinations = {
    {
        {
            {7, 0},
            {3, true},
            {6, 0},
            {1, true},
            {4, true},
            {8, 0},
            {5, 0},
            {2, true},
        },
        {
            {1, true},
            {0, 0},
            {0, 0},
            {0, 0},
            {4, true},
            {2, true},
            {3, true},
            {0, 0},
        }
    },
    {
        {
            {1, true},
            {2, true},
            {0, 0},
            {0, 0},
            {0, 0},
            {4, true},
            {0, 0},
            {3, true},
        },
        {
            {0, 0},
            {0, 0},
            {4, true},
            {3, true},
            {2, true},
            {1, true},
            {0, 0},
            {0, 0},
        }
    },
    {
        {
            {2, true},
            {8, 0},
            {1, true},
            {5, 0},
            {3, true},
            {7, 0},
            {4, true},
            {6, 0},
        },
        {
            {0, 0},
            {3, true},
            {0, 0},
            {4, true},
            {1, true},
            {2, true},
            {0, 0},
            {0, 0},
        }
    },
    {
        {
            {5, 0},
            {3, true},
            {1, true},
            {7, 0},
            {6, 0},
            {2, true},
            {8, 0},
            {4, true},
        },
        {
            {0, 0},
            {0, 0},
            {2, true},
            {1, true},
            {0, 0},
            {4, true},
            {0, 0},
            {3, true},
        }
    }
}

local function DrawSpriteCut(dict, name, x, y, width, height, a)
    DrawSprite(dict, name, (0.5 - ((0.5 - x) / ratio)), y, (width / 1920.0) * ratioR, height / 1920, 0.0, 255, 255, 255, a, 0)
end

local function LoadHackDicts()
    for i = 1, #dicts do
        RequestStreamedTextureDict(dicts[i])
    end 
    
    while not HasStreamedTextureDictLoaded(dicts[#dicts]) do 
        Wait(10)
    end
end

local function GetSelected()
    local obj = {}
    
    for i = 1, 8 do 
        if selectedA ~= 120 then 
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
        selectedA[position] = 250
    else
        selectedA[position] = 120
    end
end

local function CheckPrint()
    local obj = GetSelected()

    if combinations[fingerprints[progress]][layout][obj[1]][2] and combinations[fingerprints[progress]][layout][obj[2]][2] and combinations[fingerprints[progress]][layout][obj[1]][2] and combinations[fingerprints[progress]][layout][obj[4]][2] then
        
        for i = 1, #selectedA do 
            selectedA[i] = 120
        end
        
        progress = progress + 1
    else

    end
end

local function StartHackKeyPress()
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

    fingerprints[1] = 4
    fingerprints[2] = 3
    layout = 1 --math.random(1, 2)
    
    --print(fingerprints[progress])

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

    for i = 1, 8 do 
        print("mpfclone_print" .. fingerprints[progress] - 1, "fp" .. fingerprints[progress] .. "_comp_" .. combinations[fingerprints[progress]][layout][i][1])
    end

    CreateThread(function()
        while progress < 3 and lives >= 0 and min >= 0 and tenSec >= 0 and sec >= 0 do
            Wait(3)

            print(progress < 3 and lives >= 0 and min >= 0 and tenSec >= 0 and sec >= 0)

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

            -- Fingerprints Part 1

            if progress < 3 then 
                for i = 1, 8 do 
                    DrawSpriteCut("mpfclone_print" .. fingerprints[progress] - 1, "fp" .. fingerprints[progress] .. "_comp_" .. combinations[fingerprints[progress]][layout][i][1], test[1][i], test[2][i], 128.0, 220.0, selectedA[i])
                end
            end

            --DrawSpriteCut("mpfclone_print0", "fp".."1".."_comp_".."1", 0.106, 0.315, 128.0, 220.0, selectedA[1])
            --DrawSpriteCut("mpfclone_print0", "fp".."1".."_comp_".."1", 0.2393, 0.315, 128.0, 220.0, selectedA[2])
            --
            ---- Fingerprints Part 2
            --DrawSpriteCut("mpfclone_print0", "fp".."1".."_comp_".."1", 0.106, 0.440, 128.0, 220.0, selectedA[3])
            --DrawSpriteCut("mpfclone_print0", "fp".."1".."_comp_".."1", 0.2393, 0.440, 128.0, 220.0, selectedA[4])
            --
            ---- Fingerprints Part 3
            --DrawSpriteCut("mpfclone_print0", "fp".."1".."_comp_".."1", 0.106, 0.569, 128.0, 220.0, selectedA[5])
            --DrawSpriteCut("mpfclone_print0", "fp".."1".."_comp_".."1", 0.2393, 0.569, 128.0, 220.0, selectedA[6])
            --
            ---- Fingerprints Part 4
            --DrawSpriteCut("mpfclone_print0", "fp".."1".."_comp_".."1", 0.106, 0.697, 128.0, 220.0, selectedA[7])
            --DrawSpriteCut("mpfclone_print0", "fp".."1".."_comp_".."1", 0.2393, 0.697, 128.0, 220.0, selectedA[8])
            
            -- Selector
            DrawSpriteCut("mpfclone_common", "component_selector", selector[position][1], selector[position][2], 180.0, 305.0, 250)
            
            -- Large Fingerprint
            for i = 1, 8 do 
                DrawSpriteCut("mpfclone_print" .. fingerprints[progress] - 1, "fp" .. fingerprints[progress] .. "_" .. i, 0.674, 0.382, 400.0, 850.0, partA[i])
            end
        end
    end)

    CreateThread(function()
        while progress < 3 and lives >= 0 and not (min <= 0 and tenSec <= 0 and sec <= 0) do 
            Wait(0)

            if IsDisabledControlJustPressed(0, 172) then -- Up
                if position ~= 1 and position ~= 2 then 
                    position = position - 2
                end
            elseif IsDisabledControlJustPressed(0, 173) then -- Down
                if position ~= 7 and position ~= 8 then 
                    position = position + 2
                end
            elseif IsDisabledControlJustPressed(0, 174) then -- Left
                if position ~= 1 and position ~= 3 and position ~= 5 and position ~= 7 then 
                    position = position - 1
                end
            elseif IsDisabledControlJustPressed(0, 175) then -- Right
                if position ~= 2 and position ~= 4 and position ~= 6 and position ~= 8 then 
                    position = position + 1
                end
            elseif GetSelectedAmount() == 4 then 
                if IsDisabledControlJustPressed(0, 192) then -- Tab
                    CheckPrint()
                end
            else
                if IsDisabledControlJustPressed(0, 191) then -- Enter 
                    SelectPart()
                end
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

function StartHack()
    LoadHackDicts()

    StartHackKeyPress()

end

RegisterCommand("test_hack", function()
    StartHack()
end, false)