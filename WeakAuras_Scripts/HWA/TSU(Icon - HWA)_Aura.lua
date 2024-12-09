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
    aura_env.cache = aura_env.cache or {}

    local key = "AURA"

    local unitTargets = nil

    if "OPTIONS" == event then
        aura_env.cache[key] = {}
    elseif "UNIT_AURA" == event then
        local unitTarget, updateInfo = ...
        if unitTarget and updateInfo and not updateInfo.isFullUpdate then
            unitTargets = { unitTarget }
        end
    end

    if HWA and HWA.getAuraState then
        aura_env.cache[key] = aura_env.cache[key] or {}

        local result, state =
            HWA.getAuraState(aura_env, aura_env.cache[key], aura_env.aura, aura_env.strategy, unitTargets)
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
