--[[
- Events: PLAYER_TOTEM_UPDATE
--]]
-- Trigger
function(event, ...)
    aura_env.cache = aura_env.cache or {}
    aura_env.result = aura_env.result or {}

    local key = "TOTEM"

    local totemSlots = nil

    if "OPTIONS" == event then
        aura_env.cache[key] = {}
    elseif "PLAYER_TOTEM_UPDATE" == event then
        local totemSlot = ...
        if totemSlot then
            totemSlots = { totemSlot }
        else
            return false
        end
    end

    if HWA and HWA.getTotemState then
        aura_env.cache[key] = aura_env.cache[key] or {}

        local result, state =
            HWA.getTotemState(aura_env, aura_env.cache[key], aura_env.totem, aura_env.strategy, totemSlots)
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
    local key = "TOTEM"
    local state = aura_env.result and aura_env.result[key]
    if state then
        return true
    end
    return false
end

-- Duration Info
function()
    local key = "TOTEM"
    local state = aura_env.result and aura_env.result[key]
    if state then
        return state.duration, state.expirationTime
    end
    return 0, 0
end

-- Stack Info
function()
    local key = "TOTEM"
    local state = aura_env.result and aura_env.result[key]
    if state then
        return state.stacks
    end
    return 0
end
