--[[
- Events: HWA_UNIT_AURA, HWA_UPDATE

- Conditions:
{
    duration = true,
    expirationTime = true,
    stacks = true,
    -- 0: no glow, 1: pixel glow, 2: autocast shine, 3: action buttom glow
    glow = {
        display = "发光类型",
        type = "number",
    },
}
--]]
function(states, event, ...)
    aura_env.cache = aura_env.cache or {}

    local key = "AURA"

    local unitTargets = nil

    if "OPTIONS" == event or "STATUS" == event then
        return false
    elseif "HWA_UPDATE" == event then
        local type = ...
        if type == "init" then
            aura_env.cache[key] = {}
        else
            return false
        end
    elseif "HWA_UNIT_AURA" == event then
        local unitTarget = ...
        if unitTarget then
            unitTargets = { unitTarget }
        else
            return false
        end
    end

    if HWA and HWA.getAuraState then
        aura_env.cache[key] = aura_env.cache[key] or {}

        local result, state =
            HWA.getAuraState(aura_env, aura_env.cache[key], aura_env.info, unitTargets)
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
