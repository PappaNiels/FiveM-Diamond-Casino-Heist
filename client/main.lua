heistInProgress = false

hPlayer = {1, 1, 1, 1}

heistType = 0
entryType = 0

entrypointsCasino = {
    -- Agressive 

    --[[1]]  vector3(923.76, 47.20, 81.11),     -- Front
    --[[2]]  vector3(893.29, -176.47, 22.58),   -- Sewer

    -- Silent and sneaky + Big con

    --[[3]]  vector3(978.78, 18.64, 80.99),     -- Staff Entry
    --[[4]]  vector3(993.17, 77.05, 80.99),     -- Garbage Entry
    --[[5]]  vector3(972.15, 25.54, 120.24),    -- Roof Helipad North  
    --[[6]]  vector3(959.39, 31.75, 120.23),    -- Roof Helipad South 
    --[[7]]  vector3(988.32, 59.03, 111.26),    -- Roof North East
    --[[8]]  vector3(953.78, 4.02, 111.26),     -- Roof South East 
    --[[9]]  vector3(936.42, 14.51, 112.55),    -- Roof South West
    --[[10]] vector3(953.40, 79.20, 111.25),    -- Roof North West
    
    -- Gruppe Sechs
    --[[11]] vector3(1000.4, -54.99, 74.96)     -- Garage

}


keypads = {
    ["lvlOneKeypad"] = {

    },

    ["lvlTwoKeypad"] = {

    },

    ["lvlThreeKeypad"] = {
        [1] = {
            vector3(2519.80, -226.47, -70.40),
            vector3(2533.10, -237.28, -70.40),
            vector3(2519.72, -250.60, -70.40)
        },
        [2] = {
            vector3(2514.85, -223.50, -70.40),
            vector3(2536.07, -232.34, -70.40),
            vector3(2536.06, -244.72, -70.40),
            vector3(2514.85, -253.55, -70.40)
        }
        
        
    },

    ["lvlFourKeypad"]  = {
        vector3(2464.828, -282.2930, -70.4072),
        vector3(2464.845, -276.1607, -70.4072),
        vector3(2492.825, -241.5286, -70.4072),
        vector3(2492.829, -235.4994, -70.4072)
    } 
}

difficulty = 1 -- 1 = Normal, 2 = Hard
loot = 1 -- 1 = CASH, 2 = GOLD, 3 = ARTWORK, 4 = DIAMONDS
approach = 2 -- 1 = Silent and Sneaky, 2 = The Big Con, 3 = Aggressive
vaultLayout = 0
teamlives = 1
take = 8502100

cash = 5875
goldbar = 16156

potential = {
    [1] = { -- Normal
        2115000,
        2585000,
        2350000,
        3290000
    },
    [2] = { -- Hard
        2326500,
        2843500,
        2585000,
        3619000
    }
}

gunman = {
    -- Person, Skill, Index, Cut
    {"Chester McCoy", "Expert", 1, 0.1},
    {"Gustavo Mota", "Expert", 2, 0.09},
    {"Patrick McReary", "Expert", 3, 0.08},
    {"Charlie Reed", "Good", 4, 0.07},
    {"Karl Abolaji", "Poor", 5, 0.05}
}

driver = {
    -- Person, Skill, Index, Cut
    {"Chester McCoy", "Expert", 1, 0.1},
    {"Eddie Toh", "Expert", 2, 0.09},
    {"Taliana Martinez", "Good", 3, 0.07},
    {"Zach Nelson", "Good", 4, 0.06},
    {"Karim Denz", "Poor", 5, 0.05}
}

hacker = {
    -- Person, Skill, Time Undetected, Time Detected, Cut
    {"Avi Schartzman", "Expert", 2000, 146000, 0.1},
    {"Paige Harris", "Expert", 205000, 143000, 0.09},
    {"Christian Feltz", "Good", 179000, 125000, 0.07},
    {"Yohan Blair", "Good", 172000, 121000, 0.05},
    {"Rickie Lukens", "Poor", 146000, 102000, 0.03},
}

selectedGunman = 0
selectedDriver = 0
selectedHacker = 0

