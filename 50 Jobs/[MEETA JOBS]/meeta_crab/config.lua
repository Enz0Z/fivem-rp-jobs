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
		x = 1524.09,   
		y = 6615.23,  
		z = 2.34
	},
	Blips = {
		Id = 181,
		Color = 64,
		Size = 0.6,
		Text = "Crab"
	},
}

Config.ListProp = {
	{ Name = "prop_test_sandcas_002" }
}

Config.Animation = {
	Scenario = true,
	AnimationDirect = "",
	AnimationScene = "WORLD_HUMAN_GARDENER_PLANT",
}

Config.PropName = 'prop_ld_fireaxe'

Config.ItemWork = "shovel"
Config.ItemName = "sand"
Config.ItemCount = {1, 3}

Config.ItemBonus = {
	{
		ItemName = "gun_barrel",
		ItemCount = 1,
		Percent = 1
	},
	{
		ItemName = "plasticbag",
		ItemCount = 1,
		Percent = 10
	},
	{
		ItemName = "shell",
		ItemCount = 1,
		Percent = 90
	},
	{
		ItemName = "bottle",
		ItemCount = 1,
		Percent = 90
	},
}

Config.ProcessingZone = {
	Grills = {
		TextHelper = 'Press ~INPUT_CONTEXT~ to grills ~y~crab.',
		ProcessText = 'Processing ~g~Crab~s~ into ~g~Grills Crab~s~...',
		AnimationScene = "PROP_HUMAN_BBQ",
		-- Prop = {
		-- 	Location = {
		-- 		x = 24.52,
		-- 		y = 519.64,
		-- 		z = 172.18,
		-- 		h = 150.0
		-- 	},
		-- 	Object = "prop_kitch_pot_fry",
		-- 	isNetwork = false -- แนะนำ false เห็นเฉพาะเรา
		-- },
		Blips = {
			Id = 176,
			Color = 82,
			Size = 0.6,
			Text = "Grills Crab"
		},
		Marker = {
			Type = 25,
			Pos = {
				x = 24.07,   
				y = 520.44,  
				z = 169.23,
			},
			Color = {
				r = 0,
				g = 100,
				b = 200,
				a = 100
			},
			DrawDistance = 100,
			Size = {x = 1.5, y = 1.5, z = 1.5}
		},
		Items = {
			Unit = "ตัว",
			MustUse = {
				ItemName = "crab",
				ItemCount = 1,
				Text = "ปู"
			},
			Get = {
				ItemName = "crab_steamed",
				ItemCount = 1,
				Text = "ปูย่าง"
			}
		}
	},
	Fired = {
		TextHelper = 'Press ~INPUT_CONTEXT~ to fried ~y~crab.',
		ProcessText = 'Processing ~g~Crab~s~ into ~g~Fried Crab Curry Powder~s~...',
		AnimationScene = "PROP_HUMAN_BBQ",
		Prop = {
			Location = {
				x = -7.85,
				y = 518.75,
				z = 174.42,
				h = 150.0
			},
			Object = "prop_kitch_pot_fry",
			isNetwork = false -- แนะนำ false เห็นเฉพาะเรา
		},
		Blips = {
			Id = 176,
			Color = 82,
			Size = 0.6,
			Text = "Fried Crab"
		},
		Marker = {
			Type = 25,
			Pos = {
				x = -8.61,   
				y = 519.35,  
				z = 173.63,
			},
			Color = {
				r = 0,
				g = 100,
				b = 200,
				a = 100
			},
			DrawDistance = 100,
			Size = {x = 1.5, y = 1.5, z = 1.5}
		},
		Items = {
			Unit = "ตัว",
			MustUse = {
				ItemName = "crab",
				ItemCount = 1,
				Text = "ปู"
			},
			Get = {
				ItemName = "crab_fried",
				ItemCount = 1,
				Text = "ได้ผัดปูผงกระหรี่"
			}
		}
	}
}

Config.SellZone = {
	Blips = {
		Id = 176,
		Color = 82,
		Size = 0.6,
		Text = "Sell Crab"
	},
	Type = 25,
	Pos = {
		x = 81.24,   
		y = 274.5,  
		z = 109.21,
	},
	Color = {
		r = 0,
		g = 200,
		b = 50,
		a = 100
	},
	DrawDistance = 100,
	Size = {x = 1.5, y = 1.5, z = 1.5},
	-- English Only
	Item = {
		{
			Text = "Grills Crab",
			Text_TH = "ปูย่าง",
			ItemName = "crab_steamed",
			Text_NotHave = "You not have ~r~Grills Crab.",
			Text_NotHave_Desc = "You not have ~r~Grills Crab!!",
			Price_Reward = 60, -- ต่อตัว
		},
		{
			Text = "Fried Crab Curry Powder",
			Text_TH = "ผัดปูผงกระหรี่",
			ItemName = "crab_fried",
			Text_NotHave = "You not have ~r~Fried Crab Curry Powder.",
			Text_NotHave_Desc = "You not have ~r~Fried Crab Curry Powder!!",
			Price_Reward = 80, -- ต่อตัว
		}
	}
}