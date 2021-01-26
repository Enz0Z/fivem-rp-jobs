-- CREATE BY THANAWUT PROMRAUNGDET
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('meeta_wood:pickedUp')
AddEventHandler('meeta_wood:pickedUp', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(Config.ItemName)
	local xItemCount = math.random(Config.ItemCount[1], Config.ItemCount[2])

	if xItem.limit ~= -1 and xItem.count >= xItem.limit then
		TriggerClientEvent("pNotify:SendNotification", source, {
			text = '<span class="red-text">ยางไม้คุณเต็ม</span> ',
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

		-- Bonus
		if Config.ItemBonus ~= nil then
			for k,v in pairs(Config.ItemBonus) do
				if math.random(1, 100) <= v.Percent then
					xPlayer.addInventoryItem(v.ItemName, v.ItemCount)
				end
			end
		end

	end
end)

ESX.RegisterServerCallback('meeta_wood:checkItem', function(source, cb, item, item2)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(item)
	local xItem2 = xPlayer.getInventoryItem(item2)

	if xItem.count >= 1 then
		cb(true, (xItem2.count >= xItem2.limit))
	else
		cb(false, (xItem2.count >= xItem2.limit))
	end
end)

ESX.RegisterServerCallback('meeta_wood:canPickUp', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(item)

	if xItem.limit ~= -1 and xItem.count >= xItem.limit then
		cb(false)
	else
		cb(true)
	end
end)