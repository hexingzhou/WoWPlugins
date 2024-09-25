-- Events: UNIT_HEALTH, UNIT_TARGET, SPELL_UPDATE_CHARGES, SPELL_UPDATE_COOLDOWN, SPELL_UPDATE_USABLE, HWA_INIT, SL_WALKING

--[[
- Conditions:
{
    expirationTime = true,
    duration = true,
    value = true,
    total = true,
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
]]--

-- Function checks the spell states with a few targets.
-- It can work with spell using micros.
function(states, event)
    local key = "SPELL"
    local spellID = aura_env.spell and aura_env.spell.id or 0
    if spellID == 0 then
        local sID, count = aura_env.id:gsub(".+ %- ", "")
        spellID = tonumber(sID) or 0
    end
    local spellName = aura_env.spell and aura_env.spell.name or ""
    if spellName == "" then
        spellName = aura_env.id:gsub(" %- %d+", "")
    end
    if spellID == 0 and spellName == "" then
        states[key] = {
            show = false,
            changed = true
        }
        return true
    end

    local spell = nil
    if spellID == 0 then
        spell = spellName
    else
        spell = spellID
    end

    local spellInfo = C_Spell.GetSpellInfo(spell)
    if not spellInfo then
        states[key] = {
            show = false,
            changed = true
        }
        return true
    end

    local unitTargets = aura_env.unit_targets or { "target" }

    local icon = spellInfo and spellInfo.iconID
    local duration = 0
    local expirationTime = 0
    local stacks = 0
    local charges = 1
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
            charges = chargeInfo.currentCharges
        end
    else
        local globalCooldownInfo = C_Spell.GetSpellCooldown(61304)
        if globalCooldownInfo and globalCooldownInfo.isEnabled and globalCooldownInfo.duration > 0 then
            aura_env.gcd = globalCooldownInfo.duration
        end
        local spellCooldownInfo = C_Spell.GetSpellCooldown(spell)
        if spellCooldownInfo and spellCooldownInfo.isEnabled and spellCooldownInfo.duration > 0 then
            if aura_env.gcd and spellCooldownInfo.duration ~= aura_env.gcd then
                duration = spellCooldownInfo.duration
                expirationTime = spellCooldownInfo.startTime + spellCooldownInfo.duration
                charges = 0
            end
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
        charges = charges,
        isUsable = isUsable,
        noResource = noResource,
        isSpellInRange = isSpellInRange,
        hasTarget = hasTarget,
        healthPercent = healthPercent,
        priority = HWA and HWA.getPriority and HWA.getPriority(aura_env.priority or {}) or 0
    }
    return true
end
