ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_pigjob:reward')
AddEventHandler('esx_pigjob:reward', function(AnimalWeight)
    local xPlayer = ESX.GetPlayerFromId(source)

    if AnimalWeight >= 1 then
        xPlayer.addInventoryItem('pork', 1)
    elseif AnimalWeight >= 6 then
        xPlayer.addInventoryItem('pork', 2)
    elseif AnimalWeight >= 15 then
        xPlayer.addInventoryItem('pork', 3)
    end

   -- xPlayer.addInventoryItem('leather', math.random(1, 4))
        
end)

RegisterServerEvent('esx_pigjob:porkpack')
AddEventHandler('esx_pigjob:porkpack', function()
    local xPlayer = ESX.GetPlayerFromId(source)
	local xPork, xPorkPack = xPlayer.getInventoryItem('pork'), xPlayer.getInventoryItem('porkpackage')
	if xPorkPack.limit ~= -1 and (xPorkPack.count) >= xPorkPack.limit then
		TriggerClientEvent('esx:showNotification', xPlayer.source, 'Porkpackage is full')
	elseif xPork.count < 3 then
		TriggerClientEvent('esx:showNotification', xPlayer.source, 'You don\'t have pork 3 more')
	else
		xPlayer.removeInventoryItem('pork', 3)
		xPlayer.addInventoryItem('porkpackage', 1)

		TriggerClientEvent('esx:showNotification', xPlayer.source, 'You get Porkpackage 1 more, waste Pork 3 more')
	end
        
end)

function sendNotification(xsource, message, messageType, messageTimeout)
    TriggerClientEvent('notification', xsource, message)
end