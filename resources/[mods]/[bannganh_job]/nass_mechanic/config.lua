Config = {}

Config.PedList = {
	{ped = 's_m_y_xmech_01', name = "Victor", pos = vector4(454.11, -1027.64, 27.51, 1.21), blip = {enabled = true, sprite = 402, scale = 0.75, label = "Mechanic", shortRange = true}},
	{job = 'police', ped = 's_m_y_xmech_01', name = "Pedro", pos = vector4(458.72, -1022.47, 27.27, 106.35), blip = {enabled = true, sprite = 402, scale = 0.75, label = "Mechanic", shortRange = true}},
}

Config.carpolice = {
	"POLICE",
    "POLICE2",
}

Config.price = 1000.0
Config.DamageMultiplier = 5.0	
Config.useTarget = true --If false it will use helptext
Config.chargeForRepair = true -- Set to false to remove repair cost
Config.checkForOnlineMechanic = true -- This will check if there is a mechanic online before repairing a vehicle
