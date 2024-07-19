LoggedIn = false
if Config.Framework == "QBCore" then 
	CoreName = exports['qb-core']:GetCoreObject()
	RegisterNetEvent(''..Config.Framework..':Client:OnPlayerLoaded', function()
		LoggedIn = true
	end)
	RegisterNetEvent(''..Config.Framework..':Client:OnPlayerUnload', function()
		LoggedIn = false
	end)
else 
	if Config.Pepev6 then 
		CoreName = exports["pepe-core"]:GetCoreObject()
	else 
		CoreName = nil
		Citizen.CreateThread(function()
			while true do
				Citizen.Wait(10)
				if CoreName == nil then
					TriggerEvent(''..Config.Framework..':GetObject', function(obj) CoreName = obj end)
					Citizen.Wait(200)
				end
			end
		end)
		RegisterNetEvent(''..Config.Framework..':Client:OnPlayerLoaded', function()
			LoggedIn = true
		end)
		RegisterNetEvent(''..Config.Framework..':Client:OnPlayerUnload', function()
			LoggedIn = false
		end)
	end 
end