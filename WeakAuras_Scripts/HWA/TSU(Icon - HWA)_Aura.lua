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
    local H = HWA or {}
    local env = aura_env or {}

    env.cache = env.cache or {}

    local key = "AURA"

    if "HWA_UPDATE" == event then
        local type = ...
        if type == "init" then
            if H.initAuraState then
                env.cache[key] = H.initAuraState(env, env.info)
            else
                env.cache[key] = {}
            end
        else
            return false
        end
    elseif "HWA_UNIT_AURA" == event then
        local unitTarget = ...
        if unitTarget then
            local matchedAura = env.cache[key] and env.cache[key].matchedAura or {}
            if not matchedAura[unitTarget] then
                return false
            end
        else
            return false
        end
    end

    env.cache[key] = env.cache[key] or {}

    if H.getAuraState then
        local result, data = H.getAuraState(env, env.cache[key], env.info)
        if result then
            if data then
                states[key] = {
                    show = true,
                    changed = true,
                    autoHide = true,
                    progressType = data.progressType,
                    duration = data.duration,
                    expirationTime = data.expirationTime,
                    stacks = data.stacks,
                    priority = data.priority,
                    init = data.init,
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
