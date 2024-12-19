--[[
- Events: HWA_UPDATE_TOTEM, HWA_UPDATE
--]]
-- Trigger
function(event, ...)
    local H = HWA or {}
    local env = aura_env or {}

    env.cache = env.cache or {}
    env.result = env.result or {}

    local key = "TOTEM"

    if "HWA_UPDATE" == event then
        local type = ...
        if type == "init" then
            if H.initTotemState then
                env.cache[key] = H.initTotemState(env, env.info)
            else
                env.cache[key] = {}
            end
        else
            return false
        end
    elseif "HWA_UPDATE_TOTEM" == event then
        local matchedTotem = env.cache[key] and env.cache[key].matchedTotem or {}
        if not next(matchedTotem) then
            return false
        end
    end

    env.cache[key] = env.cache[key] or {}

    if H.getTotemState then
        local result, data = H.getTotemState(env, env.cache[key], env.info)
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
    local key = "TOTEM"
    local data = env.result and env.result[key]
    if data then
        return true
    end
    return false
end

-- Duration Info
function()
    local env = aura_env or {}
    local key = "TOTEM"
    local data = env.result and env.result[key]
    if data then
        return data.duration, data.expirationTime
    end
    return 0, 0
end

-- Stack Info
function()
    local env = aura_env or {}
    local key = "TOTEM"
    local data = env.result and env.result[key]
    if data then
        return data.stacks
    end
    return 0
end
