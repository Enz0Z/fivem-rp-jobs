local showPro                 = false       -- don't touch
local spawnedshellfish = 0
local Minewood = {}
local isPickingUp, isProcessing = false, false


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.CircleZones.woodField.coords, true) < 50 then
			Spawnwoods()
			Citizen.Wait(0)
		else
			Citizen.Wait(0)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID

		for i=1, #Minewood, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(Minewood[i]), false) < 1 then
				nearbyObject, nearbyID = Minewood[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp then
				ESX.ShowHelpNotification(_U('wood_pickupprompt'))
			end

			if IsControlJustReleased(0, Keys['E']) and not isPickingUp then
				isPickingUp = true

				ESX.TriggerServerCallback('esx_shellfish:canPickUp', function(canPickUp)

					if canPickUp then
						TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_GARDENER_PLANT', 0, false)
	                     TriggerEvent("mythic_progbar:client:progress", {
						 
							name = "unique_action_name",
							duration = 6500,
							label = "กำลังหาหอย....",
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
						procent(50)
					--	Citizen.Wait(2000)
						ClearPedTasks(playerPed)
						
						Citizen.Wait(0)
		
						ESX.Game.DeleteObject(nearbyObject)
		
						table.remove(Minewood, nearbyID)
						spawnedshellfish = spawnedshellfish - 1
		

						TriggerServerEvent('esx_shellfish:pickedUpwoods')
					else
						ESX.ShowNotification(_U('wood_inventoryfull'))
					end

					isPickingUp = false

				end, 'shellfish')
			end

		else
			Citizen.Wait(500)
		end

	end

end)

Citizen.CreateThread(function()
	while true do
    Citizen.Wait(6)
    if showPro == true then
      local playerPed = PlayerPedId()
		  local coords = GetEntityCoords(playerPed)
      DrawText3D(coords.x, coords.y, coords.z, TimeLeft .. '~g~%', 0.4)
    end
	end
end)


function procent(time)
  showPro = true
  TimeLeft = 0
  repeat
  TimeLeft = TimeLeft + 1        -- thank you (github.com/Loffes)
  Citizen.Wait(time)
  until(TimeLeft == 100)
  showPro = false
end



itemFound = false
itemFoundSell = false

RegisterNetEvent('esx_shellfish:CheackingOK')
AddEventHandler('esx_shellfish:CheackingOK', function()
	itemFound = true
end)


RegisterNetEvent('esx_shellfish:CheackingSellOK')
AddEventHandler('esx_shellfish:CheackingSellOK', function(itemValue)
	itemFoundSell = true
	itemValue = 1
end)

RegisterNetEvent('esx_shellfish:CheackingNO')
AddEventHandler('esx_shellfish:CheackingNo', function()
	itemFound = false
end)




Citizen.CreateThread(function()
  while true do
  Citizen.Wait(0)



  local coords = GetEntityCoords(PlayerPedId())
  local distance = Vdist(coords.x, coords.y, coords.z, Config.CircleZones.woodCut.coords.x, Config.CircleZones.woodCut.coords.y, Config.CircleZones.woodCut.coords.z)

  if(Config.Type ~= -1 and GetDistanceBetweenCoords(coords, Config.CircleZones.woodCut.coords.x, Config.CircleZones.woodCut.coords.y, Config.CircleZones.woodCut.coords.z, true) < 4) then



		local playerPed = PlayerPedId()
          DrawMarker(3, Config.CircleZones.woodCut.coords.x, Config.CircleZones.woodCut.coords.y, Config.CircleZones.woodCut.coords.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 15, 15, 15, 255, 255, 255, 100, false, true, 2, false, false, false, false)


          if distance < 2 then
          	StatusReady = true

          	if StatusReady == true  then
            ESX.ShowHelpNotification(_U('Enter'))
            TriggerServerEvent('esx_shellfish:CheackingPack')

            end
            

            if IsControlJustReleased(1,  38) and StatusReady == true  then
            itemFound = false
            TriggerServerEvent('esx_shellfish:CheackingPack')
			            	 TriggerEvent("mythic_progbar:client:progress", {
						 
							name = "unique_action_name",
							duration = 7000,
							label = "กำลังแพ๊คหอย....",
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
             FreezeEntityPosition(playerPed, true)
            Citizen.Wait(500)
             FreezeEntityPosition(playerPed, false)
            if itemFound == true  then
            	itemFound = false 
            	StatusReady = false
            	
            	procent(50)
             	TriggerServerEvent('esx_shellfish:pack')
				
            	ClearPedTasks(playerPed)
            	Citizen.Wait(0)

            	StatusReady = true
            else
            		ESX.ShowNotification(_U('NoItem'))

            end

            	


              
    
            end

            
          end


  end
  end
end)

Citizen.CreateThread(function()
  while true do
  Citizen.Wait(0)



  local coords = GetEntityCoords(PlayerPedId())
  local distance = Vdist(coords.x, coords.y, coords.z, Config.CircleZones.woodSell.coords.x, Config.CircleZones.woodSell.coords.y, Config.CircleZones.woodSell.coords.z)

  if(Config.Type ~= -1 and GetDistanceBetweenCoords(coords, Config.CircleZones.woodSell.coords.x, Config.CircleZones.woodSell.coords.y, Config.CircleZones.woodSell.coords.z, true) < 4) then



		local playerPed = PlayerPedId()
          DrawMarker(3, Config.CircleZones.woodSell.coords.x, Config.CircleZones.woodSell.coords.y, Config.CircleZones.woodSell.coords.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 15, 15, 15, 255, 255, 255, 100, false, true, 2, false, false, false, false)


          if distance < 2 then
          	StatusReady = true

          	if StatusReady == true then
            ESX.ShowHelpNotification(_U('EnterSell'))

            end
            

            if IsControlJustReleased(1,  38) and StatusReady == true  then
            itemFoundSell = false
            TriggerServerEvent('esx_shellfish:SellCheak')
			            TriggerServerEvent('esx_shellfish:CheackingPack')
						 TriggerEvent("mythic_progbar:client:progress", {
						 
							name = "unique_action_name",
							duration = 17000,
							label = "กำลังขายหอย....",
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
             FreezeEntityPosition(playerPed, true)
            Citizen.Wait(500)
             FreezeEntityPosition(playerPed, false)
            if itemFoundSell == true  then
            	itemFoundSell = false 
            	StatusReady = false
            	TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, false)
            	procent(150)
				
             	TriggerServerEvent('esx_shellfish:Sellpack')
				
            	ClearPedTasks(playerPed)
            	
            	Citizen.Wait(300)

            	StatusReady = true
            else
            		ESX.ShowNotification(_U('NoItem'))

            end

            	


              
    
            end

            
          end


  end
  end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(Minewood) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function Spawnwoods()
	while spawnedshellfish < 70 do
		Citizen.Wait(0)
		local woodCoords = GeneratewoodCoords()

		ESX.Game.SpawnLocalObject('prop_rock_5_d', woodCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(Minewood, obj)
			spawnedshellfish = spawnedshellfish + 1
		end)
	end
end

function ValidatewoodCoord(plantCoord)
	if spawnedshellfish > 0 then
		local validate = true

		for k, v in pairs(Minewood) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.woodField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GeneratewoodCoords()
	while true do
		Citizen.Wait(1)

		local woodCoordX, woodCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-30, 30)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-60, 60)

		woodCoordX = Config.CircleZones.woodField.coords.x + modX
		woodCoordY= Config.CircleZones.woodField.coords.y + modY

		local coordZ = GetCoordZ(woodCoordX, woodCoordY)
		local coord = vector3(woodCoordX, woodCoordY, coordZ)

		if ValidatewoodCoord(coord) then
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




