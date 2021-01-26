resource_manifest_version '00000000-0000-0000-0000-000000000000'

description 'CrossBite Milk Script'

version '1.0.0'

client_scripts {
	'@es_extended/locale.lua',
	'locales/th.lua',
	'config.lua',
	'clients/milk.lua',
	'clients/client.lua'
}
server_scripts {
	'@es_extended/locale.lua',
	'locales/th.lua',
	'config.lua',
	'servers/server.lua'
}