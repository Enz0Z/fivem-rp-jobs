ESX = nil
local PlayerData                = {}

local CanPutArmor = true
local IsPutArmor = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterNetEvent('meeta_combat:armor')
AddEventHandler('meeta_combat:armor', function()

	if not CanPutArmor then
		TriggerEvent("pNotify:SendNotification", {
			text = '<strong class="red-text">กรุณารอ 5 นาที!!</strong>',
			type = "success",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		})
	else

		TriggerEvent('skinchanger:getSkin', function(skin)
			local playerPed = PlayerPedId()

			if IsPutArmor then

				local lib_un, anim_un = 'mp_safehouseshower@male@', 'male_shower_undress_&_turn_on_water'
				ESX.Streaming.RequestAnimDict(lib_un, function()
					local co = GetEntityCoords(playerPed)
					local he = GetEntityHeading(playerPed)
		
					TaskPlayAnimAdvanced(playerPed, lib_un, anim_un, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.3, 0, 0)
					Citizen.Wait(2000)
					ClearPedTasks(playerPed)
					if skin.sex == 0 then
						if Config.BulletWear.un_male ~= nil then
							TriggerEvent('skinchanger:loadClothes', skin, Config.BulletWear.un_male)
							SetPedArmour(playerPed, 0)
						end
					else
						if Config.BulletWear.un_female ~= nil then
							TriggerEvent('skinchanger:loadClothes', skin, Config.BulletWear.un_female)
							SetPedArmour(playerPed, 0)
						end
					end
					CanPutArmor = false
					Wait(300000)
					CanPutArmor = true
					IsPutArmor = false
					
				end)
				
			else
				if PlayerData.job ~= nil and PlayerData.job.name == 'police' then

					TriggerEvent('esx_inventoryhud:closeHud')
					local playerPed = PlayerPedId()	

					local elements = {}
					for k,v in pairs(Config.BulletWearPolice) do
						table.insert(elements, {label = v.title, value = k})
					end

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armor_more',
					{
						title    = "ชุดเกราะตำรวจ",
						align    = 'top-left',
						elements = elements
					}, function(data, menu)

						if data.current.value ~= nil then

							TriggerEvent('skinchanger:getSkin', function(skin)
								local lib, anim = 'mp_safehouseshower@male@', 'male_shower_towel_dry_to_get_dressed' 
								ESX.Streaming.RequestAnimDict(lib, function()
									local co = GetEntityCoords(playerPed)
									local he = GetEntityHeading(playerPed)
						
									TaskPlayAnimAdvanced(playerPed, lib, anim, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.5, 0, 0)
									Citizen.Wait(2000)
									ClearPedTasks(playerPed)
									if skin.sex == 0 then
										if Config.BulletWear.male ~= nil then
											TriggerEvent('skinchanger:loadClothes', skin, Config.BulletWearPolice[data.current.value].male)
											SetPedArmour(playerPed, 100)
										end
									else
										if Config.BulletWear.female ~= nil then
											TriggerEvent('skinchanger:loadClothes', skin, Config.BulletWearPolice[data.current.value].female)
											SetPedArmour(playerPed, 100)
										end
									end
									IsPutArmor = true		
								end)
							end)
						
						end

					end, function(data, menu)
						menu.close()
					end)
				else

					local lib, anim = 'mp_safehouseshower@male@', 'male_shower_towel_dry_to_get_dressed' 
					ESX.Streaming.RequestAnimDict(lib, function()
						local co = GetEntityCoords(playerPed)
						local he = GetEntityHeading(playerPed)
			
						TaskPlayAnimAdvanced(playerPed, lib, anim, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.5, 0, 0)
						Citizen.Wait(2000)
						ClearPedTasks(playerPed)
						if skin.sex == 0 then
							if Config.BulletWear.male ~= nil then
								TriggerEvent('skinchanger:loadClothes', skin, Config.BulletWear.male)
								SetPedArmour(playerPed, 100)
							end
						else
							if Config.BulletWear.female ~= nil then
								TriggerEvent('skinchanger:loadClothes', skin, Config.BulletWear.female)
								SetPedArmour(playerPed, 100)
							end
						end
						IsPutArmor = true		
					end)

				end
			end

			
		end)
	end
end)

RegisterNetEvent('meeta_combat:reloadPistol')
AddEventHandler('meeta_combat:reloadPistol', function()
	if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("WEAPON_PISTOL") then
		TriggerServerEvent('meeta_combat:reloadPistol')
	else
		TriggerEvent("pNotify:SendNotification", {
			text = '<strong class="red-text">คุณต้องถือปืน Pistol</strong>',
			type = "error",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		})
	end
end)

RegisterNetEvent('meeta_combat:reloadPistol50')
AddEventHandler('meeta_combat:reloadPistol50', function()
	if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey("WEAPON_PISTOL50") then
		TriggerServerEvent('meeta_combat:reloadPistol50')
	else
		TriggerEvent("pNotify:SendNotification", {
			text = '<strong class="red-text">คุณต้องถือปืน Pistol .50</strong>',
			type = "error",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		})
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		ClearTimecycleModifier()
		ShakeGameplayCam("DRUNK_SHAKE", 0.0)
		SetPedMoveRateOverride(PlayerPedId(), 1.0)
	end
end)