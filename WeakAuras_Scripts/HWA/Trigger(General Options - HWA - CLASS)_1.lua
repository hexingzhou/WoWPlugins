--[[
- Events: OPTIONS, HWA_OPTIONS, HWA_INIT, PLAYER_ENTERING_WORLD, PLAYER_SPECIALIZATION_CHANGED, TRAIT_CONFIG_UPDATED, UPDATE_SHAPESHIFT_FORM
--]]
function(event, ...)
    local arg1, arg2 = ...
   
    if "OPTIONS" == event or "HWA_OPTIONS" == event or ("HWA_INIT" == event and arg1) then
        aura_env.initThrottled()
       
    elseif "HWA_INIT" == event then
        aura_env.init()
       
    elseif ("PLAYER_ENTERING_WORLD" == event and (arg1 or arg2)) or "PLAYER_SPECIALIZATION_CHANGED" == event or "TRAIT_CONFIG_UPDATED" == event then
        aura_env.initThrottled()
       
        C_Timer.After(1, function()
            WeakAuras.ScanEvents("HWA_INIT", true)
        end)
    elseif "UPDATE_SHAPESHIFT_FORM" == event then
        local formID = GetShapeshiftFormID()

        if aura_env.formID ~= formID then
            aura_env.formID = formID

            WeakAuras.ScanEvents("HWA_UPDATE_SHAPESHIFT_FORM")
        end
    end
   
    return true
end