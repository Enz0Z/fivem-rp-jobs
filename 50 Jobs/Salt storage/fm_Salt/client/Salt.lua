local spawnedSalts = 0
local Saltss = {}
local isPickingUp, isProcessing = false, false


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(7000)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.CircleZones.SaltField.coords, true) < 20 then
			SpawnSaltes()
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

		for i=1, #Saltss, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(Saltss[i]), false) < 1 then
				nearbyObject, nearbyID = Saltss[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp then
				ESX.ShowHelpNotification(_U('weed_pickupprompt'))
			end

			if IsControlJustReleased(0, Keys['E']) and not isPickingUp then
				isPickingUp = true

				ESX.TriggerServerCallback('fm_Salt:canPickUp', function(canPickUp)

					if canPickUp then
					exports['progressBars']:startUI(Time_MS, "Text Display")
						TaskStartScenarioInPlace(playerPed, 'world_human_const_drill', 0, false)

						Citizen.Wait(3500)
						ClearPedTasks(playerPed)
						Citizen.Wait(1000)
		
						ESX.Game.DeleteObject(nearbyObject)
		
						table.remove(Saltss, nearbyID)
						spawnedSalts = spawnedSalts - 1
		
						TriggerServerEvent('fm_Salt:pickedUpCannabis')
					else
						ESX.ShowNotification(_U('weed_inventoryfull'))
					end

					isPickingUp = false

				end, 'Salt_a')
			end

		else
			Citizen.Wait(500)
		end

	end

end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(Saltss) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function SpawnSaltes()
	while spawnedSalts < 20 do
		Citizen.Wait(0)
		local SaltCoords = GenerateSaltCoords()

		ESX.Game.SpawnLocalObject('bkr_prop_bkr_cashpile_05', SaltCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(Saltss, obj)
			spawnedSalts = spawnedSalts + 1
		end)
	end
end

function ValidateSaltCoord(plantCoord)
	if spawnedSalts > 0 then
		local validate = true

		for k, v in pairs(Saltss) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 10 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.SaltField.coords, false) > 20 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateSaltCoords()
	while true do
		Citizen.Wait(200)

		local SaltCoordX, SaltCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-30, 30)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-25, 25)

		SaltCoordX = Config.CircleZones.SaltField.coords.x + modX
		SaltCoordY = Config.CircleZones.SaltField.coords.y + modY

		local coordZ = GetCoordZ(SaltCoordX, SaltCoordY)
		local coord = vector3(SaltCoordX, SaltCoordY, coordZ)

		if ValidateSaltCoord(coord) then
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