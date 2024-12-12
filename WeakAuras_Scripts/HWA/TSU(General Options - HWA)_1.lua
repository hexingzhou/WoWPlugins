--[[
- Events: PLAYER_ENTERING_WORLD, PLAYER_SPECIALIZATION_CHANGED, TRAIT_CONFIG_UPDATED, GROUP_JOINED, GROUP_LEFT, UPDATE_SHAPESHIFT_FORM, HWA_INIT
--]]
function(states, event, ...)
    if not HWA then
        return
    end

    if "STATUS" == event then
        -- Reset config first.
        HWA.getConfig()
        -- Then, delay init.
        HWA.initThrottled()
    elseif "HWA_INIT" == event then
        local delay = ...
        if delay then
            HWA.initThrottled()
        else
            HWA.init()
        end
    elseif
        "PLAYER_ENTERING_WORLD" == event
        or "PLAYER_SPECIALIZATION_CHANGED" == event
        or "TRAIT_CONFIG_UPDATED" == event
        or "GROUP_JOINED" == event
        or "GROUP_LEFT" == event
    then
        HWA.initThrottled()
        C_Timer.After(1, function()
            WeakAuras.ScanEvents("HWA_INIT", true)
        end)
    elseif "UPDATE_SHAPESHIFT_FORM" == event then
        local formID = GetShapeshiftFormID()
        if aura_env.formID ~= formID then
            aura_env.formID = formID
            WeakAuras.ScanEvents("HWA_UPDATE", "form")
        end
    end
end
