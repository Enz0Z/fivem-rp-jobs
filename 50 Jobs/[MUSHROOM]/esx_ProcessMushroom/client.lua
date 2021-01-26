ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)



--[[function CreateBlipCircle(coords, text, radius, color, sprite)
	local blip 

	SetBlipHighDetail(blip, true)
	SetBlipColour(blip, 1)
	SetBlipAlpha (blip, 128)

	blip = AddBlipForCoord(coords)

	SetBlipHighDetail(blip, true)
	SetBlipSprite (blip, sprite)
	SetBlipScale  (blip, 1.0)
	SetBlipColour (blip, color)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(text)
	EndTextCommandSetBlipName(blip)
end]]

Citizen.CreateThread(function()
	for k,zone in pairs(config.zones) do
		CreateBlipCircle(zone.coords, zone.name, zone.radius, zone.color, zone.sprite)
	end
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		
		local px,py,pz = table.unpack(config.zones.process.coords)
		if GetDistanceBetweenCoords(coords, config.zones.process.coords, true) < 10 then
				DrawMarker(2, px, py, pz, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 240,230,140, 165, 1,0, 0,1)	
		end
		
	end
end)