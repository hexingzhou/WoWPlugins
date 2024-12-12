aura_env.info = {
    aura = {
        [0] = { -- precise spellID
            id = 0,
            type = 0, -- 0 for harmful, 1 for helpful
            unit_targets = {},
            source_units = {},
        },
    },
    strategy = {
        {
            match = {
                aura = {}, -- Example: { id_x, id_y }, id_x is the value of aura[x].id
                totem = {},
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
