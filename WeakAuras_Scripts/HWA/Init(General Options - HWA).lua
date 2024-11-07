HWA = HWA or {}

local function tcontains(t, v)
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

function HWA.getShow(config)
    if not config then
        return true
    end
    local show = config.show or 0
    local formID = nil
    if config.form then
        formID = GetShapeshiftFormID() or 0
        local s = config.form[formID] and config.form[formID].show or 0
        if s ~= 0 then
            show = s
        end
    end
    if config.spec then
        local specID = 0
        local spec = GetSpecialization()
        if spec then
            specID = GetSpecializationInfo(spec) or 0
        end
        local sConfig = config.spec[specID]
        if sConfig then
            local s = sConfig.show or 0
            if s ~= 0 then
                show = s
            end
            if sConfig.form then
                if not formID then
                    formID = GetShapeshiftFormID() or 0
                end
                s = sConfig.form[formID] and sConfig.form[formID].show or 0
                if s ~= 0 then
                    show = s
                end
            end
        end
    end
    if show < 0 then
        return false
    else
        return true
    end
end

function HWA.getPriority(env)
    local c = env and env.priority
    if not c then
        return 0
    end

    local specID = 0
    local spec = GetSpecialization()
    if spec then
        specID = GetSpecializationInfo(spec) or 0
    end
    local formID = GetShapeshiftFormID() or 0

    local p = c.value or 0
    local fp = c.form and c.form[formID] or 0
    if fp ~= 0 then
        p = fp
    end

    local cs = c.spec and c.spec[specID] or {}
    local sp = cs.value or 0
    if sp ~= 0 then
        p = sp
    end
    local sfp = cs.form and c.form[formID] or 0
    if sfp ~= 0 then
        p = sfp
    end

    return p
end

-- Get spell info.
function HWA.getSpell(env)
    if not HWA.getShow(env.spell) then
        return true, {
            show = false,
        }
    end

    local spellID = env.spell and env.spell.id or 0
    if spellID == 0 then
        local sID, count = env.id:gsub(".+ %- ", "")
        spellID = tonumber(sID) or 0
    end
    local spellName = env.spell and env.spell.name or ""
    if spellName == "" then
        spellName = env.id:gsub(" %- %d+", "")
    end
    if spellID == 0 and spellName == "" then
        return true, {
            show = false,
        }
    end

    local spell = nil
    if spellID == 0 then
        spell = spellName
    else
        spell = spellID
    end

    local spellInfo = C_Spell.GetSpellInfo(spell)
    if not spellInfo then
        return true, {
            show = false,
        }
    end

    local unitTargets = env.unit_targets or { "target" }

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
            env.gcd = globalCooldownInfo.duration
        end
        local spellCooldownInfo = C_Spell.GetSpellCooldown(spell)
        if spellCooldownInfo and spellCooldownInfo.isEnabled and spellCooldownInfo.duration > 0 then
            if env.gcd and spellCooldownInfo.duration ~= env.gcd then
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

    return true,
        {
            show = true,
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
            priority = HWA.getPriority(env) or 0,
        }
end

-- Get totem info.
function HWA.getTotem(env, init, totemSlot)
    if init then
        env.totems = {}
        return true, {
            show = false,
        }
    end

    if not totemSlot then
        return false
    end

    -- There may be more than one totem exist at the same time.
    local name = env.totem and env.totem.name or ""
    if name == "" then
        name = env.id:gsub(" %- %d+", "")
    end

    local totems = env.totems or {}

    local haveTotem, totemName, startTime, duration, icon = GetTotemInfo(totemSlot)

    if haveTotem and name == totemName then
        local inCache = false
        for i = 1, #totems do
            local totem = totems[i]
            if totem.totemSlot == totemSlot then
                totem.duration = duration
                totem.expirationTime = startTime + duration
                inCache = true
                break
            end
        end
        if not inCache then
            local totem = {}
            totem.totemSlot = totemSlot
            totem.duration = duration
            totem.expirationTime = startTime + duration

            table.insert(totems, totem)
        end
    else
        for i = #totems, 1, -1 do
            local totem = totems[i]
            if totem.totemSlot == totemSlot then
                table.remove(totems, i)
            end
        end
    end

    -- Sorted by the expirationTime of totem. The first totem will be choozen.
    table.sort(totems, function(a, b)
        return a.expirationTime > b.expirationTime
    end)

    env.totems = totems

    if totems[1] then
        local stacks = 0
        if #totems > 1 then
            stacks = #totems
        end
        return true,
            {
                show = true,
                progressType = "timed",
                duration = totems[1].duration,
                expirationTime = totems[1].expirationTime,
                stacks = stacks,
            }
    else
        return true, {
            show = false,
        }
    end
