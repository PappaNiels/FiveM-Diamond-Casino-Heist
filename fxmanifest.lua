fx_version "cerulean"
game "gta5"

author "Niels"
description "Diamond Casino Heist"
version "1.0.0"

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

--escrow_ignore {
--    "shared/*.lua"
--}

dependencies {
    "/gameBuild:h4",
    "baseevents",
    "nj_casino"
}