ESX = nil

local IsSpawnGrill = false
local IsObjectGrill
local IsObjectGrillName = "prop_bbq_5"
local IsCooking = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('meeta_cooking:menuGrill')
AddEventHandler('meeta_cooking:menuGrill', function()
	TriggerEvent('esx_inventoryhud:closeHud')

	local playerPed = PlayerPedId()

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'meeta_shop_actions',
	{
		title    = 'My Shop',
		align    = 'top-left',
		elements = {
			{ label = "เตาย่าง", value = 'grill' },
			{ label = "เกาอี้", value = 'chair' },
			{ label = "โต๊ะ", value = 'table' },
			{ label = "ต้นไม้", value = 'tree' },
			{ label = "ร่ม", value = 'umb' },
			{ label = "รั้ว", value = 'fence' },
			{ label = "ตู้น้ำ", value = 'vend' },
			{ label = "อื่นๆ", value = 'other' },
			{ label = "<strong class='red-text'>เก็บอุปกรณ์</strong>", value = 'remove' }
		}
	}, function(data, menu)

		local value = data.current.value

		if value == "grill" then
			TriggerEvent("meeta_cooking:spawnGrill")
		elseif value == "chair" then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'meeta_shop_actions_sub',
			{
				title    = 'เก้าอี้',
				align    = 'top-left',
				elements = Config.Menu.Chair
			}, function(data1, menu1)

				local value1 = data1.current.value

				TriggerEvent("meeta_cooking:spawnObject", value1, nil)

			end, function(data1, menu1)
				menu1.close()
			end)
		elseif value == "table" then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'meeta_shop_actions_sub',
			{
				title    = 'ร่ม',
				align    = 'top-left',
				elements = Config.Menu.Table
			}, function(data1, menu1)

				local value1 = data1.current.value

				TriggerEvent("meeta_cooking:spawnObject", value1, nil)

			end, function(data1, menu1)
				menu1.close()
			end)
		elseif value == "other" then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'meeta_shop_actions_sub',
			{
				title    = 'อื่นๆ',
				align    = 'top-left',
				elements = Config.Menu.Other
			}, function(data1, menu1)

				local value1 = data1.current.value

				TriggerEvent("meeta_cooking:spawnObject", value1, nil)

			end, function(data1, menu1)
				menu1.close()
			end)
		elseif value == "remove" then
			TriggerEvent("meeta_cooking:removeObject")
		elseif value == "tree" then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'meeta_shop_actions_sub',
			{
				title    = 'ต้นไม้',
				align    = 'top-left',
				elements = Config.Menu.Tree
			}, function(data1, menu1)

				local value1 = data1.current.value

				TriggerEvent("meeta_cooking:spawnObject", value1, nil)

			end, function(data1, menu1)
				menu1.close()
			end)
		elseif value == "umb" then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'meeta_shop_actions_sub',
			{
				title    = 'ร่ม',
				align    = 'top-left',
				elements = Config.Menu.Umbe
			}, function(data1, menu1)

				local value1 = data1.current.value

				TriggerEvent("meeta_cooking:spawnObject", value1, nil)

			end, function(data1, menu1)
				menu1.close()
			end)
		elseif value == "vend" then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'meeta_shop_actions_sub',
			{
				title    = 'ตู้น้ำ',
				align    = 'top-left',
				elements = Config.Menu.Vend
			}, function(data1, menu1)

				local value1 = data1.current.value

				TriggerEvent("meeta_cooking:spawnObject", value1, nil)

			end, function(data1, menu1)
				menu1.close()
			end)
		elseif value == "fence" then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'meeta_shop_actions_sub',
			{
				title    = 'รั้ว',
				align    = 'top-left',
				elements = Config.Menu.Fence
			}, function(data1, menu1)

				local value1 = data1.current.value

				TriggerEvent("meeta_cooking:spawnObject", value1, nil)

			end, function(data1, menu1)
				menu1.close()
			end)
		else
			TriggerEvent("meeta_cooking:spawnObject", value, nil)
		end

	end, function(data, menu)
		menu.close()
	end)
end)

RegisterNetEvent('meeta_cooking:removeObject')
AddEventHandler('meeta_cooking:removeObject', function()
	local ListProp = {}
	for k,v in pairs(Config.Menu) do
		table.insert(ListProp, v.value)
	end
	local obj, dist = ESX.Game.GetClosestObject(ListProp)
	if dist < 2.0 then
		DeleteEntity(obj)
	end
end)

