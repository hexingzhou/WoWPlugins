aura_env.totem = {
    [""] = { -- totemName
        id = 0,
    },
}
aura_env.strategy = {
    {
        match = {
            aura = {},
            totem = {}, -- Example: { id_x, id_y }, id_x is the value of totem[x].id
        },
        func = nil, -- function() end
        func_string = nil, -- ""
    },
}
