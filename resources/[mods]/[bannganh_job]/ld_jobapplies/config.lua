Config = {}

Config.Target = "QB" -- QB / OX

Config.PDWebHook = "https://discord.com/api/webhooks/1255718320993210459/8GJEEcH_NAmxpJagC0P6GlkXxSvh7Syu_lyW9YFhJfhNOgfMLXod9RLWvDXBMExmD7Ag" -- Your webhook for police applications
Config.EMSWebHook = "https://discord.com/api/webhooks/1255718320993210459/8GJEEcH_NAmxpJagC0P6GlkXxSvh7Syu_lyW9YFhJfhNOgfMLXod9RLWvDXBMExmD7Ag" -- Your webhook for EMS applications
Config.MechanicWebHook = "https://discord.com/api/webhooks/1255718320993210459/8GJEEcH_NAmxpJagC0P6GlkXxSvh7Syu_lyW9YFhJfhNOgfMLXod9RLWvDXBMExmD7Ag" -- Your webhook for mechanic applications

Config.Applys = {
    -- [1] = {
    --     type = "Type of job - police/ems/mechanic",
    --     name = "Name for apply",
    --     label = "Label to display",
    --     coords = vector4(),
    --     ped = false/true,
    --     pedModel = "Ped model",
    -- },

    -- FOR EXAMPLE:
    [1] = {
        type = "police",
        name = "mrpd",
        label = "Police applicaiton",
        coords = vector4(433.64, -985.62, 30.71, 92.05),
        ped = true,
        pedModel = "s_m_y_cop_01",
    },
    [2] = {
        type = "ems",
        name = "pillbox_hospital",
        label = "EMS applicaiton",
        coords = vector4(299.08, -584.64, 43.26, 71.61),
        ped = true,
        pedModel = "s_m_m_scientist_01",
    },
    [3] = {
        type = "mechanic",
        name = "ls_customs",
        label = "Mechanic applicaiton",
        coords = vector4(-355.44, -129.54, 39.43, 86.9),
        ped = true,
        pedModel = "s_m_m_lathandy_01",
    },
}