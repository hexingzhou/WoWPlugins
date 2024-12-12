--[[
- Events: PLAYER_TARGET_CHANGED, UNIT_AURA, HWA_UPDATE
--]]
function(states, event, ...)
    if "HWA_UPDATE" == event then
        local type = ...
        if type == "init" then
            if HWA and HWA.initCurrentAuras then
                HWA.initCurrentAuras()
            end
        end
    elseif "PLAYER_TARGET_CHANGED" == event then
        if HWA and HWA.scanCurrentAuras then
            HWA.scanCurrentAuras("target", "HELPFUL")
            HWA.scanCurrentAuras("target", "HARMFUL")
        end
    elseif "UNIT_AURA" == event then
        local unitTarget, updateInfo = ...
        if unitTarget == "player" or unitTarget == "target" then
            if HWA and HWA.scanCurrentAuras then
                HWA.scanCurrentAuras(unitTarget, "HELPFUL", updateInfo)
                HWA.scanCurrentAuras(unitTarget, "HARMFUL", updateInfo)
            end
        end
    end
end
