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

    if HWA and HWA.getAuraState then
        aura_env.cache = aura_env.cache or {}
        aura_env.result = aura_env.result or {}

        local result, state = HWA.getAuraState(aura_env, aura_env.cache, aura_env.aura, aura_env.strategy, unitTarget)
        if result and state then
            if state.show then
                aura_env.result[key] = state
                return true
            else
                aura_env.result[key] = nil
                return false
            end
        end
    end
    return false
end

-- Untrigger
function(event, ...)
    local key = "AURA"
    local state = aura_env.result and aura_env.result[key]
    if state then
        return true
    end
    return false
end

-- Duration Info
function()
    local key = "AURA"
    local state = aura_env.result and aura_env.result[key]
    if state then
        return state.duration, state.expirationTime
    end
    return 0, 0
end

-- Stack Info
function()
    local key = "AURA"
    local state = aura_env.result and aura_env.result[key]
    if state then
        return state.stacks
    end
    return 0
end
