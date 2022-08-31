--[[
    componentId 
    1 = berd
    3 = uppr
    4 = lowr
    5 = hand
    6 = feet
    8 = accs
    10 = decl
    11 = jbib

    componentId 4 male 
    120 = fire fighter 
    121 = Noose
    122 = gruppe sechs 
    123 = gruppe sechs high shoes
    124 = Aggressive

    componentId 8 male
    131 = Armor

    componentId 10 male
    66 = bugstar long sleeve lowr 38 
    67 = bugstar 2 lowr 39
    70 = Noose
    71 = gruppe sechs
    73 = YA jacket 
    74 = YA hoodie
    75 = YA hoodie
    76 = gruppe sechs

    componentId 11 male
    50 = Stealth 
    53 = Stealth 2
    65 = Bugstar / maintenance
    66 = Bugstar short sleeve
    314 = Fire fighter gear closed
    315 = Fire fighter gear open
    316 = Police long sleeve closed 
        0 = black
        1 = green
        2 = cream
        3 = sand
        4 = dark green 
        5 = white
        6 = grey
        7 = dark grey
        9 = black
    317 = Police long sleeve open
    318 = Police polo closed
    319 = Police polo owpen
    320 = Noose
    324 = Aggressive 
        10 = blue camo
        11 = green zigzag

    329 = YA jacket
    330 = YA Hoodie
    331 = YA Hoodie 2

    componentId 0 hat malet
    137 = fire fighter
    138 = fire fighter goggles
    139 = bugstar front
    140 = bugstar back
    141 = Noose
    142 = cap front
    143 = cap back
    144 = gruppe sech helmet
    145 = builder 
    146 = high hat 
    147 = night vision
]]

