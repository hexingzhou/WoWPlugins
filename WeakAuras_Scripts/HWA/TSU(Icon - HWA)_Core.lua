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
    gcd = {
        display = "法术存在公共冷却",
        type = "bool",
    },
    subDuration = {
        display = "监控持续时间",
        type = "number",
    },
    subExpirationTime = {
        display = "监控超时时间",
        type = "number",
    },
    subStacks = {
        display = "监控层数",
        type = "number",
    },
    -- 0: no glow, 1: pixel glow, 2: autocast shine, 3: action buttom glow
    glow = {
        display = "发光类型",
        type = "number",
    },
}
--]]
function(states, event, ...)
    aura_env.cache = aura_env.cache or {}
    aura_env.result = aura_env.result or {}

    local key = "CORE"

    local checkList = nil

    if "OPTIONS" == event then
        if HWA and HWA.initCoreStates then
            aura_env.cache[key] = HWA.initCoreStates(env, aura_env.core)
        else
            aura_env.cache[key] = {}
        end
    elseif "HWA_UPDATE" == event then
        local type = ...
        if type == "init" then
            if HWA and HWA.initCoreStates then
                aura_env.cache[key] = HWA.initCoreStates(env, aura_env.core)
            else
                aura_env.cache[key] = {}
            end
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
