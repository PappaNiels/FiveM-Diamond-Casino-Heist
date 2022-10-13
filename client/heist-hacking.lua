local scaleformBar = 0
local progress = 1
local lives = 6

local ratio = GetAspectRatio(0)
local ratioR = 1.778 / ratio

local fingerprints = {} 

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

    CreateThread(function()
        while progress < 3 and lives >= 0 do
            Wait(3)

            DrawSpriteCut("mphackinggamebg", "bg", 0.5, 0.5, 1920.0, 1920.0, 255)
            DrawSpriteCut("mphackinggamewin", "tech_3_0", 0.090, 0.489, 980.0, 1000.0, 255)
            DrawSpriteCut("mphackinggamewin3", "tech_4_1", 0.065, 0.670, 950.0, 1000.0, 255)
            DrawSpriteCut("mphackinggamewin2", "tech_2_0", 0.950, 0.642, 840.0, 800.0, 255)
            DrawSpriteCut("mpfclone_common", "background_layout", 0.5, 0.5, 1264.0, 1600.0, 250)
            
            for i = 0, 30 do                 
                DrawSpriteCut("mphackinggame", "Scrambler_Fill_Segment", 0.0025 + (i * 0.0111), 0.835, 12.0, 120.0, 250)
            end
            
            DrawSpriteCut("mphackinggame", "Numbers_Colon", 0.122, 0.159, 40.0, 110.0, 250)
            DrawSpriteCut("mphackinggame", "Numbers_Colon", 0.215, 0.159, 40.0, 110.0, 250)

            -- Minutes
            DrawSpriteCut("mphackinggame", "numbers_0", 0.06, 0.159, 40.0, 110.0, 250)
            DrawSpriteCut("mphackinggame", "numbers_".."0", 0.091, 0.159, 40.0, 110.0, 250)

            -- Seconds
            DrawSpriteCut("mphackinggame", "numbers_".."0", 0.153, 0.159, 40.0, 110.0, 250)
            DrawSpriteCut("mphackinggame", "numbers_".."0", 0.184, 0.159, 40.0, 110.0, 250)

            -- Milliseconds
            DrawSpriteCut("mphackinggame", "numbers_".."0", 0.246, 0.159, 40.0, 110.0, 250)
            DrawSpriteCut("mphackinggame", "numbers_".."0", 0.277, 0.159, 40.0, 110.0, 250)

            for i = 0, lives - 1, 1 do
                DrawSpriteCut("mphackinggame", "Life", 0.9825, 0.2551 + (i * 0.0532), 60.0, 101.0, 250)
            end

            DrawSpriteCut("mphackinggameoverlay", "grid_rgb_pixels", 0.5, 0.5, 1920.0, 1920.0, 255)

            DrawSpriteCut("mpfclone_print0", "fp".."1".."_comp_".."1", 0.106, 0.315, 128.0, 220.0, 250)
            DrawSpriteCut("mpfclone_print0", "fp".."1".."_comp_".."1", 0.2393, 0.440, 128.0, 220.0, 250)
            
            DrawSpriteCut("mpfclone_print0", "fp".."1".."_comp_".."1", 0.106, 0.569, 128.0, 220.0, 250)
            DrawSpriteCut("mpfclone_print0", "fp".."1".."_comp_".."1", 0.2393, 0.697, 128.0, 220.0, 250)
            -- First 0.105 Second 0.239

            --[[
                1 0.315
                2 0.440
                3 0.569
                4 0.695
            ]]
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