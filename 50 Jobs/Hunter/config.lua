Config = {}

Config.items = {
	cloth = 500,
}
Config.zones = {
	hunter = { coords = vector3(1275.804, 1804.727, 83.995), name = 'Hunter', color = 1, sprite = 141 },
	callgun = { coords = vector3(1219.58, 1847.984, 78.964), name = 'Hunter Gun Rented', color = 1, sprite = 433 },
	process = { coords = vector3(732.977, 2523.192, 73.224), name = 'Leather Process', color = 1, sprite = 175 },
	--dealer = { coords = vector3(911.059, 3644.1, 32.677), name = 'Cloth Dealer', color = 1, sprite = 108 }
}

Config.animalname = 'a_c_deer'
Config.animalDirectory1 = 'amb@medic@standing@kneel@base'
Config.animalDirectory2 = 'anim@gangops@facility@servers@bodysearch@'

Config.Locale                       = 'th'

--[[ Random ตอนเชือด หากไม่ต้องการให้ใส่ 1 1]]--
Config.MinRandom = 1 
Config.MaxRandom = 1

Config.Price = 10000

--[[ Wait time เวลารอต่างๆ ]]--
Config.WaitTimePickup = 5000 -- 5 วิ                                                                                                                                                                       
Config.WaitProcess = 5 -- 10 วิ

-- [[ ในที่นี้ น้ำมัน 2 แลก ได้ 1 น้ำมันสำเร็จรูป]]--
Config.Packgrage = 1 -- แลกได้เท่าไหร่ --บรรจุพร้อมขาย
Config.Normal = 2 -- ใช้หนังเท่าไหร่

-- [[ Props ]]--
Config.Props = 8 --จำนวน พ็อบ

-- [[ Marker ]] --
Config.DrawDistance               = 100.0
Config.MarkerColor                = { r = 25, g = 165, b = 165 }
Config.MarkerSize                 = { x = 0.5, y = 0.5, z = 0.5 }
Config.MarkerType 				  = 2

