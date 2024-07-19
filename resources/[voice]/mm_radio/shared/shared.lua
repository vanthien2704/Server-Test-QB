Shared.MaxFrequency = 500.00 -- Max Limit of Radio Channel

Shared.RadioNames = {
    ["113"] = "MPD", -- channel value 1
    -- ["113.%"] = "MPD CH" -- channel value 1.%%%% string formatter
    ["115"] = "MBS", -- channel value 1
}

Shared.RestrictedChannels = {
    [113] = { -- channel id
        type = 'job', -- job/gang
        name = {"police"}
    },
    [115] = { -- channel id
        type = 'job', -- job/gang
        name = {"ambulance"}
    },
}

lib.locale()