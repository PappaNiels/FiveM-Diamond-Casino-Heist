gunman = {
    -- Person, Skill, Index, Image, Cut
    {"Karl Abolaji", "Poor", 5, 1, 0.05},
    {"Charlie Reed", "Good", 4, 3, 0.07},
    {"Patrick McReary", "Expert", 3, 5, 0.08},
    {"Gustavo Mota", "Expert", 2, 2, 0.09},
    {"Chester McCoy", "Expert", 1, 4, 0.1},
}

driver = {
    -- Person, Skill, Index, Image Cut
    {"Karim Denz", "Poor", 5, 1, 0.05},
    {"Zach Nelson", "Good", 4, 4, 0.06},
    {"Taliana Martinez", "Good", 3, 2, 0.07},
    {"Eddie Toh", "Expert", 2, 3, 0.09},
    {"Chester McCoy", "Expert", 1, 5, 0.1},
}

hacker = {
    -- Person, Skill, Time Undetected, Time Detected, Image, Cut
    {"Rickie Lukens", "Poor", 146000, 102000, 1, 0.03},
    {"Yohan Blair", "Good", 172000, 121000, 3, 0.05},
    {"Christian Feltz", "Good", 179000, 125000, 2, 0.07},
    {"Paige Harris", "Expert", 205000, 143000, 5, 0.09},
    {"Avi Schartzman", "Expert", 2000, 146000, 4, 0.1},
}

weaponLoadout = {
    [1] = { -- Approach
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
    [2] = {
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
    [3] = {
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

availableVehicles = {
    [1] = { -- Driver
        { -- Getaway Vehicle
            -- Model Name, Name on Board
            {"zhaba", "Zhaba"},
            {"vagrant", "Vargrant"},
            {"outlaw", "Outlaw"},
            {"everon", "Everon"}
        },
        "kamacho", -- Departure Vehicle   
        "mesa3"  -- Switch Vehicle
    },
    [2] = {
        {
            {"sultan2", "Sultan Classic"},
            {"gauntlet3", "Gauntlet Classic"},
            {"ellie", "Ellie"},
            {"komoda", "Komoda"}
        },
        "kuruma",
        "taxi"
    },
    [3] = {
        {
            {"retinue2", "Retinue MK II"},
            {"yosemite2", "Drift Yosemite"},
            {"sugoi", "Sugoi"},
           {"jugular", "Jugular"}
        },
        "sultan",
        "emperor"
    },
    [4] = {
        {
            {"manchez", "Manchez"},
            {"stryder", "Stryder"},
            {"defiler", "Defiler"},
            {"lectro", "Lectro"}
        },
        "youga2",
        "pony"
    },
    [5] = {
        {
            {"issi3", "Issi Classic"},
            {"asbo", "Asbo"},
            {"kanjo", "Kanjo"},
            {"sentinel3", "Sentinal Classic"}
        },
        "rancherxl",
        "regina"
    }
}