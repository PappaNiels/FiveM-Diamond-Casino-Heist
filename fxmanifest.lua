fx_version "bodacious"
game "gta5"

author "Niels"
description "Diamond Casino Heist"
version "1.0.0"

client_scripts {
    "client/rappel.lua",
    "client/anim.lua",
    "client/sewer.lua",
    "client/test.lua",
    "client/keycard.lua",
    "client/aggressive-ent.lua",
    "client/functions.lua",
    "client/main.lua", 
    "client/staff.lua",
    "client/security.lua",
    "client/mantrap.lua",
    "client/ipl.lua",
    "client/vault.lua"
}

server_scripts { 
    "server/main.lua"
}

dependencies {
    "/gameBuild:h4"
}