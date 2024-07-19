local zone = nil
local blip = nil
hasAlreadyEnteredMarker, isInMarker = false, false

Citizen.CreateThread(function()
	Citizen.Wait(10)
	for _,new_zone in pairs(shark.zones) do
		
		zone = AddBlipForRadius(new_zone.coords.x, new_zone.coords.y, new_zone.coords.z, new_zone.zone.radius)
		SetBlipSprite(zone, 9)
		SetBlipAlpha(zone, 0)
		SetBlipColour(zone, new_zone.zone.color)
		
		if (new_zone.blip.draw == true) then
			blip = AddBlipForCoord(new_zone.coords.x, new_zone.coords.y, new_zone.coords.z)
			SetBlipSprite(blip, new_zone.blip.id)
			SetBlipColour(blip, new_zone.blip.color)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(new_zone.blip.text)
			EndTextCommandSetBlipName(blip)
		end
		
	end
end)

shark = {
	zones = {
		{
			coords = {x = 2851.4416, y = -652.9113, z = -0.474897},
			zone = {radius = 100.0, color = 32},
			v3 = vector3(2851.4416, -652.9113, -0.474897),
			blip = {draw = true, id = 0, color = 0, text = "VÙNG CÁ MẬP"}
		}
	}
	
}


Citizen.CreateThread(function()
Citizen.Wait(1000)
	while true do
        local sleep = 1000
		local coords = GetEntityCoords(PlayerPedId())
		isInMarker = false
		for k,v in pairs(shark.zones) do
			local distance = GetDistanceBetweenCoords(coords, v.coords.x, v.coords.y, v.coords.z, true)
			if distance < 200 then
			sleep = 10
				isInMarker = true
			end
end
		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
		end
		Citizen.Wait(sleep)
	end
end)