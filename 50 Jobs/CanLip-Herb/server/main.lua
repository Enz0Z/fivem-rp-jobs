
ESX = nil
local playersProcessingStones = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('CanLip-Herb:pickedUpwoods')
AddEventHandler('CanLip-Herb:pickedUpwoods', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('herbun')
	math.randomseed(GetGameTimer())

	if xItem.limit ~= -1 and (xItem.count + 1) > xItem.limit then
		TriggerClientEvent('esx:showNotification', _source, _U('stone_inventoryfull'))
	else

		xPlayer.addInventoryItem(xItem.name, 3)
	end
end)


RegisterServerEvent('CanLip-Herb:pack')
AddEventHandler('CanLip-Herb:pack', function()
	local xPlayer = ESX.GetPlayerFromId(source)


	xPlayer.removeInventoryItem('herbun', 3)
	xPlayer.addInventoryItem('herbpn', 3)

end)

RegisterServerEvent('CanLip-Herb:Sellpack')

AddEventHandler('CanLip-Herb:Sellpack', function()
	--[[local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('fresh_shellfish', 1)
	xPlayer.addMoney(Config.Price)--]]

	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('herbpn')

	xPlayer.removeInventoryItem('herbpn', xItem.count)
	xPlayer.addMoney(Config.Price * xItem.count)

end)

RegisterServerEvent('CanLip-Herb:CheackingPack')
AddEventHandler('CanLip-Herb:CheackingPack', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('herbun')

	if xItem.count > 1 then
	TriggerClientEvent('CanLip-Herb:CheackingOK', source)

	end




end)


RegisterServerEvent('CanLip-Herb:CheackingPack')
AddEventHandler('CanLip-Herb:CheackingPack', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('herbun')

	if xItem.count > 1 then



	TriggerClientEvent('CanLip-Herb:CheackingOK', source)

	end




end)

RegisterServerEvent('CanLip-Herb:SellCheak')
AddEventHandler('CanLip-Herb:SellCheak', function()

	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('herbpn')

	if xItem.count > 0 then
	TriggerClientEvent('CanLip-Herb:CheackingSellOK', source)

	end


end)

ESX.RegisterServerCallback('CanLip-Herb:canPickUp', function(source, cb, item)
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

RegisterServerEvent('CanLip-Herb:cancelProcessing')
AddEventHandler('CanLip-Herb:cancelProcessing', function()
	CancelProcessing(source)
end)

AddEventHandler('esx:playerDropped', function(playerID, reason)
	CancelProcessing(playerID)
end)

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	CancelProcessing(source)
end)

