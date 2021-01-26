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

Config.ProcessingZone = {
	WeedToMarijuana = {
		Text = {
			Title = "Drugs",
			SubTitle = "Processing Drugs",
			TextHelper = 'Press ~INPUT_CONTEXT~ to ~y~Processing drugs.',
			ProcessText = 'Wait for ~g~Processing...',
		},
		Animation = {
			Scenario = true,
			AnimationDirect = nil,
			AnimationScene = "WORLD_HUMAN_HANG_OUT_STREET",
		},
		PoliceCount = 3,
		MultileItems = true,
		WaitProcessing = 5000,
		Marker = {
			Type = 25,
			Pos = {
				x = 105.82,   
				y = -258.12,  
				z = 54.5,
			},
			Color = {
				r = 200,
				g = 190,
				b = 0,
				a = 100
			},
			DrawDistance = 100,
			Size = {x = 1.0, y = 1.0, z = 1.0},
			SizeMark = 2.0
		},
		Items = {
			{
				Text = "ใบกัญชา",
				Text_TH = "ใบกัญชา",
				Unit = "ใบ",
				ItemName = "cannabis",
				Text_NotHave = "คุณไม่มี <strong class='red-text'>ใบกัญชา.</strong>",
				Text_NotHave_Desc = "ต้องใช้ <strong class='red-text'>ใบกัญชา 5 ใบ.</strong>",
				OnceProcessing = false,
				ItemCount = 5,
				Get = {
					ItemName = "marijuana",
					ItemCount = 1,
					Text = "Marijuana",
					Unit = "ขวด"
				}
			},
			{
				Text = "Coke",
				Text_TH = "Coke",
				Unit = "กิโลกรัม",
				ItemName = "coke",
				Text_NotHave = "คุณไม่มี <strong class='red-text'>Coke.</strong>",
				Text_NotHave_Desc = "ต้องใช้ <strong class='red-text'>Coke 1 กิโลกรัม.</strong>",
				OnceProcessing = false,
				ItemCount = 1,
				Get = {
					ItemName = "coke_pooch",
					ItemCount = 20,
					Text = "โคเคน",
					Unit = "ถุง"
				}
			}
		}
	},
	WeedToWeedSmoking = {
		Text = {
			Title = "Drugs",
			SubTitle = "Processing Drugs",
			TextHelper = 'Press ~INPUT_CONTEXT~ to ~y~Processing drugs.',
			ProcessText = 'Wait for ~g~Processing...',
		},
		Animation = {
			Scenario = true,
			AnimationDirect = nil,
			AnimationScene = "WORLD_HUMAN_HANG_OUT_STREET",
		},
		PoliceCount = 0,
		MultileItems = true,
		WaitProcessing = 5000,
		Blips = {
			Id = 140,
			Color = 3,
			Size = 0.6,
			Text = "Weed Processing"
		},
		Marker = {
			Type = 25,
			Pos = {
				x = -1169.01,   
				y = -1573.09,  
				z = 3.76,
			},
			Color = {
				r = 200,
				g = 190,
				b = 0,
				a = 100
			},
			DrawDistance = 100,
			Size = {x = 1.0, y = 1.0, z = 1.0},
			SizeMark = 2.0
		},
		Items = {
			{
				Text = "ใบกัญชา",
				Text_TH = "ใบกัญชา",
				Unit = "ใบ",
				ItemName = "cannabis",
				Text_NotHave = "คุณไม่มี <strong class='red-text'>ใบกัญชา.</strong>",
				Text_NotHave_Desc = "ต้องใช้ <strong class='red-text'>ใบกัญชา 1 ใบ.</strong>",
				OnceProcessing = false,
				ItemCount = 1,
				Get = {
					ItemName = "weed",
					ItemCount = 1,
					Text = "Weed",
					Unit = "กรัม"
				}
			}
		}
	},
	WashedStone = {
		Text = {
			Title = "Wash Stone",
			SubTitle = "Washed Stone",
			TextHelper = 'Press ~INPUT_CONTEXT~ to processing ~b~Washed Stone.',
			ProcessText = 'Wait for ~b~Washed Stone...',
		},
		Animation = {
			Scenario = true,
			AnimationDirect = nil,
			AnimationScene = "WORLD_HUMAN_HANG_OUT_STREET",
		},
		PoliceCount = 0,
		MultileItems = false,
		WaitProcessing = 10000,
		Blips = {
			Id = 318,
			Color = 28,
			Size = 0.6,
			Text = "Washed Stone"
		},
		Marker = {
			Type = 25,
			Pos = {
				x = 2655.47,   
				y = 2806.08,  
				z = 33.4,
			},
			Color = {
				r = 0,
				g = 100,
				b = 200,
				a = 0
			},
			DrawDistance = 100,
			Size = {x = 3.0, y = 3.0, z = 3.0},
			SizeMark = 3.0
		},
		Items = {
			{
				Text = "แร่ดิบ",
				Text_TH = "แร่ดิบ",
				Unit = "อัน",
				ItemName = "raw_ore",
				Text_NotHave = "คุณไม่มี <strong class='red-text'>แร่ดิบ.</strong>",
				Text_NotHave_Desc = "ต้องใช้ <strong class='red-text'>แร่ดิบ 1 อัน.</strong>",
				OnceProcessing = false,
				ItemCount = 20,
				Get = {
					ItemName = "stone",
					ItemCount = 20,
					Text = "หิน",
					Unit = "อัน",
					Bonus = {
						{
							ItemName = "rough_diamond",
							ItemCount = 1,
							Text = "เพชรหยาบ",
							Percent = 1,
							Animation = "WORLD_HUMAN_CHEERING"
						},
						{
							ItemName = "gold_nugget",
							ItemCount = 2,
							Text = "ก้อนทองคำ",
							Percent = 2
						},
						{
							ItemName = "metal_scrap",
							ItemCount = 1,
							Text = "เศษโลหะ",
							Percent = 8
						},
						{
							ItemName = "copper_nugget",
							ItemCount = 4,
							Text = "นักเก็ตทองแดง",
							Percent = 10
						},
					}
				}
			}
		}
	},
	DiamondCutter = {
		Text = {
			Title = "Cutter Diamond",
			SubTitle = "Cutter Diamond",
			TextHelper = 'Press ~INPUT_CONTEXT~ to use ~p~Diamond ~w~cutter machine.',
			ProcessText = 'Wait for ~p~Cutter Diamond...',
		},
		Animation = {
			Scenario = true,
			AnimationDirect = nil,
			AnimationScene = "WORLD_HUMAN_HANG_OUT_STREET",
		},
		PoliceCount = 0,
		MultileItems = false,
		WaitProcessing = 10000,
		Blips = {
			Id = 318,
			Color = 28,
			Size = 0.6,
			Text = "Diamond Cutter"
		},
		Marker = {
			Type = 25,
			Pos = {
				x = 3560.74,   
				y = 3669.65,  
				z = 27.12,
			},
			Color = {
				r = 0,
				g = 100,
				b = 200,
				a = 0
			},
			DrawDistance = 100,
			Size = {x = 2.0, y = 2.0, z = 2.0},
			SizeMark = 2.0
		},
		Items = {
			{
				Text = "เพชรหยาบ",
				Text_TH = "เพชรหยาบ",
				Unit = "อัน",
				ItemName = "rough_diamond",
				Text_NotHave = "คุณไม่มี <strong class='red-text'>เพชรหยาบ.</strong>",
				Text_NotHave_Desc = "ต้องใช้ <strong class='red-text'>เพชรหยาบ 1 อัน.</strong>",
				OnceProcessing = false,
				ItemCount = 1,
				Get = {
					ItemName = "diamond",
					ItemCount = 1,
					Text = "เพชร",
					Unit = "อัน"
				}
			}
		}
	},
	MeltZone = {
		Text = {
			Title = "Melt",
			SubTitle = "Melt",
			TextHelper = 'Press ~INPUT_CONTEXT~ to ~y~Melt.',
			ProcessText = 'Wait for ~y~Melt...',
		},
		Animation = {
			Scenario = true,
			AnimationDirect = nil,
			AnimationScene = "WORLD_HUMAN_HANG_OUT_STREET",
		},
		PoliceCount = 0,
		MultileItems = true,
		WaitProcessing = 10000,
		Blips = {
			Id = 318,
			Color = 28,
			Size = 0.6,
			Text = "Melt"
		},
		Marker = {
			Type = 25,
			Pos = {
				x = 1108.67,   
				y = -2007.46,  
				z = 29.9,
			},
			Color = {
				r = 0,
				g = 100,
				b = 200,
				a = 0
			},
			DrawDistance = 100,
			Size = {x = 2.0, y = 2.0, z = 2.0},
			SizeMark = 2.0
		},
		Items = {
			{
				Text = "นักเก็ตทองแดง",
				Text_TH = "นักเก็ตทองแดง",
				Unit = "อัน",
				ItemName = "copper_nugget",
				Text_NotHave = "คุณไม่มี <strong class='red-text'>นักเก็ตทองแดง.</strong>",
				Text_NotHave_Desc = "ต้องใช้ <strong class='red-text'>นักเก็ตทองแดง 2 อัน.</strong>",
				OnceProcessing = true,
				ItemCount = 2,
				Get = {
					ItemName = "copper_bar",
					ItemCount = 1,
					Text = "Copper Bar",
					Unit = "อัน"
				}
			},
			{
				Text = "ก้อนทองคำ",
				Text_TH = "ก้อนทองคำ",
				Unit = "อัน",
				ItemName = "gold_nugget",
				Text_NotHave = "คุณไม่มี <strong class='red-text'>ก้อนทองคำ.</strong>",
				Text_NotHave_Desc = "ต้องใช้ <strong class='red-text'>ก้อนทองคำ 2 อัน.</strong>",
				OnceProcessing = true,
				ItemCount = 2,
				Get = {
					ItemName = "gold_bar",
					ItemCount = 1,
					Text = "Gold Bar",
					Unit = "อัน"
				}
			},
			{
				Text = "Metal Scrap",
				Text_TH = "Metal Scrap",
				Unit = "อัน",
				ItemName = "metal_scrap",
				Text_NotHave = "คุณไม่มี <strong class='red-text'>Metal Scrap.</strong>",
				Text_NotHave_Desc = "ต้องใช้ <strong class='red-text'>Metal Scrap 2 อัน.</strong>",
				OnceProcessing = true,
				ItemCount = 2,
				Get = {
					ItemName = "steel_bar",
					ItemCount = 1,
					Text = "Steel Bar",
					Unit = "อัน"
				}
			},
		}
	},
	LeatherBeltProcessing = {
		Text = {
			Title = "Gucci Belt",
			SubTitle = "Gucci Belt",
			TextHelper = 'Press ~INPUT_CONTEXT~ to processing ~y~Gucci Belt.',
			ProcessText = 'Wait for proccessing ~y~Gucci Belt...',
		},
		Animation = {
			Scenario = true,
			AnimationDirect = nil,
			AnimationScene = "WORLD_HUMAN_CLIPBOARD",
		},
		PoliceCount = 0,
		MultileItems = false,
		WaitProcessing = 10000,
		Blips = {
			Id = 366,
			Color = 27,
			Size = 0.6,
			Text = "Leather Process"
		},
		Marker = {
			Type = 25,
			Pos = {
				x = 716.33,   
				y = -962.21,  
				z = 29.4,
			},
			Color = {
				r = 0,
				g = 0,
				b = 200,
				a = 100
			},
			DrawDistance = 100,
			Size = {x = 2.0, y = 2.0, z = 2.0},
			SizeMark = 2.0
		},
		Items = {
			{
				Text = "หนังวัว",
				Text_TH = "หนังวัว",
				Unit = "อัน",
				ItemName = "leather",
				Text_NotHave = "คุณไม่มี <strong class='red-text'>หนังวัว.</strong>",
				Text_NotHave_Desc = "ต้องใช้ <strong class='red-text'>หนังวัว 1 อัน.</strong>",
				OnceProcessing = false,
				ItemCount = 5,
				Get = {
					ItemName = "bikersuit",
					ItemCount = 1,
					Text = "Gucci Belt เข็มขัดหนัง",
					Unit = "อัน"
				}
			}
		}
	},
	LeatherProcessing = {
		Text = {
			Title = "Wagyu A5 Process",
			SubTitle = "Wagyu A5 Process",
			TextHelper = 'Press ~INPUT_CONTEXT~ to processing ~y~Wagyu A5 Process.',
			ProcessText = 'Wait for proccessing ~y~Wagyu A5 Process...',
		},
		Animation = {
			Scenario = true,
			AnimationDirect = nil,
			AnimationScene = "PROP_HUMAN_BBQ",
		},
		PoliceCount = 0,
		MultileItems = false,
		WaitProcessing = 10000,
		Blips = {
			Id = 366,
			Color = 27,
			Size = 0.6,
			Text = "Wagyu A5 Process"
		},
		Marker = {
			Type = 25,
			Pos = {
				x = -101.97,   
				y = 6208.82,  
				z = 30.04,
			},
			Color = {
				r = 200,
				g = 100,
				b = 0,
				a = 100
			},
			DrawDistance = 100,
			Size = {x = 2.0, y = 2.0, z = 2.0},
			SizeMark = 2.0
		},
		Items = {
			{
				Text = "เนื้อวากิว A5",
				Text_TH = "เนื้อวากิว A5",
				Unit = "ชิ้น",
				ItemName = "meat",
				Text_NotHave = "คุณไม่มี <strong class='red-text'>เนื้อ.</strong>",
				Text_NotHave_Desc = "ต้องใช้ <strong class='red-text'>เนื้อ 1 อัน.</strong>",
				OnceProcessing = false,
				ItemCount = 2,
				Get = {
					ItemName = "meatfood",
					ItemCount = 1,
					Text = "สเต็กเซอร์ลอยน์ A5",
					Unit = "จาน"
				}
			}
		}
	},
	WoodProcessing = {
		Text = {
			Title = "Tree Sap",
			SubTitle = "Tree Sap",
			TextHelper = 'Press ~INPUT_CONTEXT~ to processing ~y~Tree Sap.',
			ProcessText = 'Wait for proccessing ~y~Tree Sap...',
		},
		Animation = {
			Scenario = false,
			AnimationDirect = "mini@repair",
			AnimationScene = "fixing_a_ped",
		},
		PoliceCount = 0,
		MultileItems = false,
		WaitProcessing = 10000,
		Blips = {
			Id = 238,
			Color = 81,
			Size = 0.6,
			Text = "Tree Sap Process"
		},
		Marker = {
			Type = 25,
			Pos = {
				x = 2340.84,   
				y = 3128.355,  
				z = 47.31,
			},
			Color = {
				r = 200,
				g = 100,
				b = 0,
				a = 100
			},
			DrawDistance = 100,
			Size = {x = 1.0, y = 1.0, z = 1.0},
			SizeMark = 2.0
		},
		Items = {
			{
				Text = "ยางไม้",
				Text_TH = "ยางไม้",
				Unit = "อัน",
				ItemName = "wood",
				Text_NotHave = "คุณไม่มี <strong class='red-text'>ยางไม้.</strong>",
				Text_NotHave_Desc = "ต้องใช้ <strong class='red-text'>ยางไม้ 1 อัน.</strong>",
				OnceProcessing = false,
				ItemCount = 5,
				Get = {
					ItemName = "pro_wood",
					ItemCount = 1,
					Text = "ยางรถยนต์",
					Unit = "อัน"
				}
			}
		}
	},
	CrabProcessing = {
		Text = {
			Title = "Crab",
			SubTitle = "Crab",
			TextHelper = 'Press ~INPUT_CONTEXT~ to processing ~o~Crab.',
			ProcessText = 'Wait for proccessing ~o~Crab...',
		},
		Animation = {
			Scenario = false,
			AnimationDirect = "mini@repair",
			AnimationScene = "fixing_a_ped",
		},
		PoliceCount = 0,
		MultileItems = false,
		WaitProcessing = 10000,
		Blips = {
			Id = 181,
			Color = 64,
			Size = 0.6,
			Text = "Crab Process"
		},
		Marker = {
			Type = 25,
			Pos = {
				x = -796.71,   
				y = 185.58,  
				z = 71.61,
			},
			Color = {
				r = 200,
				g = 100,
				b = 0,
				a = 100
			},
			DrawDistance = 100,
			Size = {x = 1.0, y = 1.0, z = 1.0},
			SizeMark = 2.0
		},
		Items = {
			{
				Text = "ปูม้า",
				Text_TH = "ปูม้า",
				Unit = "อัน",
				ItemName = "sand",
				Text_NotHave = "คุณไม่มี <strong class='red-text'>ปูม้า.</strong>",
				Text_NotHave_Desc = "ต้องใช้ <strong class='red-text'>ปูม้า 1 อัน.</strong>",
				OnceProcessing = false,
				ItemCount = 3,
				Get = {
					ItemName = "glass",
					ItemCount = 1,
					Text = "ปูไข่ดอง",
					Unit = "จาน"
				}
			}
		}
	},
	CookingProcessing = {
		Text = {
			Title = "ทำแป้งข้าวโพด",
			SubTitle = "ทำแป้งข้าวโพด",
			TextHelper = 'Press ~INPUT_CONTEXT~ to processing ~y~Food ingredients.',
			ProcessText = 'Wait for proccessing...',
		},
		Animation = {
			Scenario = true,
			AnimationDirect = nil,
			AnimationScene = "WORLD_HUMAN_HANG_OUT_STREET",
		},
		PoliceCount = 0,
		MultileItems = true,
		WaitProcessing = 10000,
		Blips = {
			Id = 469,
			Color = 2,
			Size = 0.8,
			Text = "Cooking Processing"
		},
		Marker = {
			Type = 25,
			Pos = {
				x = 2016.68,   
				y = 4987.35,  
				z = 41.1,
			},
			Color = {
				r = 10,
				g = 100,
				b = 0,
				a = 100
			},
			DrawDistance = 100,
			Size = {x = 1.0, y = 1.0, z = 1.0},
			SizeMark = 2.0
		},
		Items = {
			{
				Text = "ข้าวโพด",
				Text_TH = "ข้าวโพด",
				Unit = "อัน",
				ItemName = "cook_corn",
				Text_NotHave = "คุณไม่มี <strong class='red-text'>ข้าวโพด.</strong>",
				Text_NotHave_Desc = "ต้องใช้ <strong class='red-text'>ข้าวโพด 1 อัน.</strong>",
				OnceProcessing = true,
				ItemCount = 5,
				Get = {
					ItemName = "cook_cornflour",
					ItemCount = 1,
					Text = "แป้งข้าวโพด",
					Unit = "กล่อง"
				}
			},
			{
				Text = "ต้นข้าว",
				Text_TH = "ต้นข้าว",
				Unit = "ต้น",
				ItemName = "cook_ride_plant",
				Text_NotHave = "คุณไม่มี <strong class='red-text'>ต้นข้าว.</strong>",
				Text_NotHave_Desc = "ต้องใช้ <strong class='red-text'>ต้นข้าว 1 อัน.</strong>",
				OnceProcessing = true,
				ItemCount = 2,
				Get = {
					ItemName = "cook_ride_plant_process",
					ItemCount = 1,
					Text = "ข้าว",
					Unit = "กก"
				}
			}
		}
	},
	GrassProcessing = {
		Text = {
			Title = "ทำกาแฟ",
			SubTitle = "ทำกาแฟ",
			TextHelper = 'Press ~INPUT_CONTEXT~ to start ~g~Process Grass~s~.',
			ProcessText = 'Wait Processing ~g~Grass~s~...',
		},
		Animation = {
			Scenario = true,
			AnimationDirect = nil,
			AnimationScene = "WORLD_HUMAN_HANG_OUT_STREET",
		},
		PoliceCount = 0,
		MultileItems = false,
		WaitProcessing = 10000,
		Blips = {
			Id = 89,
			Color = 1,
			Size = 0.8,
			Text = "Coffee Processing"
		},
		Marker = {
			Type = 25,
			Pos = {
				x = -1842.84,
				y = 2151.82,  
				z = 117.22,
			},
			Color = {
				r = 10,
				g = 100,
				b = 0,
				a = 0
			},
			DrawDistance = 100,
			Size = {x = 1.0, y = 1.0, z = 1.0},
			SizeMark = 2.0
		},
		Items = {
			{
				Text = "ขี้วัว",
				Text_TH = "ขี้วัว",
				Unit = "อัน",
				ItemName = "grass",
				Text_NotHave = "คุณไม่มี <strong class='red-text'>ขี้วัว.</strong>",
				Text_NotHave_Desc = "ต้องใช้ <strong class='red-text'>ขี้วัว 50 อัน.</strong>",
				OnceProcessing = false,
				ItemCount = 50,
				Get = {
					ItemName = "grass_pack",
					ItemCount = 50,
					Text = "กาแฟขี้วัว",
					Unit = "อัน"
				}
			}
		}
	},
}