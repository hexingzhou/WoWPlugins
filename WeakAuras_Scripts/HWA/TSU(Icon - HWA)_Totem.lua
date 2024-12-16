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
    aura_env.cache = aura_env.cache or {}

    local key = "TOTEM"

    if "HWA_UPDATE" == event then
        local type = ...
        if type == "init" then
            if HWA and HWA.initTotemState then
                aura_env.cache[key] = HWA.initTotemState(aura_env, aura_env.info)
            else
                aura_env.cache[key] = {}
            end
        else
            return false
        end
    elseif "HWA_UPDATE_TOTEM" == event then
        local matchedTotem = aura_env.cache[key] and aura_env.cache[key].matchedTotem or {}
        if not next(matchedTotem) then
            return false
        end
    end

    aura_env.cache[key] = aura_env.cache[key] or {}

    if HWA and HWA.getTotemState then
        local result, data = HWA.getTotemState(aura_env, aura_env.cache[key], aura_env.info)
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
