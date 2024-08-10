fx_version 'cerulean'
game 'gta5'

lua54 'yes'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/app.js',
}

shared_scripts {
    '@ox_lib/init.lua'
}

client_scripts {
    'client.lua',
}



server_scripts {
    'server.lua',
}
