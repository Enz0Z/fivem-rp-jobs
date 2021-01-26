-- CREATE BY THANAWUT PROMRAUNGDET
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback("meeta_mining:getPlayerInventory", function(source, cb, target)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if targetXPlayer ~= nil then
		cb({inventory = targetXPlayer.inventory})
	else
		cb(nil)
	end
end)


RegisterServerEvent('meeta_mining:pickedUp')
AddEventHandler('meeta_mining:pickedUp', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(Config.ItemName)
	local xItemCount = math.random(Config.ItemCount[1], Config.ItemCount[2])

	if xItem.limit ~= -1 and xItem.count >= xItem.limit then
		TriggerClientEvent("pNotify:SendNotification", source, {
			text = '<span class="red-text">หินของคุณเต็ม</span> ',
			type = "success",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		}) 
	else
		if xItem.limit ~= -1 and (xItem.count + xItemCount) > xItem.limit then
			xPlayer.setInventoryItem(xItem.name, xItem.limit)
		else
			xPlayer.addInventoryItem(xItem.name, xItemCount)
		end
	end
end)

ESX.RegisterServerCallback('meeta_mining:checkItem', function(source, cb, item, item2)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(item)
	local xItem2 = xPlayer.getInventoryItem(item2)

	if xItem.count >= 1 then
		cb(true, (xItem2.count >= xItem2.limit))
	else
		cb(false, (xItem2.count >= xItem2.limit))
	end
end)

ESX.RegisterServerCallback('meeta_mining:canPickUp', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(item)

	if xItem.limit ~= -1 and xItem.count >= xItem.limit then
		cb(false)
	else
		cb(true)
	end
end)