--[[
- Events: UNIT_POWER_FREQUENT, HWA_UPDATE

- Conditions:
{
    value = true,
    total = true,
}
--]]
function(states, event, ...)
    aura_env.result = aura_env.result or {}

    local key = "POWER"

    if "UNIT_POWER_FREQUENT" == event then
        local unitTarget = ...
        if unitTarget ~= "player" then
            return false
        end
    end

    if HWA and HWA.getPowerStates then
        local result, state = HWA.getPowerStates(aura_env, aura_env.info)
        if result and state then
            local records = aura_env.result[key] or {}
            local size = records.size or 0
            if state.show then
                size = max(size, #state.states)
                for i = 1, size do
                    local s = state.states[i]
                    if s then
                        states[i] = {
                            show = true,
                            changed = true,
                            progressType = s.progressType,
                            total = s.total,
                            value = s.value,
                            init = s.init,
                        }
                    else
                        states[i] = {
                            show = false,
                            changed = true,
                        }
                    end
                end
                size = #state.states
            else
                for i = 1, size do
                    states[i] = {
                        show = false,
                        changed = true,
                    }
                end
                size = 0
            end
            records.size = size
            aura_env.result[key] = records
            return true
        end
    end
    return false
end
