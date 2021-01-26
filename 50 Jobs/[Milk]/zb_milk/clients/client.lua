ESX = nil
local menuOpen = false
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	RequestModel(GetHashKey(Config.animalname))
	RequestAnimDict(Config.animalDirectory1)
	RequestAnimDict(Config.animalDirectory2)
	RequestAnimDict(Config.animalDirectory3)
end)

function OpenShop()
	ESX.UI.Menu.CloseAll()
	local elements = {}
	menuOpen = true

	for k, v in pairs(ESX.GetPlayerData().inventory) do
		local price = Config.items[v.name]

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

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'milk_shop', {
		title    = _U('Title'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		
		exports['mythic_progbar']:Progress({
		name = 'chicken_action',
		duration = Config.WaitTimePickup,
		label = _U('Processcoming'),
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
		},
		animation = {
				animDict = Config.animalDirectory3,
				anim = 'put_down_case',
				--flags = 49,
				},
		prop = {
			model = 'prop_apple_box_02',
			bone = 57005,
			coords = { x = 0.11, y = 0.0145, z =  0.02 },
			rotation = { x = 240.0, y = 150.0, z = 90.0 },
			}
		},  function(status)
			TriggerServerEvent('crossbite_milk:sell', data.current.name, data.current.value)
		end)
	end, function(data, menu)
		menu.close()
		menuOpen = false
	end)
end

Citizen.CreateThread(function()	
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local ped = GetPlayerPed(-1)
		local coords = GetEntityCoords(playerPed)
		if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
			
			if GetDistanceBetweenCoords(coords, Config.zones.dealer.coords, true) < 2 then
					
				ESX.ShowHelpNotification(_U('Sell'))
					
				if IsControlJustReleased(0, 38) then
								OpenShop()	
				end
			end
		end
	end
end)
--[[function CreateBlipCircle(coords, text, radius, color, sprite)
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

Citizen.CreateThread(function()
	for k,zone in pairs(Config.zones) do
		CreateBlipCircle(zone.coords, zone.name, zone.radius, zone.color, zone.sprite)
	end
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		
		local px,py,pz = table.unpack(Config.zones.process.coords)
		if GetDistanceBetweenCoords(coords, Config.zones.process.coords, true) < 10 then
			DrawMarker(Config.MarkerType, px, py, pz, 0, 0, 0, 0, 0, 0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 165, 0,0, 0,0)	
		end
		local pxZ,pyZ,pzZ = table.unpack(Config.zones.milk.coords)
		if GetDistanceBetweenCoords(coords, Config.zones.milk.coords, true) < 10 then
			DrawMarker(Config.MarkerType, pxZ, pyZ, pzZ, 0, 0, 0, 0, 0, 0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 165, 0,0, 0,0)	
		end
		local p2x,p2y,p2z = table.unpack(Config.zones.dealer.coords)
		if GetDistanceBetweenCoords(coords, Config.zones.dealer.coords, true) < 10 then
			DrawMarker(Config.MarkerType, p2x, p2y, p2z, 0, 0, 0, 0, 0, 0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 165, 0,0, 0,0)	
		end
	end
end)]]--