end

-- Get aura info.
function HWA.getAura(env, init, unitTarget)
    if init then
        env.auras = {}
        return true, {
            show = false,
        }
    end
    if not unitTarget then
        return false
    end

    env.auras = env.auras or {}
    env.auras[unitTarget] = env.auras[unitTarget] or {}

    local auras = env.auras[unitTarget] or {}
    local configs = env.configs or {}
    local strategies = env.strategies or {}

    local currentAuras = {}

    -- Find current auras.
    for i, config in ipairs(configs) do
        local unitTargets = config.unit_targets
        local sourceUnits = config.source_units
        if tcontains(unitTargets, unitTarget) then
            local info = C_UnitAuras.GetAuraDataByAuraInstanceID(unitTarget, config.id or 0)
            if info and tcontains(sourceUnits, info.sourceUnit) then
                table.insert(currentAuras, {
                    index = i,
                    strategy = strategies[config.group or 0] or {},
                    unitTarget = unitTarget,
                    auraInstanceID = auraData.auraInstanceID,
                    charges = auraData.charges,
                    duration = auraData.duration,
                    expirationTime = auraData.expirationTime,
                    icon = auraData.icon,
                    maxCharges = auraData.maxCharges,
                    points = auraData.points,
                    sourceUnit = auraData.sourceUnit,
                    spellID = auraData.spellId,
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
            if
                aura.unitTarget == currentAura.unitTarget
                and aura.auraInstanceID == currentAura.auraInstanceID
                and aura.sourceUnit == currentAura.sourceUnit
            then
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

    if not next(auras) then
        return true, {
            show = false,
        }
    end

    -- Use strategies to sort auras.
    table.sort(auras, function(a, b)
        local priorityA = a.strategy.priority or 0
        local priorityB = b.strategy.priority or 0
        if priorityA == priorityB then
            return a.index < b.index
        end
        return priorityA < priorityB
    end)

    -- Use auras cache to update states.
    local getState = auras[1].strategy.get_state
        or function(auras)
            local aura = auras[1]
            local stacks = 0
            if aura.charges > 1 then
                stacks = aura.charges
            end
            return {
                progressType = "timed",
                duration = aura.duration,
                expirationTime = aura.expirationTime,
                stacks = stacks,
            }
        end
    local state = getState(auras)
    if state then
        return true,
            {
                show = true,
                progressType = state.progressType,
                duration = state.duration,
                expirationTime = state.expirationTime,
                name = state.name,
                stacks = state.stacks,
            }
    else
        return true, {
            show = false,
        }
    end
end

function HWA.getPower(env, init)
    if init then
        return true, {
            show = false,
        }
    end
    local config = env and env.power or {}
    local unit = config.unit or "player"
    local type = config.type or -1
    if type == -1 then
        type = Enum.PowerType[env.id:gsub(" %- .+", "")]
    end
    local unmodified = config.unmodified or false
    local per = config.per or 1

    local current = UnitPower(unit, type, unmodified)
    local maxCount = UnitPowerMax(unit, type, unmodified) / per
    local states = {}
    for i = 1, maxCount do
        states[i] = {
            show = true,
            progressType = "static",
            total = per,
        }
        local value = current - per * (i - 1)
        if value > per then
            value = per
        end
        states[i].value = value
    end
    return true, {
        show = true,
        states = states,
    }
end
