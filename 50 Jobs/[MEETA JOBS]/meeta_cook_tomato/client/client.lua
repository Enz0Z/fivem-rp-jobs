-- CREATE BY THANAWUT PROMRAUNGDET

local Objects = 0
local ObjectLists = {}
local IsPickingUp, IsProcessing, IsOpenMenu = false, false, false

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(5000)
end)

function GenerateObjectCoords() -- Thank for ESX-Org
	while true do
		Citizen.Wait(1)

		local crabCoordX, crabCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-10, 10)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-10, 10)

		crabCoordX = Config.Zone.Pos.x + modX
		crabCoordY = Config.Zone.Pos.y + modY

		local coordZ = GetCoordZ(crabCoordX, crabCoordY)
		local coord = vector3(crabCoordX, crabCoordY, coordZ)

		if ValidateObjectCoord(coord) then
			return coord
		end
	end
end

function GetCoordZ(x, y)
	local groundCheckHeights = { 1.0, 10.0, 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0, 49.0, 50.0, 100.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 43.0
end

function ValidateObjectCoord(plantCoord)
	if Objects > 0 then
		local validate = true

		for k, v in pairs(ObjectLists) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.Zone.Pos.x, Config.Zone.Pos.y, Config.Zone.Pos.z, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function SpawnObjects()
	while Objects < 10 do
		Citizen.Wait(0)
		local ObjectCoords = GenerateObjectCoords()

		local ListObject = Config.ListProp

		local random_stone = math.random(#ListObject)

		ESX.Game.SpawnLocalObject(ListObject[random_stone].Name, ObjectCoords, function(object)
			PlaceObjectOnGroundProperly(object)
			FreezeEntityPosition(object, true)

			table.insert(ObjectLists, object)
			Objects = Objects + 1
		end)
	end
end

-- Spawn Object
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local PlayerCoords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(PlayerCoords, Config.Zone.Pos.x, Config.Zone.Pos.y, Config.Zone.Pos.z, true) < 50 then
			SpawnObjects()
			Citizen.Wait(500)
		else
			Citizen.Wait(500)
		end
	end
end)

-- Create Blips
Citizen.CreateThread(function()

	local Config1 = Config.Zone
	local blip1 = AddBlipForCoord(Config1.Pos.x, Config1.Pos.y, Config1.Pos.z)

	SetBlipSprite (blip1, Config1.Blips.Id)
	SetBlipDisplay(blip1, 4)
	SetBlipScale  (blip1, Config1.Blips.Size)
	SetBlipColour (blip1, Config1.Blips.Color)
	SetBlipAsShortRange(blip1, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(Config1.Blips.Text)
	EndTextCommandSetBlipName(blip1)

end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID

		for i=1, #ObjectLists, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(ObjectLists[i]), false) < 1 then
				nearbyObject, nearbyID = ObjectLists[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not IsPickingUp then
				ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to pick ~o~Tomato.~s~")
			end

			if IsControlJustReleased(0, Config.Key['E']) and not IsPickingUp then
				ESX.TriggerServerCallback("meeta_cook_tomato:checkItem", function(result, itemfull)
					if result == true then 

						if itemfull then
							TriggerEvent("pNotify:SendNotification", {
								text = '<strong class="red-text">'..Config.ItemNameText..'คุณเต็ม</strong>',
								type = "error",
								timeout = 3000,
								layout = "bottomCenter",
								queue = "global"
							})
						else
							
							IsPickingUp = true

							if Config.Animation.Scenario then
								TaskStartScenarioInPlace(playerPed, Config.Animation.AnimationScene, 0, false)
							else
								ESX.Streaming.RequestAnimDict(Config.Animation.AnimationDirect, function()
									TaskPlayAnim(GetPlayerPed(-1), Config.Animation.AnimationDirect, Config.Animation.AnimationScene, 8.0, -8, -1, 49, 0, 0, 0, 0)
								end)
							end

							FreezeEntityPosition(playerPed, true)
							Citizen.Wait(5000)
							ESX.Game.DeleteObject(nearbyObject)
							FreezeEntityPosition(playerPed, false)
							ClearPedTasks(playerPed)
			
							table.remove(ObjectLists, nearbyID)
							Objects = Objects - 1
			
							TriggerServerEvent('meeta_cook_tomato:pickedUp')

							IsPickingUp = false
						end
					else
						TriggerEvent("pNotify:SendNotification", {
							text = '<strong class="red-text">คุณไม่มีพลั่วขุดทราย</strong>',
							type = "error",
							timeout = 3000,
							layout = "bottomCenter",
							queue = "global"
						})
					end
				end, Config.ItemWork, Config.ItemName)
			end

		else
			Citizen.Wait(500)
		end

	end

end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(ObjectLists) do
			ESX.Game.DeleteObject(v)
		end
	end
end)