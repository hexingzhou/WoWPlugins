aura_env.core = {
    [0] = { -- spellID
        spell = {
            precise = false,
            target = false,
            show = 0, -- 1 for show, -1 for hide, 0 for default
            form = {
                [0] = {
                    show = 0,
                },
            },
            spec = {
                [0] = {
                    show = 0,
                    form = {
                        [0] = {
                            show = 0,
                        },
                    },
                },
            },
        },
        totem = {
            name = "",
        },
        priority = {
            value = 0,
            form = {
                [0] = 0,
            },
            spec = {
                [0] = {
                    value = 0,
                    form = {
                        [0] = 0,
                    },
                },
            },
        },
        aura = {
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
        },
        func = nil,
        func_string = nil,
    },
}
