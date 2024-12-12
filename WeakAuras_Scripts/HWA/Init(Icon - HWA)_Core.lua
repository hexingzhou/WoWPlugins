--[[
- Demo:
strategy = {
    {
        func = function(env, stateGroup)
            if HWA and HWA.getDefaultCoreStrategyState then
                return HWA.getDefaultCoreStrategyState(env, stateGroup)
            end
        end,
    },
    {
        func = function(env, stateGroup)
            if HWA and HWA.getNormalCoreStrategyState then
                return HWA.getNormalCoreStrategyState(env, stateGroup)
            end
        end,
    },
    {
        func = function(env, stateGroup)
            if HWA and HWA.getNoticeCoreStrategyState then
                return HWA.getNoticeCoreStrategyState(env, stateGroup)
            end
        end,
    },
    {
        func = function(env, stateGroup)
            if HWA and HWA.getImportantCoreStrategyState then
                return HWA.getImportantCoreStrategyState(env, stateGroup)
            end
        end,
    },
}
--]]
aura_env.info = {
    {
        spell = {
            id = 0, -- spellID
            precise = false,
            gcd = false,
            target = false,
        },
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
}
