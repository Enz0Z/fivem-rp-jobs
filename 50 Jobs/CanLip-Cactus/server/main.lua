
ESX = nil
local playersProcessingStones = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('CanLip-Cactus:pickedUpwoods')
AddEventHandler('CanLip-Cactus:pickedUpwoods', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('echinopsis')
	math.randomseed(GetGameTimer())

	if xItem.limit ~= -1 and (xItem.count + 1) > xItem.limit then
		TriggerClientEvent('esx:showNotification', _source, _U('stone_inventoryfull'))
	else

		xPlayer.addInventoryItem(xItem.name, 3)
	end
end)


RegisterServerEvent('CanLip-Cactus:pack')
AddEventHandler('CanLip-Cactus:pack', function()
	local xPlayer = ESX.GetPlayerFromId(source)


	xPlayer.removeInventoryItem('echinopsis', 3)
	xPlayer.addInventoryItem('cactus', 3)

end)

RegisterServerEvent('CanLip-Cactus:Sellpack')

AddEventHandler('CanLip-Cactus:Sellpack', function()
	--[[local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('fresh_shellfish', 1)
	xPlayer.addMoney(Config.Price)--]]

	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('cactus')

	xPlayer.removeInventoryItem('cactus', xItem.count)
	xPlayer.addMoney(Config.Price * xItem.count)

end)

RegisterServerEvent('CanLip-Cactus:CheackingPack')
AddEventHandler('CanLip-Cactus:CheackingPack', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('echinopsis')

	if xItem.count > 1 then
	TriggerClientEvent('CanLip-Cactus:CheackingOK', source)

	end




end)


RegisterServerEvent('CanLip-Cactus:CheackingPack')
AddEventHandler('CanLip-Cactus:CheackingPack', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('echinopsis')

	if xItem.count > 1 then



	TriggerClientEvent('CanLip-Cactus:CheackingOK', source)

	end




end)

RegisterServerEvent('CanLip-Cactus:SellCheak')
AddEventHandler('CanLip-Cactus:SellCheak', function()

	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('cactus')

	if xItem.count > 0 then
	TriggerClientEvent('CanLip-Cactus:CheackingSellOK', source)

	end


end)

ESX.RegisterServerCallback('CanLip-Cactus:canPickUp', function(source, cb, item)
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

RegisterServerEvent('CanLip-Cactus:cancelProcessing')
AddEventHandler('CanLip-Cactus:cancelProcessing', function()
	CancelProcessing(source)
end)

AddEventHandler('esx:playerDropped', function(playerID, reason)
	CancelProcessing(playerID)
end)

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	CancelProcessing(source)
end)

