--[[
- Events: HWA_UNIT_AURA, HWA_UPDATE
--]]
-- Trigger
function(event, ...)
    local H = HWA or {}
    local env = aura_env or {}

    env.cache = env.cache or {}
    env.result = env.result or {}

    local key = "AURA"

    if "HWA_UPDATE" == event then
        local type = ...
        if type == "init" then
            if H.initAuraState then
                env.cache[key] = H.initAuraState(env, env.info)
            else
                env.cache[key] = {}
            end
        else
            return false
        end
    elseif "HWA_UNIT_AURA" == event then
        local unitTarget = ...
        if unitTarget then
            local matchedAura = env.cache[key] and env.cache[key].matchedAura or {}
            if not matchedAura[unitTarget] then
                return false
            end
        else
            return false
        end
    end

    env.cache[key] = env.cache[key] or {}

    if H.getAuraState then
        local result, data = H.getAuraState(env, env.cache[key], env.info)
        if result then
            if data then
                env.result[key] = data
                return true
            else
                env.result[key] = nil
                return false
            end
        end
    end
    return false
end

-- Untrigger
function(event, ...)
    local env = aura_env or {}
    local key = "AURA"
    local data = env.result and env.result[key]
    if data then
        return true
    end
    return false
end

-- Duration Info
function()
    local env = aura_env or {}
    local key = "AURA"
    local data = env.result and env.result[key]
    if data then
        return data.duration, data.expirationTime
    end
    return 0, 0
end

-- Name Info
function()
    local env = aura_env or {}
    local key = "AURA"
    local data = env.result and env.result[key]
    if data then
        return data.text
    end
end

-- Stack Info
function()
    local env = aura_env or {}
    local key = "AURA"
    local data = env.result and env.result[key]
    if data then
        return data.stacks
    end
    return 0
end
