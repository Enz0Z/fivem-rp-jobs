local spawnedMushrooms = 0
local mushroomss = {}
local isPickingUp, isProcessing = false, false


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.CircleZones.MushroomField.coords, true) < 25 then
			spawnedMushroomms()
			Citizen.Wait(500)
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
		local nearbyObject, nearbyID

		for i=1, #mushroomss, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(mushroomss[i]), false) < 1 then
				nearbyObject, nearbyID = mushroomss[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp then
				ESX.ShowHelpNotification(_U('weed_pickupprompt'))
			end

			if IsControlJustReleased(0, Keys['E']) and not isPickingUp then
				isPickingUp = true

				ESX.TriggerServerCallback('esx_mushroom:canPickUp', function(canPickUp)

					if canPickUp then
						TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)
                        	 TriggerEvent("mythic_progbar:client:progress", {
						 
							name = "unique_action_name",
							duration = 3500,
							label = "งมเห็ด....",
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
						Citizen.Wait(2000)
						ClearPedTasks(playerPed)
						Citizen.Wait(1500)
		
						ESX.Game.DeleteObject(nearbyObject)
		
						table.remove(mushroomss, nearbyID)
						spawnedMushrooms = spawnedMushrooms - 1
		
						TriggerServerEvent('esx_mushroom:pickedUpCannabis')
					else
						ESX.ShowNotification(_U('weed_inventoryfull'))
					end

					isPickingUp = false

				end, 'mushroom_d')
			end

		else
			Citizen.Wait(500)
		end

	end

end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(mushroomss) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function spawnedMushroomms()
	while spawnedMushrooms < 25 do
		Citizen.Wait(0)
		local mushroomCoords = GenerateMushroomCoords()

		ESX.Game.SpawnLocalObject('prop_stoneshroom1', mushroomCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(mushroomss, obj)
			spawnedMushrooms = spawnedMushrooms + 1
		end)
	end
end

function ValidateMushroomCoord(plantCoord)
	if spawnedMushrooms > 0 then
		local validate = true

		for k, v in pairs(mushroomss) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.MushroomField.coords, false) > 25 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateMushroomCoords()
	while true do
		Citizen.Wait(1)

		local mushroomCoordX, mushroomCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-50, 50)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-90, 90)

		mushroomCoordX = Config.CircleZones.MushroomField.coords.x + modX
		mushroomCoordY = Config.CircleZones.MushroomField.coords.y + modY

		local coordZ = GetCoordZ(mushroomCoordX, mushroomCoordY)
		local coord = vector3(mushroomCoordX, mushroomCoordY, coordZ)

		if ValidateMushroomCoord(coord) then
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