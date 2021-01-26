local spawnedSands = 0
local sandess = {}
local isPickingUp, isProcessing = false, false


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.CircleZones.SandField.coords, true) < 50 then
			SpawnSandds()
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

		for i=1, #sandess, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(sandess[i]), false) < 1 then
				nearbyObject, nearbyID = sandess[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp then
				ESX.ShowHelpNotification(_U('weed_pickupprompt'))
			end

			if IsControlJustReleased(0, Keys['E']) and not isPickingUp then
				isPickingUp = true

				ESX.TriggerServerCallback('esx_sands:canPickUp', function(canPickUp)

					if canPickUp then
						TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)
 TriggerEvent("mythic_progbar:client:progress", {
						 
							name = "unique_action_name",
							duration = 3500,
							label = "กำลังขุดทราย...",
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
		
						table.remove(sandess, nearbyID)
						spawnedSands = spawnedSands - 1
		
						TriggerServerEvent('esx_sands:pickedUpCannabis')
					else
						ESX.ShowNotification(_U('weed_inventoryfull'))
					end

					isPickingUp = false

				end, 'sands')
			end

		else
			Citizen.Wait(500)
		end

	end

end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(sandess) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function SpawnSandds()
	while spawnedSands < 25 do
		Citizen.Wait(0)
		local sandCoords = GenerateSandCoords()

		ESX.Game.SpawnLocalObject('prop_beach_sandcas_01', sandCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(sandess, obj)
			spawnedSands = spawnedSands + 1
		end)
	end
end

function ValidateSandCoord(plantCoord)
	if spawnedSands > 0 then
		local validate = true

		for k, v in pairs(sandess) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.SandField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateSandCoords()
	while true do
		Citizen.Wait(1)

		local sandCoordX, sandCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-90, 90)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-90, 90)

		sandCoordX = Config.CircleZones.SandField.coords.x + modX
		sandCoordY = Config.CircleZones.SandField.coords.y + modY

		local coordZ = GetCoordZ(sandCoordX, sandCoordY)
		local coord = vector3(sandCoordX, sandCoordY, coordZ)

		if ValidateSandCoord(coord) then
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