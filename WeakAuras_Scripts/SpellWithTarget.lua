-- Events: UNIT_HEALTH, UNIT_TARGET, SPELL_UPDATE_CHARGES, SPELL_UPDATE_COOLDOWN, SPELL_UPDATE_USABLE, SL_WALKING

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
        display = "可用",
        type = "bool"
    }
}
]]--

-- Function checks the spell states with a few targets.
-- It should work with spell using micros.
function(allstates, event)
    local spellName = "" -- TODO: Set the name of spell for check.
    local unitTargets = {
        "target",
        "targettarget",
        "targettargettarget",
        "targettargettargettarget"
    } -- Target will be checked under the order of the value in this table.

    if aura_env.spellName ~= spellName then
        aura_env.spellName = spellName
        aura_env.icon = select(3, GetSpellInfo(spellName))
    end

    local icon = aura_env.icon
    local duration = 0
    local expirationTime = 0
    local stacks = 0
    local isSpellInRange = false
    local hasTarget = false
    local isUsable, noResource = IsUsableSpell(spellName)
    local healthPercent = 0

    local currentCharges, maxCharges, cooldownStart, cooldownDuration, chargeModRate = GetSpellCharges(spellName)
    if currentCharges < maxCharges then
        duration = cooldownDuration
        expirationTime = cooldownStart + cooldownDuration
    end
    if maxCharges > 1 then
        stacks = currentCharges
    end

    for i = 1, #unitTargets do
        local inRange = IsSpellInRange(spellName, unitTargets[i])
        if inRange ~= nil then
            isSpellInRange = inRange == 1
            hasTarget = true
            healthPercent = UnitHealth(unitTargets[i]) / UnitHealthMax(unitTargets[i]) * 100
            break
        end
    end

    allstates["SPELL"] = {
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
        healthPercent = healthPercent
    }
    return true
end
