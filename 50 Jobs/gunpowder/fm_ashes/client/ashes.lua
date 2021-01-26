local spawnedashess = 0
local ashesss = {}
local isPickingUp, isProcessing = false, false


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(7000)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.CircleZones.ashesField.coords, true) < 20 then
			Spawnasheses()
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

		for i=1, #ashesss, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(ashesss[i]), false) < 1 then
				nearbyObject, nearbyID = ashesss[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp then
				ESX.ShowHelpNotification(_U('weed_pickupprompt'))
			end

			if IsControlJustReleased(0, Keys['E']) and not isPickingUp then
				isPickingUp = true

				ESX.TriggerServerCallback('fm_ashes:canPickUp', function(canPickUp)

					if canPickUp then
						TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, false)

						Citizen.Wait(3500)
						ClearPedTasks(playerPed)
						Citizen.Wait(1000)
		
						ESX.Game.DeleteObject(nearbyObject)
		
						table.remove(ashesss, nearbyID)
						spawnedashess = spawnedashess - 1
		
						TriggerServerEvent('fm_ashes:pickedUpCannabis')
					else
						ESX.ShowNotification(_U('weed_inventoryfull'))
					end

					isPickingUp = false

				end, 'ashes_a')
			end

		else
			Citizen.Wait(500)
		end

	end

end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(ashesss) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function Spawnasheses()
	while spawnedashess < 20 do
		Citizen.Wait(0)
		local sandCoords = GenerateashesCoords()

		ESX.Game.SpawnLocalObject('ex_office_swag_guns04', sandCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(ashesss, obj)
			spawnedashess = spawnedashess + 1
		end)
	end
end

function ValidateSandCoord(plantCoord)
	if spawnedashess > 0 then
		local validate = true

		for k, v in pairs(ashesss) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 10 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.ashesField.coords, false) > 20 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateashesCoords()
	while true do
		Citizen.Wait(200)

		local ashesCoordX, ashesCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-30, 30)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-25, 25)

		ashesCoordX = Config.CircleZones.ashesField.coords.x + modX
		ashesCoordY = Config.CircleZones.ashesField.coords.y + modY

		local coordZ = GetCoordZ(ashesCoordX, ashesCoordY)
		local coord = vector3(ashesCoordX, ashesCoordY, coordZ)

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