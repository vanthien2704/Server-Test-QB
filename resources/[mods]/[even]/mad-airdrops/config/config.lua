return {
   intervalBetweenAirdrops = 20, --time in minutes

   progressbarDuration = 10000, -- miliseconds

    --locations here can airdrops drop
    Locs = {
        vector3(-1336.09, -3044.15, 13.94),
        vector3(1369.66, 3160.47, 40.41),
        vector3(-2144.35, 3019.58, 32.83),
    },

    AirCraft = {
        PilotModel = "s_m_m_pilot_01", -- Pilot model
        PlaneModel = "titan", -- Plane model
        Height = 450.0, -- Plane Height
        Speed = 92.0, -- Plane Speed
    },

    --location here aircraft can spawn
    aircraftSpawnPoint = vec3(3562.5, 1356.43, 450.0),

    --items that you can get in airdrop
    LootTable= {

        "weapon_combatpistol",
        "weapon_assaultrifle",
        "weapon_smg",
        "weapon_heavypistol",
        "weapon_carbinerifle",
        "weapon_machinepistol",
        "weapon_pistol",
        
    },

    amountOfItems = math.random(4,5), --amount of items you can get in airdrop

    timetodeletebox = 0.2, --time to delete the airdrop after looted in minutes

    falldownSpeed = 0.1, -- you can set it like 0.01 to get very slow you 0.2 to get faster
}