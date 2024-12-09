aura_env.aura = {
    [0] = { -- auraInstanceID
        id = 0,
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
