local spawnedCiments = 0
local Cimentss = {}
local isPickingUp, isProcessing = false, false


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(7000)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.CircleZones.CimentField.coords, true) < 20 then
			SpawnCimentes()
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

		for i=1, #Cimentss, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(Cimentss[i]), false) < 1 then
				nearbyObject, nearbyID = Cimentss[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp then
				ESX.ShowHelpNotification(_U('weed_pickupprompt'))
			end

			if IsControlJustReleased(0, Keys['E']) and not isPickingUp then
				isPickingUp = true

				ESX.TriggerServerCallback('fm_Ciment:canPickUp', function(canPickUp)

					if canPickUp then
						TaskStartScenarioInPlace(playerPed, 'world_human_const_drill', 0, false)
						exports['progressBars']:startUI(Time_MS, "Text Display")

						Example:
						exports['progressBars']:startUI(30000, "กำลังเก็บปูน")
						This will display and progress over 30 seconds / 30000ms and show Repaiing as the text

						Citizen.Wait(3500)
						ClearPedTasks(playerPed)
						Citizen.Wait(1000)
		
						ESX.Game.DeleteObject(nearbyObject)
		
						table.remove(Cimentss, nearbyID)
						spawnedCiments = spawnedCiments - 1
		
						TriggerServerEvent('fm_Ciment:pickedUpCannabis')
					else
						ESX.ShowNotification(_U('weed_inventoryfull'))
					end

					isPickingUp = false

				end, 'Ciment_a')
			end

		else
			Citizen.Wait(500)
		end

	end

end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(Cimentss) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function SpawnCimentes()
	while spawnedCiments < 20 do
		Citizen.Wait(0)
		local CimentCoords = GenerateCimentCoords()

		ESX.Game.SpawnLocalObject('prop_cons_cements01', CimentCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(Cimentss, obj)
			spawnedCiments = spawnedCiments + 1
		end)
	end
end

function ValidateCimentCoord(plantCoord)
	if spawnedCiments > 0 then
		local validate = true

		for k, v in pairs(Cimentss) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 10 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.CimentField.coords, false) > 20 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateCimentCoords()
	while true do
		Citizen.Wait(200)

		local CimentCoordX, CimentCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-30, 30)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-25, 25)

		CimentCoordX = Config.CircleZones.CimentField.coords.x + modX
		CimentCoordY = Config.CircleZones.CimentField.coords.y + modY

		local coordZ = GetCoordZ(CimentCoordX, CimentCoordY)
		local coord = vector3(CimentCoordX, CimentCoordY, coordZ)

		if ValidateCimentCoord(coord) then
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