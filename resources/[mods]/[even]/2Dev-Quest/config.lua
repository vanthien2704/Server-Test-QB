-- TriggerClientEvent("UpdateQuest", source, "quest_cabbage", 2) // ส่งจาก Server
-- TriggerEvent("UpdateQuest","quest_cabbage", 2) // ส่งจาก Client
Config = {}
Config.BlurMode = true
Config.EnableReset = false
Config.WaitUpdate = 200
Config.TimeReset = {{"17:59"},{"18:00"}} -- ตั้งเวลาในการเปิดกิจกรรม
Config.CommandReset = "resetquest"
Config.Blip = {
    Blip = 52,
    Size = 0.6,
    Color = 2,
    Text = "Quest System"
}
Config.Distance = 10
Config.Position = {
    vector3(-1632.0471, -3107.4097, 13.9448),
}
Config.Quest = {
    ['daoda'] = { -- ไอดีของ Quest เวลาจะอัพเดต
        State = true,
        Title = 'Đào đá',
        Detail = 'Đào đá', -- รายละเอียดเควส
        Count = 1, -- จำนวนครั้งที่ต้องทำ
        Picture = "https://media.discordapp.net/attachments/1030094411150930060/1033325086859591690/random_9.png",
        Reward = {
            {name = 'lockpick', quantity = 1, type = "item" },
        },
    },
    ['daoda2'] = { -- ไอดีของ Quest เวลาจะอัพเดต
    State = true,
    Title = 'Đào đá 2',
    Detail = 'Đào đá 2', -- รายละเอียดเควส
    Count = 2, -- จำนวนครั้งที่ต้องทำ
    Picture = "https://media.discordapp.net/attachments/1030094411150930060/1033325086859591690/random_9.png",
    Reward = {
        {name = 'lockpick', quantity = 1, type = "item" },
    },
    },

    ['daoda3'] = { -- ไอดีของ Quest เวลาจะอัพเดต
        State = true,
        Title = 'Đào đá 3',
        Detail = 'Đào đá 3', -- รายละเอียดเควส
        Count = 3, -- จำนวนครั้งที่ต้องทำ
        Picture = "https://media.discordapp.net/attachments/1030094411150930060/1033325086859591690/random_9.png",
        Reward = {
            {name = 'lockpick', quantity = 1, type = "item" },
        },
    },

    ['daoda4'] = { -- ไอดีของ Quest เวลาจะอัพเดต
        State = true,
        Title = 'Đào đá 4',
        Detail = 'Đào đá 4', -- รายละเอียดเควส
        Count = 4, -- จำนวนครั้งที่ต้องทำ
        Picture = "https://media.discordapp.net/attachments/1030094411150930060/1033325086859591690/random_9.png",
        Reward = {
            {name = 'lockpick', quantity = 1, type = "item" },
        },
    },

    ['daoda5'] = { -- ไอดีของ Quest เวลาจะอัพเดต
        State = true,
        Title = 'Đào đá 5',
        Detail = 'Đào đá 5', -- รายละเอียดเควส
        Count = 5, -- จำนวนครั้งที่ต้องทำ
        Picture = "https://media.discordapp.net/attachments/1030094411150930060/1033325086859591690/random_9.png",
        Reward = {
            {name = 'lockpick', quantity = 1, type = "item" },
        },
    },

    ['daoda6'] = { -- ไอดีของ Quest เวลาจะอัพเดต
        State = true,
        Title = 'Đào đá 6',
        Detail = 'Đào đá 6', -- รายละเอียดเควส
        Count = 6, -- จำนวนครั้งที่ต้องทำ
        Picture = "https://media.discordapp.net/attachments/1030094411150930060/1033325086859591690/random_9.png",
        Reward = {
            {name = 'lockpick', quantity = 1, type = "item" },
        },
    },

    ['daoda7'] = { -- ไอดีของ Quest เวลาจะอัพเดต
        State = true,
        Title = 'Đào đá 7',
        Detail = 'Đào đá 7', -- รายละเอียดเควส
        Count = 7, -- จำนวนครั้งที่ต้องทำ
        Picture = "https://media.discordapp.net/attachments/1030094411150930060/1033325086859591690/random_9.png",
        Reward = {
            {name = 'lockpick', quantity = 1, type = "item" },
        },
    },

    ['daoda8'] = { -- ไอดีของ Quest เวลาจะอัพเดต
        State = true,
        Title = 'Đào đá 8',
        Detail = 'Đào đá 8', -- รายละเอียดเควส
        Count = 8, -- จำนวนครั้งที่ต้องทำ
        Picture = "https://media.discordapp.net/attachments/1030094411150930060/1033325086859591690/random_9.png",
        Reward = {
            {name = 'lockpick', quantity = 1, type = "item" },
        },
    },

    ['daoda9'] = { -- ไอดีของ Quest เวลาจะอัพเดต
        State = true,
        Title = 'Đào đá 9',
        Detail = 'Đào đá 9', -- รายละเอียดเควส
        Count = 9, -- จำนวนครั้งที่ต้องทำ
        Picture = "https://media.discordapp.net/attachments/1030094411150930060/1033325086859591690/random_9.png",
        Reward = {
            {name = 'lockpick', quantity = 1, type = "item" },
        },
    },

    ['daoda10'] = { -- ไอดีของ Quest เวลาจะอัพเดต
        State = true,
        Title = 'Đào đá 10',
        Detail = 'Đào đá 10', -- รายละเอียดเควส
        Count = 10, -- จำนวนครั้งที่ต้องทำ
        Picture = "https://media.discordapp.net/attachments/1030094411150930060/1033325086859591690/random_9.png",
        Reward = {
            {name = 'lockpick', quantity = 1, type = "item" },
        },
    }, 
}
