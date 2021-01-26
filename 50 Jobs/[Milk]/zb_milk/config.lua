Config = {}

Config.items = {
	milk_package = 400,
}

Config.AnimalPositions = {
	{ x = 2397.62, y = 4778.671, z = 34.613 },
	{ x = 2398.593, y = 4779.362, z = 34.642 },
	{ x = 2400.163, y = 4780.771, z = 34.7 },
}

Config.zones = {
	milk = { coords = vector3(2398.905, 4778.282, 34.58), name = 'Milk Cow', color = 64, sprite = 537 },
	process = { coords = vector3(287.478, 2843.713, 44.704), name = 'Milk Process', color = 64, sprite = 478 },
	--dealer = { coords = vector3(-132.278, -939.393, 29.292), name = 'Milk Dealer', color = 64, sprite = 108 },
}

Config.animalname = 'a_c_cow'
Config.animalDirectory1 = 'amb@medic@standing@kneel@base'
Config.animalDirectory2 = 'anim@gangops@facility@servers@bodysearch@'
Config.animalDirectory3 = 'anim@heists@money_grab@briefcase'


Config.Locale                       = 'th'

--[[ Random ตอนเชือด หากไม่ต้องการให้ใส่ 1 1]]--
Config.MinRandom = 5 
Config.MaxRandom = 10

--[[ Wait time เวลารอต่างๆ ]]--
Config.WaitTimePickup = 5000 -- 5 วิ                                                                                                                                                                       
Config.WaitProcess = 3 -- 10 วิ

-- [[ ในที่นี้ น้ำมัน 2 แลก ได้ 1 น้ำมันสำเร็จรูป]]--
Config.Packgrage = 1 -- แลกได้เท่าไหร่ --บรรจุพร้อมขาย
Config.Normal = 3 -- ใช้ทั่วไปเท่าไหร่

-- [[ Props ]]--
Config.Props = 3 --จำนวน พ็อบ

-- [[ Marker ]] --
Config.DrawDistance               = 100.0
Config.MarkerColor                = { r = 25, g = 165, b = 165 }
Config.MarkerSize                 = { x = 0.5, y = 0.5, z = 0.5 }
Config.MarkerType 				  = 2

