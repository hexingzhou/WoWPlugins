-- Events: PLAYER_TOTEM_UPDATE, STATUS

-- Trigger
function(event, ...)
    local key = "TOTEM"
    local totemSlot = nil
    if "PLAYER_TOTEM_UPDATE" == event then
        totemSlot = ...
    end
    local result, state = HWA and HWA.getTotem and HWA.getTotem(aura_env, "STATUS" == event, totemSlot)
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
    local key = "TOTEM"
    local state = aura_env.result and aura_env.result[key]
    if state and not state.show then
        return true
    end
    return false
end


-- Duration Info
function()
    local key = "TOTEM"
    local state = aura_env.result and aura_env.result[key]
    if state and state.show then
        return state.duration, state.expirationTime
    end
    return 0, 0
end


-- Stack Info
function()
    local key = "TOTEM"
    local state = aura_env.result and aura_env.result[key]
    if state and state.show then
        return state.stacks
    end
    return 0
end