availableVehicles = {
    [1] = { -- Driver
        [1] = { -- Getaway Vehicle
            "zhaba",
            "vagrant",
            "outlaw",
            "everon"
        },
        "kamacho", -- Departure Vehicle   
        "mesa3"  -- Switch Vehicle
    },
    [2] = {
        [1] = {
            "sultan2",
            "gauntlet3",
            "ellie",
            "komoda"
        },
        "kuruma",
        "taxi"
    },
    [3] = {
        [1] = {
            "retinue2",
            "yosemite2",
            "sugoi",
            "jugular"
        },
        "sultan",
        "emperor"
    },
    [4] = {
        [1] = {
            "manchez",
            "stryder",
            "defiler",
            "lectro"
        },
        "youga2",
        "pony"
    },
    [5] = {
        [1] = {
            "issi3",
            "asbo",
            "kanjo",
            "sentinel3"
        },
        "rancherxl",
        "regina"
    }
}

weaponLoadout = {
    [1] { -- Approach
        [1] = { -- Gunman
            [1] = { -- Loadout 1
                "WEAPON_PUMPSHOTGUN_MK2",
                "WEAPON_PISTOL50",
                "WEAPON_STUNGUN",
                "WEAPON_KNIFE"
            },
            [2] = { -- Loadout 2
                "WEAPON_CARBINERIFLE_MK2",
                "WEAPON_PISTOL50",
                "WEAPON_STUNGUN",
                "WEAPON_KNIFE"
            }
        },
        [2] = {
            [1] = {
                "WEAPON_CARBINERIFLE",
                "WEAPON_HEAVYPISTOL",
                "WEAPON_STUNGUN",
                "WEAPON_KNIFE"
            },
            [2] = {
                "WEAPON_ASSAULTSHOTGUN",
                "WEAPON_PISTOL50",
                "WEAPON_STUNGUN",
                "WEAPON_KNIFE"
            }
        },
        [3] = {
            [1] = {
                "WEAPON_COMBATPDW",
                "WEAPON_PISTOL50",
                "WEAPON_STUNGUN",
                "WEAPON_KNIFE"
            },
            [2] = {
                "WEAPON_ASSAULTRIFLE",
                "WEAPON_PISTOL50",
                "WEAPON_STUNGUN",
                "WEAPON_KNIFE"
            }
        },
        [4] = {
            [1] = {
                "WEAPON_ASSAULTSMG",
                "WEAPON_COMBATPISTOL",
                "WEAPON_STUNGUN",
                "WEAPON_KNIFE"
            },
            [2] = {
                "WEAPON_BULLPUPSHOTGUN",
                "WEAPON_HEAVYPISTOL",
                "WEAPON_STUNGUN",
                "WEAPON_KNIFE"
            }
        },
        [5] = {
            [1] = {
                "WEAPON_MICROSMG",
                "WEAPON_VINTAGEPISTOL",
                "WEAPON_STUNGUN",
                "WEAPON_KNIFE"
            },
            [2] = {
                "WEAPON_MACHINEPISTOL",
                "WEAPON_COMBATPISTOL",
                "WEAPON_STUNGUN",
                "WEAPON_KNIFE"
            }
        }
    },
    [2] {
        [1] = {
            [1] = {
                "WEAPON_SMG_MK2",
                "WEAPON_CERAMICPISTOL",
                "WEAPON_SWITCHBLADE"
            },
            [2] = {
                "WEAPON_BULLPUPRIFLE_MK2",
                "WEAPON_CERAMICPISTOL",
                "WEAPON_SWITCHBLADE"
            }
        },
        [2] = {
            [1] = {
                "WEAPON_CARBINERIFLE",
                "WEAPON_CERAMICPISTOL",
                "WEAPON_SWITCHBLADE"
            },
            [2] = {
                "WEAPON_ASSAULTSHOTGUN",
                "WEAPON_CERAMICPISTOL",
                "WEAPON_SWITCHBLADE"
            }
        },
        [3] = {
            [1] = {
                "WEAPON_SAWNOFFSHOTGUN",
                "WEAPON_CERAMICPISTOL",
                "WEAPON_SWITCHBLADE"
            },
            [2] = {
                "WEAPON_COMPACTRIFLE",
                "WEAPON_CERAMICPISTOL",
                "WEAPON_SWITCHBLADE"
            }
        },
        [4] = {
            [1] = {
                "WEAPON_MACHINEPISTOL",
                "WEAPON_CERAMICPISTOL",
                "WEAPON_SWITCHBLADE"
            },
            [2] = {
                "WEAPON_AUTOSHOTGUN",
                "WEAPON_CERAMICPISTOL",
                "WEAPON_SWITCHBLADE"
            }
        },
        [5] = {
            [1] = {
                "WEAPON_MICROSMG",
                "WEAPON_CERAMICPISTOL",
                "WEAPON_SWITCHBLADE"
            },
            [2] = {
                "WEAPON_DBSHOTGUN",
                "WEAPON_CERAMICPISTOL",
                "WEAPON_SWITCHBLADE"
            }
        }
    },
    [3] {
        [1] = {
            [1] = {
                "WEAPON_PUMPSHOTGUN_MK2",
                "WEAPON_SMG_MK2",
                "WEAPON_PIPEBOMB",
                "WEAPON_WRENCH"
            },
            [2] = {
                "WEAPON_ASSAULTRIFLE_MK2",
                "WEAPON_SMG_MK2",
                "WEAPON_PIPEBOMB",
                "WEAPON_WRENCH"
            }
        },
        [2] = {
            [1] = {
                "WEAPON_CARBINERIFLE",
                "WEAPON_SMG",
                "WEAPON_PROXMINE",
                "WEAPON_MACHETE"
            },
            [2] = {
                "WEAPON_ASSAULTSHOTGUN",
                "WEAPON_SMG",
                "WEAPON_PROXMINE",
                "WEAPON_MACHETE"
            }
        },
        [3] = {
            [1] = {
                "WEAPON_HEAVYSHOTGUN",
                "WEAPON_SMG",
                "WEAPON_STICKYBOMB",
                "WEAPON_CROWBAR"
            },
            [2] = {
                "WEAPON_COMBATMG",
                "WEAPON_SMG",
                "WEAPON_STICKYBOMB",
                "WEAPON_CROWBAR"
            }
        },
        [4] = {
            [1] = {
                "WEAPON_ASSAULTSMG",
                "WEAPON_SMG",
                "WEAPON_GRENADE",
                "WEAPON_HAMMER"
            },
            [2] = {
                "WEAPON_PUMPSHOTGUN",
                "WEAPON_SMG",
                "WEAPON_GRENADE",
                "WEAPON_HAMMER"
            }
        },
        [5] = {
            [1] = {
                "WEAPON_SAWNOFFSHOTGUN",
                "WEAPON_SMG",
                "WEAPON_MOLOTOV",
                "WEAPON_KNUCKLE"
            },
            [2] = {
                "WEAPON_REVOLVER",
                "WEAPON_SMG",
                "WEAPON_MOLOTOV",
                "WEAPON_KNUCKLE"
            }
        }
    }
}

