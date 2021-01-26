
local Frieds = {}
local isPickingUp, isProcessing = false, false
local IsRiding = false



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, config.zones.process.coords, true) < 1 then
			if not isProcessing then
				ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to ~g~Process ~y~Fried")
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

	TriggerServerEvent('fm_Fried:process')
	local timeLeft = 5000 / 1000
	local playerPed = PlayerPedId()
	
	TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_CLIPBOARD", 0, false)
	Citizen.Wait(5000)
	ClearPedTasks(playerPed)

	while timeLeft > 0 do
		Citizen.Wait(1000)
		timeLeft = timeLeft - 1
		if GetDistanceBetweenCoords(GetEntityCoords(playerPed), config.zones.process.coords, false) > 4 then
			TriggerServerEvent('fm_Fried:cancelProcessing')
			break
		end
	end

	isProcessing = false
end


AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(lays) do
			ESX.Game.DeleteObject(v)
		end
	end
end)


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