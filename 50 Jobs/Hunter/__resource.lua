resource_manifest_version '00000000-0000-0000-0000-000000000000'

description 'CrossBite Chicken Script'

version '1.0.0'

client_scripts {
	'@es_extended/locale.lua',
	'locales/th.lua',
	'config.lua',
	'clients/hunter.lua',
	'clients/client.lua'
}
server_scripts {
	'@es_extended/locale.lua',
	'locales/th.lua',
	'config.lua',
	'servers/server.lua'
}