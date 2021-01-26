ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('meeta_leather:reward')
AddEventHandler('meeta_leather:reward', function(AnimalWeight)
    local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('leather')
	local xItem_meat = xPlayer.getInventoryItem('meat')
    local random = math.random(1,100)		
	
	if xItem.limit ~= -1 and (xItem.count + 1) > xItem.limit then
		TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {
			text = '<strong class="red-text">หนังวิวของคุณเต็ม</strong>',
			type = "error",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		})
	else
		xPlayer.addInventoryItem(xItem.name, 1)
	end	

	if xItem_meat.limit ~= -1 and (xItem_meat.count + 1) > xItem_meat.limit then
		TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {
			text = '<strong class="red-text">เนื้อวากิว A5 ของคุณเต็ม</strong>',
			type = "error",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		})
	else
		xPlayer.addInventoryItem(xItem_meat.name, 1)
	end	

	-- Bonus
	if random >= 99 then
		xPlayer.addInventoryItem('leather_gun', 1)
	end
		
	if random >= 20 then
		xPlayer.addInventoryItem('milk', 1)
	end
        
end)