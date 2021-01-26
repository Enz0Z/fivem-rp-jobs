local spawnedCabbages = 0
local cabbages = {}
local isPickingUp, isProcessing = false, false


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.CircleZones.CabbageField.coords, true) < 50 then
			SpawnedCabbagees()
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

		for i=1, #cabbages, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(cabbages[i]), false) < 1 then
				nearbyObject, nearbyID = cabbages[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp then
				ESX.ShowHelpNotification(_U('weed_pickupprompt'))
			end

			if IsControlJustReleased(0, Keys['E']) and not isPickingUp then
				isPickingUp = true

				ESX.TriggerServerCallback('esx_cabbage:canPickUp', function(canPickUp)

					if canPickUp then
	TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)
    TriggerEvent("mythic_progbar:client:progress", {
        name = "unique_action_name",
        duration = 2500,
        label = "กำลังโซ้ย..",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        prop = {
            model = "prop_paper_bag_small",
        }
    }, function(status)
        if not status then
            -- Do Something If Event Wasn't Cancelled
        end
    end)
						Citizen.Wait(2500)
						ClearPedTasks(playerPed)
						Citizen.Wait(0)
		
						ESX.Game.DeleteObject(nearbyObject)
		
						table.remove(cabbages, nearbyID)
						spawnedCabbages = spawnedCabbages - 1
		
						TriggerServerEvent('esx_cabbage:pickedUpCannabis')
					else
						ESX.ShowNotification(_U('weed_inventoryfull'))
					end

					isPickingUp = false

				end, 'acabbage')
			end

		else
			Citizen.Wait(500)
		end

	end

end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(cabbages) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function SpawnedCabbagees()
	while spawnedCabbages < 25 do
		Citizen.Wait(0)
		local cabbageCoords = GenerateCabbageCoords()

		ESX.Game.SpawnLocalObject('prop_veg_crop_03_cab', cabbageCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(cabbages, obj)
			spawnedCabbages = spawnedCabbages + 1
		end)
	end
end

function ValidateCabbageCoord(plantCoord)
	if spawnedCabbages > 0 then
		local validate = true

		for k, v in pairs(cabbages) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.CabbageField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateCabbageCoords()
	while true do
		Citizen.Wait(1)

		local cabbageCoordX, cabbageCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-19, 22)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-23, 23)

		cabbageCoordX = Config.CircleZones.CabbageField.coords.x + modX
		cabbageCoordY = Config.CircleZones.CabbageField.coords.y + modY

		local coordZ = GetCoordZ(cabbageCoordX, cabbageCoordY)
		local coord = vector3(cabbageCoordX, cabbageCoordY, coordZ)

		if ValidateCabbageCoord(coord) then
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