--[[
- Events: UNIT_HEALTH, PLAYER_TARGET_CHANGED, SPELL_COOLDOWN_CHANGED, HWA_UPDATE

- Conditions:
{
    duration = true,
    expirationTime = true,
    stacks = true,
    charges = {
        display = "充能",
        type = "number",
    },
    healthPercent = {
        display = "生命百分比",
        type = "number",
    },
    isSpellInRange = {
        display = "在法术可用范围内",
        type = "bool",
    },
    hasTarget = {
        display = "目标存在",
        type = "bool",
    },
    noResource = {
        display = "资源不足",
        type = "bool",
    },
    isUsable = {
        display = "法术可用",
        type = "bool",
    },
    gcd = {
        display = "法术存在公共冷却",
        type = "bool",
    },
}
--]]
function(states, event)
    aura_env.cache = aura_env.cache or {}

    local key = "SPELL"

    local config = aura_env.spell

    if "OPTIONS" == event or "STATUS" == event then
        return false
    elseif "HWA_UPDATE" == event then
        local type = ...
        if type == "init" then
            if HWA and HWA.initSpell then
                aura_env.cache[key] = HWA.initSpell(aura_env, config)
            else
                aura_env.cache[key] = 0
            end
        end
    elseif "UNIT_HEALTH" == event then
        local unitTarget = ...
        if unitTarget == "target" then
            if config and config.target then
                -- Continue.
            else
                return false
            end
        else
            return false
        end
    elseif "PLAYER_TARGET_CHANGED" == event then
        if config and config.target then
            -- Continue.
        else
            return false
        end
    elseif "SPELL_COOLDOWN_CHANGED" == event then
        local id = ...
        local spellID = aura_env.cache[key] or 0
        if id ~= spellID then
            return false
        end
    end

    if HWA and HWA.getSpell then
        aura_env.cache[key] = aura_env.cache[key] or {}

        local result, state = HWA.getSpell(aura_env, config, aura_env.cache[key])
        if result and state then
            if state.show then
                states[key] = {
                    show = true,
                    changed = true,
                    progressType = state.progressType,
                    duration = state.duration,
                    expirationTime = state.expirationTime,
                    icon = state.icon,
                    stacks = state.stacks,
                    charges = state.charges,
                    isUsable = state.isUsable,
                    noResource = state.noResource,
                    isSpellInRange = state.isSpellInRange,
                    hasTarget = state.hasTarget,
                    healthPercent = state.healthPercent,
                    priority = state.priority,
                    init = state.init,
                }
            else
                states[key] = {
                    show = false,
                    changed = true,
                }
            end
            return true
        end
    end
    return false
end
