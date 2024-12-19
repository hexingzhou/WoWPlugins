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
    local H = HWA or {}
    local env = aura_env or {}

    env.cache = env.cache or {}

    local key = "SPELL"
    local config = env.info

    if "HWA_UPDATE" == event then
        local type = ...
        if type == "init" then
            if H.initSpellState then
                env.cache[key] = H.initSpellState(env, env.info)
            else
                env.cache[key] = {}
            end
        end
    elseif "HWA_UNIT_HEALTH" == event or "HWA_SPELL_IN_RANGE_UPDATE" == event then
        local changed = ...
        if not changed or not changed[env.cache[key] and env.cache[key].id or 0] then
            return false
        end
    elseif "SPELL_COOLDOWN_CHANGED" == event then
        local id = ...
        if id ~= (env.cache[key] and env.cache[key].id or 0) then
            return false
        end
    end

    env.cache[key] = env.cache[key] or {}

    if H.getSpellState then
        local result, data = H.getSpellState(env, env.cache[key], env.info)
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
