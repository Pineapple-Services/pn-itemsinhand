fx_version "cerulean"
game "gta5"

author "Pineapple Studios"
description "Join our discord - discord.gg/547nKvQhZ7"
lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    "config.lua"
}

client_script "client.lua"
server_script "server.lua"
escrow_ignore "config.lua"