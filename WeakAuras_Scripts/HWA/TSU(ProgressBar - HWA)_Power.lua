--[[
- Events: UNIT_POWER_FREQUENT, STATUS, UPDATE_SHAPESHIFT_FORM, HWA_INIT

- Conditions:
{
    value = true,
    total = true,
}
--]]
function(states, event, ...)
    if "UNIT_POWER_FREQUENT" == event then
        local unitTarget = ...
        if unitTarget ~= "player" then
            return false
        end
    end
    local initTime = 0
    if "HWA_INIT" == event then
        initTime = GetTime()
    end
    local powerSize = aura_env.power_size or 1
    local result, state = false, {}
    if HWA and HWA.getPower then
        result, state = HWA.getPower(aura_env, false)
    end
    if result and state then
        if not state.show then
            for i = 1, powerSize do
                states[i] = {
                    show = false,
                    changed = true,
                }
            end
            aura_env.power_size = 1
        else
            local rStates = state.states or {}
            local size = max(powerSize, #rStates)
            for i = 1, size do
                if rStates[i] then
                    states[i] = rStates[i]
                    states[i].show = true
                    states[i].changed = true
                    states[i].initTime = initTime
                else
                    states[i] = {
                        show = false,
                        changed = true,
                    }
                end
            end
            aura_env.power_size = #rStates
            if aura_env.power_size == 0 then
                aura_env.power_size = 1
            end
        end
        return true
    end
    return false
end
