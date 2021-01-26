ESX = nil
local Props = {}
local cutting = false
local cankeep = false
local spawn = true
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function Cut(Id, Object, Pped, treeCoords)
	cutting = true

	FreezeEntityPosition(Pped, true)
	local x,y,z = table.unpack(GetEntityCoords(Pped))
	local prop = CreateObject(GetHashKey("prop_w_me_hatchet"), x, y, z + 0.2, true, true, true)
	local boneIndex = GetPedBoneIndex(Pped, 57005)
	AttachEntityToEntity(prop, Pped, boneIndex, 0.11, 0.0145, 0.02, 240, 150, 15.0, true, true, true, true, 1, true)
									--
						 TriggerEvent("mythic_progbar:client:progress", {
						 
							name = "unique_action_name",
							duration = 6000,
							label = "กำลังตัดต้นไม้",
							useWhileDead = false,
							canCancel = true,
							controlDisables = {
								disableMovement = true,
								disableCarMovement = true,
								disableMouse = false,
								disableCombat = true,
								},
								
							}, function(status)
								if not status then
									-- Do Something If Event Wasn't Cancelled
								end
						end)
						--
	TaskPlayAnim(Pped, "melee@hatchet@streamed_core", "plyr_rear_takedown_b", 3.0, 3.0, -1, 50, 0, false, false, false)
	Wait(3000)
	TaskPlayAnim(Pped, "melee@hatchet@streamed_core", "plyr_rear_takedown_b", 3.0, 3.0, -1, 50, 0, false, false, false)
	Wait(3000)
									--
						 TriggerEvent("mythic_progbar:client:progress", {
						 
							name = "unique_action_name",
							duration = 3000,
							label = "กำลังเก็บไม้",
							useWhileDead = false,
							canCancel = true,
							controlDisables = {
								disableMovement = true,
								disableCarMovement = true,
								disableMouse = false,
								disableCombat = true,
								},
								
							}, function(status)
								if not status then
									-- Do Something If Event Wasn't Cancelled
								end
						end)
						--
	TaskPlayAnim(Pped, "melee@hatchet@streamed_core", "plyr_rear_takedown_b", 3.0, 3.0, -1, 50, 0, false, false, false)
	Wait(3000)
	ClearPedTasks(Pped)
	DeleteObject(prop)

	ESX.Game.DeleteObject(Object)
	table.remove(Props, Id)
	
	SpawnFallTree(Pped, treeCoords)
	
end

function SpawnTree()
	for k,zone in pairs(config.spawn) do
		ESX.Game.SpawnLocalObject('prop_tree_fallen_pine_01', zone.coords, function(obj)
			--PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)
			
			table.insert(Props, obj)
		end)
	end
end
function SpawnNewTree(treeCoords)
	Citizen.Wait(3000)
	
	ESX.Game.SpawnLocalObject('prop_tree_fallen_pine_01', treeCoords, function(obj)
		--PlaceObjectOnGroundProperly(obj)
		FreezeEntityPosition(obj, true)
		
		table.insert(Props, obj)
	end)
end
function SpawnFallTree(Pped, treeCoords)
	ESX.Game.SpawnLocalObject('prop_tree_fallen_01', treeCoords, function(obj)
		--PlaceObjectOnGroundProperly(obj)
		FreezeEntityPosition(obj, true)
		
		table.insert(Props, obj)
	end)
	
	cankeep = true
end

