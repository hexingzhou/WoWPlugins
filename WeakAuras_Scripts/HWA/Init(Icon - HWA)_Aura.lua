aura_env.aura = {
    [0] = { -- auraInstanceID
        strategy = 0,
        unit_targets = {},
        source_units = {},
    },
}
aura_env.strategy = {
    {
        id = {
            aura = {}, -- Example: { strategy_x, strategy_y }, strategy_x is the value of aura[x].strategy
            totem = {},
        },
        func = nil, -- function() end
        func_string = nil, -- ""
    },
}
