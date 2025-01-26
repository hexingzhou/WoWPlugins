--[[
- Demo:
{
    spell = {
        -- Check if target health <= 35 percents or not.
        health = {
            func = function(healthes, state)
                local health = healthes and healthes["target"] or {}
                local state = state or {}
                if health.hasTarget and health.current / health.max < 0.35 then
                    return state.value ~= true, {
                        value = true,
                    }
                else
                    return state.value, {
                        value = false,
                    }
                end
            end,
        },
    },
    show = {
        func = function(id)
            local H = HWA or {}
            if H.getIsSpellKnownStateShow then
                return H.getIsSpellKnownStateShow(id)
            end
        end,
    },
    strategy = {
        -- Show "YYY" with aura XX.
        {
            match = {
                aura = {
                    XX,
                },
            },
            func = function(env, stateGroup)
                local H = HWA or {}
                if H.getDefaultCoreStrategyState then
                    local r, s = H.getDefaultCoreStrategyState(env, stateGroup)
                    if r and s then
                        s.text = "YYY"
                    end
                    return r, s
                end
            end,
        },
        -- Default only show cooldown.
        {
            func = function(env, stateGroup)
                local H = HWA or {}
                if H.getDefaultCoreStrategyState then
                    return H.getDefaultCoreStrategyState(env, stateGroup)
                end
            end,
        },
        -- Nomal show cooldown and splash glow.
        {
            func = function(env, stateGroup)
                local H = HWA or {}
                if H.getNormalCoreStrategyState then
                    return H.getNormalCoreStrategyState(env, stateGroup)
                end
            end,
        },
        -- Notice show cooldown and auto skill glow.
        {
            func = function(env, stateGroup)
                local H = HWA or {}
                if H.getNoticeCoreStrategyState then
                    return H.getNoticeCoreStrategyState(env, stateGroup)
                end
            end,
        },
        -- Important show cooldown and skill high-light.
        {
            func = function(env, stateGroup)
                local H = HWA or {}
                if H.getImportantCoreStrategyState then
                    return H.getImportantCoreStrategyState(env, stateGroup)
                end
            end,
        },
        -- Health check: if matched health condition, show notice glow.
        {
            func = function(env, stateGroup)
                local health = stateGroup and stateGroup.spell and stateGroup.spell.health or {}
                if health.value then
                    return true, {
                        glow = 2,
                    }
                else
                    return false
                end
            end,
        },
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
            pet = false,
            gcd = false,
            range = false,
            health = {
                func = nil,
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
            },
        },
        show = {
            func = nil,
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
