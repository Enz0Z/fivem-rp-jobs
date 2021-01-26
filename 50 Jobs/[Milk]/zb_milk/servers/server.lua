ESX = nil
local playersProcessing = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent('crossbite_milk:sell')
AddEventHandler('crossbite_milk:sell', function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = Config.items[itemName]
	local xItem = xPlayer.getInventoryItem(itemName)

	if not price then
		return
	end

	if xItem.count < amount then
		return
	end

	price = ESX.Math.Round(price * amount)
	xPlayer.addMoney(price)

	xPlayer.removeInventoryItem(xItem.name, amount)

end)

RegisterServerEvent('crossbite_milk:pickedUp')
AddEventHandler('crossbite_milk:pickedUp', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('milk')
	local zItem = math.random(Config.MinRandom, Config.MaxRandom)
	if xItem.limit ~= 300 and (xItem.count + zItem) > xItem.limit then
		--
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = _U('Inventoryfull') })
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = _U('success') })
		xPlayer.addInventoryItem(xItem.name, zItem)
	end
end)

ESX.RegisterServerCallback('crossbite_milk:canPickUp', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(item)

	if xItem.limit ~= -1 and xItem.count >= xItem.limit then
		cb(false)
	else
		cb(true)
	end
end)
ESX.RegisterServerCallback('crossbite_milk:haveItem', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(item)

	if xItem.count >= 1 then
		cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('crossbite_milk:process')
AddEventHandler('crossbite_milk:process', function()
	if not playersProcessing[source] then
		local _source = source

		playersProcessing[_source] = ESX.SetTimeout(Config.WaitProcess*1000, function()
			
			local xPlayer = ESX.GetPlayerFromId(_source)
			local milk, milk_package = xPlayer.getInventoryItem('milk'), xPlayer.getInventoryItem('milk_package')
			if milk_package.limit ~= -1 and (milk_package.count + Config.Packgrage) >= milk_package.limit then
				--
				TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = _U('Inventoryfull') })
			elseif milk.count < Config.Normal then
				--
				TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = _U('empty') })
			else
				xPlayer.removeInventoryItem('milk', Config.Normal)
				xPlayer.addInventoryItem('milk_package', Config.Packgrage)
				TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'success', text = _U('success') })
			end

			playersProcessing[_source] = nil
		end)
	end
end)

function CancelProcessing(playerID)
	if playersProcessing[playerID] then
		ESX.ClearTimeout(playersProcessing[playerID])
		playersProcessing[playerID] = nil
	end
end

RegisterServerEvent('crossbite_milk:cancelProcessing')
AddEventHandler('crossbite_milk:cancelProcessing', function()
	CancelProcessing(source)
end)

AddEventHandler('esx:playerDropped', function(playerID, reason)
	CancelProcessing(playerID)
end)

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	CancelProcessing(source)
end)

print ('=== SCRIPT  BY ZOMBOI EVERYONE SCRIPT === ')