--[[
- Events: HWA_UNIT_HEALTH, HWA_SPELL_IN_RANGE_UPDATE, SPELL_COOLDOWN_CHANGED, SPELL_UPDATE_USABLE, HWA_UPDATE_TOTEM, HWA_UNIT_AURA, HWA_UPDATE

- Conditions:
{
    duration = true,
    expirationTime = true,
    stacks = true,
    charges = {
        display = "充能",
        type = "number",
    },
    isSpellInRange = {
        display = "在法术可用范围内",
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
        display = "发光",
        type = "number",
    },
}
--]]
function(states, event, ...)
    local H = HWA or {}
    local env = aura_env or {}

    env.cache = env.cache or {}
    env.result = env.result or {}

    local key = "CORE"

    local checkList = {}

    if "HWA_UPDATE" == event then
        local type = ...
        if type == "init" then
            if H.initCoreStates then
                env.cache[key] = H.initCoreStates(env, env.info)
            else
                env.cache[key] = {}
            end
        end
    elseif "HWA_UNIT_HEALTH" == event or "HWA_SPELL_IN_RANGE_UPDATE" == event then
        local changed = ...
        if changed and next(changed) then
            for id, _ in pairs(changed) do
                checkList[id] = {}
            end
        else
            return false
        end
    elseif "SPELL_COOLDOWN_CHANGED" == event then
        local id = ...
        if id then
            local data = env.cache[key] and env.cache[key].data or {}
            if not data[id] then
                return false
            end
            checkList[id] = {}
        else
            return false
        end
    elseif "HWA_UPDATE_TOTEM" == event then
        local matchedTotem = env.cache[key] and env.cache[key].matchedTotem or {}
        if not next(matchedTotem) then
            return false
        end
        for _, id in ipairs(matchedTotem) do
            checkList[id] = {}
        end
    elseif "HWA_UNIT_AURA" == event then
        local unitTarget = ...
        if unitTarget then
            local matchedAura = env.cache[key]
                    and env.cache[key].matchedAura
                    and env.cache[key].matchedAura[unitTarget]
                or {}
            if not next(matchedAura) then
                return false
            end
            for _, id in ipairs(matchedAura) do
                checkList[id] = {}
            end
        else
            return false
        end
    end

    env.cache[key] = env.cache[key] or {}

    if H.getCoreStates then
        local result, datas = H.getCoreStates(env, env.cache[key], env.info, checkList)
        if result then
            local records = env.result[key] or {}
            local checks = checkList or {}
            if not next(checks) then
                checks = env.cache[key] and env.cache[key].data or {}
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
                    local data = datas[id]
                    if data then
                        states[id] = {
                            show = true,
                            changed = true,
                            progressType = data.progressType,
                            duration = data.duration,
                            expirationTime = data.expirationTime,
                            icon = data.icon,
                            stacks = data.stacks,
                            charges = data.charges,
                            isUsable = data.isUsable,
                            noResource = data.noResource,
                            isSpellInRange = data.isSpellInRange,
                            gcd = data.gcd,
                            priority = data.priority,
                            init = data.init,
                            subDuration = data.subDuration,
                            subExpirationTime = data.subExpirationTime,
                            subStacks = data.subStacks,
                            glow = data.glow,
                            index = data.index,
                        }
                        records[id] = data
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
            env.result[key] = records
            return true
        end
    end
    return false
end
