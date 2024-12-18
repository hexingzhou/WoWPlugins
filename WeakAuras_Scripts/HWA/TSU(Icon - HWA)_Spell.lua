--[[
- Events: HWA_UNIT_HEALTH, HWA_SPELL_IN_RANGE_UPDATE, SPELL_COOLDOWN_CHANGED, SPELL_UPDATE_USABLE, HWA_UPDATE

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
    -- 0: no glow, 1: pixel glow, 2: autocast shine, 3: action buttom glow
    glow = {
        display = "发光",
        type = "number",
    },
}
--]]
function(states, event, ...)
    aura_env.cache = aura_env.cache or {}

    local key = "SPELL"
    local config = aura_env.info

    if "HWA_UPDATE" == event then
        local type = ...
        if type == "init" then
            if HWA and HWA.initSpellState then
                aura_env.cache[key] = HWA.initSpellState(aura_env, aura_env.info)
            else
                aura_env.cache[key] = {}
            end
        end
    elseif "HWA_UNIT_HEALTH" == event or "HWA_SPELL_IN_RANGE_UPDATE" == event then
        local changed = ...
        if not changed or not changed[aura_env.cache[key] and aura_env.cache[key].id or 0] then
            return false
        end
    elseif "SPELL_COOLDOWN_CHANGED" == event then
        local id = ...
        if id ~= (aura_env.cache[key] and aura_env.cache[key].id or 0) then
            return false
        end
    end

    aura_env.cache[key] = aura_env.cache[key] or {}

    if HWA and HWA.getSpellState then
        local result, data = HWA.getSpellState(aura_env, aura_env.cache[key], aura_env.info)
        if result then
            if data then
                states[key] = {
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
                    priority = data.priority,
                    init = data.init,
                }
            else
                states[key] = {
                    show = false,
                    changed = true,
                }
            end
            return true
        end
    end
    return false
end
