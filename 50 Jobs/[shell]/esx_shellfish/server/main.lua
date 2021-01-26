
ESX = nil
local playersProcessingStones = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_shellfish:pickedUpwoods')
AddEventHandler('esx_shellfish:pickedUpwoods', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('shellfish')
	math.randomseed(GetGameTimer())

	if xItem.limit ~= -1 and (xItem.count + 1) > xItem.limit then
		TriggerClientEvent('esx:showNotification', _source, _U('stone_inventoryfull'))
	else

		xPlayer.addInventoryItem(xItem.name, 1)
	end
end)


RegisterServerEvent('esx_shellfish:pack')
AddEventHandler('esx_shellfish:pack', function()
	local xPlayer = ESX.GetPlayerFromId(source)


	xPlayer.removeInventoryItem('shellfish', 2)
	xPlayer.addInventoryItem('fresh_shellfish', 1)

end)

RegisterServerEvent('esx_shellfish:Sellpack')

AddEventHandler('esx_shellfish:Sellpack', function()
	--[[local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('fresh_shellfish', 1)
	xPlayer.addMoney(Config.Price)--]]

	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('fresh_shellfish')

	xPlayer.removeInventoryItem('fresh_shellfish', xItem.count)
	xPlayer.addMoney(Config.Price * xItem.count)

end)

RegisterServerEvent('esx_shellfish:CheackingPack')
AddEventHandler('esx_shellfish:CheackingPack', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('shellfish')

	if xItem.count > 1 then
	TriggerClientEvent('esx_shellfish:CheackingOK', source)

	end




end)


RegisterServerEvent('esx_shellfish:CheackingPack')
AddEventHandler('esx_shellfish:CheackingPack', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('shellfish')

	if xItem.count > 1 then



	TriggerClientEvent('esx_shellfish:CheackingOK', source)

	end




end)

RegisterServerEvent('esx_shellfish:SellCheak')
AddEventHandler('esx_shellfish:SellCheak', function()

	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('fresh_shellfish')

	if xItem.count > 0 then
	TriggerClientEvent('esx_shellfish:CheackingSellOK', source)

	end


end)

ESX.RegisterServerCallback('esx_shellfish:canPickUp', function(source, cb, item)
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

RegisterServerEvent('esx_shellfish:cancelProcessing')
AddEventHandler('esx_shellfish:cancelProcessing', function()
	CancelProcessing(source)
end)

AddEventHandler('esx:playerDropped', function(playerID, reason)
	CancelProcessing(playerID)
end)

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	CancelProcessing(source)
end)

