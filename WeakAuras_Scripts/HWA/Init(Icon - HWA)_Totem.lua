aura_env.totem = {
    [""] = { -- totemName
        strategy = 0,
    },
}
aura_env.strategy = {
    {
        id = {
            aura = {},
            totem = {}, -- Example: { strategy_x, strategy_y }, strategy_x is the value of totem[x].strategy
        },
        func = nil, -- function() end
        func_string = nil, -- ""
    },
}
