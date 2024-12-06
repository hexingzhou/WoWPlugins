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
    local result, state = false, {}
    if HWA and HWA.getAura then
        result, state = HWA.getAura(aura_env, false, unitTarget)
    end
    if result and state then
        if not state.show then
            states[key] = {
                show = false,
                changed = true,
            }
        else
            states[key] = {
                show = true,
                changed = true,
                autoHide = true,
                progressType = state.progressType,
                duration = state.duration,
                expirationTime = state.expirationTime,
                stacks = state.stacks,
            }
        end
        return true
    end
    return false
end
