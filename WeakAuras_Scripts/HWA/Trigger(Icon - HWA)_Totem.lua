--[[
- Events: HWA_UPDATE_TOTEM, HWA_UPDATE
--]]
-- Trigger
function(event, ...)
    aura_env.cache = aura_env.cache or {}
    aura_env.result = aura_env.result or {}

    local key = "TOTEM"

    if "HWA_UPDATE" == event then
        local type = ...
        if type == "init" then
            if HWA and HWA.initTotemState then
                aura_env.cache[key] = HWA.initTotemState(aura_env, aura_env.info)
            else
                aura_env.cache[key] = {}
            end
        else
            return false
        end
    elseif "HWA_UPDATE_TOTEM" == event then
        local matchedTotem = aura_env.cache[key] and aura_env.cache[key].matchedTotem or {}
        if not next(matchedTotem) then
            return false
        end
    end

    aura_env.cache[key] = aura_env.cache[key] or {}

    if HWA and HWA.getTotemState then
        local result, data = HWA.getTotemState(aura_env, aura_env.cache[key], aura_env.info)
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
    local key = "TOTEM"
    local data = aura_env.result and aura_env.result[key]
    if data then
        return true
    end
    return false
end

-- Duration Info
function()
    local key = "TOTEM"
    local data = aura_env.result and aura_env.result[key]
    if data then
        return data.duration, data.expirationTime
    end
    return 0, 0
end

-- Stack Info
function()
    local key = "TOTEM"
    local data = aura_env.result and aura_env.result[key]
    if data then
        return data.stacks
    end
    return 0
end
