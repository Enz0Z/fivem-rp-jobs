-- CREATE BY THANAWUT PROMRAUNGDET
local IsProcessing, IsOpenMenu = false, false

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(5000)
end)

function ProcessObject(Zone)
	IsProcessing = true

	ESX.ShowHelpNotification(Zone.Text.ProcessText)
	TriggerServerEvent('meeta_processing:process', Zone)
	local timeLeft = Zone.WaitProcessing / 1000
	local playerPed = PlayerPedId()
	local ObjectSpawn = nil
	if Zone.Prop ~= nil then

		ObjectSpawn = CreateObject(GetHashKey(Zone.Prop.Object), Zone.Prop.Location.x, Zone.Prop.Location.y, Zone.Prop.Location.z, Zone.Prop.isNetwork, false, true)
		SetEntityHeading(ObjectSpawn, Zone.Prop.Location.h)
		PlaceObjectOnGroundProperly(ObjectSpawn)

	end

	-- Play Animation
	if Zone.Animation.Scenario then
		TaskStartScenarioInPlace(playerPed, Zone.Animation.AnimationScene, 0, false)
	else
		ESX.Streaming.RequestAnimDict(Zone.Animation.AnimationDirect, function()
			TaskPlayAnim(GetPlayerPed(-1), Zone.Animation.AnimationDirect, Zone.Animation.AnimationScene, 8.0, -8.0, -1, 0, 0, false, false, false)
		end)							
	end

	while timeLeft > 0 do
		Citizen.Wait(1000)
		timeLeft = timeLeft - 1

		if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Zone.Marker.Pos.x, Zone.Marker.Pos.y, Zone.Marker.Pos.z, false) > 4 then
			ESX.ShowHelpNotification("The processing has been ~r~canceled~s~ due to you abandoning the area.")
			TriggerServerEvent('meeta_processing:cancelProcessing')
			break
		end
	end

	ClearPedTasks(playerPed)

	if Zone.Prop ~= nil then
		if ObjectSpawn ~= nil then
			ESX.Game.DeleteObject(ObjectSpawn)
		end
	end

	local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
	local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey("prop_fish_slice_01"), false, false, false)
	if object ~= 0 then
		Wait(800)
		ESX.Game.DeleteObject(object)
	end
	IsProcessing = false
end

-- Create Blips
Citizen.CreateThread(function()
	
	for k,v in pairs(Config.ProcessingZone) do
		if v.Blips then
			local blip = AddBlipForCoord(v.Marker.Pos.x, v.Marker.Pos.y, v.Marker.Pos.z)
			SetBlipSprite (blip, v.Blips.Id)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, v.Blips.Size)
			SetBlipColour (blip, v.Blips.Color)
			SetBlipAsShortRange(blip, true)
			AddTextEntry('BLIP_PROCESS', v.Blips.Text)
			BeginTextCommandSetBlipName("BLIP_PROCESS")
			EndTextCommandSetBlipName(blip)
		end
	end

end)

-- สร้างโพลเสส
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		local coords = GetEntityCoords(GetPlayerPed(-1))
		local _Config = Config.ProcessingZone
		local IsInMarkerProcess  = false
		local CurrentZone = nil
		local CurrentTextHelper = nil

		for k,v in pairs(Config.ProcessingZone) do
			if(v.Marker.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Marker.Pos.x, v.Marker.Pos.y, v.Marker.Pos.z, true) < v.Marker.DrawDistance) then
				DrawMarker(v.Marker.Type, v.Marker.Pos.x, v.Marker.Pos.y, v.Marker.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Marker.Size.x, v.Marker.Size.y, v.Marker.Size.z, v.Marker.Color.r, v.Marker.Color.g, v.Marker.Color.b, v.Marker.Color.a, false, true, 2, false, false, false, false)
			end
		end

		for k,v in pairs(Config.ProcessingZone) do
			if(GetDistanceBetweenCoords(coords, v.Marker.Pos.x, v.Marker.Pos.y, v.Marker.Pos.z, true) < v.Marker.SizeMark) then
				IsInMarkerProcess  = true
				CurrentZone = v
				CurrentTextHelper = v.Text.TextHelper
			end
		end
		
		if IsInMarkerProcess and not IsProcessing and not IsOpenMenu then
			ESX.ShowHelpNotification(CurrentTextHelper)
			if IsControlJustPressed(0, Config.Key['E']) then
				if CurrentZone.MultileItems then
					AddMenuProcessMain(CurrentZone)
					IsOpenMenu = true
				else
					ESX.TriggerServerCallback("meeta_processing:CheckPolice", function(result)
		
						if result == true  then 
							ProcessObject(CurrentZone)
						else
							TriggerEvent("pNotify:SendNotification", {
								text = '<strong class="red-text">ตำรวจไม่พอ</strong>',
								type = "error",
								timeout = 3000,
								layout = "bottomCenter",
								queue = "global"
							})
						end
				
					end, CurrentZone.PoliceCount)
				end
				
			end
		end

	end
