--[[
- Events: UNIT_AURA
--]]
-- Trigger
function(event, ...)
    local key = "AURA"
    local unitTarget = nil
    if "UNIT_AURA" == event then
        local updateInfo = nil
        unitTarget, updateInfo = ...
        if not updateInfo or updateInfo.isFullUpdate then
            return false
        end
    end
    local result, state = false, {}
    if HWA and HWA.getAura then
        result, state = HWA.getAura(aura_env, false, totemSlot)
    end
    if result and state then
        aura_env.result = aura_env.result or {}
        aura_env.result[key] = state
        if not state.show then
            return false
        else
            return true
        end
    end
    return false
end

-- Untrigger
function(event, ...)
    local key = "AURA"
    local state = aura_env.result and aura_env.result[key]
    if state and not state.show then
        return true
    end
    return false
end

-- Duration Info
function()
    local key = "AURA"
    local state = aura_env.result and aura_env.result[key]
    if state and state.show then
        return state.duration, state.expirationTime
    end
    return 0, 0
end

-- Name Info
function()
    local key = "AURA"
    local state = aura_env.result and aura_env.result[key]
    if state and state.show then
        return state.name
    end
    return nil
end

-- Stack Info
function()
    local key = "AURA"
    local state = aura_env.result and aura_env.result[key]
    if state and state.show then
        return state.stacks
    end
    return 0
end
