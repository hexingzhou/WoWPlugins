-- Events: UNIT_POWER_FREQUENT, STATUS

function(states, event, ...)
    if "UNIT_POWER_FREQUENT" == event then
        local unitTarget = ...
        if unitTarget ~= "player" then
            return
        end
    end
    local max = aura_env.max or 1
    local result, state = false, {}
    if HWA and HWA.getPower then
        result, state = HWA.getPower(aura_env, false)
    end
    if result and state then
        if not state.show then
            for i = 1, max do
                states[i] = {
                    show = false,
                    changed = true,
                }
            end
            aura_env.max = 1
        else
            local rStates = state.states or {}
            local size = max(max, #rStates)
            for i = 1, size do
                if rStates[i] then
                    states[i] = rStates[i]
                    states[i].show = true
                    states[i].changed = true
                else
                    states[i] = {
                        show = false,
                        changed = true,
                    }
                end
            end
            local cooldown = {}
            for i = 1, #rStates do
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
            for i = 1, #rStates do
                local c = cooldown[i]
                if not c.isRuneReady then
                    states[i].progressType = "timed"
                    states[i].duration = c.duration
                    states[i].expirationTime = c.expirationTime
                end
            end
            aura_env.max = #rStates
            if aura_env.max == 0 then
                aura_env.max = 1
            end
        end
        return true
    end
    return false
end
