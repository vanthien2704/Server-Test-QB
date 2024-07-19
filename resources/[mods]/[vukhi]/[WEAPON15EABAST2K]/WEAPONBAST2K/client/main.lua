sleep = 2000

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(sleep)
			
			  -- WEAPON BAT --
			
			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_BOARDWALK') then
				sleep = 5
				N_0x4757f00bc6323cfe(GetHashKey("WEAPON_BOARDWALK"), Config.DAMAGEBOARDWALK)
			end

			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_COMET') then
				sleep = 5
				N_0x4757f00bc6323cfe(GetHashKey("WEAPON_COMET"), Config.DAMAGECOMET)
			end

			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_CYBER') then
				sleep = 5
				N_0x4757f00bc6323cfe(GetHashKey("WEAPON_CYBER"), Config.DAMAGECYBER)
			end
			
			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_DANCER') then
				sleep = 5
				N_0x4757f00bc6323cfe(GetHashKey("WEAPON_DANCER"), Config.DAMAGEDANCER)
			end

			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_GHOSTHUNTER') then
				sleep = 5
				N_0x4757f00bc6323cfe(GetHashKey("WEAPON_GHOSTHUNTER"), Config.DAMAGEGHOSTHUNTER)
			end

			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_GRIM') then
				sleep = 5
				N_0x4757f00bc6323cfe(GetHashKey("WEAPON_GRIM"), Config.DAMAGEGRIM)
			end

			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_GUANYU') then
				sleep = 5
				N_0x4757f00bc6323cfe(GetHashKey("WEAPON_GUANYU"), Config.DAMAGEGUANYU)
			end

			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_KATANAWOMBAT') then
				sleep = 5
				N_0x4757f00bc6323cfe(GetHashKey("WEAPON_KATANAWOMBAT"), Config.DAMAGEKATANAWOMBAT)
			end
			
			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_PUNKKOI') then
				sleep = 5
				N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PUNKKOI"), Config.DAMAGEPUNKKOI)
			end

			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_SAMURAI') then
				sleep = 5
				N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SAMURAI"), Config.DAMAGESAMURAI)
			end

			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_SAMURAIULTRA') then
				sleep = 5
				N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SAMURAIULTRA"), Config.DAMAGESAMURAIULTRA)
			end

			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_SLIPPER') then
				sleep = 5
				N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SLIPPER"), Config.DAMAGESLIPPER)
			end

			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_VIVID') then
				sleep = 5
				N_0x4757f00bc6323cfe(GetHashKey("WEAPON_VIVID"), Config.DAMAGEVIVID)
			end
			
			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_WOLF') then
				sleep = 5
				N_0x4757f00bc6323cfe(GetHashKey("WEAPON_WOLF"), Config.DAMAGEWOLF)
			end

			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_WUKONG') then
				sleep = 5
				N_0x4757f00bc6323cfe(GetHashKey("WEAPON_WUKONG"), Config.DAMAGEWUKONG)
			end
			
			
			
	end
