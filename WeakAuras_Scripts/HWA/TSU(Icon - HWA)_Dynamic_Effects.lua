--[[
- Events: HWA_UPDATE_TOTEM, HWA_UNIT_AURA, HWA_UPDATE

- Conditions:
{
    duration = true,
    expirationTime = true,
    stacks = true,
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

    local key = "DYNAMIC_EFFECTS"

    local checkList = {}

    if "HWA_UPDATE" == event then
        local type = ...
        if type == "init" then
            if H.initDynamicEffectStates then
                env.cache[key] = H.initDynamicEffectStates(env, env.info)
            else
                env.cache[key] = {}
            end
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
            if not matchedAura then
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

    if H.getDynamicEffectStates then
        local result, datas = H.getDynamicEffectStates(env, env.cache[key], env.info, checkList)
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
                            glow = data.glow,
                            index = data.index,
                            priority = data.priority,
                            init = data.init,
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
