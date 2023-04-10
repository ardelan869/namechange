fx_version 'cerulean'
game 'gta5'
lua54 'yes'

ui_page 'html/index.html'
files {
    'html/**/**/*.*',
    'html/index.html'
}

client_scripts {
    'config/cl_config.lua',
    'client/main.lua'
}
server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'config/sv_config.lua',
    'server/main.lua'
}

escrow_ignore {
    'html/index.html',
    'html/**/**/*.*',
    'config/*.*'
}