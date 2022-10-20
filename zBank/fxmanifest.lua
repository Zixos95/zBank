fx_version "adamant"
lua54 'yes'

game "gta5"

client_scripts {
    -- RAGEUI
    "src/client/RMenu.lua",
    "src/client/menu/RageUI.lua",
    "src/client/menu/Menu.lua",
    "src/client/menu/MenuController.lua",
    "src/client/components/*.lua",
    "src/client/menu/elements/*.lua",
    "src/client/menu/items/*.lua",
    "src/client/menu/panels/*.lua",
    "src/client/menu/windows/*.lua",
    -- Script
    'shared/*.lua',
    'client/*.lua',
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    'shared/*.lua',
    'server/*.lua',
}

escrow_ignore {
    'shared/*.lua',
}