end)



Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(500)
			
		    -- WEAPON BAT --
			
			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_BOARDWALK') then
				EffectFire = true
				EffectThunder = false	
				WhiteNeon = false
				Effectpur = false
				EffectThor = false
			end

			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_COMET') then
				EffectFire = true
				EffectThunder = false	
				WhiteNeon = false
				Effectpur = false
				EffectThor = false
			end

			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_CYBER') then
				EffectFire = true
				EffectThunder = false	
				WhiteNeon = false
				Effectpur = false
				EffectThor = false
			end

			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_DANCER') then
				EffectFire = true
				EffectThunder = false	
				WhiteNeon = false
				Effectpur = false
				EffectThor = false
			end

			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_GHOSTHUNTER') then
				EffectFire = true
				EffectThunder = false	
				WhiteNeon = false
				Effectpur = false
				EffectThor = false
			end

			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_GRIM') then
				EffectFire = true
				EffectThunder = false	
				WhiteNeon = false
				Effectpur = false
				EffectThor = false
			end

			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_GUANYU') then
				EffectFire = true
				EffectThunder = false	
				WhiteNeon = false
				Effectpur = false
				EffectThor = false
			end

			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_KATANAWOMBAT') then
				EffectFire = true
				EffectThunder = false	
				WhiteNeon = false
				Effectpur = false
				EffectThor = false
			end

			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_GHOSTHUNTER') then
				EffectFire = true
				EffectThunder = false	
				WhiteNeon = false
				Effectpur = false
				EffectThor = false
			end

			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_PUNKKOI') then
				EffectFire = true
				EffectThunder = false	
				WhiteNeon = false
				Effectpur = false
				EffectThor = false
			end

			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_SAMURAI') then
				EffectFire = true
				EffectThunder = false	
				WhiteNeon = false
				Effectpur = false
				EffectThor = false
			end

			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_SAMURAIULTRA') then
				EffectFire = true
				EffectThunder = false	
				WhiteNeon = false
				Effectpur = false
				EffectThor = false
			end

			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_SLIPPER') then
				EffectFire = true
				EffectThunder = false	
				WhiteNeon = false
				Effectpur = false
				EffectThor = false
			end

			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_VIVID') then
				EffectFire = true
				EffectThunder = false	
				WhiteNeon = false
				Effectpur = false
				EffectThor = false
			end

			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_WOLF') then
				EffectFire = true
				EffectThunder = false	
				WhiteNeon = false
				Effectpur = false
				EffectThor = false
			end

			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_WUKONG') then
				EffectFire = true
				EffectThunder = false	
				WhiteNeon = false
				Effectpur = false
				EffectThor = false
			end


			
			
		    -- WEAPON BAT --
		       
		 
	if Config.EffectBOARDWALK then	
		if EffectFire then
			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_BOARDWALK') then
				 
				local Host = "scr_powerplay"
				local Name = "sp_powerplay_beast_appear_trails"
				RequestNamedPtfxAsset(Host)
				while not HasNamedPtfxAssetLoaded(Host) do
					Citizen.Wait(0)
				end
				SetPtfxAssetNextCall(Host) 
				StartNetworkedParticleFxNonLoopedOnPedBone(Name, GetPlayerPed(-1) , 0.1, 0.1, 0.06, 0.0, -90.0, 80.0, 57005, 0.30, false, false, false)	
			end
			Wait(100)
			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_BOARDWALK') then
				 
				local Host = "scr_powerplay"
				local Name = "sp_powerplay_beast_appear_trails"
				RequestNamedPtfxAsset(Host)
				while not HasNamedPtfxAssetLoaded(Host) do
					Citizen.Wait(0)
				end
				SetPtfxAssetNextCall(Host) 
				StartNetworkedParticleFxNonLoopedOnPedBone(Name, GetPlayerPed(-1) , 0.1, 0.1, 0.08, 0.0, -90.0, 80.0, 57005, 0.30, false, false, false)	
			end
			Wait(100)
				else
					Citizen.Wait(400)
			end
		end


		
		if Config.EffectCOMET then	
			if EffectFire then
				if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_COMET') then
					 
					local Host = "scr_powerplay"
					local Name = "sp_powerplay_beast_appear_trails"
					RequestNamedPtfxAsset(Host)
					while not HasNamedPtfxAssetLoaded(Host) do
						Citizen.Wait(0)
					end
					SetPtfxAssetNextCall(Host) 
					StartNetworkedParticleFxNonLoopedOnPedBone(Name, GetPlayerPed(-1) , 0.1, 0.1, 0.06, 0.0, -90.0, 80.0, 57005, 0.30, false, false, false)	
				end
				Wait(100)
				if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_COMET') then
					 
					local Host = "scr_powerplay"
					local Name = "sp_powerplay_beast_appear_trails"
					RequestNamedPtfxAsset(Host)
					while not HasNamedPtfxAssetLoaded(Host) do
						Citizen.Wait(0)
					end
					SetPtfxAssetNextCall(Host) 
					StartNetworkedParticleFxNonLoopedOnPedBone(Name, GetPlayerPed(-1) , 0.1, 0.1, 0.08, 0.0, -90.0, 80.0, 57005, 0.30, false, false, false)	
				end
				Wait(100)
					else
						Citizen.Wait(400)
				end
			end
		
		
		
		if Config.EffectCYBER then	
			if EffectFire then
				if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_CYBER') then
						 
					local Host = "scr_powerplay"
					local Name = "sp_powerplay_beast_appear_trails"
					RequestNamedPtfxAsset(Host)
					while not HasNamedPtfxAssetLoaded(Host) do
						Citizen.Wait(0)
					end
					SetPtfxAssetNextCall(Host) 
					StartNetworkedParticleFxNonLoopedOnPedBone(Name, GetPlayerPed(-1) , 0.1, 0.1, 0.06, 0.0, -90.0, 80.0, 57005, 0.30, false, false, false)	
				end
				Wait(100)
				if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_CYBER') then
						 
					local Host = "scr_powerplay"
					local Name = "sp_powerplay_beast_appear_trails"
					RequestNamedPtfxAsset(Host)
					while not HasNamedPtfxAssetLoaded(Host) do
						Citizen.Wait(0)
					end
					SetPtfxAssetNextCall(Host) 
					StartNetworkedParticleFxNonLoopedOnPedBone(Name, GetPlayerPed(-1) , 0.1, 0.1, 0.08, 0.0, -90.0, 80.0, 57005, 0.30, false, false, false)	
				end
				Wait(100)
					else
						Citizen.Wait(400)
				end
			end


	if Config.EffectDANCER then	
		if EffectFire then
			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_DANCER') then
				 
				local Host = "scr_powerplay"
				local Name = "sp_powerplay_beast_appear_trails"
				RequestNamedPtfxAsset(Host)
				while not HasNamedPtfxAssetLoaded(Host) do
					Citizen.Wait(0)
				end
				SetPtfxAssetNextCall(Host) 
				StartNetworkedParticleFxNonLoopedOnPedBone(Name, GetPlayerPed(-1) , 0.1, 0.1, 0.06, 0.0, -90.0, 80.0, 57005, 0.30, false, false, false)	
			end
			Wait(100)
			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_DANCER') then
				 
				local Host = "scr_powerplay"
				local Name = "sp_powerplay_beast_appear_trails"
				RequestNamedPtfxAsset(Host)
				while not HasNamedPtfxAssetLoaded(Host) do
					Citizen.Wait(0)
				end
				SetPtfxAssetNextCall(Host) 
				StartNetworkedParticleFxNonLoopedOnPedBone(Name, GetPlayerPed(-1) , 0.1, 0.1, 0.08, 0.0, -90.0, 80.0, 57005, 0.30, false, false, false)	
			end
			Wait(100)
				else
					Citizen.Wait(400)
			end
		end


		
		if Config.EffectGHOSTHUNTER then	
			if EffectFire then
				if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_GHOSTHUNTER') then
					 
					local Host = "scr_powerplay"
					local Name = "sp_powerplay_beast_appear_trails"
					RequestNamedPtfxAsset(Host)
					while not HasNamedPtfxAssetLoaded(Host) do
						Citizen.Wait(0)
					end
					SetPtfxAssetNextCall(Host) 
					StartNetworkedParticleFxNonLoopedOnPedBone(Name, GetPlayerPed(-1) , 0.1, 0.1, 0.06, 0.0, -90.0, 80.0, 57005, 0.30, false, false, false)	
				end
				Wait(100)
				if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_GHOSTHUNTER') then
					 
					local Host = "scr_powerplay"
					local Name = "sp_powerplay_beast_appear_trails"
					RequestNamedPtfxAsset(Host)
					while not HasNamedPtfxAssetLoaded(Host) do
						Citizen.Wait(0)
					end
					SetPtfxAssetNextCall(Host) 
					StartNetworkedParticleFxNonLoopedOnPedBone(Name, GetPlayerPed(-1) , 0.1, 0.1, 0.08, 0.0, -90.0, 80.0, 57005, 0.30, false, false, false)	
				end
				Wait(100)
					else
						Citizen.Wait(400)
				end
			end
		
		
		
		if Config.EffectGRIM then	
			if EffectFire then
				if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_GRIM') then
						 
					local Host = "scr_powerplay"
					local Name = "sp_powerplay_beast_appear_trails"
					RequestNamedPtfxAsset(Host)
					while not HasNamedPtfxAssetLoaded(Host) do
						Citizen.Wait(0)
					end
					SetPtfxAssetNextCall(Host) 
					StartNetworkedParticleFxNonLoopedOnPedBone(Name, GetPlayerPed(-1) , 0.1, 0.1, 0.06, 0.0, -90.0, 80.0, 57005, 0.30, false, false, false)	
				end
				Wait(100)
				if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_GRIM') then
						 
					local Host = "scr_powerplay"
					local Name = "sp_powerplay_beast_appear_trails"
					RequestNamedPtfxAsset(Host)
					while not HasNamedPtfxAssetLoaded(Host) do
						Citizen.Wait(0)
					end
					SetPtfxAssetNextCall(Host) 
					StartNetworkedParticleFxNonLoopedOnPedBone(Name, GetPlayerPed(-1) , 0.1, 0.1, 0.08, 0.0, -90.0, 80.0, 57005, 0.30, false, false, false)	
				end
				Wait(100)
					else
						Citizen.Wait(400)
				end
			end
				

	if Config.EffectGUANYU then	
		if EffectFire then
			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_GUANYU') then
				 
				local Host = "scr_powerplay"
				local Name = "sp_powerplay_beast_appear_trails"
				RequestNamedPtfxAsset(Host)
				while not HasNamedPtfxAssetLoaded(Host) do
					Citizen.Wait(0)
				end
				SetPtfxAssetNextCall(Host) 
				StartNetworkedParticleFxNonLoopedOnPedBone(Name, GetPlayerPed(-1) , 0.1, 0.1, 0.06, 0.0, -90.0, 80.0, 57005, 0.30, false, false, false)	
			end
			Wait(100)
			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_GUANYU') then
				 
				local Host = "scr_powerplay"
				local Name = "sp_powerplay_beast_appear_trails"
				RequestNamedPtfxAsset(Host)
				while not HasNamedPtfxAssetLoaded(Host) do
					Citizen.Wait(0)
				end
				SetPtfxAssetNextCall(Host) 
				StartNetworkedParticleFxNonLoopedOnPedBone(Name, GetPlayerPed(-1) , 0.1, 0.1, 0.08, 0.0, -90.0, 80.0, 57005, 0.30, false, false, false)	
			end
			Wait(100)
				else
					Citizen.Wait(400)
			end
		end


		
		if Config.EffectKATANAWOMBAT then	
			if EffectFire then
				if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_KATANAWOMBAT') then
					 
					local Host = "scr_powerplay"
					local Name = "sp_powerplay_beast_appear_trails"
					RequestNamedPtfxAsset(Host)
					while not HasNamedPtfxAssetLoaded(Host) do
						Citizen.Wait(0)
					end
					SetPtfxAssetNextCall(Host) 
					StartNetworkedParticleFxNonLoopedOnPedBone(Name, GetPlayerPed(-1) , 0.1, 0.1, 0.06, 0.0, -90.0, 80.0, 57005, 0.30, false, false, false)	
				end
				Wait(100)
				if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_KATANAWOMBAT') then
					 
					local Host = "scr_powerplay"
					local Name = "sp_powerplay_beast_appear_trails"
					RequestNamedPtfxAsset(Host)
					while not HasNamedPtfxAssetLoaded(Host) do
						Citizen.Wait(0)
					end
					SetPtfxAssetNextCall(Host) 
					StartNetworkedParticleFxNonLoopedOnPedBone(Name, GetPlayerPed(-1) , 0.1, 0.1, 0.08, 0.0, -90.0, 80.0, 57005, 0.30, false, false, false)	
				end
				Wait(100)
					else
						Citizen.Wait(400)
				end
			end
		
		
		
		if Config.EffectPUNKKOI then	
			if EffectFire then
				if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_PUNKKOI') then
						 
					local Host = "scr_powerplay"
					local Name = "sp_powerplay_beast_appear_trails"
					RequestNamedPtfxAsset(Host)
					while not HasNamedPtfxAssetLoaded(Host) do
						Citizen.Wait(0)
					end
					SetPtfxAssetNextCall(Host) 
					StartNetworkedParticleFxNonLoopedOnPedBone(Name, GetPlayerPed(-1) , 0.1, 0.1, 0.06, 0.0, -90.0, 80.0, 57005, 0.30, false, false, false)	
				end
				Wait(100)
				if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_PUNKKOI') then
						 
					local Host = "scr_powerplay"
					local Name = "sp_powerplay_beast_appear_trails"
					RequestNamedPtfxAsset(Host)
					while not HasNamedPtfxAssetLoaded(Host) do
						Citizen.Wait(0)
					end
					SetPtfxAssetNextCall(Host) 
					StartNetworkedParticleFxNonLoopedOnPedBone(Name, GetPlayerPed(-1) , 0.1, 0.1, 0.08, 0.0, -90.0, 80.0, 57005, 0.30, false, false, false)	
				end
				Wait(100)
					else
						Citizen.Wait(400)
				end
			end


	if Config.EffectSAMURAI then	
		if EffectFire then
			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_SAMURAI') then
				 
				local Host = "scr_powerplay"
				local Name = "sp_powerplay_beast_appear_trails"
				RequestNamedPtfxAsset(Host)
				while not HasNamedPtfxAssetLoaded(Host) do
					Citizen.Wait(0)
				end
				SetPtfxAssetNextCall(Host) 
				StartNetworkedParticleFxNonLoopedOnPedBone(Name, GetPlayerPed(-1) , 0.1, 0.1, 0.06, 0.0, -90.0, 80.0, 57005, 0.30, false, false, false)	
			end
			Wait(100)
			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_SAMURAI') then
				 
				local Host = "scr_powerplay"
				local Name = "sp_powerplay_beast_appear_trails"
				RequestNamedPtfxAsset(Host)
				while not HasNamedPtfxAssetLoaded(Host) do
					Citizen.Wait(0)
				end
				SetPtfxAssetNextCall(Host) 
				StartNetworkedParticleFxNonLoopedOnPedBone(Name, GetPlayerPed(-1) , 0.1, 0.1, 0.08, 0.0, -90.0, 80.0, 57005, 0.30, false, false, false)	
			end
			Wait(100)
				else
					Citizen.Wait(400)
			end
		end


		
		if Config.EffectSAMURAIULTRA then	
			if EffectFire then
				if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_SAMURAIULTRA') then
					 
					local Host = "scr_powerplay"
					local Name = "sp_powerplay_beast_appear_trails"
					RequestNamedPtfxAsset(Host)
					while not HasNamedPtfxAssetLoaded(Host) do
						Citizen.Wait(0)
					end
					SetPtfxAssetNextCall(Host) 
					StartNetworkedParticleFxNonLoopedOnPedBone(Name, GetPlayerPed(-1) , 0.1, 0.1, 0.06, 0.0, -90.0, 80.0, 57005, 0.30, false, false, false)	
				end
				Wait(100)
				if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_SAMURAIULTRA') then
					 
					local Host = "scr_powerplay"
					local Name = "sp_powerplay_beast_appear_trails"
					RequestNamedPtfxAsset(Host)
					while not HasNamedPtfxAssetLoaded(Host) do
						Citizen.Wait(0)
					end
					SetPtfxAssetNextCall(Host) 
					StartNetworkedParticleFxNonLoopedOnPedBone(Name, GetPlayerPed(-1) , 0.1, 0.1, 0.08, 0.0, -90.0, 80.0, 57005, 0.30, false, false, false)	
				end
				Wait(100)
					else
						Citizen.Wait(400)
				end
			end
		
		
		
		if Config.EffectSLIPPER then	
			if EffectFire then
				if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_SLIPPER') then
						 
					local Host = "scr_powerplay"
					local Name = "sp_powerplay_beast_appear_trails"
					RequestNamedPtfxAsset(Host)
					while not HasNamedPtfxAssetLoaded(Host) do
						Citizen.Wait(0)
					end
					SetPtfxAssetNextCall(Host) 
					StartNetworkedParticleFxNonLoopedOnPedBone(Name, GetPlayerPed(-1) , 0.1, 0.1, 0.06, 0.0, -90.0, 80.0, 57005, 0.30, false, false, false)	
				end
				Wait(100)
				if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_SLIPPER') then
						 
					local Host = "scr_powerplay"
					local Name = "sp_powerplay_beast_appear_trails"
					RequestNamedPtfxAsset(Host)
					while not HasNamedPtfxAssetLoaded(Host) do
						Citizen.Wait(0)
					end
					SetPtfxAssetNextCall(Host) 
					StartNetworkedParticleFxNonLoopedOnPedBone(Name, GetPlayerPed(-1) , 0.1, 0.1, 0.08, 0.0, -90.0, 80.0, 57005, 0.30, false, false, false)	
				end
				Wait(100)
					else
						Citizen.Wait(400)
				end
			end		
		
		
		if Config.EffectVIVID then	
			if EffectFire then
				if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_VIVID') then
						 
					local Host = "scr_powerplay"
					local Name = "sp_powerplay_beast_appear_trails"
					RequestNamedPtfxAsset(Host)
					while not HasNamedPtfxAssetLoaded(Host) do
						Citizen.Wait(0)
					end
					SetPtfxAssetNextCall(Host) 
					StartNetworkedParticleFxNonLoopedOnPedBone(Name, GetPlayerPed(-1) , 0.1, 0.1, 0.06, 0.0, -90.0, 80.0, 57005, 0.30, false, false, false)	
				end
				Wait(100)
				if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_VIVID') then
						 
					local Host = "scr_powerplay"
					local Name = "sp_powerplay_beast_appear_trails"
					RequestNamedPtfxAsset(Host)
					while not HasNamedPtfxAssetLoaded(Host) do
						Citizen.Wait(0)
					end
					SetPtfxAssetNextCall(Host) 
					StartNetworkedParticleFxNonLoopedOnPedBone(Name, GetPlayerPed(-1) , 0.1, 0.1, 0.08, 0.0, -90.0, 80.0, 57005, 0.30, false, false, false)	
				end
				Wait(100)
					else
						Citizen.Wait(400)
				end
			end				

		
		if Config.EffectWOLF then	
			if EffectFire then
				if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_WOLF') then
						 
					local Host = "scr_powerplay"
					local Name = "sp_powerplay_beast_appear_trails"
					RequestNamedPtfxAsset(Host)
					while not HasNamedPtfxAssetLoaded(Host) do
						Citizen.Wait(0)
					end
					SetPtfxAssetNextCall(Host) 
					StartNetworkedParticleFxNonLoopedOnPedBone(Name, GetPlayerPed(-1) , 0.1, 0.1, 0.06, 0.0, -90.0, 80.0, 57005, 0.30, false, false, false)	
				end
				Wait(100)
				if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_WOLF') then
						 
					local Host = "scr_powerplay"
					local Name = "sp_powerplay_beast_appear_trails"
					RequestNamedPtfxAsset(Host)
					while not HasNamedPtfxAssetLoaded(Host) do
						Citizen.Wait(0)
					end
					SetPtfxAssetNextCall(Host) 
					StartNetworkedParticleFxNonLoopedOnPedBone(Name, GetPlayerPed(-1) , 0.1, 0.1, 0.08, 0.0, -90.0, 80.0, 57005, 0.30, false, false, false)	
				end
				Wait(100)
					else
						Citizen.Wait(400)
				end
			end				
		
		
		if Config.EffectWUKONG then	
			if EffectFire then
				if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_WUKONG') then
						 
					local Host = "scr_powerplay"
					local Name = "sp_powerplay_beast_appear_trails"
					RequestNamedPtfxAsset(Host)
					while not HasNamedPtfxAssetLoaded(Host) do
						Citizen.Wait(0)
					end
					SetPtfxAssetNextCall(Host) 
					StartNetworkedParticleFxNonLoopedOnPedBone(Name, GetPlayerPed(-1) , 0.1, 0.1, 0.06, 0.0, -90.0, 80.0, 57005, 0.30, false, false, false)	
				end
				Wait(100)
				if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_WUKONG') then
						 
					local Host = "scr_powerplay"
					local Name = "sp_powerplay_beast_appear_trails"
					RequestNamedPtfxAsset(Host)
					while not HasNamedPtfxAssetLoaded(Host) do
						Citizen.Wait(0)
					end
					SetPtfxAssetNextCall(Host) 
					StartNetworkedParticleFxNonLoopedOnPedBone(Name, GetPlayerPed(-1) , 0.1, 0.1, 0.08, 0.0, -90.0, 80.0, 57005, 0.30, false, false, false)	
				end
				Wait(100)
					else
						Citizen.Wait(400)
				end
			end		
		
		
		
		
	
		
		
		
		
	
		
		
		
		
		

		
		
		
		
		
		
		
		
		
		
		
		

		
		
	
		
		



	
		 

			
	end
end)

