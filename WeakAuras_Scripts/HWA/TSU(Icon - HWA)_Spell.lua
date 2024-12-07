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
function(states, event)
    local key = "SPELL"

    if HWA and HWA.getSpell then
        local result, state = HWA.getSpell(aura_env, aura_env.spell)
        if result and state then
            if state.show then
                states[key] = {
                    show = true,
                    changed = true,
                    progressType = state.progressType,
                    duration = state.duration,
                    expirationTime = state.expirationTime,
                    icon = state.icon,
                    stacks = state.stacks,
                    charges = state.charges,
                    isUsable = state.isUsable,
                    noResource = state.noResource,
                    isSpellInRange = state.isSpellInRange,
                    hasTarget = state.hasTarget,
                    healthPercent = state.healthPercent,
                    priority = state.priority,
                    init = state.init,
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
