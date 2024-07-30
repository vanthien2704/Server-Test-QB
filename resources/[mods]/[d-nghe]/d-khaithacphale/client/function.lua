QBCore = exports["qb-core"]:GetCoreObject()

spawnedCrab = 0
crabPlants = {}
isPickingUp = false
blipsZonesLoaded = false
onlineplayer = false

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
	CreateBlipsZones()
	Wait(5000)
	Citizen.CreateThread(function()
		Citizen.Wait(5000)

		local ped = PlayerPedId()
		while not onlineplayer do

			Citizen.Wait(10000)
			onlineplayer = true
			break
		end
	end)
end)

AddEventHandler("onResourceStart", function(res)
    if res ~= GetCurrentResourceName() then return end
    CreateBlipsZones()
	onlineplayer = true
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(crabPlants) do
			DeleteObject(v)
		end
	end
end)

function CreateBlipsZones()
	if blipsZonesLoaded then return end
    PlayerData = QBCore.Functions.GetPlayerData()

	local blipjobche = AddBlipForCoord(thaitu_dev.blips.jobCoords)
	SetBlipSprite(blipjobche, 51)
	SetBlipDisplay(blipjobche, 4)
	SetBlipScale(blipjobche, 1.3)
	SetBlipAsShortRange(blipjobche, true)
	SetBlipColour(blipjobche, 0)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName(thaitu_dev.blips.namejob)
	EndTextCommandSetBlipName(blipjobche)
	
	blipsZonesLoaded = true
end