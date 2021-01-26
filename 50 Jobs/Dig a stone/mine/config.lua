config = {}

config.items = {
	copper = 150,
	iron = 250,
	gold = 350,
	diamond = 500
}
RegisterNetEvent("market:change:copper")
AddEventHandler('market:change:copper', function(price)
	config.items['copper'] = price
end)
RegisterNetEvent("market:change:diamond")
AddEventHandler('market:change:diamond', function(price)
	config.items['diamond'] = price
end)

config.zones = {
	Mine = { coords = vector3(2946.40, 2793.20, 40.39), name = 'Mine', color = 70, sprite = 318},
	MineProcessing = {coords = vector3(1109.24, -2007.90, 31.64), name = 'Foundry', color = 70, sprite = 318},
	MineDealer = {coords = vector3(406.78, -349.7, 46.89), name = 'Mineral Dealer', color = 70, sprite = 207},
}