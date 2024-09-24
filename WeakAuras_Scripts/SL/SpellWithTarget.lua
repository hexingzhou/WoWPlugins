-- Events: UNIT_HEALTH, UNIT_TARGET, SPELL_UPDATE_CHARGES, SPELL_UPDATE_COOLDOWN, SPELL_UPDATE_USABLE, HWA_INIT, SL_WALKING

--[[
- Conditions:
{
    expirationTime = true,
    duration = true,
    value = true,
    total = true,
    stacks = true,
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
]]--

-- Function checks the spell states with a few targets.
-- It can work with spell using micros.
function(states, event)
    local key = "SPELL"
    local spellID = aura_env.spell and aura_env.spell.id or aura_env.id:gsub(".+ %- ", "")
    local spellName = aura_env.spell and aura_env.spell.name or aura_env.id:gsub(" %- %d+", "")
    if spellID == 0 and spellName == "" then
        states[key] = {
            show = false,
            changed = true
        }
        return true
    end
    local unitTargets = aura_env.unit_targets or { "target" }

    local spell = spellID or spellName

    local spellInfo = C_Spell.GetSpellInfo(spell)
    if not spellInfo then
        states[key] = {
            show = false,
            changed = true
        }
        return true
    end

    local icon = spellInfo and spellInfo.iconID
    local duration = 0
    local expirationTime = 0
    local stacks = 0
    local isSpellInRange = false
    local hasTarget = false
    local isUsable, noResource = C_Spell.IsSpellUsable(spell)
    local healthPercent = 0

    local chargeInfo = C_Spell.GetSpellCharges(spell)
    if chargeInfo then
        if chargeInfo.currentCharges < chargeInfo.maxCharges then
            duration = chargeInfo.cooldownDuration
            expirationTime = chargeInfo.cooldownStartTime + chargeInfo.cooldownDuration
        end
        if chargeInfo.maxCharges > 1 then
            stacks = chargeInfo.currentCharges
        end
    end

    for i = 1, #unitTargets do
        local inRange = C_Spell.IsSpellInRange(spell, unitTargets[i])
        if inRange ~= nil then
            isSpellInRange = inRange == 1
            hasTarget = true
            healthPercent = UnitHealth(unitTargets[i]) / UnitHealthMax(unitTargets[i]) * 100
            break
        end
    end

    states[key] = {
        show = true,
        changed = true,
        progressType = "timed",
        duration = duration,
        expirationTime = expirationTime,
        icon = icon,
        stacks = stacks,
        isUsable = isUsable,
        noResource = noResource,
        isSpellInRange = isSpellInRange,
        hasTarget = hasTarget,
        healthPercent = healthPercent,
        priority = HWA and HWA.getPriority and HWA.getPriority(aura_env.priority or {}) or 0
    }
    return true
end
