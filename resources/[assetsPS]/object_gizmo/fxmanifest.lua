fx_version 'cerulean'
game 'gta5'
lua54 'yes'

version '2.1.0'

client_scripts {
	"client/gizmo.lua",
	'client/test.lua'
}
description "Dépendance pour placer précisément les lumières lors de l'édition"
shared_scripts {
	'@ox_lib/init.lua'
}

files {
	'client/dataview.lua',
}

server_script 'version.lua'

dependencies {
	'ox_lib'
}
