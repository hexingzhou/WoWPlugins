--[[
- Events: PLAYER_TARGET_CHANGED, PLAYER_TOTEM_UPDATE, UNIT_AURA, HWA_UPDATE
--]]
function(states, event, ...)
    if "HWA_UPDATE" == event then
        local type = ...
        if type == "init" then
            if HWA then
                if HWA.initCurrentAuras then
                    HWA.initCurrentAuras()
                end
                if HWA.initCurrentTotems then
                    HWA.initCurrentTotems()
                end
            end
        end
    elseif "PLAYER_TARGET_CHANGED" == event then
        if HWA and HWA.scanCurrentAuras then
            HWA.scanCurrentAuras("target")
        end
    elseif "PLAYER_TOTEM_UPDATE" == event then
        local totemSlot = ...
        if totemSlot and HWA and HWA.scanCurrentTotems then
            HWA.scanCurrentTotems(totemSlot)
        end
    elseif "UNIT_AURA" == event then
        local unitTarget, updateInfo = ...
        if unitTarget == "player" or unitTarget == "target" then
            if HWA and HWA.scanCurrentAuras then
                HWA.scanCurrentAuras(unitTarget, updateInfo)
            end
        end
    end
end
