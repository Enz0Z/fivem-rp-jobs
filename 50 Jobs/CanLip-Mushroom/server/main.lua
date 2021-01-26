
ESX = nil
local playersProcessingStones = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('CanLip-Mushroom:pickedUpwoods')
AddEventHandler('CanLip-Mushroom:pickedUpwoods', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('mushroomun')
	math.randomseed(GetGameTimer())

	if xItem.limit ~= -1 and (xItem.count + 1) > xItem.limit then
		TriggerClientEvent('esx:showNotification', _source, _U('stone_inventoryfull'))
	else

		xPlayer.addInventoryItem(xItem.name, 3)
	end
end)


RegisterServerEvent('CanLip-Mushroom:pack')
AddEventHandler('CanLip-Mushroom:pack', function()
	local xPlayer = ESX.GetPlayerFromId(source)


	xPlayer.removeInventoryItem('mushroomun', 3)
	xPlayer.addInventoryItem('omushroom', 3)

end)

RegisterServerEvent('CanLip-Mushroom:Sellpack')

AddEventHandler('CanLip-Mushroom:Sellpack', function()
	--[[local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('fresh_shellfish', 1)
	xPlayer.addMoney(Config.Price)--]]

	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('omushroom')

	xPlayer.removeInventoryItem('omushroom', xItem.count)
	xPlayer.addMoney(Config.Price * xItem.count)

end)

RegisterServerEvent('CanLip-Mushroom:CheackingPack')
AddEventHandler('CanLip-Mushroom:CheackingPack', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('mushroomun')

	if xItem.count > 1 then
	TriggerClientEvent('CanLip-Mushroom:CheackingOK', source)

	end




end)


RegisterServerEvent('CanLip-Mushroom:CheackingPack')
AddEventHandler('CanLip-Mushroom:CheackingPack', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('mushroomun')

	if xItem.count > 1 then



	TriggerClientEvent('CanLip-Mushroom:CheackingOK', source)

	end




end)

RegisterServerEvent('CanLip-Mushroom:SellCheak')
AddEventHandler('CanLip-Mushroom:SellCheak', function()

	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('omushroom')

	if xItem.count > 0 then
	TriggerClientEvent('CanLip-Mushroom:CheackingSellOK', source)

	end


end)

ESX.RegisterServerCallback('CanLip-Mushroom:canPickUp', function(source, cb, item)
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

RegisterServerEvent('CanLip-Mushroom:cancelProcessing')
AddEventHandler('CanLip-Mushroom:cancelProcessing', function()
	CancelProcessing(source)
end)

AddEventHandler('esx:playerDropped', function(playerID, reason)
	CancelProcessing(playerID)
end)

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	CancelProcessing(source)
end)

