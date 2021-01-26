local spawnedgrapes = 0
local grapess = {}
local isPickingUp, isProcessing = false, false


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(7000)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.CircleZones.grapeField.coords, true) < 20 then
			Spawngrapees()
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

		for i=1, #grapess, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(grapess[i]), false) < 1 then
				nearbyObject, nearbyID = grapess[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp then
				ESX.ShowHelpNotification(_U('weed_pickupprompt'))
			end

			if IsControlJustReleased(0, Keys['E']) and not isPickingUp then
				isPickingUp = true

				ESX.TriggerServerCallback('fm_grape:canPickUp', function(canPickUp)

					if canPickUp then
					exports['progressBars']:startUI(Time_MS, "Text Display")
						TaskStartScenarioInPlace(playerPed, 'world_human_const_drill', 0, false)

						Citizen.Wait(3500)
						ClearPedTasks(playerPed)
						Citizen.Wait(1000)
		
						ESX.Game.DeleteObject(nearbyObject)
		
						table.remove(grapess, nearbyID)
						spawnedgrapes = spawnedgrapes - 1
		
						TriggerServerEvent('fm_grape:pickedUpCannabis')
					else
						ESX.ShowNotification(_U('weed_inventoryfull'))
					end

					isPickingUp = false

				end, 'grape_a')
			end

		else
			Citizen.Wait(500)
		end

	end

end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(grapess) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function Spawngrapees()
	while spawnedgrapes < 20 do
		Citizen.Wait(0)
		local grapeCoords = GenerategrapeCoords()

		ESX.Game.SpawnLocalObject('prop_bush_med_03', grapeCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(grapess, obj)
			spawnedgrapes = spawnedgrapes + 1
		end)
	end
end

function ValidategrapeCoord(plantCoord)
	if spawnedgrapes > 0 then
		local validate = true

		for k, v in pairs(grapess) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 10 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.grapeField.coords, false) > 20 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerategrapeCoords()
	while true do
		Citizen.Wait(200)

		local grapeCoordX, grapeCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-30, 30)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-25, 25)

		grapeCoordX = Config.CircleZones.grapeField.coords.x + modX
		grapeCoordY = Config.CircleZones.grapeField.coords.y + modY

		local coordZ = GetCoordZ(grapeCoordX, grapeCoordY)
		local coord = vector3(grapeCoordX, grapeCoordY, coordZ)

		if ValidategrapeCoord(coord) then
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