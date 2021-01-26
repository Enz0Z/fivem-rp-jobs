local spawnedProps = 0
local Props = {}
local isPickingUp, isProcessing = false, false
local OnGoingHuntSession = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.zones.hunter.coords, true) < 50 then
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

		if GetDistanceBetweenCoords(coords, Config.zones.process.coords, true) < 1 then
			if not isProcessing then
				ESX.ShowHelpNotification(_U('Package'))
			end

			if IsControlJustReleased(0, 38) and not isProcessing then
					Process()
			end
		elseif GetDistanceBetweenCoords(coords, Config.zones.callgun.coords, true) < 1 then
			if not OnGoingHuntSession then
				ESX.ShowHelpNotification(_U('Start'))
			elseif OnGoingHuntSession then
				ESX.ShowHelpNotification(_U('Stop'))
			end

			if IsControlJustReleased(0, 38) and not OnGoingHuntSession then
					--StartHunt()
					TriggerServerEvent('crossbite_hunter:checkstarthunt')
			elseif IsControlJustReleased(0, 38) and OnGoingHuntSession then
					StopHunt()
			end
		else
			Citizen.Wait(500)
		end
	end
end)

function Process()
	isProcessing = true
	TriggerEvent('mythic_notify:client:SendAlert', { type = 'success', text = _U('Processcoming') })
	TriggerServerEvent('crossbite_hunter:process')
	local timeLeft = Config.WaitProcess
	local playerPed = PlayerPedId()
	local ped = GetPlayerPed(-1)

	while timeLeft > 0 do
		FreezeEntityPosition(ped, true)
		Citizen.Wait(1000)
		timeLeft = timeLeft - 1
		if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.zones.process.coords, false) > 4 then
			TriggerServerEvent('crossbite_hunter:cancelProcessing')
			break
		end
	end
	FreezeEntityPosition(ped, false)
	isProcessing = false
end
function StopHunt()
		OnGoingHuntSession = false
		RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_MUSKET"), true, true)
		for k, v in pairs(Props) do
			if DoesEntityExist(v) then
				DeleteEntity(v)
				spawnedProps = spawnedProps - 1
			end
		end
		TriggerServerEvent('crossbite_hunter:stophunt')
end

RegisterNetEvent('crossbite_hunter:starthunt')
AddEventHandler('crossbite_hunter:starthunt', function()

		OnGoingHuntSession = true
		
		SetEntityInvincible(PlayerPedId(),true) -- GOD
		
		GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_MUSKET"),45, true, false)
		
		--Animals
		Citizen.CreateThread(function()
			while OnGoingHuntSession do
				--SpawnProps()
				Citizen.Wait(0)
				local playerPed = PlayerPedId()
				local coords = GetEntityCoords(playerPed)
				local nearbyObject, nearbyID , AnimalCoords
				
				

				for i=1, #Props, 1 do
					if GetDistanceBetweenCoords(coords, GetEntityCoords(Props[i]), false) < 3 then
						nearbyObject, nearbyID , AnimalCoords  = Props[i], i , GetEntityCoords(Props[i])
					end
					if GetDistanceBetweenCoords(coords, GetEntityCoords(Props[i]), true) > 80 then
						FreezeEntityPosition(Props[i], true)
					end
				end
					
				local AnimalHealth = GetEntityHealth(nearbyObject)
				
				if nearbyObject and IsPedOnFoot(playerPed) and AnimalHealth <= 0  then
					
						if not isPickingUp then
							ESX.ShowHelpNotification(_U('SlatDeer'))
						end
						ESX.Game.Utils.DrawText3D({x = AnimalCoords.x, y = AnimalCoords.y, z = AnimalCoords.z + 1}, '[E] Slaughter Animal', 0.4)
						if IsControlJustReleased(0, 38) and not isPickingUp then
								isPickingUp = true
							ESX.TriggerServerCallback('crossbite_hunter:canPickUp', function(canPickUp)
												
												if canPickUp then
													while not HasAnimDictLoaded(Config.animalDirectory1) and not HasAnimDictLoaded(Config.animalDirectory2) do
														Citizen.Wait(0)
													end
													TaskPlayAnim(PlayerPedId(), Config.animalDirectory2 ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
													
													exports['mythic_progbar']:Progress({
													name = 'hunter_action',
													duration = Config.WaitTimePickup,
													label = _U('hunter_doing'),
													useWhileDead = false,
													canCancel = true,
													controlDisables = {
														disableMovement = true,
														disableCarMovement = true,
														disableMouse = false,
														disableCombat = true,
													},
													animation = {
														animDict = Config.animalDirectory1,
														anim = 'base',
														--flags = 49,
													},
													prop = {
														model = 'prop_cs_bowie_knife',
														bone = 60309,
														coords = { x = 0.0, y = 0.1, z = 0.5 },
														rotation = { x = 364.0, y = 180.0, z = 90.0 },
													}
													},  function(status)
															TriggerServerEvent('crossbite_hunter:pickedUp')
													end)

													Citizen.Wait(8000)
													ClearPedTasks(playerPed)
													Citizen.Wait(1)
													DeleteEntity(nearbyObject)
													ClearPedTasksImmediately(PlayerPedId())
									
													table.remove(Props, nearbyID)
													spawnedProps = spawnedProps - 1
									
												end

												isPickingUp = false
											
										end, 'leather')
									
								
									
						end
				else
					Citizen.Wait(500)
				end
			end
		end)
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		
		if OnGoingHuntSession then
			RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_MUSKET"), true, true)
		end
		for k, v in pairs(Props) do
			DeleteEntity(v)
		end
	end
end)

function SpawnProps()
	while spawnedProps < Config.Props  do
		Citizen.Wait(0)
		local Coords = GeneratePropCoords()
		
		local Animal = CreatePed(5, GetHashKey(Config.animalname), Coords.x, Coords.y, Coords.z, 0.0, true, false)
		TaskWanderStandard(Animal, true, true)
		SetEntityAsMissionEntity(Animal, true, true)
		
		spawnedProps = spawnedProps + 1
		--FreezeEntityPosition(Animal, true)
		table.insert(Props, Animal)
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

		if GetDistanceBetweenCoords(Coord, Config.zones.hunter.coords, false) > 60 then
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
		local modX = math.random(-50, 60)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-50, 60)

		CoordX = Config.zones.hunter.coords.x + modX
		CoordY = Config.zones.hunter.coords.y + modY

		local coordZ = GetCoordZ(CoordX, CoordY)
		local coord = vector3(CoordX, CoordY, coordZ)

		if ValidateCoord(coord) then
			return coord
		end
	end
end

function GetCoordZ(x, y)
	local groundCheckHeights = { 80.0, 81.0, 82.0, 83.0, 84.0, 85.0, 86.0, 87.0, 88.0, 89.0, 90.0 }
	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 84.0
end