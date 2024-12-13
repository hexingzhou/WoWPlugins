--[[
- Events: PLAYER_TOTEM_UPDATE, HWA_UNIT_AURA, HWA_UPDATE

- Conditions:
{
    duration = true,
    expirationTime = true,
    stacks = true,
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

    local key = "DYNAMIC_EFFECTS"

    local checkList = nil

    if "HWA_UPDATE" == event then
        local type = ...
        if type == "init" then
            if HWA and HWA.initDynamicEffectStates then
                aura_env.cache[key] = HWA.initDynamicEffectStates(aura_env, aura_env.info)
            else
                aura_env.cache[key] = {}
            end
        else
            return false
        end
    elseif "PLAYER_TOTEM_UPDATE" == event then
        local totemSlot = ...
        if totemSlot then
            local totemSlots = { totemSlot }
            local totemList = aura_env.cache[key] and aura_env.cache[key].totemList
            if not totemList then
                return false
            end
            local param = {
                totemSlots = totemSlots,
            }
            checkList = checkList or {}
            for _, id in ipairs(auraList) do
                checkList[id] = param
            end
        else
            return false
        end
    elseif "HWA_UNIT_AURA" == event then
        local unitTarget = ...
        if unitTarget then
            local unitTargets = { unitTarget }
            local auraList = aura_env.cache[key]
                and aura_env.cache[key].auraList
                and aura_env.cache[key].auraList[unitTarget]
            if not auraList then
                return false
            end
            local param = {
                unitTargets = unitTargets,
            }
            checkList = checkList or {}
            for _, id in ipairs(auraList) do
                checkList[id] = param
            end
        else
            return false
        end
    end

    if HWA and HWA.getDynamicEffectStates then
        aura_env.cache[key] = aura_env.cache[key] or {}

        local result, state = HWA.getDynamicEffectStates(aura_env, aura_env.cache[key], aura_env.info, checkList)
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
                            glow = s.glow,
                            index = s.index,
                            priority = s.priority,
                            init = s.init,
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
