ESX = nil
local playersProcessing = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('caruby_lumberjack:canCUT', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('hatchet_lj')

	if xItem.count >= 1 then
		cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('caruby_lumberjack:giveItem')
AddEventHandler('caruby_lumberjack:giveItem', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('wood')

	if xItem.limit ~= -1 and (xItem.count + 1) > xItem.limit then
		--
	else
		xPlayer.addInventoryItem(xItem.name, 5)
	end
end)

RegisterServerEvent('caruby_lumberjack:sell')
AddEventHandler('caruby_lumberjack:sell', function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = config.items[itemName]
	local xItem = xPlayer.getInventoryItem(itemName)

	if not price then
		print(('caruby_lumberjack: %s attempted to sell an invalid!'):format(xPlayer.identifier))
		return
	end

	if xItem.count < amount then
		return
	end

	price = ESX.Math.Round(price * amount)
	xPlayer.addMoney(price)

	xPlayer.removeInventoryItem(xItem.name, amount)

end)

RegisterServerEvent('caruby_lumberjack:process')
AddEventHandler('caruby_lumberjack:process', function()
	if not playersProcessing[source] then
		local _source = source

		playersProcessing[_source] = ESX.SetTimeout(7000, function()
			
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xMin, xMax = xPlayer.getInventoryItem('wood'), xPlayer.getInventoryItem('pro_wood')
			if xMax.limit ~= -1 and (xMax.count + 1) >= xMax.limit then
				--
			elseif xMin.count < 3 then
				--
			else
				xPlayer.removeInventoryItem('wood', 5)
				xPlayer.addInventoryItem('pro_wood', 1)
			end

			playersProcessing[_source] = nil
		end)
	else
		print(('caruby_lumberjack: %s attempted to exploit!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)

function CancelProcessing(playerID)
	if playersProcessing[playerID] then
		ESX.ClearTimeout(playersProcessing[playerID])
		playersProcessing[playerID] = nil
	end
end

RegisterServerEvent('caruby_lumberjack:cancelProcessing')
AddEventHandler('caruby_lumberjack:cancelProcessing', function()
	CancelProcessing(source)
end)

AddEventHandler('esx:playerDropped', function(playerID, reason)
	CancelProcessing(playerID)
end)

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	CancelProcessing(source)
end)
