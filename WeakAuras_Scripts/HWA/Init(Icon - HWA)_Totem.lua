local env = aura_env or {}

env.info = {
    totem = {
        {
            name = "", -- totemName
        },
    },
    strategy = {
        {
            match = {
                aura = {},
                totem = {}, -- Example: { name_x, name_y }, name_x is the value of totem[x].name
            },
            func = nil, -- function() end
        },
    },
    show = {
        func = nil,
        value = 0, -- 1 for show, -1 for hide, 0 for default
        form = {
            [0] = {
                value = 0,
            },
        },
        spec = {
            [0] = {
                value = 0,
                form = {
                    [0] = {
                        value = 0,
                    },
                },
            },
        },
    },
}
