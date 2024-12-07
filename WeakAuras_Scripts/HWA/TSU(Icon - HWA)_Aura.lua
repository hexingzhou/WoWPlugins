--[[
- Events: UNIT_AURA

- Conditions:
{
    duration = true,
    expirationTime = true,
    stacks = true
}
--]]
function(states, event, ...)
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
