ESX = nil
local playersProcessing = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('crossbite_hunter:sell')
AddEventHandler('crossbite_hunter:sell', function(itemName, amount)
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

RegisterServerEvent('crossbite_hunter:pickedUp')
AddEventHandler('crossbite_hunter:pickedUp', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('leather')
	local zItem = math.random(Config.MinRandom, Config.MaxRandom)
	if xItem.limit ~= -1 and (xItem.count + zItem) > xItem.limit then
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = _U('Inventoryfull') })
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = _U('success') })
		xPlayer.addInventoryItem(xItem.name, zItem)
	end
end)

RegisterServerEvent('crossbite_hunter:checkstarthunt')
AddEventHandler('crossbite_hunter:checkstarthunt', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.get('money') >= Config.Price then
		xPlayer.removeMoney(Config.Price)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = _U('Deletemoney') })
		TriggerClientEvent('crossbite_hunter:starthunt', source)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = _U('Moneynotenought') })
	end
	
end)

RegisterServerEvent('crossbite_hunter:stophunt')
AddEventHandler('crossbite_hunter:stophunt', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addMoney(Config.Price)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = _U('Addmoney') })
end)


ESX.RegisterServerCallback('crossbite_hunter:canPickUp', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(item)

	if xItem.limit ~= -1 and xItem.count >= xItem.limit then
		cb(false)
	else
		cb(true)
	end
end)

RegisterServerEvent('crossbite_hunter:process')
AddEventHandler('crossbite_hunter:process', function()
	if not playersProcessing[source] then
		local _source = source

		playersProcessing[_source] = ESX.SetTimeout(Config.WaitProcess*1000, function()
			
			local xPlayer = ESX.GetPlayerFromId(_source)
			local leather, cloth = xPlayer.getInventoryItem('leather'), xPlayer.getInventoryItem('cloth')
			if cloth.limit ~= -1 and (cloth.count + Config.Packgrage) >= cloth.limit then
				--
				TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = _U('Inventoryfull') })
			elseif leather.count < Config.Normal then
				--
				TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = _U('empty') })
			else
				xPlayer.removeInventoryItem('leather', Config.Normal)
				xPlayer.addInventoryItem('cloth', Config.Packgrage)
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

RegisterServerEvent('crossbite_hunter:cancelProcessing')
AddEventHandler('crossbite_hunter:cancelProcessing', function()
	CancelProcessing(source)
end)

AddEventHandler('esx:playerDropped', function(playerID, reason)
	CancelProcessing(playerID)
end)

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	CancelProcessing(source)
end)

print ('=== SCRIPT  BY CROSSBITE-STUDIO LOCKED EVERYONE SCRIPT === ')