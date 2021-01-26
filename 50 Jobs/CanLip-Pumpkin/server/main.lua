
ESX = nil
local playersProcessingStones = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('CanLip-Pumpkin:pickedUpwoods')
AddEventHandler('CanLip-Pumpkin:pickedUpwoods', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('pumpkinun')
	math.randomseed(GetGameTimer())

	if xItem.limit ~= -1 and (xItem.count + 1) > xItem.limit then
		TriggerClientEvent('esx:showNotification', _source, _U('stone_inventoryfull'))
	else

		xPlayer.addInventoryItem(xItem.name, 3)
	end
end)


RegisterServerEvent('CanLip-Pumpkin:pack')
AddEventHandler('CanLip-Pumpkin:pack', function()
	local xPlayer = ESX.GetPlayerFromId(source)


	xPlayer.removeInventoryItem('pumpkinun', 3)
	xPlayer.addInventoryItem('pumpkino', 3)

end)

RegisterServerEvent('CanLip-Pumpkin:Sellpack')

AddEventHandler('CanLip-Pumpkin:Sellpack', function()
	--[[local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('fresh_shellfish', 1)
	xPlayer.addMoney(Config.Price)--]]

	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('pumpkino')

	xPlayer.removeInventoryItem('pumpkino', xItem.count)
	xPlayer.addMoney(Config.Price * xItem.count)

end)

RegisterServerEvent('CanLip-Pumpkin:CheackingPack')
AddEventHandler('CanLip-Pumpkin:CheackingPack', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('pumpkinun')

	if xItem.count > 1 then
	TriggerClientEvent('CanLip-Pumpkin:CheackingOK', source)

	end




end)


RegisterServerEvent('CanLip-Pumpkin:CheackingPack')
AddEventHandler('CanLip-Pumpkin:CheackingPack', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('pumpkinun')

	if xItem.count > 1 then



	TriggerClientEvent('CanLip-Pumpkin:CheackingOK', source)

	end




end)

RegisterServerEvent('CanLip-Pumpkin:SellCheak')
AddEventHandler('CanLip-Pumpkin:SellCheak', function()

	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('pumpkino')

	if xItem.count > 0 then
	TriggerClientEvent('CanLip-Pumpkin:CheackingSellOK', source)

	end


end)

ESX.RegisterServerCallback('CanLip-Pumpkin:canPickUp', function(source, cb, item)
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

RegisterServerEvent('CanLip-Pumpkin:cancelProcessing')
AddEventHandler('CanLip-Pumpkin:cancelProcessing', function()
	CancelProcessing(source)
end)

AddEventHandler('esx:playerDropped', function(playerID, reason)
	CancelProcessing(playerID)
end)

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	CancelProcessing(source)
end)

