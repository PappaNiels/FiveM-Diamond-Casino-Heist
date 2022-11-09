gunman = {
    -- Person, Skill, Image, Cut
    {"Karl Abolaji", "Poor", 1, 0.05},
    {"Charlie Reed", "Good", 3, 0.07},
    {"Patrick McReary", "Expert", 5, 0.08},
    {"Gustavo Mota", "Expert", 2, 0.09},
    {"Chester McCoy", "Expert", 4, 0.1},
}

driver = {
    -- Person, Skill, Index, Image Cut
    {"Karim Denz", "Poor", 1, 0.05},
    {"Zach Nelson", "Good", 4, 0.06},
    {"Taliana Martinez", "Good", 2, 0.07},
    {"Eddie Toh", "Expert", 3, 0.09},
    {"Chester McCoy", "Expert", 5, 0.1},
}

hacker = {
    -- Person, Skill, Time Undetected, Time Detected, Image, Cut | Time is in seconds
    {"Rickie Lukens", "Poor", 146, 102, 1, 0.03},
    {"Yohan Blair", "Good", 172, 121, 3, 0.05},
    {"Christian Feltz", "Good", 179, 125, 2, 0.07},
    {"Paige Harris", "Expert", 205, 143, 5, 0.09},
    {"Avi Schartzman", "Expert", 210, 146, 4, 0.1},
}

weaponLoadout = {
    { -- Approach
        { -- Gunman 
            { -- Loadout 1
                "WEAPON_MICROSMG",
                "WEAPON_VINTAGEPISTOL",
                "WEAPON_STUNGUN",
                "WEAPON_KNIFE"
            },
            { -- Loadout 2
                "WEAPON_MACHINEPISTOL",
                "WEAPON_COMBATPISTOL",
                "WEAPON_STUNGUN",
                "WEAPON_KNIFE"
            }
        },
        {
            { 
                "WEAPON_ASSAULTSMG",
                "WEAPON_COMBATPISTOL",
                "WEAPON_STUNGUN",
                "WEAPON_KNIFE"
            },
            {
                "WEAPON_BULLPUPSHOTGUN",
                "WEAPON_HEAVYPISTOL",
                "WEAPON_STUNGUN",
                "WEAPON_KNIFE"
            }
        },
        {
            { 
                "WEAPON_COMBATPDW",
                "WEAPON_PISTOL50",
                "WEAPON_STUNGUN",
                "WEAPON_KNIFE"
            },
            {
                "WEAPON_ASSAULTRIFLE",
                "WEAPON_PISTOL50",
                "WEAPON_STUNGUN",
                "WEAPON_KNIFE"
            }
        },
        {
            { 
                "WEAPON_CARBINERIFLE",
                "WEAPON_HEAVYPISTOL",
                "WEAPON_STUNGUN",
                "WEAPON_KNIFE"
            },
            {
                "WEAPON_ASSAULTSHOTGUN",
                "WEAPON_PISTOL50",
                "WEAPON_STUNGUN",
                "WEAPON_KNIFE"
            }
        },
        { 
            {  
                "WEAPON_PUMPSHOTGUN_MK2",
                "WEAPON_PISTOL50",
                "WEAPON_STUNGUN",
                "WEAPON_KNIFE"
            },
            { 
                "WEAPON_CARBINERIFLE_MK2",
                "WEAPON_PISTOL50",
                "WEAPON_STUNGUN",
                "WEAPON_KNIFE"
            }
        }
    },
    {
        {
            {
                "WEAPON_MICROSMG",
                "WEAPON_CERAMICPISTOL",
                "WEAPON_SWITCHBLADE"
            },
            {
                "WEAPON_DBSHOTGUN",
                "WEAPON_CERAMICPISTOL",
                "WEAPON_SWITCHBLADE"
            }
        },
        {
            {
                "WEAPON_MACHINEPISTOL",
                "WEAPON_CERAMICPISTOL",
                "WEAPON_SWITCHBLADE"
            },
            {
                "WEAPON_AUTOSHOTGUN",
                "WEAPON_CERAMICPISTOL",
                "WEAPON_SWITCHBLADE"
            }
        },
        {
            {
                "WEAPON_SAWNOFFSHOTGUN",
                "WEAPON_CERAMICPISTOL",
                "WEAPON_SWITCHBLADE"
            },
            {
                "WEAPON_COMPACTRIFLE",
                "WEAPON_CERAMICPISTOL",
                "WEAPON_SWITCHBLADE"
            }
        },
        {
            {
                "WEAPON_CARBINERIFLE",
                "WEAPON_CERAMICPISTOL",
                "WEAPON_SWITCHBLADE"
            },
            {
                "WEAPON_ASSAULTSHOTGUN",
                "WEAPON_CERAMICPISTOL",
                "WEAPON_SWITCHBLADE"
            }
        },
        {
            {
                "WEAPON_SMG_MK2",
                "WEAPON_CERAMICPISTOL",
                "WEAPON_SWITCHBLADE"
            },
            {
                "WEAPON_BULLPUPRIFLE_MK2",
                "WEAPON_CERAMICPISTOL",
                "WEAPON_SWITCHBLADE"
            }
        }
    },
    {
        {
            {
                "WEAPON_SAWNOFFSHOTGUN",
                "WEAPON_SMG",
                "WEAPON_MOLOTOV",
                "WEAPON_KNUCKLE"
            },
            {
                "WEAPON_REVOLVER",
                "WEAPON_SMG",
                "WEAPON_MOLOTOV",
                "WEAPON_KNUCKLE"
            }
        },
        {
            {
                "WEAPON_ASSAULTSMG",
                "WEAPON_SMG",
                "WEAPON_GRENADE",
                "WEAPON_HAMMER"
            },
            {
                "WEAPON_PUMPSHOTGUN",
                "WEAPON_SMG",
                "WEAPON_GRENADE",
                "WEAPON_HAMMER"
            }
        },
        {
            {
                "WEAPON_HEAVYSHOTGUN",
                "WEAPON_SMG",
                "WEAPON_STICKYBOMB",
                "WEAPON_CROWBAR"
            },
            {
                "WEAPON_COMBATMG",
                "WEAPON_SMG",
                "WEAPON_STICKYBOMB",
                "WEAPON_CROWBAR"
            }
        },
        {
            {
                "WEAPON_CARBINERIFLE",
                "WEAPON_SMG",
                "WEAPON_PROXMINE",
                "WEAPON_MACHETE"
            },
            {
                "WEAPON_ASSAULTSHOTGUN",
                "WEAPON_SMG",
                "WEAPON_PROXMINE",
                "WEAPON_MACHETE"
            }
        },
        {
            {
                "WEAPON_PUMPSHOTGUN_MK2",
                "WEAPON_SMG_MK2",
                "WEAPON_PIPEBOMB",
                "WEAPON_WRENCH"
            },
            {
                "WEAPON_ASSAULTRIFLE_MK2",
                "WEAPON_SMG_MK2",
                "WEAPON_PIPEBOMB",
                "WEAPON_WRENCH"
            }
        }
    }
}

availableVehicles = {
    [5] = {
        {
            {"issi3", "Issi Classic"},
            {"asbo", "Asbo"},
            {"kanjo", "Kanjo"},
            {"sentinel3", "Sentinal Classic"}
        },
        "rancherxl",
        "regina"
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
    }
}