-- Events: PLAYER_TOTEM_UPDATE, STATUS

--[[
- Conditions:
{
    duration = true,
    expirationTime = true,
    stacks = true
}
]]--
function(states, event, ...)
    local key = "TOTEM"
    local totemSlot = nil
    if "PLAYER_TOTEM_UPDATE" == event then
        totemSlot = ...
    end
    local result, state = HWA and HWA.getTotem and HWA.getTotem(aura_env, "STATUS" == event, totemSlot)
    if result and state then
        if not state.show then
            states[key] = {
                show = false,
                changed = true
            }
        else
            states[key] = {
                show = true,
                changed = true,
                autoHide = true,
                progressType = state.progressType,
                duration = state.duration,
                expirationTime = state.expirationTime,
                stacks = state.stacks
            }
        end
        return true
    end
    return false
end
