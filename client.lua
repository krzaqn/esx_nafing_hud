local ESX	 = nil
local currLevel = 2
-- ESX
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	SendNUIMessage({
		action = 'voice',
		prox = 2
	})
	NetworkSetTalkerProximity(2.5)
	DisplayRadar(false)
end)


Citizen.CreateThread(function()
	Citizen.Wait(500)
	while true do
		Citizen.Wait(500)
		local health = (GetEntityHealth(GetPlayerPed(-1)) -100)
		local armor = GetPedArmour(GetPlayerPed(-1)) 
	
		SendNUIMessage({action = "hud",
						health = health,
						armor = armor,
						thirst = thrist,
						hunger = hunger,
						})

		TriggerEvent('esx_status:getStatus', 'thirst', function(status)
			thrist = status.getPercent()
		end)
		
		TriggerEvent('esx_status:getStatus', 'hunger', function(status)
			hunger = status.getPercent()
		end)
	end
end)

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
		if NetworkIsPlayerTalking(PlayerId()) then
			SendNUIMessage({
				action = 'voice-color',
				isTalking = 100
			})
		else
			SendNUIMessage({
				action = 'voice-color',
				isTalking = 0
			})
		end

		if IsControlJustReleased(1, 20) then
			currLevel = (currLevel + 1) % 3
			if currLevel == 0 then
				SendNUIMessage({
					action = 'voice',
					prox = 0
				})
				vol = 26.0
				print("shout", vol)
			elseif currLevel == 1 then
				SendNUIMessage({
					action = 'voice',
					prox = 1
				})
				vol = 10.0
				print("normal", vol)
			elseif currLevel == 2 then
				SendNUIMessage({
					action = 'voice',
					prox = 2
				})
				vol = 2.5
				print("whisper", vol)
			end
			NetworkSetTalkerProximity(vol)
		end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustReleased(0, 344) then  -- "F11"
			showUi = not showUi
			if showUi then
				SendNUIMessage({
					action = 'showui'
				})
			else
				SendNUIMessage({
					action = 'hideui'
				})
			end
        end
    end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		local ped = GetPlayerPed(-1)
		
		if IsPedInAnyVehicle(ped, false) then
			DisplayRadar(true)
			local inCar = GetVehiclePedIsIn(ped, false)
			carSpeed = math.ceil(GetEntitySpeed(inCar) * 1.23)
			fuel = math.floor(GetVehicleFuelLevel(inCar)+0.0)	
			SendNUIMessage({
				action = 'car',
				showhud = true,
				speed = carSpeed,
				fuel = fuel,
			})
		else
			DisplayRadar(false)
			SendNUIMessage({
				action = 'car',
				showhud = false,
			})
		end
	end
end)
