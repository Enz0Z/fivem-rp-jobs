local spawnedProps = 0
local Props = {}
local isPickingUp, isProcessing = false, false
local IsRiding = false
local Tractor = false
function Spawn(Pcoords, Pped)	
	ESX.Game.SpawnVehicle(1641462412, Pcoords, 13, function(spawnedVehicle)
		-- save & set plate
		local plate = 'WORK' .. math.random(100, 900)
		SetVehicleNumberPlateText(spawnedVehicle, plate)

		TaskWarpPedIntoVehicle(Pped, spawnedVehicle, -1)
	end)
	--DeleteEntity(HuntBoat)
end
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, config.zones.farm.coords, true) < 50 then
			SpawnProps()
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

		if GetDistanceBetweenCoords(coords, config.zones.process.coords, true) < 1 then
			if not isProcessing then
				ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to ~g~Process")
			end

			if IsControlJustReleased(0, 38) and not isProcessing then
					Process()
			end
		else
			Citizen.Wait(500)
		end
	end
end)

function Process()
	isProcessing = true

	TriggerServerEvent('caruby_farm:process')
	 TriggerEvent("mythic_progbar:client:progress", {
						 
							name = "unique_action_name",
							duration = 3500,
							label = "กำลังแพ๊คข้าว....",
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
	local timeLeft = 3500 / 700
	local playerPed = PlayerPedId()

	while timeLeft > 0 do
		Citizen.Wait(700)
		timeLeft = timeLeft - 1
		if GetDistanceBetweenCoords(GetEntityCoords(playerPed), config.zones.process.coords, false) > 4 then
			TriggerServerEvent('caruby_farm:cancelProcessing')
			break
		end
	end

	isProcessing = false
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID
		local veh = GetVehiclePedIsIn(playerPed)
		for i=1, #Props, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(Props[i]), false) < 3 then
				nearbyObject, nearbyID = Props[i], i
			end
		end

		if nearbyObject then
					if not isPickingUp and GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "TRACTOR" then
						ESX.ShowHelpNotification("Press ~INPUT_THROW_GRENADE~ to ~g~Harvest")
					end

					if IsControlJustReleased(0, 58) and not isPickingUp and GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "TRACTOR" then
						
						ESX.TriggerServerCallback('caruby_farm:haveItem', function(haveItem)
							if haveItem then
								isPickingUp = true
						
									ESX.TriggerServerCallback('caruby_farm:canPickUp', function(canPickUp)
											
											if canPickUp then												
 TriggerEvent("mythic_progbar:client:progress", {
						 
							name = "unique_action_name",
							duration = 2000,
							label = "กำลังทำนา....",
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
												--ClearPedTasks(playerPed)
												Citizen.Wait(1)
								
												ESX.Game.DeleteObject(nearbyObject)
								
												table.remove(Props, nearbyID)
												spawnedProps = spawnedProps - 1
								
												TriggerServerEvent('caruby_farm:pickedUp')
											end

											isPickingUp = false
										
									end, 'rice')
							else
								ESX.ShowNotification("You need to buy Sickle")
							end
						
						end)
					end
				
		else
			Citizen.Wait(500)
		end

	end

end)

Citizen.CreateThread(function()	

	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local ped = GetPlayerPed(-1)
		local coords = GetEntityCoords(playerPed)
		if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
			if GetDistanceBetweenCoords(coords, config.zones.cow.coords, true) < 2 then
					
				ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to ~g~Spawn Tractor")
				if not Tractor then	
					if IsControlJustReleased(0, 38) then
							Tractor = true
							Spawn(coords, ped)
							Wait(20000)
							Tractor = false
					end
				end
			end
		end
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(Props) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function SpawnProps()
	while spawnedProps < 25 do
		Citizen.Wait(0)
		local Coords = GeneratePropCoords()

		ESX.Game.SpawnLocalObject('prop_veg_grass_01_c', Coords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)
			
			table.insert(Props, obj)
			spawnedProps = spawnedProps + 1
		end)
	end
end

function ValidateCoord(Coord)
	if spawnedProps > 0 then
		local validate = true

		for k, v in pairs(Props) do
			if GetDistanceBetweenCoords(Coord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(Coord, config.zones.farm.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GeneratePropCoords()
	while true do
		Citizen.Wait(1)

		local CoordX, CoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-20, 20)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-20, 20)

		CoordX = config.zones.farm.coords.x + modX
		CoordY = config.zones.farm.coords.y + modY

		local coordZ = GetCoordZ(CoordX, CoordY)
		local coord = vector3(CoordX, CoordY, coordZ)

		if ValidateCoord(coord) then
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