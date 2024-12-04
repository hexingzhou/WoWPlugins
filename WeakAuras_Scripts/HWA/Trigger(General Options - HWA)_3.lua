--[[
- Events: STATUS
--]]
function(event)
    if "STATUS" == event then
        C_Timer.After(0.05, function()
            WeakAuras.ScanEvents("HWA_INIT")
        end)
    end
end
