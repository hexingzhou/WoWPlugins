--[[
- Events: HWA_UNIT_AURA, HWA_UPDATE
--]]
-- Trigger
function(event, ...)
    aura_env.cache = aura_env.cache or {}
    aura_env.result = aura_env.result or {}

    local key = "AURA"

    if "HWA_UPDATE" == event then
        local type = ...
        if type == "init" then
            if HWA and HWA.initAuraState then
                aura_env.cache[key] = HWA.initAuraState(aura_env, aura_env.info)
            else
                aura_env.cache[key] = {}
            end
        else
            return false
        end
    elseif "HWA_UNIT_AURA" == event then
        local unitTarget = ...
        if unitTarget then
            local matchedAura = aura_env.cache[key] and aura_env.cache[key].matchedAura or {}
            if not matchedAura[unitTarget] then
                return false
            end
        else
            return false
        end
    end

    aura_env.cache[key] = aura_env.cache[key] or {}

    if HWA and HWA.getAuraState then
        local result, data = HWA.getAuraState(aura_env, aura_env.cache[key], aura_env.info)
        if result then
            if data then
                aura_env.result[key] = data
                return true
            else
                aura_env.result[key] = nil
                return false
            end
        end
    end
    return false
end

-- Untrigger
function(event, ...)
    local key = "AURA"
    local data = aura_env.result and aura_env.result[key]
    if data then
        return true
    end
    return false
end

-- Duration Info
function()
    local key = "AURA"
    local data = aura_env.result and aura_env.result[key]
    if data then
        return data.duration, data.expirationTime
    end
    return 0, 0
end

-- Stack Info
function()
    local key = "AURA"
    local data = aura_env.result and aura_env.result[key]
    if data then
        return data.stacks
    end
    return 0
end
