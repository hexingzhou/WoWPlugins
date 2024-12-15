--[[
- Events: UNIT_HEALTH, PLAYER_TARGET_CHANGED, SPELL_COOLDOWN_CHANGED, SPELL_UPDATE_USABLE, PLAYER_TOTEM_UPDATE, HWA_UNIT_AURA, HWA_UPDATE

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

    local checkList = {}

    if "HWA_UPDATE" == event then
        local type = ...
        if type == "init" then
            if HWA and HWA.initCoreStates then
                aura_env.cache[key] = HWA.initCoreStates(aura_env, aura_env.info)
            else
                aura_env.cache[key] = {}
            end
        end
    elseif "UNIT_HEALTH" == event then
        local unitTarget = ...
        if unitTarget == "target" then
            local matchedTarget = aura_env.cache[key] and aura_env.cache[key].matchedTarget or {}
            if not next(matchedTarget) then
                return false
            end
            for _, id in ipairs(matchedTarget) do
                checkList[id] = {}
            end
        else
            return false
        end
    elseif "PLAYER_TARGET_CHANGED" == event then
        local matchedTarget = aura_env.cache[key] and aura_env.cache[key].matchedTarget or {}
        if not next(matchedTarget) then
            return false
        end
        local param = {
            unitTargets = { "target" },
        }
        for _, id in ipairs(matchedTarget) do
            checkList[id] = param
        end
    elseif "SPELL_COOLDOWN_CHANGED" == event then
        local id = ...
        local data = aura_env.cache[key] and aura_env.cache[key].data or {}
        if data[id] then
            checkList[id] = {}
        else
            return false
        end
    elseif "PLAYER_TOTEM_UPDATE" == event then
        local totemSlot = ...
        if totemSlot then
            local matchedTotem = aura_env.cache[key] and aura_env.cache[key].matchedTotem or {}
            if not next(matchedTotem) then
                return false
            end
            local param = {
                totemSlots = { totemSlot },
            }
            for _, id in ipairs(matchedTotem) do
                checkList[id] = param
            end
        else
            return false
        end
    elseif "HWA_UNIT_AURA" == event then
        local unitTarget = ...
        if unitTarget then
            local matchedAura = aura_env.cache[key]
                    and aura_env.cache[key].matchedAura
                    and aura_env.cache[key].matchedAura[unitTarget]
                or {}
            if not next(matchedAura) then
                return false
            end
            local param = {
                unitTargets = { unitTarget },
            }
            for _, id in ipairs(matchedAura) do
                checkList[id] = param
            end
        else
            return false
        end
    end

    aura_env.cache[key] = aura_env.cache[key] or {}

    if HWA and HWA.getCoreStates then
        local result, datas = HWA.getCoreStates(aura_env, aura_env.cache[key], aura_env.info, checkList)
        if result then
            local records = aura_env.result[key] or {}
            local checks = checkList or {}
            if not next(checks) then
                checks = aura_env.cache[key] and aura_env.cache[key].data or {}
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
                if datas then
                    local s = datas[id]
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
                            gcd = s.gcd,
                            priority = s.priority,
                            init = s.init,
                            subDuration = s.subDuration,
                            subExpirationTime = s.subExpirationTime,
                            subStacks = s.subStacks,
                            glow = s.glow,
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