--hackerSelected = 1

alarmTriggered = 0

local models = { 
    GetHashKey("a_f_m_bevhills_01"),
    GetHashKey("a_f_m_bevhills_02"),
    GetHashKey("a_f_m_bodybuild_01") 
}

local nPropsCoords = { 
    vector3(2505.54, -238.53, -71.65),
    vector3(2504.98, -240.31, -70.19)
}

local nPropsNames = { 
    GetHashKey("ch_prop_ch_vault_wall_damage"),
    GetHashKey("ch_des_heist3_vault_end")
}

RegisterCommand("vl_break", function()
    for i = 1, #nPropsCoords, 1 do 
        local prop = GetClosestObjectOfType(nPropsCoords[i], 1.0, nPropsNames[i], false, false, false)
        local prop1 = GetClosestObjectOfType(2504.97, -240.31, -70.17, 1.0, GetHashKey("ch_des_heist3_vault_01"), false, false, false)
        SetEntityVisible(prop, true)
        SetEntityVisible(prop1, false)
        SetEntityCollision(prop, true, true)
        SetEntityCollision(prop1, false, true)
    end
end, false)

function GetHeistPlayer()
    Models()
    --hPlayer[2] = CreatePed(7, models[1], 0.0, 0.0, 0.0, 0.0, true, true)
    --hPlayer[3] = CreatePed(7, models[2], 0.0, 0.0, 0.0, 0.0, true, true)
    --hPlayer[4] = CreatePed(7, models[3], 0.0, 0.0, 0.0, 0.0, true, true)
    return hPlayer 
