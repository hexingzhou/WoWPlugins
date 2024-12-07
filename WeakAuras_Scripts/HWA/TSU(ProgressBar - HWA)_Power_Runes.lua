--[[
- Events: UNIT_POWER_FREQUENT, HWA_UPDATE

- Conditions:
{
    value = true,
    total = true,
}
--]]
function(states, event, ...)
    local key = "POWER"

    if "UNIT_POWER_FREQUENT" == event then
        local unitTarget = ...
        if unitTarget ~= "player" then
            return false
        end
    end

    if HWA and HWA.getPower then
        aura_env.result = aura_env.result or {}

        local result, state = HWA.getPower(aura_env, aura_env.power)
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
                            index = s.index,
                        }
                    else
                        states[i] = {
                            show = false,
                            changed = true,
                        }
                    end
                end
                size = #state.states
                local cooldown = {}
                for i = 1, size do
                    local startTime, duration, isRuneReady = GetRuneCooldown(i)
                    local c = {}
                    c.isRuneReady = isRuneReady
                    if isRuneReady then
                        c.duration = 0
                        c.expirationTime = 0
                    else
                        c.duration = duration
                        c.expirationTime = startTime + duration
                    end
                    table.insert(cooldown, c)
                end
                table.sort(cooldown, function(a, b)
                    return a.expirationTime < b.expirationTime
                end)
                for i, c in ipairs(cooldown) do
                    if not c.isRuneReady then
                        states[i].progressType = "timed"
                        states[i].duration = c.duration
                        states[i].expirationTime = c.expirationTime
                    end
                end
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
