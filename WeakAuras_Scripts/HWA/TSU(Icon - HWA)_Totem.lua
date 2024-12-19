--[[
- Events: HWA_UPDATE_TOTEM, HWA_UPDATE

- Conditions:
{
    duration = true,
    expirationTime = true,
    stacks = true
}
--]]
function(states, event, ...)
    local H = HWA or {}
    local env = aura_env or {}

    env.cache = env.cache or {}

    local key = "TOTEM"

    if "HWA_UPDATE" == event then
        local type = ...
        if type == "init" then
            if H.initTotemState then
                env.cache[key] = H.initTotemState(env, env.info)
            else
                env.cache[key] = {}
            end
        else
            return false
        end
    elseif "HWA_UPDATE_TOTEM" == event then
        local matchedTotem = env.cache[key] and env.cache[key].matchedTotem or {}
        if not next(matchedTotem) then
            return false
        end
    end

    env.cache[key] = env.cache[key] or {}

    if H.getTotemState then
        local result, data = H.getTotemState(env, env.cache[key], env.info)
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
