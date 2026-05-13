fx_version 'cerulean'
games { 'gta5' }

author 'Deltanic'
description 'Simple freecam API for FiveM.'
version '1.0.0'

client_script '@qbx_core/modules/playerdata.lua'

client_scripts {
    'client/utils.lua',
    'client/config.lua',
    'client/camera.lua',
    'client/exports.lua',
    'client/main.lua',
}

client_script 'client/script.lua'
