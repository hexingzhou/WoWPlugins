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

    if "HWA_UPDATE" == event then
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

    aura_env.cache[key] = aura_env.cache[key] or {}

    if HWA and HWA.getTotemState then
        local result, data =
            HWA.getTotemState(aura_env, aura_env.cache[key], aura_env.info, totemSlots)
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
