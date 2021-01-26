-- CREATE BY THANAWUT PROMRAUNGDET

Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118, ["Enter"] = 191
}

local Stones = 0
local StoneLists = {}
local IsPickingUp, IsProcessing, IsOpenMenu = false, false, false

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(5000)
end)

function GenerateCoords(Zone) -- Thank for ESX-Org
	while true do
		Citizen.Wait(1)

		local CoordX, CoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-20, 20)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-20, 20)

		CoordX = Zone.x + modX
		CoordY = Zone.y + modY

		local coordZ = GetCoordZ(CoordX, CoordY)
		local coord = vector3(CoordX, CoordY, coordZ)

		if ValidateObjectCoord(coord) then
			return coord
		end
	end
end

function GenerateCrabCoords() -- Thank for ESX-Org
	while true do
		Citizen.Wait(1)

		local crabCoordX, crabCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-20, 20)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-20, 20)

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
	local groundCheckHeights = { 30.0, 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0, 49.0, 50.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 43.0
end

function ValidateObjectCoord(plantCoord)
	if Stones > 0 then
		local validate = true

		for k, v in pairs(StoneLists) do
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
	while Stones < 25 do
		Citizen.Wait(0)
		local CrabCoords = GenerateCrabCoords()

		local ListStone = {
			{ Name = "prop_rock_1_i" },
			{ Name = "prop_rock_1_h" }
		}

		local random_stone = math.random(#ListStone)

		ESX.Game.SpawnLocalObject(ListStone[random_stone].Name, CrabCoords, function(object)
			PlaceObjectOnGroundProperly(object)
			FreezeEntityPosition(object, true)

			table.insert(StoneLists, object)
			Stones = Stones + 1
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

	AddTextEntry('BLIP_MINING', Config1.Blips.Text)
	BeginTextCommandSetBlipName("BLIP_MINING")
	EndTextCommandSetBlipName(blip1)

end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID

		for i=1, #StoneLists, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(StoneLists[i]), false) < 1 then
				nearbyObject, nearbyID = StoneLists[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not IsPickingUp then
				ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to ~b~Mining.~s~")
			end

			if IsControlJustReleased(0, Keys['E']) and not IsPickingUp then
				ESX.TriggerServerCallback("meeta_mining:checkItem", function(result, itemfull)
					if result == true then 

						if itemfull then
							TriggerEvent("pNotify:SendNotification", {
								text = '<strong class="red-text">หินคุณเต็ม</strong>',
								type = "error",
								timeout = 3000,
								layout = "bottomCenter",
								queue = "global"
							})
						else
							
							IsPickingUp = true

							TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_CONST_DRILL', 0, false)
							FreezeEntityPosition(playerPed, true)
							Citizen.Wait(8000)
							
							TriggerServerEvent('meeta_mining:pickedUp')
							
							local drill = GetClosestObjectOfType(coords, 30.0, GetHashKey("prop_tool_jackham"), false, false, false)
							ClearPedTasks(playerPed)
							SetEntityAsMissionEntity(drill, true, true)
							DeleteEntity(drill)

							ESX.Game.DeleteObject(nearbyObject)
							FreezeEntityPosition(playerPed, false)
							ClearPedTasks(playerPed)
			
							table.remove(StoneLists, nearbyID)
							Stones = Stones - 1

							IsPickingUp = false
						end
					else
						TriggerEvent("pNotify:SendNotification", {
							text = '<strong class="red-text">คุณไม่มีใบอนุญาติ</strong>',
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
		for k, v in pairs(StoneLists) do
			ESX.Game.DeleteObject(v)
		end
	end
end)