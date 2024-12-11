aura_env.aura = {
    [0] = { -- precise spellID
        id = 0,
        type = 0, -- 0 for harmful, 1 for helpful
        unit_targets = {},
        source_units = {},
    },
}
aura_env.strategy = {
    {
        match = {
            aura = {}, -- Example: { id_x, id_y }, id_x is the value of aura[x].id
            totem = {},
        },
        func = nil, -- function() end
        func_string = nil, -- ""
    },
}
