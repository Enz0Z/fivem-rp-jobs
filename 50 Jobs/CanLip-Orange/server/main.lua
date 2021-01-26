
ESX = nil
local playersProcessingStones = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('CanLip-Orange:pickedUpwoods')
AddEventHandler('CanLip-Orange:pickedUpwoods', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('orange')
	math.randomseed(GetGameTimer())

	if xItem.limit ~= -1 and (xItem.count + 1) > xItem.limit then
		TriggerClientEvent('esx:showNotification', _source, _U('stone_inventoryfull'))
	else

		xPlayer.addInventoryItem(xItem.name, 3)
	end
end)


RegisterServerEvent('CanLip-Orange:pack')
AddEventHandler('CanLip-Orange:pack', function()
	local xPlayer = ESX.GetPlayerFromId(source)


	xPlayer.removeInventoryItem('orange', 3)
	xPlayer.addInventoryItem('orangep', 3)

end)

RegisterServerEvent('CanLip-Orange:Sellpack')

AddEventHandler('CanLip-Orange:Sellpack', function()
	--[[local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('fresh_shellfish', 1)
	xPlayer.addMoney(Config.Price)--]]

	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('orangep')

	xPlayer.removeInventoryItem('orangep', xItem.count)
	xPlayer.addMoney(Config.Price * xItem.count)

end)

RegisterServerEvent('CanLip-Orange:CheackingPack')
AddEventHandler('CanLip-Orange:CheackingPack', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('orange')

	if xItem.count > 1 then
	TriggerClientEvent('CanLip-Orange:CheackingOK', source)

	end




end)


RegisterServerEvent('CanLip-Orange:CheackingPack')
AddEventHandler('CanLip-Orange:CheackingPack', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('orange')

	if xItem.count > 1 then



	TriggerClientEvent('CanLip-Orange:CheackingOK', source)

	end




end)

RegisterServerEvent('CanLip-Orange:SellCheak')
AddEventHandler('CanLip-Orange:SellCheak', function()

	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('orangep')

	if xItem.count > 0 then
	TriggerClientEvent('CanLip-Orange:CheackingSellOK', source)

	end


end)

ESX.RegisterServerCallback('CanLip-Orange:canPickUp', function(source, cb, item)
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

RegisterServerEvent('CanLip-Orange:cancelProcessing')
AddEventHandler('CanLip-Orange:cancelProcessing', function()
	CancelProcessing(source)
end)

AddEventHandler('esx:playerDropped', function(playerID, reason)
	CancelProcessing(playerID)
end)

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	CancelProcessing(source)
end)

