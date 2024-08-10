local feedActive = true

local isDead = false
CreateThread(function()
	while true do
		local killed = GetPlayerPed(PlayerId())
		if IsEntityDead(killed) and not isDead then
			local killer = GetPedKiller(killed)
			if killer ~= 0 then
				if killer == killed then
					TriggerServerEvent('killfeed:client:selfKill')
				else
					local KillerNetwork = NetworkGetPlayerIndexFromPed(killer)
					if KillerNetwork == "**Invalid**" or KillerNetwork == -1 then
						TriggerServerEvent('killfeed:client:selfKill')
					else
						TriggerServerEvent('killfeed:server:announcKill', GetPlayerServerId(KillerNetwork))
					end
				end
			else
				TriggerServerEvent('killfeed:client:selfKill')
			end
			isDead = true
		end
		if not IsEntityDead(killed) then
			isDead = false
		end
		Wait(50)
	end
end)

RegisterNetEvent('killfeed:client:announcKill', function(source, killer, killStreak, type)
	if feedActive then
		SendNUIMessage({
			type = 'newKill',
			self = source,
			killer = killer,
			killStreak = tostring(killStreak),
			killType = type
		})
	end
end)

RegisterNetEvent('killfeed:client:selfKill')
AddEventHandler('killfeed:client:selfKill', function(killed)
	if feedActive then
		SendNUIMessage({
			type = 'newDeath',
			killed = killed,
		})
	end
end)

RegisterCommand('teszt', function()
	SendNUIMessage({
		type = 'newKill',
		self = 'Killed',
		killer = 'Killer',
		killStreak = '1',
		killType = 'kill'
	})
end, false)
