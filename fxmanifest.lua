fx_version "cerulean"
game "gta5"

author "PappaNiels"
description "Diamond Casino Heist"
version "1.0.1"
repository "https://github.com/PappaNiels/FiveM-Diamond-Casino-Heist"

-- for the ytyps
this_is_a_map "yes"

lua54 "yes"

client_scripts {
    "client/*.lua"
}

server_scripts { 
    "server/*.lua"
}

shared_scripts {
    "shared/*.lua"
}

dependencies {
    "/gameBuild:h4",
    "baseevents"
}