local clothes = {
    [1] = {
        [1] = {
            {1, 52, 0},
            {3, 33, 0},
            {4, 31, 0},
            {5, 82, 13},
            {6, 25, 0},
            {7, 146, 0},
            {8, 124, 0},
            {11, 53, 0}
        },
        [2] = {
            {1, 52, 0},
            {3, 33, 0},
            {4, 31, 0},
            {5, 82, 13},
            {6, 25, 0},
            {7, 146, 0},
            {8, 124, 0},
            {11, 53, 0}
        },
        [3] = {
            {1, 52, 0},
            {3, 33, 0},
            {4, 31, 0},
            {5, 82, 13},
            {6, 25, 0},
            {7, 146, 0},
            {8, 124, 0},
            {11, 50, 0}
        },
        [4] = {
            {1, 52, 0},
            {3, 33, 0},
            {4, 31, 0},
            {5, 82, 13},
            {6, 25, 0},
            {7, 146, 0},
            {8, 124, 0},
            {11, 50, 0}
        }
    },
    [2] = { -- approach
        [1] = { -- disguise
            [1] = { -- Bugstar
                [1] = { 
                    {0, 0, 0},
                    {3, 4, 0},
                    {4, 38, 0},
                    {5, 82, 8},
                    {6, 25, 0},
                    {8, 15, 0},
                    {10, 66, 0},
                    {11, 65, 0}
                },
                [2] = {
                    {0, 0, 0},
                    {3, 4, 0},
                    {4, 39, 0},
                    {5, 82, 8},
                    {6, 25, 0},
                    {8, 15, 0},
                    {10, 67, 0},
                    {11, 66, 0}
                },
                [3] = {
                    {0, 0, 0},
                    {3, 4, 0},
                    {4, 38, 0},
                    {5, 82, 8},
                    {6, 25, 0},
                    {8, 15, 0},
                    {10, 66, 0},
                    {11, 65, 0}
                },
                [4] = {
                    {0, 0, 0},
                    {3, 4, 0},
                    {4, 39, 0},
                    {5, 82, 8},
                    {6, 25, 0},
                    {8, 15, 0},
                    {10, 67, 0},
                    {11, 66, 0}
                }
            },
            [2] = { -- Maintenance
                [1] = {
                    {0, 2, 0},
                    {3, 64, 0},
                    {4, 38, 1},
                    {5, 82, 3},
                    {6, 25, 0},
                    {8, 155, 0},
                    {11, 65, 1}
                },
                [2] = {
                    {0, 2, 0},
                    {3, 64, 0},
                    {4, 39, 1},
                    {5, 82, 3},
                    {6, 25, 0},
                    {8, 155, 0},
                    {11, 66, 1}
                },
                [3] = {
                    {0, 143, 0},
                    {3, 64, 0},
                    {4, 38, 1},
                    {5, 82, 3},
                    {6, 25, 0},
                    {8, 155, 0},
                    {11, 65, 1}
                },
                [4] = {
                    {0, 143, 0},
                    {3, 64, 0},
                    {4, 39, 1},
                    {5, 82, 3},
                    {6, 25, 0},
                    {8, 155, 0},
                    {11, 66, 1}
                }
            },
            [3] = { -- Gruppe Sechs
                [1] = {
                    {0, 144, 0},
                    {3, 11, 0},
                    {4, 10, 0},
                    {5, 82, 0},
                    {6, 24, 0},
                    {8, 15, 0},
                    {9, 11, 1},
                    {10, 76, 0},
                    {11, 318, 1}
                },
                [2] = {
                    {0, 144, 0},
                    {3, 6, 0},
                    {4, 10, 0},
                    {5, 82, 0},
                    {6, 24, 0},
                    {8, 15, 0},
                    {9, 11, 1},
                    {10, 71, 0},
                    {11, 316, 1}
                },
                [3] = {
                    {0, 144, 0},
                    {3, 11, 0},
                    {4, 10, 0},
                    {5, 82, 0},
                    {6, 24, 0},
                    {8, 15, 0},
                    {9, 11, 1},
                    {10, 76, 0},
                    {11, 318, 2}
                },
                [4] = {
                    {0, 144, 0},
                    {3, 6, 0},
                    {4, 10, 0},
                    {5, 82, 0},
                    {6, 24, 0},
                    {8, 15, 0},
                    {9, 11, 1},
                    {10, 71, 0},
                    {11, 316, 2}
                }
            },
            [4] = { -- Yung Ancestor
                [1] = {
                    {0, 139, 2},
                    {3, 6, 0},
                    {4, 0, 2},
                    {5, 82, 9},
                    {6, 99, 0},
                    {8, 15, 0},
                    {10, 73, 0},
                    {11, 329, 1}
                },
                [2] = {
                    {0, 140, 2},
                    {3, 6, 0},
                    {4, 0, 2},
                    {5, 82, 9},
                    {6, 99, 0},
                    {8, 15, 0},
                    {10, 74, 0},
                    {11, 330, 1}
                },
                [3] = {
                    {0, 139, 2},
                    {3, 6, 0},
                    {4, 0, 2},
                    {5, 82, 9},
                    {6, 99, 0},
                    {8, 15, 0},
                    {10, 74, 0},
                    {11, 331, 1}
                },
                [4] = {
                    {0, 140, 2},
                    {3, 6, 0},
                    {4, 0, 2},
                    {5, 82, 9},
                    {6, 99, 0},
                    {8, 15, 0},
                    {10, 73, 0},
                    {11, 329, 1}
                }
            }
        },
        [2] = {
            [1] = { -- Fire fighter
                [1] = {
                    {0, 137, 0},
                    {3, 4, 0},
                    {4, 120, 0},
                    {6, 24, 0},
                    {8, 15, 0},
                    {10, 64, 0},
                    {11, 314, 0}
                    
                },
                [2] = {
                    {0, 137, 0},
                    {3, 4, 0},
                    {4, 120, 1},
                    {6, 24, 0},
                    {8, 15, 0},
                    {10, 64, 0},
                    {11, 314, 1}
                },
                [3] = {
                    {0, 138, 0},
                    {3, 4, 0},
                    {4, 120, 0},
                    {6, 24, 0},
                    {8, 15, 0},
                    {10, 64, 0},
                    {11, 315, 0}
                },
                [4] = {
                    {0, 138, 0},
                    {3, 4, 0},
                    {4, 120, 1},
                    {6, 24, 0},
                    {8, 15, 0},
                    {10, 64, 0},
                    {11, 315, 1}
                }
            },
            [2] = { -- Noose
                [1] = {
                    {0, 141, 0},
                    {1, 52, 0},
                    {3, 17, 0},
                    {4, 121, 0},
                    {6, 24, 0},
                    {8, 15, 0},
                    {10, 70, 0},
                    {11, 320, 0}
                },
                [2] = {
                    {0, 141, 0},
                    {1, 52, 0},
                    {3, 17, 0},
                    {4, 121, 0},
                    {6, 24, 0},
                    {8, 15, 0},
                    {10, 70, 0},
                    {11, 320, 0}
                },
                [3] = {
                    {0, 141, 0},
                    {1, 52, 0},
                    {3, 17, 0},
                    {4, 121, 0},
                    {6, 24, 0},
                    {8, 15, 0},
                    {10, 70, 0},
                    {11, 320, 0}
                },
                [4] = {
                    {0, 141, 0},
                    {1, 52, 0},
                    {3, 17, 0},
                    {4, 121, 0},
                    {6, 24, 0},
                    {8, 15, 0},
                    {10, 70, 0},
                    {11, 320, 0}
                }
            },
            [3] = { -- High roller
                [1] = {

                },
                [2] = {
                
                },
                [3] = {

                },
                [4] = {
                
                }
            }
        }    
    },
    [3] = {
        [1] = { -- Pixel Blue
            {1, 179, 1},
            {3, 160, 0},
            {4, 124, 17},
            {5, 82, 10},
            {6, 25, 0},
            {8, 131, 0},
            {11, 324, 17}
        },
        [2] = { -- Pixel Green
            {1, 179, 0},
            {3, 160, 2},
            {4, 124, 13},
            {5, 82, 11},
            {6, 25, 0},
            {8, 131, 0},
            {11, 324, 13}
        },
        [3] = { -- Green Shard
            {1, 179, 22},
            {3, 160, 11},
            {4, 124, 11},
            {5, 82, 13},
            {6, 25, 0},
            {8, 131, 0},
            {11, 324, 11}
        },
        [4] = { -- Pink
            {1, 160, 0},
            {3, 160, 19},
            {4, 124, 9},
            {5, 82, 7},
            {6, 25, 0},
            {8, 131, 0},
            {11, 324, 9}
        }
    } 
}

