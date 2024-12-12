aura_env.dynamic_effects = {
    {
        totem = {
            [""] = { -- totemName
                id = 0,
            },
        },
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
                    totem = {}, -- Example: { id_x, id_y }, id_y is the value of totem[x].id
                },
                func = nil, -- function() end
                func_string = nil, -- ""
            },
        },
    },
}
