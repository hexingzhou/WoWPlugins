--[[
- Events: OPTIONS, STATUS, PLAYER_ENTERING_WORLD, PLAYER_SPECIALIZATION_CHANGED, TRAIT_CONFIG_UPDATED, GROUP_JOINED, GROUP_LEFT, UPDATE_SHAPESHIFT_FORM, HWA_OPTIONS, HWA_INIT
--]]
function(states, event, ...)
    local H = HWA
    local env = aura_env or {}

    if not H then
        return
    end

    if "OPTIONS" == event or "STATUS" == event or "HWA_OPTIONS" == event  then
        -- Reset config first.
        H.getConfig()
        -- Then, delay init.
        H.initThrottled()
    elseif "HWA_INIT" == event then
        local delay = ...
        if delay then
            H.initThrottled()
        else
            H.init()
        end
    elseif
        "PLAYER_ENTERING_WORLD" == event
        or "PLAYER_SPECIALIZATION_CHANGED" == event
        or "TRAIT_CONFIG_UPDATED" == event
        or "GROUP_JOINED" == event
        or "GROUP_LEFT" == event
    then
        H.initThrottled()
        C_Timer.After(1, function()
            WeakAuras.ScanEvents("HWA_INIT", true)
        end)
    elseif "UPDATE_SHAPESHIFT_FORM" == event then
        local formID = H.getFixedShapeshiftFormID() or 0
        if env.formID ~= formID then
            env.formID = formID
            WeakAuras.ScanEvents("HWA_UPDATE", "form")
        end
    end
end
