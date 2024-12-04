--[[
- Events: OPTIONS, PLAYER_ENTERING_WORLD, PLAYER_SPECIALIZATION_CHANGED, TRAIT_CONFIG_UPDATED, GROUP_JOINED, GROUP_LEFT, UPDATE_SHAPESHIFT_FORM, HWA_OPTIONS, HWA_INIT
--]]
function(event, ...)
    if not HWA then
        return
    end
    local arg = ...

    if "OPTIONS" == event or "HWA_OPTIONS" == event then
        HWA.getConfig()
        HWA.initThrottled()
    elseif "HWA_INIT" == event and arg then
        HWA.initThrottled()
    elseif "HWA_INIT" == event then
        HWA.init()
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
            WeakAuras.ScanEvents("HWA_UPDATE")
        end
    end
end
