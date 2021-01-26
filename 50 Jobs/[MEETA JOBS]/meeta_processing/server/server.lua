-- CREATE BY THANAWUT PROMRAUNGDET
ESX = nil
local playersProcessingObject = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback("meeta_processing:getPlayerInventory", function(source, cb, target)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if targetXPlayer ~= nil then
		cb({inventory = targetXPlayer.inventory})
	else
		cb(nil)
	end
end)

function CheckPolice()
	local xPlayers = ESX.GetPlayers()
	local cops = 0
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			cops = cops + 1
		end
	end
	return cops
end

ESX.RegisterServerCallback('meeta_processing:CheckPolice', function(source, cb, police)
	local cops = CheckPolice()

	if cops < police then
		cb(false)
	else
		cb(true)
	end
end)

RegisterServerEvent('meeta_processing:process')
AddEventHandler('meeta_processing:process', function(Zone)
	if not playersProcessingObject[source] then
		local _source = source

		playersProcessingObject[_source] = ESX.SetTimeout(Zone.WaitProcessing, function()
			local xPlayer = ESX.GetPlayerFromId(_source)
			local ItemMustUse = xPlayer.getInventoryItem(Zone.Items[1].ItemName)
			local ItemMustUseCount = Zone.Items[1].ItemCount
			

			local xItem = xPlayer.getInventoryItem(Zone.Items[1].Get.ItemName)

			if ItemMustUse.count < ItemMustUseCount then
				TriggerClientEvent("pNotify:SendNotification", _source, {
					text = '<strong class="red-text">คุณต้องมี '..Zone.Items[1].Text..' จำนวน '..ItemMustUseCount..' ขึ้นไป</strong> ',
					type = "error",
					timeout = 3000,
					layout = "bottomCenter",
					queue = "global"
				}) 
			elseif xItem.limit ~= -1 and (xItem.count + Zone.Items[1].Get.ItemCount) > xItem.limit then
				TriggerClientEvent("pNotify:SendNotification", _source, {
					text = '<strong class="red-text">'..Zone.Items[1].Text..'ของคุณเต็ม</strong>',
					type = "error",
					timeout = 3000,
					layout = "bottomCenter",
					queue = "global"
				}) 
			else

				xPlayer.removeInventoryItem(Zone.Items[1].ItemName, Zone.Items[1].ItemCount)
				xPlayer.addInventoryItem(Zone.Items[1].Get.ItemName, Zone.Items[1].Get.ItemCount)

				--Bonus
				if Zone.Items[1].Get.Bonus ~= nil then
					for k,v in pairs(Zone.Items[1].Get.Bonus) do
						if math.random(1, 100) <= v.Percent then
							xPlayer.addInventoryItem(v.ItemName, v.ItemCount)
							if v.Animation ~= nil then
								TriggerClientEvent("meeta_processing:animation", _source, v.Animation) 
							end
						end
					end
				end
			end

			playersProcessingObject[_source] = nil
		end)
	end
end)

RegisterServerEvent('meeta_processing:ProccessFunction')
AddEventHandler('meeta_processing:ProccessFunction', function(Index, CurrentZone)
	local _source = source
	local Item = CurrentZone.Items[Index]
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xItem = xPlayer.getInventoryItem(Item.ItemName)

	if xItem.count < Item.ItemCount then
		TriggerClientEvent("pNotify:SendNotification", _source, {
			text = '<strong class="red-text">คุณมี '..Item.Text..' ไม่พอ</strong>',
			type = "success",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		}) 
	else

		if Item.OnceProcessing then
			GetCount = math.floor(xItem.count/Item.ItemCount)
			RemoveCount = xItem.count
		else
			GetCount = math.floor(Item.Get.ItemCount)
			RemoveCount = Item.ItemCount
		end

		xPlayer.addInventoryItem(Item.Get.ItemName, GetCount)
		xPlayer.removeInventoryItem(Item.ItemName, RemoveCount)

	end
end)

function CancelProcessing(playerID)
	if playersProcessingObject[playerID] then
		ESX.ClearTimeout(playersProcessingObject[playerID])
		playersProcessingObject[playerID] = nil
	end
end

RegisterServerEvent('meeta_processing:cancelProcessing')
AddEventHandler('meeta_processing:cancelProcessing', function()
	CancelProcessing(source)
end)