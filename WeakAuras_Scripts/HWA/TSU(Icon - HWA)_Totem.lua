--[[
- Events: PLAYER_TOTEM_UPDATE, HWA_UPDATE

- Conditions:
{
    duration = true,
    expirationTime = true,
    stacks = true
}
--]]
function(states, event, ...)
    aura_env.cache = aura_env.cache or {}

    local key = "TOTEM"

    local totemSlots = nil

    if "OPTIONS" == event or "STATUS" == event then
        return false
    elseif "HWA_UPDATE" == event then
        local type = ...
        if type == "init" then
            aura_env.cache[key] = {}
        else
            return false
        end
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
                states[key] = {
                    show = true,
                    changed = true,
                    autoHide = true,
                    progressType = state.progressType,
                    duration = state.duration,
                    expirationTime = state.expirationTime,
                    stacks = state.stacks,
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
