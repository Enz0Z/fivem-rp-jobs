local spawnedcrabs = 0
local crabss = {}
local isPickingUp, isProcessing = false, false


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(7000)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.CircleZones.crabField.coords, true) < 20 then
			Spawncrabes()
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

		for i=1, #crabss, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(crabss[i]), false) < 1 then
				nearbyObject, nearbyID = crabss[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp then
				ESX.ShowHelpNotification(_U('weed_pickupprompt'))
			end

			if IsControlJustReleased(0, Keys['E']) and not isPickingUp then
				isPickingUp = true

				ESX.TriggerServerCallback('fm_crab:canPickUp', function(canPickUp)

					if canPickUp then
						TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)

						Citizen.Wait(3500)
						ClearPedTasks(playerPed)
						Citizen.Wait(1000)
		
						ESX.Game.DeleteObject(nearbyObject)
		
						table.remove(crabss, nearbyID)
						spawnedcrabs = spawnedcrabs - 1
		
						TriggerServerEvent('fm_crab:pickedUpCannabis')
					else
						ESX.ShowNotification(_U('weed_inventoryfull'))
					end

					isPickingUp = false

				end, 'crab_a')
			end

		else
			Citizen.Wait(500)
		end

	end

end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(crabss) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function Spawncrabes()
	while spawnedcrabs < 20 do
		Citizen.Wait(0)
		local sandCoords = GeneratecrabCoords()

		ESX.Game.SpawnLocalObject('prop_beach_sandcas_03', sandCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(crabss, obj)
			spawnedcrabs = spawnedcrabs + 1
		end)
	end
end

function ValidateSandCoord(plantCoord)
	if spawnedcrabs > 0 then
		local validate = true

		for k, v in pairs(crabss) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 10 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.crabField.coords, false) > 20 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GeneratecrabCoords()
	while true do
		Citizen.Wait(200)

		local crabCoordX, crabCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-30, 30)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-25, 25)

		crabCoordX = Config.CircleZones.crabField.coords.x + modX
		crabCoordY = Config.CircleZones.crabField.coords.y + modY

		local coordZ = GetCoordZ(crabCoordX, crabCoordY)
		local coord = vector3(crabCoordX, crabCoordY, coordZ)

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