local function IsCorrectModel()
    local ped = PlayerPedId()
    if GetEntityModel(ped) ~= GetHashKey("mp_m_freemode_01") and GetEntityModel(ped) ~= GetHashKey("mp_f_freemode_01") then 
        print("false")
        return false 
    else
        print("true")
        return true 
    end
end

function SetAllOutfits()
    for i = 1, #hPlayer do 
        if not IsCorrectModel(hPlayer[i]) then 
            LoadModel("mp_m_freemode_01")
            SetPlayerModel(GetPlayerFromServerId(hPlayer[i]), GetHashKey("mp_m_freemode_01"))
        end
    end

    if approach == 2 then
        for i = 1, #hPlayer do 
            SetPedPropIndex(GetPlayerPed(hPlayer[i]), clothes[approach][1][selectedEntryDisguise][i][1][1], clothes[approach][1][selectedEntryDisguise][i][1][2], clothes[approach][1][selectedEntryDisguise][i][1][3], true)
        end
    else
        if approach == 1 then 
            for i = 1, #hPlayer do 
                SetPedPropIndex(GetPlayerPed(hPlayer[i]), 0, 147, 0, true)
            end
        end

        for i = 1, #hPlayer do
            for j = 1, #clothes[approach][i] do
                SetPedComponentVariation(GetPlayerPed(hPlayer[i]), clothes[approach][i][j][1], clothes[approach][i][j][2], clothes[approach][i][j][3], 0)
            end
        end

    end
end 

function SetOutfit(id)
    for i = 1, #hPlayer do 
        local ped = GetPlayerped(GetPlayerFromServerId(hPlayer[i]))
        ClearAllPedProps(ped)
        ClearPedDecorations(ped)
        ClearPedFacialDecorations(ped)
    end

    if approach == 1 then 

    elseif approach == 2 then 

    elseif approach == 3 then 

    end
end

function SetPedComponents(command)
    local ped = PlayerPedId()

    SetPedComponentVariation(ped, 1, 0, 0, 0)
    SetPedComponentVariation(ped, 3, 4, 0, 0)
    SetPedComponentVariation(ped, 4, 39, 0, 0)
    SetPedComponentVariation(ped, 5, 82, 8, 0)
    SetPedComponentVariation(ped, 6, 25, 0, 0)
    SetPedComponentVariation(ped, 7, 0, 0, 0)
    SetPedComponentVariation(ped, 8, 15, 0, 0)
    SetPedComponentVariation(ped, 10, 67, 0, 0)
    SetPedComponentVariation(ped, 11, 66, 0, 0)
    SetPedPropIndex(ped, 0, 140, 0, true) 
end

function StartHeist(src, args)
    local ped = PlayerPedId()
    --print(ped, PlayerPedId())

    if not IsCorrectModel() then 
        local model = GetHashKey("mp_m_freemode_01")
        LoadModel(model)

        --while not HasModelLoaded("mp_m_freemode_01") do 
        --    Wait(0)
        --end

        SetPlayerModel(PlayerId(), model)

        ClearAllPedProps(ped)
        ClearPedDecorations(ped)
        ClearPedFacialDecorations(ped)

        SetModelAsNoLongerNeeded(model)
    end

    --Wait(1000)
    --SetPedPropIndex(ped, 0, 0, 0, false)
    --SetPedPropIndex(ped, 1, 0, 0, false)
    SetPedDefaultComponentVariation(ped)
    
    SetPedComponents(tonumber(args[1]))
end

RegisterCommand("test_start", StartHeist, false)