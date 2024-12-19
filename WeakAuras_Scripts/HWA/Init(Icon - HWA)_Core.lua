--[[
- Demo:
strategy = {
    {
        func = function(env, stateGroup)
            local H = HWA or {}
            if H.getDefaultCoreStrategyState then
                return H.getDefaultCoreStrategyState(env, stateGroup)
            end
        end,
    },
    {
        func = function(env, stateGroup)
            local H = HWA or {}
            if H.getNormalCoreStrategyState then
                return H.getNormalCoreStrategyState(env, stateGroup)
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
local H = HWA or {}
local env = aura_env or {}

env.info = {
    {
        spell = {
            id = 0, -- spellID
            precise = false,
            gcd = false,
            range = false,
            health = {
                func = nil,
                func_string = nil,
            },
        },
        totem = {
            {
                name = "", -- totemName
            },
        },
        aura = {
            {
                id = 0, -- precise spellID for aura
                type = 0, -- 0 for harmful, 1 for helpful
                unit_targets = {},
                source_units = {},
            },
        },
        strategy = {
            {
                match = {
                    aura = {}, -- Example: { id_x, id_y }, id_x is the value of aura[x].id
                    totem = {}, -- Example: { name_x, name_y }, id_y is the value of totem[x].name
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

if H.loadFunction then
    local config = env.config and env.config.info or {}
    for _, c in ipairs(config) do
        if c.data then
            local data = H.loadFunction(c.data)
            if data then
                table.insert(env.info, data)
            end
        end
    end
end
