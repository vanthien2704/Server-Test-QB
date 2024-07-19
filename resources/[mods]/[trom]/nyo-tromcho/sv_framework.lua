if Config.Framework == "QBCore" then 
	CoreName = exports['qb-core']:GetCoreObject()
else 
	if Config.Pepev6 then 
		CoreName = exports["pepe-core"]:GetCoreObject()
	else 
		Framework = nil
		TriggerEvent(''..Config.Framework..':GetObject', function(obj) CoreName = obj end)
	end 
end 
