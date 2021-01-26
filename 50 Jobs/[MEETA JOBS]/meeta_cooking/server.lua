ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('grill', function(source)
	TriggerClientEvent('meeta_cooking:menuGrill', source)
end)
