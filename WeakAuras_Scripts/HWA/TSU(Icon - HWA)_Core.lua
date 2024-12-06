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
function a(states, event)
    local result, state = false, {}
    if HWA and HWA.getCoreStates then
        result, state = HWA.getCoreStates(aura_env)
    end
    if result and state then
        for id, s in pairs(state.states) do
            if not s.show then
                states[id] = {
                    show = false,
                    changed = true,
                }
            else
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
                }
            end
        end
        return true
    end
    return false
end
