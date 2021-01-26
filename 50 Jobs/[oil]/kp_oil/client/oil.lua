local spawnedOils = 0
local oilss = {}
local isPickingUp, isProcessing = false, false


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.CircleZones.OilField.coords, true) < 30 then
			SpawnOills()
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

		for i=1, #oilss, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(oilss[i]), false) < 1 then
				nearbyObject, nearbyID = oilss[i], i
			end
		end

		if nearbyObject  then

			if not isPickingUp then
				ESX.ShowHelpNotification(_U('weed_pickupprompt'))
			end

			if IsControlJustReleased(0, Keys['E']) and not isPickingUp then
				isPickingUp = true
				
				
				ESX.TriggerServerCallback('kp_oil:canPickUp', function(canPickUp)

					if canPickUp then
						TaskStartScenarioInPlace(playerPed, 'world_human_const_drill', 0, false)
						
						
						 TriggerEvent("mythic_progbar:client:progress", {
						 
							name = "unique_action_name",
							duration = 15000,
							label = "กำลังขุดเจาะน้ำมันดิบ....",
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
						--						
						Citizen.Wait(14500)
						ClearPedTasks(playerPed)
						Citizen.Wait(500)
		
						ESX.Game.DeleteObject(nearbyObject)
		
						table.remove(oilss, nearbyID)
						spawnedOils = spawnedOils - 1
		
						TriggerServerEvent('kp_oil:pickedUpCannabis')
					else
						ESX.ShowNotification(_U('weed_inventoryfull'))
					end

					isPickingUp = false

				end, 'oil_a')
			
			
						
		end
		
		else
			Citizen.Wait(500)
		end

	end

end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(oilss) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function SpawnOills()
	while spawnedOils < 15 do
		Citizen.Wait(0)
		local oilCoords = GenerateOilCoords()

		ESX.Game.SpawnLocalObject('prop_mp_icon_shad_sm', oilCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(oilss, obj)
			spawnedOils = spawnedOils + 1
		end)
	end
end

function ValidateOilCoord(plantCoord)
	if spawnedOils > 0 then
		local validate = true

		for k, v in pairs(oilss) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 20 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.OilField.coords, false) > 30 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateOilCoords()
	while true do
		Citizen.Wait(1)

		local oilCoordX, oilCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-70, 70)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-70, 70)

		oilCoordX = Config.CircleZones.OilField.coords.x + modX
		oilCoordY = Config.CircleZones.OilField.coords.y + modY

		local coordZ = GetCoordZ(oilCoordX, oilCoordY)
		local coord = vector3(oilCoordX, oilCoordY, coordZ)

		if ValidateOilCoord(coord) then
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