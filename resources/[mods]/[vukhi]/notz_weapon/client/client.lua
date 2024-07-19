print('\n^2 [Notz] Start Success')

local Notz2000s = false

RegisterNetEvent('fashion_notz:TRIDENT')
AddEventHandler('fashion_notz:TRIDENT', function ()
	if not EffectFire then
		--
		EffectFire = true
		Citizen.Wait(0)
		local prop1 = GetHashKey("WEAPON_TRIDENT")
		GiveWeaponToPed(PlayerPedId(), prop1,0, true, true)		
		
	else
		local prop1 = GetHashKey("WEAPON_TRIDENT")
		RemoveWeaponFromPed(PlayerPedId(), prop1, true, true)

		EffectFire = false
		
	end
end)

RegisterNetEvent('fashion_notz:Kanatasakura')
AddEventHandler('fashion_notz:Kanatasakura', function ()
	if not EffectThunder then
		--
		EffectThunder = true
		local prop2 = GetHashKey("WEAPON_NOTZSAKURA")
		GiveWeaponToPed(PlayerPedId(), prop2,0, true, true)
							
	else
		local prop2 = GetHashKey("WEAPON_NOTZSAKURA")
		RemoveWeaponFromPed(PlayerPedId(), prop2, true, true)
		
		EffectThunder = false
	end
end)

RegisterNetEvent('fashion_notz:Hammerblackpink')
AddEventHandler('fashion_notz:Hammerblackpink', function ()
	if not WhiteNeon then
		--
		WhiteNeon = true
		local prop3 = GetHashKey("WEAPON_BLACKPINK")
		GiveWeaponToPed(PlayerPedId(), prop3,0, true, true)
			
	else
		local prop3 = GetHashKey("WEAPON_BLACKPINK")
		RemoveWeaponFromPed(PlayerPedId(), prop3, true, true)
		
		WhiteNeon = false
		
	end
end)

RegisterNetEvent('fashion_notz:FANHAND')
AddEventHandler('fashion_notz:FANHAND', function ()
	if not Effectpur then
		--
		Effectpur = true
		local prop4 = GetHashKey("WEAPON_FANHAND")
		GiveWeaponToPed(PlayerPedId(), prop4,0, true, true)
			
	else
		local prop4 = GetHashKey("WEAPON_FANHAND")
		RemoveWeaponFromPed(PlayerPedId(), prop4, true, true)
		
		Effectpur = false
		
	end
end)

RegisterNetEvent('fashion_notz:HAMMERTHOR')
AddEventHandler('fashion_notz:HAMMERTHOR', function ()
	if not EffectThor then
		--
		EffectThor = true
		local prop5 = GetHashKey("WEAPON_HAMMERTHOR")
		GiveWeaponToPed(PlayerPedId(), prop5,0, true, true)
			
	else
		local prop5 = GetHashKey("WEAPON_HAMMERTHOR")
		RemoveWeaponFromPed(PlayerPedId(), prop5, true, true)
		
		EffectThor = false
		
	end
end)

RegisterNetEvent('fashion_notz:lightsaber')
AddEventHandler('fashion_notz:lightsaber', function ()
	if not EffectThor then
		--
		EffectThor1 = true
		local prop6 = GetHashKey("WEAPON_LIGHTSABER")
		GiveWeaponToPed(PlayerPedId(), prop6,0, true, true)
			
	else
		local prop6 = GetHashKey("WEAPON_LIGHTSABER")
		RemoveWeaponFromPed(PlayerPedId(), prop6, true, true)
		
		EffectThor1 = false
		
	end
end)
