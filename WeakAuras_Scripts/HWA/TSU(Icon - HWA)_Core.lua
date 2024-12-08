--[[
- Events: UNIT_HEALTH, UNIT_TARGET, SPELL_UPDATE_CHARGES, SPELL_UPDATE_COOLDOWN, SPELL_UPDATE_USABLE, HWA_UPDATE

- Conditions:
{
    duration = true,
    expirationTime = true,
    stacks = true,
    charges = {
        display = "充能",
        type = "number",
    },
    healthPercent = {
        display = "生命百分比",
        type = "number",
    },
    isSpellInRange = {
        display = "在法术可用范围内",
        type = "bool",
    },
    hasTarget = {
        display = "目标存在",
        type = "bool",
    },
    noResource = {
        display = "资源不足",
        type = "bool",
    },
    isUsable = {
        display = "法术可用",
        type = "bool",
    },
}
--]]
function(states, event, ...)
    aura_env.cache = aura_env.cache or {}
    aura_env.result = aura_env.result or {}

    local key = "CORE"

    local checkList = nil

    if "OPTIONS" == event then
        aura_env.cache[key] = {}
    elseif "HWA_UPDATE" == event then
        local type = ...
        if type == "init" then
            aura_env.cache[key] = {}
        end
    end

    if HWA and HWA.getCoreStates then
        aura_env.cache[key] = aura_env.cache[key] or {}

        local result, state = HWA.getCoreStates(aura_env, aura_env.cache[key], aura_env.core, checkList)
        if result and state then
            local records = aura_env.result[key] or {}
            local checks = checkList or {}
            if not next(checks) then
                checks = aura_env.cache[key]
                for id, record in pairs(records) do
                    if not checks[id] and record then
                        states[id] = {
                            show = false,
                            changed = true,
                        }
                        records[id] = nil
                    end
                end
            end
            for id, _ in pairs(checks) do
                if state.show then
                    local s = state.states[id]
                    if s then
                        states[id] = {
                            show = true,
                            changed = true,
                            progressType = s.progressType,
                            duration = s.duration,
                            expirationTime = s.expirationTime,
                            icon = s.icon,
                            stacks = s.stacks,
                            charges = s.charges,
                            isUsable = s.isUsable,
                            noResource = s.noResource,
                            isSpellInRange = s.isSpellInRange,
                            hasTarget = s.hasTarget,
                            healthPercent = s.healthPercent,
                            priority = s.priority,
                            init = s.init,
                            index = s.index,
                        }
                        records[id] = s
                    else
                        states[id] = {
                            show = false,
                            changed = true,
                        }
                        records[id] = nil
                    end
                else
                    states[id] = {
                        show = false,
                        changed = true,
                    }
                    records[id] = nil
                end
            end
            aura_env.result[key] = records
            return true
        end
    end
    return false
end
