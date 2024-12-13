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
function(states, event, ...)
    aura_env.cache = aura_env.cache or {}

    local key = "SPELL"
    local config = aura_env.info

    local check = nil

    if "HWA_UPDATE" == event then
        local type = ...
        if type == "init" then
            if HWA and HWA.initSpellState then
                aura_env.cache[key] = HWA.initSpellState(aura_env, aura_env.info)
            else
                aura_env.cache[key] = {}
            end
        end
    elseif "UNIT_HEALTH" == event then
        local unitTarget = ...
        if unitTarget == "target" then
            if aura_env.cache[key] and aura_env.cache[key].matchedTarget then
                -- Continue.
            else
                return false
            end
        else
            return false
        end
    elseif "PLAYER_TARGET_CHANGED" == event then
        if aura_env.cache[key] and aura_env.cache[key].matchedTarget then
            -- Continue.
        else
            return false
        end
    elseif "SPELL_COOLDOWN_CHANGED" == event then
        local id = ...
        if id ~= (aura_env.cache[key] and aura_env.cache[key].id or 0) then
            return false
        end
        check = id
    end

    aura_env.cache[key] = aura_env.cache[key] or {}

    if HWA and HWA.getSpellState then
        local result, state = HWA.getSpellState(aura_env, aura_env.cache[key], aura_env.info, check)
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
