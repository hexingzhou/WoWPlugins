aura_env.core = {
    [0] = { -- spellID
        name = "",
        spell = {
            precise = false,
            target = false,
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
            priority = {
                value = 0,
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
        },
        totem = {
            [""] = { -- totemName
                strategy = 0,
            },
        },
        aura = {
            [0] = { -- auraInstanceID
                strategy = 0,
                unit_targets = {},
                source_units = {},
            },
        },
        strategy = {
            {
                match = {
                    aura = {}, -- Example: { strategy_x, strategy_y }, strategy_x is the value of aura[x].strategy
                    totem = {}, -- Example: { strategy_x, strategy_y }, strategy_x is the value of totem[x].strategy
                },
                func = nil, -- function() end
                func_string = nil, -- ""
            },
        },
    },
}