RegisterNetEvent('meeta_cooking:spawnObject')
AddEventHandler('meeta_cooking:spawnObject', function(object, type)

	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	-- Delete Before

	local x, y, z   = table.unpack(GetEntityCoords(playerPed))
	local xF = GetEntityForwardX(playerPed) * 1.0
	local yF = GetEntityForwardY(playerPed) * 1.0

	ESX.Game.SpawnObject(object, {
		x = x + xF,
		y = y + yF,
		z = z
	}, function(obj)

		SetEntityHeading(obj, GetEntityHeading(playerPed))
		FreezeEntityPosition(obj, true)
		PlaceObjectOnGroundProperly(obj)

		local ObjectPreview = obj

		local elements_preview = {
			{
				label     = "หมุน",
				name 	= "heading",
				value     = GetEntityHeading(ObjectPreview),
				min       = -360,
				max       = 360,
				type      = 'slider',
				decimal = 10.0
			},
			{
				label     = "ความสูง",
				name 	= "z",
				value     = GetEntityCoords(ObjectPreview).z,
				min       = -999,
				max       = 10000,
				type      = 'slider',
				decimal = 0.05
			},
			{
				label     = "X",
				name 	= "x",
				value     = GetEntityCoords(ObjectPreview).x,
				min       = -99999999,
				max       = 10000000,
				type      = 'slider',
				decimal = 0.02
			},
			{
				label     = "Y",
				name 	= "y",
				value     = GetEntityCoords(ObjectPreview).y,
				min       = -99999999,
				max       = 10000000,
				type      = 'slider',
				decimal = 0.02
			}
		}

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'meeta_shop_actions_sub_preview',
		{
			title    = 'ปรับแต่ง',
			align    = 'top-left',
			elements = elements_preview
		}, function(data2, menu2) -- OnEnter
			
		end, function(data2, menu2)
			SetEntityCollision(ObjectPreview, true, false)
			menu2.close()
		end, function(data2, menu2)
			if data2.current.name == "heading" then
				SetEntityHeading(ObjectPreview, data2.current.value)
			elseif data2.current.name == "z" then
				local xx, yy, zz   = table.unpack(GetEntityCoords(ObjectPreview))
				SetEntityCoords(ObjectPreview, xx, yy, data2.current.value)
			elseif data2.current.name == "x" then
				local xx, yy, zz   = table.unpack(GetEntityCoords(ObjectPreview))
				SetEntityCoords(ObjectPreview, data2.current.value, yy, zz)
			elseif data2.current.name == "y" then
				local xx, yy, zz   = table.unpack(GetEntityCoords(ObjectPreview))
				SetEntityCoords(ObjectPreview, xx, data2.current.value, zz)
			end
		end)

	end)
	

end)

RegisterNetEvent('meeta_cooking:spawnGrill')
AddEventHandler('meeta_cooking:spawnGrill', function()

	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	if IsSpawnGrill then
		local obj, dist = ESX.Game.GetClosestObject({'prop_bbq_5', 'prop_table_para_comb_02', 'prop_table_03_chr'})
		if dist < 3.0 then
			DeleteEntity(obj)
		end
		IsSpawnGrill = false
		IsObjectGrill = nil
	else

		local obj, dist = ESX.Game.GetClosestObject({'prop_bbq_5', 'prop_table_para_comb_02', 'prop_table_03_chr'})
		if dist < 3.0 then
			DeleteEntity(obj)
		end
		IsSpawnGrill = false
		IsObjectGrill = nil
		
		local x, y, z   = table.unpack(GetEntityCoords(playerPed))
		local xF = GetEntityForwardX(playerPed) * 1.0
		local yF = GetEntityForwardY(playerPed) * 1.0

		ESX.Game.SpawnObject(IsObjectGrillName, {
			x = x + xF,
			y = y + yF,
			z = z
		}, function(obj)
			IsObjectGrill = obj
			if IsObjectGrillName == 'prop_table_03_chr' then
				SetEntityHeading(obj, -GetEntityHeading(playerPed))
			else
				SetEntityHeading(obj, GetEntityHeading(playerPed))
			end
			PlaceObjectOnGroundProperly(obj)
			IsSpawnGrill = true
		end)
	end
end)

RegisterNetEvent('meeta_cooking:spawnObjectOnGrill')
AddEventHandler('meeta_cooking:spawnObjectOnGrill', function(object)
	if IsObjectGrill then
		IsCooking = true
		local coords  = GetEntityCoords(IsObjectGrill)
		local x, y, z = table.unpack(coords)

		ESX.Game.SpawnObject(object, {
			x = x,
			y = y,
			z = z + 0.93
		}, function(steak)

		end)
	end
end)

RegisterNetEvent('meeta_cooking:cookingClean')
AddEventHandler('meeta_cooking:cookingClean', function(object)
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
    local objectcooking = GetClosestObjectOfType(coords, 30.0, GetHashKey(object), false, false, false)
    ClearPedTasks(playerPed)
    SetEntityAsMissionEntity(objectcooking, true, true)
	DeleteEntity(objectcooking)
	IsCooking = false
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsSpawnGrill then
			local obj, dist = ESX.Game.GetClosestObject({'prop_bbq_5'})
			if dist < 1.5 then
				if not IsCooking then
					ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to ~y~Cooking")
					if IsControlJustPressed(0, Config.Key['E']) then
						TriggerEvent('meeta_advanced_craft:openCooking')
					end
				end
			end
		end
	end
end)