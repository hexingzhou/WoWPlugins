--[[
- Events: 
UNIT_HEALTH, UNIT_TARGET, SPELL_UPDATE_CHARGES, SPELL_UPDATE_COOLDOWN, SPELL_UPDATE_USABLE, UPDATE_SHAPESHIFT_FORM, HWA_INIT
or
-- Call WeakAuras.WatchSpellCooldown(id) in Actions - On Init - Custom. Once initialised, will fire "events" for the spell.
SPELL_COOLDOWN_READY:id, SPELL_COOLDOWN_CHANGED:id

- Conditions:
{
    duration = true,
    expirationTime = true,
    stacks = true,
    charges = {
        display = "充能",
        type = "number"
    },
    healthPercent = {
        display = "生命百分比",
        type = "number"
    },
    isSpellInRange = {
        display = "在法术可用范围内",
        type = "bool"
    },
    hasTarget = {
        display = "目标存在",
        type = "bool"
    },
    noResource = {
        display = "资源不足",
        type = "bool"
    },
    isUsable = {
        display = "法术可用",
        type = "bool"
    }
}
--]]
-- Function checks the spell states with a few targets.
-- It can work with spell using micros.
function(states, event)
    local key = "SPELL"
    local initTime = 0
    if "HWA_INIT" == event then
        initTime = GetTime()
    end
    local result, state = false, {}
    if HWA and HWA.getSpell then
        result, state = HWA.getSpell(aura_env)
    end
    if result and state then
        if not state.show then
            states[key] = {
                show = false,
                changed = true
            }
        else
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
                initTime = initTime,
            }
        end
        return true
    end
    return false
end
