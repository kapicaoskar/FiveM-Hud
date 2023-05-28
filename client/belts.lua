
beltOn = false
beltStatus = true
AddEventHandler('blackout:display', function(status)
	beltStatus = status
end)

function seatbeltState()
    return beltOn
end

speedBuffer = {}
velocityBuffer = {}
Citizen.CreateThread(function()
    RequestStreamedTextureDict('mpinventory')
    while not HasStreamedTextureDictLoaded('mpinventory') do
        Citizen.Wait(100)
    end

	local timer = GetGameTimer()
	while true do
		Citizen.Wait(1)

		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped, false) then
			local vehicle = GetVehiclePedIsIn(ped, false)
			if vehicle ~= 0 and IsCar(vehicle, true) then
				if IsControlJustReleased(0, 305) then
					beltOn = not beltOn
					if beltOn then
						ESX.ShowNotification('Zapięto Pasy')
						SendNUIMessage({
							najs = "UpdateCarHud2",
							belt = true
						});
					else
						ESX.ShowNotification('Odpięto Pasy')
						SendNUIMessage({
							najs = "UpdateCarHud2",
							belt = false
						});
					end
				end

				if not beltStatus then
					--
				elseif beltOn then
					DisableControlAction(0, 75)
				else
					if (GetGameTimer() - timer) > 1000 then
						timer = GetGameTimer()
					elseif (GetGameTimer() - timer) > 500 then
					end
				end

				speedBuffer[2] = speedBuffer[1]
				speedBuffer[1] = GetEntitySpeed(vehicle)
				if speedBuffer[2] ~= nil and not beltOn and GetEntitySpeedVector(vehicle, true).y > 1.0 and speedBuffer[1] > 19.25 and (speedBuffer[2] - speedBuffer[1]) > (speedBuffer[1] * 0.255) then
					local hr = GetEntityHeading(entity) + 90.0
					if hr < 0.0 then
						hr = 360.0 + hr
					end

					hr = hr * 0.0174533
					local forward = { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
					local coords = GetEntityCoords(ped)

					SetEntityCoords(ped, coords.x + forward.x, coords.y + forward.y, coords.z - 0.47, true, true, true)
					SetEntityVelocity(ped, velocityBuffer[2].x, velocityBuffer[2].y, velocityBuffer[2].z)

					Citizen.Wait(1)
					SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
				end

				velocityBuffer[2] = velocityBuffer[1]
				velocityBuffer[1] = GetEntityVelocity(vehicle)
			end
		else
			beltOn = false
			speedBuffer[1], speedBuffer[2], velocityBuffer[1], velocityBuffer[2] = 0.0, 0.0, 0.0, 0.0
		end
	end
end)

function IsCar(v, ignoreBikes)
	if ignoreBikes and IsThisModelABike(GetEntityModel(v)) then
		return false
	end

	local vc = GetVehicleClass(v)
	return (vc >= 0 and vc <= 12) or vc == 17 or vc == 18 or vc == 20
end