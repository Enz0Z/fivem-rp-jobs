local spawnedShits = 0
local Shitss = {}
local isPickingUp, isProcessing = false, false


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(7000)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.CircleZones.ShitField.coords, true) < 20 then
			SpawnShites()
			Citizen.Wait(7000)
		else
			Citizen.Wait(7000)
		end
	end
end)



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID

		for i=1, #Shitss, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(Shitss[i]), false) < 1 then
				nearbyObject, nearbyID = Shitss[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp then
				ESX.ShowHelpNotification(_U('weed_pickupprompt'))
			end

			if IsControlJustReleased(0, Keys['E']) and not isPickingUp then
				isPickingUp = true

				ESX.TriggerServerCallback('fm_Shit:canPickUp', function(canPickUp)

					if canPickUp then
					exports['progressBars']:startUI(Time_MS, "Text Display")
						TaskStartScenarioInPlace(playerPed, 'world_human_const_drill', 0, false)

						Citizen.Wait(3500)
						ClearPedTasks(playerPed)
						Citizen.Wait(1000)
		
						ESX.Game.DeleteObject(nearbyObject)
		
						table.remove(Shitss, nearbyID)
						spawnedShits = spawnedShits - 1
		
						TriggerServerEvent('fm_Shit:pickedUpCannabis')
					else
						ESX.ShowNotification(_U('weed_inventoryfull'))
					end

					isPickingUp = false

				end, 'Shit_a')
			end

		else
			Citizen.Wait(500)
		end

	end

end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(Shitss) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function SpawnShites()
	while spawnedShits < 20 do
		Citizen.Wait(0)
		local ShitCoords = GenerateShitCoords()

		ESX.Game.SpawnLocalObject('prop_bush_med_03', ShitCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(Shitss, obj)
			spawnedShits = spawnedShits + 1
		end)
	end
end

function ValidateShitCoord(plantCoord)
	if spawnedShits > 0 then
		local validate = true

		for k, v in pairs(Shitss) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 10 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.ShitField.coords, false) > 20 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateShitCoords()
	while true do
		Citizen.Wait(200)

		local ShitCoordX, ShitCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-30, 30)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-25, 25)

		ShitCoordX = Config.CircleZones.ShitField.coords.x + modX
		ShitCoordY = Config.CircleZones.ShitField.coords.y + modY

		local coordZ = GetCoordZ(ShitCoordX, ShitCoordY)
		local coord = vector3(ShitCoordX, ShitCoordY, coordZ)

		if ValidateShitCoord(coord) then
			return coord
		end
	end
end

function GetCoordZ(x, y)
	local groundCheckHeights = { 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0, 49.0, 50.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 43.0
end