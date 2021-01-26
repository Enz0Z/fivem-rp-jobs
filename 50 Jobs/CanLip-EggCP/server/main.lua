
ESX = nil
local playersProcessingStones = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('CanLip-EggCP:pickedUpwoods')
AddEventHandler('CanLip-EggCP:pickedUpwoods', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('eggun')
	math.randomseed(GetGameTimer())

	if xItem.limit ~= -1 and (xItem.count + 1) > xItem.limit then
		TriggerClientEvent('esx:showNotification', _source, _U('stone_inventoryfull'))
	else

		xPlayer.addInventoryItem(xItem.name, 3)
	end
end)


RegisterServerEvent('CanLip-EggCP:pack')
AddEventHandler('CanLip-EggCP:pack', function()
	local xPlayer = ESX.GetPlayerFromId(source)


	xPlayer.removeInventoryItem('eggun', 3)
	xPlayer.addInventoryItem('eggpn', 3)

end)

RegisterServerEvent('CanLip-EggCP:Sellpack')

AddEventHandler('CanLip-EggCP:Sellpack', function()
	--[[local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('fresh_shellfish', 1)
	xPlayer.addMoney(Config.Price)--]]

	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('eggpn')

	xPlayer.removeInventoryItem('eggpn', xItem.count)
	xPlayer.addMoney(Config.Price * xItem.count)

end)

RegisterServerEvent('CanLip-EggCP:CheackingPack')
AddEventHandler('CanLip-EggCP:CheackingPack', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('eggun')

	if xItem.count > 1 then
	TriggerClientEvent('CanLip-EggCP:CheackingOK', source)

	end




end)


RegisterServerEvent('CanLip-EggCP:CheackingPack')
AddEventHandler('CanLip-EggCP:CheackingPack', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('eggun')

	if xItem.count > 1 then



	TriggerClientEvent('CanLip-EggCP:CheackingOK', source)

	end




end)

RegisterServerEvent('CanLip-EggCP:SellCheak')
AddEventHandler('CanLip-EggCP:SellCheak', function()

	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('eggpn')

	if xItem.count > 0 then
	TriggerClientEvent('CanLip-EggCP:CheackingSellOK', source)

	end


end)

ESX.RegisterServerCallback('CanLip-EggCP:canPickUp', function(source, cb, item)
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

RegisterServerEvent('CanLip-EggCP:cancelProcessing')
AddEventHandler('CanLip-EggCP:cancelProcessing', function()
	CancelProcessing(source)
end)

AddEventHandler('esx:playerDropped', function(playerID, reason)
	CancelProcessing(playerID)
end)

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	CancelProcessing(source)
end)

