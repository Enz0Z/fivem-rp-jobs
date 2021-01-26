ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('armor', function(source)
    local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)	
	local xItem = xPlayer.getInventoryItem("armor")
	
	if xItem.count >= 1 then
		TriggerClientEvent('meeta_combat:armor', _source)
	else
		TriggerClientEvent("pNotify:SendNotification", _source, {
			text = '<strong class="red-text">คุณไม่มีเกราะกันกระสุน</strong>',
			type = "error",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		})
	end
end)

ESX.RegisterServerCallback('meeta_combat:getItem', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(item)

	if xItem.count >= 1 then
		cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('meeta_combat:DeleteItem')
AddEventHandler('meeta_combat:DeleteItem', function(Item)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeInventoryItem(Item, 1)

end)


ESX.RegisterUsableItem('ammo_pistol', function(source)
    local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)

	local xItem = xPlayer.getInventoryItem("ammo_pistol")
	
	if xItem.count >= 1 then
		TriggerClientEvent('meeta_combat:reloadPistol', _source)
	else
		TriggerClientEvent("pNotify:SendNotification", _source, {
			text = '<strong class="red-text">คุณไม่มี Ammo Pistol</strong>',
			type = "error",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		})
	end
end)

RegisterServerEvent('meeta_combat:reloadPistol')
AddEventHandler('meeta_combat:reloadPistol', function(target)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)

	local WeaponName = "WEAPON_PISTOL"
	if xPlayer.hasWeapon(WeaponName) then

		xPlayer.addWeapon(WeaponName, 48)

	else
		TriggerClientEvent("pNotify:SendNotification", _source, {
			text = '<strong class="red-text">คุณไม่มีปืน Pistol</strong>',
			type = "error",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		})
	end
	xPlayer.removeInventoryItem("ammo_pistol", 1)
end)

ESX.RegisterUsableItem('ammo_pistol50', function(source)
    local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)

	local xItem = xPlayer.getInventoryItem("ammo_pistol50")
	
	if xItem.count >= 1 then
		TriggerClientEvent('meeta_combat:reloadPistol50', _source)
	else
		TriggerClientEvent("pNotify:SendNotification", _source, {
			text = '<strong class="red-text">คุณไม่มี Ammo Pistol .50</strong>',
			type = "error",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		})
	end
end)

RegisterServerEvent('meeta_combat:reloadPistol50')
AddEventHandler('meeta_combat:reloadPistol50', function(target)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)

	local WeaponName = "WEAPON_PISTOL50"
	if xPlayer.hasWeapon(WeaponName) then

		xPlayer.addWeapon(WeaponName, 32)

	else
		TriggerClientEvent("pNotify:SendNotification", _source, {
			text = '<strong class="red-text">คุณไม่มีปืน Pistol .50</strong>',
			type = "error",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		})
	end
	xPlayer.removeInventoryItem("ammo_pistol50", 1)
end)
