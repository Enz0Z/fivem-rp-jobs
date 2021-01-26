
ESX = nil
local playersProcessingStones = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('CanLip-Apple:pickedUpwoods')
AddEventHandler('CanLip-Apple:pickedUpwoods', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('appleun')
	math.randomseed(GetGameTimer())

	if xItem.limit ~= -1 and (xItem.count + 1) > xItem.limit then
		TriggerClientEvent('esx:showNotification', _source, _U('stone_inventoryfull'))
	else

		xPlayer.addInventoryItem(xItem.name, 3)
	end
end)


RegisterServerEvent('CanLip-Apple:pack')
AddEventHandler('CanLip-Apple:pack', function()
	local xPlayer = ESX.GetPlayerFromId(source)


	xPlayer.removeInventoryItem('appleun', 3)
	xPlayer.addInventoryItem('oapple', 3)

end)

RegisterServerEvent('CanLip-Apple:Sellpack')

AddEventHandler('CanLip-Apple:Sellpack', function()
	--[[local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('fresh_shellfish', 1)
	xPlayer.addMoney(Config.Price)--]]

	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('oapple')

	xPlayer.removeInventoryItem('oapple', xItem.count)
	xPlayer.addMoney(Config.Price * xItem.count)

end)

RegisterServerEvent('CanLip-Apple:CheackingPack')
AddEventHandler('CanLip-Apple:CheackingPack', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('appleun')

	if xItem.count > 1 then
	TriggerClientEvent('CanLip-Apple:CheackingOK', source)

	end




end)


RegisterServerEvent('CanLip-Apple:CheackingPack')
AddEventHandler('CanLip-Apple:CheackingPack', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('appleun')

	if xItem.count > 1 then



	TriggerClientEvent('CanLip-Apple:CheackingOK', source)

	end




end)

RegisterServerEvent('CanLip-Apple:SellCheak')
AddEventHandler('CanLip-Apple:SellCheak', function()

	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('oapple')

	if xItem.count > 0 then
	TriggerClientEvent('CanLip-Apple:CheackingSellOK', source)

	end


end)

ESX.RegisterServerCallback('CanLip-Apple:canPickUp', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(item)

	if xItem.limit ~= -1 and xItem.count >= xItem.limit then
		cb(false)
	else
		cb(true)
	end
end)



function CancelProcessing(playerID)
	if playersProcessingStones[playerID] then
		ESX.ClearTimeout(playersProcessingStones[playerID])
		playersProcessingStones[playerID] = nil
	end
end

RegisterServerEvent('CanLip-Apple:cancelProcessing')
AddEventHandler('CanLip-Apple:cancelProcessing', function()
	CancelProcessing(source)
end)

AddEventHandler('esx:playerDropped', function(playerID, reason)
	CancelProcessing(playerID)
end)

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	CancelProcessing(source)
end)

