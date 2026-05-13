fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'EAZY-V'
description 'NPC Spawner | /npcdebug, /npcspawn, /npcdelete [id]'

shared_script '@ox_lib/init.lua'

shared_scripts {
    '@scully_emotemenu/config/animations.lua'
}

description 'Spawn de NPCs à la main avec une commande'
dependencies {
    'ox_lib',
    'scully_emotemenu'
}

client_script 'client.lua'