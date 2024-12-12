aura_env.info = {
    totem = {
        [""] = { -- totemName
            id = 0,
        },
    },
    strategy = {
        {
            match = {
                aura = {},
                totem = {}, -- Example: { id_x, id_y }, id_x is the value of totem[x].id
            },
            func = nil, -- function() end
            func_string = nil, -- ""
        },
    },
    show = {
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
