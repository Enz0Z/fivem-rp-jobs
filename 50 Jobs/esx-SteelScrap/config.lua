Config = {}

Config.SteelScrapRecieve = { 1, 1 } -- This is the math random ex. math.random(1, 6) this will give you 1 - 6 SteelScraps when searching a bin.
Config.SteelScrapReward = { 1, 1 } -- This is the math random ex. math.random(1, 4) this will give a random payout between 1 - 4

-- Here you add all the bins you are going to search.
Config.BinsAvailable = {
	"prop_rub_carwreck_10",
    "prop_rub_carwreck_11",
    "prop_rub_carwreck_12",
	"prop_rub_carwreck_13",
	"prop_rub_carwreck_14",
	"prop_rub_carwreck_15",
	"prop_rub_carwreck_16",
	"prop_rub_carwreck_17",
	"prop_rub_carwreck_2",
	"prop_rub_carwreck_3",
	"prop_rub_carwreck_4",
	"prop_rub_carwreck_5",
	"prop_rub_carwreck_6",
	"prop_rub_carwreck_7",
	"prop_rub_carwreck_8",
	"prop_rub_carwreck_9"
}

-- This is where you add the locations where you sell the SteelScraps.
--[[Config.SellSteelScrapLocations = {
    vector3(29.337753295898, -1770.3348388672, 29.607357025146),
    vector3(388.30194091797, -874.88238525391, 29.295169830322),
    vector3(26.877752304077, -1343.0764160156, 29.497024536133)
}