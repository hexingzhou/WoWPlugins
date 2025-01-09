--[[
- Events: UNIT_HEALTH, PLAYER_TARGET_CHANGED, PLAYER_TOTEM_UPDATE, UNIT_AURA, HWA_UPDATE
--]]
function(states, event, ...)
    local H = HWA or {}

    if "HWA_UPDATE" == event then
        local type = ...
        if type == "init" then
            if H.initCurrentAuras then
                H.initCurrentAuras()
            end
            if H.initCurrentTotems then
                H.initCurrentTotems()
            end
        end
    elseif "UNIT_HEALTH" == event then
        local unitTarget = ...
        if unitTarget == "player" or unitTarget == "target" then
            if H.scanCurrentHealthes then
                H.scanCurrentHealthes(unitTarget)
            end
        end
    elseif "PLAYER_TARGET_CHANGED" == event then
        if H.scanCurrentAuras then
            H.scanCurrentAuras("target")
        end
        if H.scanCurrentHealthes then
            H.scanCurrentHealthes("target")
        end
    elseif "PLAYER_TOTEM_UPDATE" == event then
        local totemSlot = ...
        if totemSlot and H.scanCurrentTotems then
            H.scanCurrentTotems(totemSlot)
        end
    elseif "UNIT_AURA" == event then
        local unitTarget, updateInfo = ...
        if unitTarget == "player" or unitTarget == "target" then
            if H.scanCurrentAuras then
                H.scanCurrentAuras(unitTarget, updateInfo)
            end
        end
    end
end
