-- Events: UNIT_AURA, STATUS

--[[
- Conditions:
{
    duration = true,
    expirationTime = true,
    stacks = true
}
]]--
function(states, event, ...)
    local key = "AURA"

    if "STATUS" == event then
        aura_env.auras = {}
        states[key] = {
            show = false,
            changed = true
        }
        return true
    end

    local unitTarget, updateInfo = ...
    if not updateInfo or updateInfo.isFullUpdate then
        return false
    end

    aura_env.auras = aura_env.auras or {}
    aura_env.auras[unitTarget] = aura_env.auras[unitTarget] or {}

    local auras = aura_env.auras[unitTarget] or {}
    local configs = aura_env.configs or {}

    local tcontains = function(t, v)
        if not t then
            return false
        end
        if not v then
            return true
        end
        for _, value in ipairs(t) do
                if v == value then
                return true
            end
        end
        return false
    end

    local currentAuras = {}

    -- Find current auras.
    for i, config in ipairs(configs) do
        local unitTargets = config.unit_targets
        local sourceUnits = config.source_units
        if tcontains(unitTargets, unitTarget) then
            local info = C_UnitAuras.GetAuraDataByAuraInstanceID(unitTarget, config.id)
            if info and tcontains(sourceUnits, info.sourceUnit) then
                table.insert(currentAuras, {
                    configIndex = i,
                    unitTarget = unitTarget,
                    auraInstanceID = auraData.auraInstanceID,
                    charges = auraData.charges,
                    duration = auraData.duration,
                    expirationTime = auraData.expirationTime,
                    icon = auraData.icon,
                    maxCharges = auraData.maxCharges,
                    points = auraData.points,
                    sourceUnit = auraData.sourceUnit,
                    spellID = auraData.spellId
                })
            end
        end
    end

    -- Update auras cache.
    for i = #auras, 1, -1 do
        local aura = auras[i]
        local inCache = false
        for index = #currentAuras, 1, -1 do
            local currentAura = currentAuras[index]
            if aura.unitTarget == currentAura.unitTarget and aura.auraInstanceID == currentAura.auraInstanceID and aura.sourceUnit == currentAura.sourceUnit then
                aura.configIndex = currentAura.configIndex
                aura.charges = currentAura.charges
                aura.duration = currentAura.duration
                aura.expirationTime = currentAura.expirationTime
                aura.icon = currentAura.icon
                aura.maxCharges = currentAura.maxCharges
                aura.points = currentAura.points
                aura.spellID = currentAura.spellID
                inCache = true
                table.remove(currentAuras, index)
            end
        end
        if not inCache then
            table.remove(auras, i)
        end
    end

    -- Use auras cache to update states.
    -- Ignore strategies. Use the first one in cache.
    local aura = auras[1]
    if aura then
        local stacks = 0
        if aura.charges > 1 then
            states = aura.charges
        end
        states[key] = {
            show = true,
            changed = true,
            autoHide = true,
            progressType = "timed",
            duration = aura.duration,
            expirationTime = aura.expirationTime,
            stacks = stacks
        }
    else
        states[key] = {
            show = false,
            changed = true
        }
    end

    return true
end