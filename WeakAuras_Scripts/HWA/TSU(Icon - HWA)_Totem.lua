--[[
- Events: PLAYER_TOTEM_UPDATE

- Conditions:
{
    duration = true,
    expirationTime = true,
    stacks = true
}
--]]
function(states, event, ...)
    local key = "TOTEM"

    local totemSlot = nil
    if "PLAYER_TOTEM_UPDATE" == event then
        totemSlot = ...
    end

    if HWA and HWA.getTotemState then
        aura_env.cache = aura_env.cache or {}
        aura_env.result = aura_env.result or {}

        local result, state = HWA.getTotemState(aura_env, aura_env.cache, aura_env.totem, aura_env.strategy, totemSlot)
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
                aura_env.result[key] = state
            else
                states[key] = {
                    show = false,
                    changed = true,
                }
                aura_env.result[key] = nil
            end
            return true
        end
    end
    return false
end
