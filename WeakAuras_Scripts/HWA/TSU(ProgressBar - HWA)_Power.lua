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
        local result, datas = HWA.getPowerStates(aura_env, aura_env.info)
        if result then
            local records = aura_env.result[key] or {}
            local size = records.size or 0
            if datas then
                size = max(size, #datas)
                for i = 1, size do
                    local data = datas[i]
                    if data then
                        states[i] = {
                            show = true,
                            changed = true,
                            progressType = data.progressType,
                            total = data.total,
                            value = data.value,
                            init = data.init,
                        }
                    else
                        states[i] = {
                            show = false,
                            changed = true,
                        }
                    end
                end
                size = #datas
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