function Keep(Id, Object, Pped, treeCoords)
	
	TaskPlayAnim(Pped, "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
	TaskPlayAnim(Pped, "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
	
	Wait(8000)
	TriggerServerEvent('caruby_lumberjack:giveItem')
	FreezeEntityPosition(Pped, false)
	
	cankeep = false
	ESX.Game.DeleteObject(Object)
	table.remove(Props, Id)
	ClearPedTasks(Pped)
	cutting = false

	
end

function LoadModel(model)
    while not HasModelLoaded(model) do
          RequestModel(model)
          Citizen.Wait(10)
    end
end

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end    
end

Citizen.CreateThread(function()	
	
	while true do
		Citizen.Wait(0)
			if spawn then
				SpawnTree()
				Wait(500)
				spawn = false
			end
	end
end)

function CreateBlipCircle(coords, text, radius, color, sprite)
	local blip 

	SetBlipHighDetail(blip, true)
	SetBlipColour(blip, 1)
	SetBlipAlpha (blip, 128)

	blip = AddBlipForCoord(coords)

	SetBlipHighDetail(blip, true)
	SetBlipSprite (blip, sprite)
	SetBlipScale  (blip, 1.0)
	SetBlipColour (blip, color)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(text)
	EndTextCommandSetBlipName(blip)
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(Props) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

Citizen.CreateThread(function()	

	LoadAnimDict('melee@hatchet@streamed_core')
	LoadAnimDict('amb@medic@standing@kneel@base')
	LoadAnimDict('anim@gangops@facility@servers@bodysearch@')
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local ped = GetPlayerPed(-1)
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID
		local treeCoords

		for i=1, #Props, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(Props[i]), false) < 2 then
				nearbyObject, nearbyID = Props[i], i
				treeCoords = GetEntityCoords(Props[i])
			end
		end
		if nearbyObject then
			if not IsPedInAnyVehicle(GetPlayerPed(-1)) and not IsPedSwimming(GetPlayerPed(-1)) then
				ESX.TriggerServerCallback('caruby_lumberjack:canCUT', function(canCUT)
					if canCUT then
						
							if not cutting then
									ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to Cut")
								
									if IsControlJustReleased(0, 38) then
											Cut(nearbyID, nearbyObject ,ped,treeCoords)
									end
							end
					else
						ESX.ShowHelpNotification("You need to buy hatchet")
					end
				end)
			end
		else
			Citizen.Wait(500)
		end
	end
end)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		
		
		if GetDistanceBetweenCoords(coords, config.zones.dealer.coords, true) < 1.5 then

			ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to ~g~Sell")

			if IsControlJustReleased(0, 38) then
					OpenWoodShop()
			end
		else
			Citizen.Wait(500)
		end
	end
end)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		local playerPed = PlayerPedId()
		local ped = GetPlayerPed(-1)
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID
		local treeCoords

		for i=1, #Props, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(Props[i]), false) < 2 then
				nearbyObject, nearbyID = Props[i], i
				treeCoords = GetEntityCoords(Props[i])
			end
		end
		if cankeep then
			ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to Keep")				
			if IsControlJustReleased(0, 38) then					
				Keep(nearbyID, nearbyObject ,ped,treeCoords)						
				SpawnNewTree(treeCoords)
			end
		end
	end
end)

function OpenWoodShop()
	ESX.UI.Menu.CloseAll()
	local elements = {}
	menuOpen = true

	for k, v in pairs(ESX.GetPlayerData().inventory) do
		local price = config.items[v.name]

		if price and v.count > 0 then
			table.insert(elements, {
				label = ('%s - <span style="color:green;">$%s</span>'):format(v.label, ESX.Math.GroupDigits(price)),
				name = v.name,
				price = price,

				type = 'slider',
				value = 1,
				min = 1,
				max = v.count
			})
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'wood_shop', {
		title    = 'Wood Dealer',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		TriggerServerEvent('caruby_lumberjack:sell', data.current.name, data.current.value)
	end, function(data, menu)
		menu.close()
		menuOpen = false
	end)
end

local isProcessing = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		
		
		if GetDistanceBetweenCoords(coords, config.zones.process.coords, true) < 1 then
			if not isProcessing then
				ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to ~g~Wood Process")
			end

			if IsControlJustReleased(0, 38) and not isProcessing then
					Process(playerPed)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

function Process(player)
	isProcessing = true
	
	TriggerServerEvent('caruby_lumberjack:process')
	local timeLeft = 7000 / 1000
	local playerPed = PlayerPedId()

	while timeLeft > 0 do
		Citizen.Wait(1000)
		timeLeft = timeLeft - 1
		if GetDistanceBetweenCoords(GetEntityCoords(playerPed), config.zones.process.coords, false) > 2 then
			TriggerServerEvent('caruby_lumberjack:cancelProcessing')
			break
		end
	end

	isProcessing = false
end

Citizen.CreateThread(function()
	for k,zone in pairs(config.zones) do
		CreateBlipCircle(zone.coords, zone.name, zone.radius, zone.color, zone.sprite)
	end
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		
		for k,zone in pairs(config.zones) do
			local x,y,z = table.unpack(zone.coords)
			if GetDistanceBetweenCoords(coords, zone.coords, true) < 10 then
				if not fishing then
					DrawMarker(2, x, y, z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 288, 153, 0, 165, 1,0, 0,1)	
				end
			end
		end
		for k,zone in pairs(config.spawn) do
			local x,y,z = table.unpack(zone.coords)
			if GetDistanceBetweenCoords(coords, zone.coords, true) < 10 then
				if not fishing then
					DrawMarker(27, x, y, z+2, 0, 0, 0, 0, 0, 0, 2.5, 2.5, 2.5, 288, 153, 0, 165, 1,0, 0,1)	
				end
			end
		end
	end
end)