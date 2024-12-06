aura_env.aura = {
    configs = {
        [0] = { -- The id of config in configs.
            id = 0, -- auraInstanceID
            unit_targets = {},
            source_units = {},
        },
    },
    strategies = {
        {
            ids = {}, -- { id, id, }, ids of config used to trigger strategy.
            func = nil, --[[ function(auras)
                local aura = auras[1]
                local stacks = 0
                if aura.charges > 1 then
                    states = aura.charges
                end
                return {
                    autoHide = true,
                    progressType = "timed",
                    duration = aura.duration,
                    expirationTime = aura.expirationTime,
                    stacks = stacks
                }
            end ]]
            func_string = nil,
        },
    },
}
