local spawnedbuckets = 0
local bucketss = {}
local isPickingUp, isProcessing = false, false


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(7000)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.CircleZones.bucketField.coords, true) < 20 then
			Spawnbucketes()
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

		for i=1, #bucketss, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(bucketss[i]), false) < 1 then
				nearbyObject, nearbyID = bucketss[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp then
				ESX.ShowHelpNotification(_U('weed_pickupprompt'))
			end

			if IsControlJustReleased(0, Keys['E']) and not isPickingUp then
				isPickingUp = true

				ESX.TriggerServerCallback('fm_bucket:canPickUp', function(canPickUp)

					if canPickUp then
						TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, false)

						Citizen.Wait(3500)
						ClearPedTasks(playerPed)
						Citizen.Wait(1000)
		
						ESX.Game.DeleteObject(nearbyObject)
		
						table.remove(bucketss, nearbyID)
						spawnedbuckets = spawnedbuckets - 1
		
						TriggerServerEvent('fm_bucket:pickedUpCannabis')
					else
						ESX.ShowNotification(_U('weed_inventoryfull'))
					end

					isPickingUp = false

				end, 'bucket_a')
			end

		else
			Citizen.Wait(500)
		end

	end

end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(bucketss) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function Spawnbucketes()
	while spawnedbuckets < 20 do
		Citizen.Wait(0)
		local sandCoords = GeneratebucketCoords()

		ESX.Game.SpawnLocalObject('bkr_prop_weed_bucket_open_01a', sandCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(bucketss, obj)
			spawnedbuckets = spawnedbuckets + 1
		end)
	end
end

function ValidateSandCoord(plantCoord)
	if spawnedbuckets > 0 then
		local validate = true

		for k, v in pairs(bucketss) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 10 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.bucketField.coords, false) > 20 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GeneratebucketCoords()
	while true do
		Citizen.Wait(200)

		local bucketCoordX, bucketCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-30, 30)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-25, 25)

		bucketCoordX = Config.CircleZones.bucketField.coords.x + modX
		bucketCoordY = Config.CircleZones.bucketField.coords.y + modY

		local coordZ = GetCoordZ(bucketCoordX, bucketCoordY)
		local coord = vector3(bucketCoordX, bucketCoordY, coordZ)

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