end)

function AddMenuProcessFunction(CurrentZone)
	local playerPed = PlayerPedId()
	ESX.TriggerServerCallback("meeta_processing:getPlayerInventory", function(data)
		local elements = {}
		inventory = data.inventory
		for i=1, #CurrentZone.Items, 1 do
			Count = 0
			if inventory ~= nil then
				for key, value in pairs(inventory) do
					if inventory[key].name == CurrentZone.Items[i].ItemName then
						Count = inventory[key].count
						break
					end
				end

				if Count > 0 then 

					if CurrentZone.Items[i].OnceProcessing then
						PreviewCount = Count
						GetCount = math.floor(Count/CurrentZone.Items[i].ItemCount)
					else
						PreviewCount = CurrentZone.Items[i].ItemCount
						GetCount = math.floor(CurrentZone.Items[i].Get.ItemCount)
					end

					local data = {
						label     = CurrentZone.Items[i].Text .." <strong class='blue-text'>x"..math.floor(PreviewCount).. "</strong> ได้รับ "..CurrentZone.Items[i].Get.Text .."<strong class='green-text'> x"..GetCount .." " ..CurrentZone.Items[i].Get.Unit.."</strong>",
						name      = i,
						value     = 1,
						zone 	 = CurrentZone,
					}
					table.insert(elements, data)
				else
					-- Not have items
					table.insert(elements, {
						label = CurrentZone.Items[i].Text_NotHave
					})
				end
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'process_dialog', {
			title    = CurrentZone.Text.SubTitle,
			align    = 'top-left',
			elements = elements
		}, function(data, menu) -- OnEnter


			if data.current.zone then
				menu.close()

				-- Play Animation
				if CurrentZone.Animation.Scenario then
					TaskStartScenarioInPlace(playerPed, data.current.zone.Animation.AnimationScene, 0, false)
				else
					ESX.Streaming.RequestAnimDict(data.current.zone.Animation.AnimationDirect, function()
						TaskPlayAnim(GetPlayerPed(-1), data.current.zone.Animation.AnimationDirect, data.current.zone.Animation.AnimationScene, 8.0, -8.0, -1, 0, 0, false, false, false)
					end)							
				end

				-- Show TexT Processing
				ESX.ShowHelpNotification(data.current.zone.Text.ProcessText)
				-- Wait Processing
				Wait(data.current.zone.WaitProcessing)
				-- Processing Success
				TriggerServerEvent('meeta_processing:ProccessFunction', data.current.name, data.current.zone)
				-- Clear Animation
				ClearPedTasks(playerPed)
				-- Exit Menu

				IsOpenMenu = false
			else
				menu.close()
				IsOpenMenu = false
			end
			

		end, function(data, menu)
			menu.close()
			IsOpenMenu = false
		end, function(data, menu)

		end)

	end, GetPlayerServerId(PlayerId()))
end

function AddMenuProcessMain(CurrentZone)

	ESX.TriggerServerCallback("meeta_processing:CheckPolice", function(result)
		
		if result == true  then 
			AddMenuProcessFunction(CurrentZone)
		else
			local elements = {}
			table.insert(elements, {
				label = '<strong class="red-text">ตำรวจไม่พอ</strong>'
			})

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'processing_dialog', {
				title    = CurrentZone.Text.SubTitle,
				align    = 'top-left',
				elements = elements
			}, function(data, menu) -- OnEnter
				
			end, function(data, menu)
				menu.close()
				IsOpenMenu = false
			end, function(data, menu)
	
			end)

		end

	end, CurrentZone.PoliceCount)


end

RegisterNetEvent("meeta_processing:animation")
AddEventHandler("meeta_processing:animation", function(animation)
	IsProcessing = true
	local playerPed = PlayerPedId()
	TaskStartScenarioInPlace(playerPed, animation, false, false)
	Citizen.Wait(10000)
	IsProcessing = false
	ClearPedTasks(playerPed)
end)