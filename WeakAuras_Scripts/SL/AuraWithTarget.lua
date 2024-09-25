-- Events: UNIT_AURA

function(states, event, ...)
    local unitTarget, updateInfo = ...
    if not updateInfo then
        return false
    end

    local auras = aura_env.auras or {}

    if updateInfo.addedAuras then
        local tcontains = function(t, v)
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
        for _, auraData in ipairs(updateInfo.addedAuras) do
            for aura, info in ipairs(aura_env.info or {}) do
                local unitTargets = info.unit_targets or {}
                local sourceUnits = info.source_units or {}
                if tcontains(unitTargets, unitTarget) and tcontains(sourceUnits, auraData.sourceUnit) and aura == auraData.auraInstanceID then
                    
                end
            end
        end
    end

    local aura = 0
    local info = nil
    for i, v in ipairs(aura_env.info or {}) do
        
    end
end