end

function DeletePeds()
    for i = 3, #hPlayer, 1 do 
        DeletePed(hPlayer[i])
    end
end

function Models()
    for i = 1, #models, 1 do 
        LoadModel(models[i])
    end
end

--function SetLoot()
--    loot = math.random(1, 4)
--end

function SetLayout()
    if loot ~= 2 then 
        vaultLayout = math.random(1,6)
    else  
        vaultLayout = math.random(7,10)
    end
    --vaultLayout = math.random(1,4)
end

AddEventHandler("onResourceStart", function()
    --HideNPropsStart()
    --if GetCurrentResourceName() ~= "1heist" then 
    --    print("Not the correct resource name")
    --    StopResource(GetCurrentResourceName())
    --end
    --TriggerServerEvent("sv:casinoheist:setupheist" )
    SetEntityVisible(PlayerPedId(), true)
end)

function SetupCheckpoint()
    for i = 1, #nPropsCoords, 1 do 
        local prop = GetClosestObjectOfType(nPropsCoords[i], 1.0, nPropsNames[i], false, false, false)
        --local prop1 = GetClosestObjectOfType(2504.97, -240.31, -70.17, 1.0, GetHashKey("ch_des_heist3_vault_01"), false, false, false)
        SetEntityVisible(prop, false)
        SetEntityCollision(prop, false, true)
        --SetEntityVisible(prop1, true)
        --SetEntityCollision(prop1, true, true)
    end

    
    --FreezeEntityPosition(GetClosestObjectOfType(2504.58, -240.4, -70.71, 2.0, GetHashKey("ch_prop_ch_vaultdoor01x"), false, false, false), true)

    local shaft = GetClosestObjectOfType(2505.54, -238.53, -71.65, 10.0, GetHashKey("ch_prop_ch_vault_wall_damage"), false, false, false)
    local vaultDoorOne = "ch_des_heist3_vault_01"
    local vaultDoorTwo = "ch_des_heist3_vault_02"

    SetEntityVisible(shaft, false)
    LoadModel(vaultDoorOne)
    LoadModel(vaultDoorTwo)

    vaultObjOne = CreateObject(GetHashKey(vaultDoorOne), 2504.97, -240.31, -73.69, false, false, false)
    vaultObjTwo = CreateObject(GetHashKey(vaultDoorTwo), 2504.97, -240.31, -75.334, false, false, false)  

    SetEntityForAll(vaultObjOne)
    SetEntityForAll(vaultObjTwo)
end

RegisterNetEvent("cl:casinoheist:updateHeistPlayers", function(one)
    print("client event " .. one)
    hPlayer[1] = one
    hPlayer[2] = two
    hPlayer[3] = three
    hPlayer[4] = four

    --for i = 1, 4 do 
    --    hPlayer[i] = one[i]
    --end

    print(hPlayer[1], hPlayer[2], hPlayer[3], hPlayer[4], "set")
end)

AddEventHandler("baseevents:onPlayerDied", function(o, i)
    if hPlayer[1] == GetPlayerServerId(PlayerId()) or hPlayer[2] == GetPlayerServerId(PlayerId()) or hPlayer[3] == GetPlayerServerId(PlayerId()) or hPlayer[4] == GetPlayerServerId(PlayerId()) then 
        TriggerServerEvent("sv:casinoheist:removeteamlive")
        print("works")
    else 
        print("isnt")
    end
end)

RegisterCommand("hPlayer", function(source, args)
    print(args[1])
    print(PlayerPedId())
    TriggerServerEvent("sv:casinoheist:setHeistPlayers", PlayerPedId(), tonumber(args[1]))
end, false)