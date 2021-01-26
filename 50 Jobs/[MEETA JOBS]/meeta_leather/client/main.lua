-- EDIT AND RECODE BY THANAWUT PROMRAUNGDET

ESX = nil
Isworking = false
ProtectSpam = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end

	ScriptLoaded()
end)

-- Create Blips
Citizen.CreateThread(function()

	local ConfigLocation = Config.Zone
	local blip1 = AddBlipForCoord(ConfigLocation.Pos.x, ConfigLocation.Pos.y, ConfigLocation.Pos.z)

	SetBlipSprite (blip1, ConfigLocation.Blips.Id)
	SetBlipDisplay(blip1, 4)
	SetBlipScale  (blip1, ConfigLocation.Blips.Size)
	SetBlipColour (blip1, ConfigLocation.Blips.Color)
	SetBlipAsShortRange(blip1, true)

	AddTextEntry('BLIP_LEATHER', Config.Zone.Blips.Text)
	BeginTextCommandSetBlipName("BLIP_LEATHER")
	EndTextCommandSetBlipName(blip1)

end)

function ScriptLoaded()
	Citizen.Wait(1000)
	LoadWorking()
end

local AnimalsInSession = {}

local OnGoingHuntSession = false

function LoadWorking()

	LoadModel('a_c_cow')
	LoadAnimDict('amb@medic@standing@kneel@base')
	LoadAnimDict('anim@gangops@facility@servers@bodysearch@')

	Citizen.CreateThread(function()
		while true do

			local coords = GetEntityCoords(GetPlayerPed(-1))
			local Pos = Config.Zone.Pos
			local Marker = Config.Zone.Marker

			if(GetDistanceBetweenCoords(coords, Pos.x, Pos.y, Pos.z, true) < Marker.DrawSize) then
				DrawMarker(Marker.Id, Pos.x, Pos.y, Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Marker.Size.x, Marker.Size.y, Marker.Size.z, Marker.Color.r, Marker.Color.g, Marker.Color.b, Marker.Color.a, false, true, 2, false, false, false, false)
			end

			local isInMarker  = false

			if(GetDistanceBetweenCoords(coords, Pos.x, Pos.y, Pos.z, true) < Marker.Size.x) then
				isInMarker  = true
			end

			if isInMarker and not ProtectSpam then
				if OnGoingHuntSession == false then
					ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to ~g~Start ~w~work.')
					if IsControlJustPressed(0, Config.Key['E']) then
						StartHuntingSession()
					end
				else
					ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to ~r~Stop ~w~work.')
					if IsControlJustPressed(0, Config.Key['E']) then
						StartHuntingSession()
					end
				end
			end

			Citizen.Wait(10)
		end
	end)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if Isworking then
			DisableControlAction(0,Config.Key['G'], true)
			EnableControlAction(0, Config.Key['T'], true)
			EnableControlAction(0, Config.Key['E'], true)
			EnableControlAction(0, Config.Key['DELETE'], true)
			EnableControlAction(0, Config.Key['F2'], true)
			EnableControlAction(0, Config.Key['X'], true)
		else
			Citizen.Wait(500)
		end
	end
end)

function StartHuntingSession()

	if OnGoingHuntSession then

		OnGoingHuntSession = false

		for index, value in pairs(AnimalsInSession) do
			if DoesEntityExist(value.id) then
				DeleteEntity(value.id)
			end
		end

	else
		OnGoingHuntSession = true

		Citizen.CreateThread(function()

				
			for index, value in pairs(Config.AnimalPosition) do

				ProtectSpam = true

				local Ped = PlayerPedId()
				local Animal = CreatePed(5, GetHashKey('a_c_cow'), value.x, value.y, value.z, 0.0, false, false)
				Citizen.Wait(1000)
				TaskSmartFleePed(Animal, Ped, 9000.0, -1, false, false)

				local AnimalBlip = AddBlipForEntity(Animal)
				SetBlipSprite(AnimalBlip, 153)
				SetBlipColour(AnimalBlip, 1)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString('Cow - Animal')
				EndTextCommandSetBlipName(AnimalBlip)

				table.insert(AnimalsInSession, {id = Animal, x = value.x, y = value.y, z = value.z, Blipid = AnimalBlip})

				if next(Config.AnimalPosition,index) == nil then
					ProtectSpam = false
				end
			end

			while OnGoingHuntSession do
				local sleep = 500
				for index, value in ipairs(AnimalsInSession) do
					if DoesEntityExist(value.id) then
						local AnimalCoords = GetEntityCoords(value.id)
						local PlyCoords = GetEntityCoords(PlayerPedId())
						local AnimalHealth = GetEntityHealth(value.id)
						
						local PlyToAnimal = GetDistanceBetweenCoords(PlyCoords, AnimalCoords, true)

						if PlyToAnimal < 2.0 then
							sleep = 10
							
							ESX.Game.Utils.DrawText3D({x = AnimalCoords.x, y = AnimalCoords.y, z = AnimalCoords.z + 1}, 'กด [G] ฆ่าวัว', 0.8)

							if IsControlJustReleased(0, Config.Key['G']) then
								if DoesEntityExist(value.id) then
									SetEntityHealth(value.id, 0)
									table.remove(AnimalsInSession, index)
									SlaughterAnimal(value.id)
								end
							end
						end
					end
				end

				Citizen.Wait(sleep)

			end
				
		end)
	end
end

function SlaughterAnimal(AnimalId)

	TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
	TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
	Isworking = true
	Citizen.Wait(5000)

	ClearPedTasksImmediately(PlayerPedId())

	local AnimalWeight = math.random(10, 160) / 10

	TriggerServerEvent('meeta_leather:reward', AnimalWeight)
	
	Isworking = false
	
	DeleteEntity(AnimalId)
end

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end    
end

function LoadModel(model)
    while not HasModelLoaded(model) do
          RequestModel(model)
          Citizen.Wait(10)
    end
end