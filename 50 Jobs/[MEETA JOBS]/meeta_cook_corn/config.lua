-- CREATE BY THANAWUT PROMRAUNGDET
Config = {}

Config.Key = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

Config.Zone = {
	Pos = {
		x = 2041.54,   
		y = 4941.55,  
		z = 41.03
	},
	Vehicle = {
		Pos = {
			x = 2020.39,   
			y = 4967.16,  
			z = 41.35
		},
		Spawn = {
			x = 2014.72,   
			y = 4959.03,  
			z = 41.55,
			h = 312.6
		},
		Delete = {
			x = 2014.92,   
			y = 4979.79,  
			z = 41.26
		},
	},
	Blips = {
		Id = 469,
		Color = 5,
		Size = 0.8,
		Text = "Corn"
	},
}



Config.ListProp = {
	{ Name = "prop_bush_med_03_cr2" }
}

Config.VehicleModel = "tractor2"

Config.PropName = 'prop_ld_fireaxe'

Config.ItemWork = "shovel"
Config.ItemNameText = "ข้าวโพด"
Config.ItemName = "cook_corn"
Config.ItemCount = {2, 5}

Config.ItemBonus = {}