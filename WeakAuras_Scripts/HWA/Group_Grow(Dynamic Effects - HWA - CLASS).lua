--[[
- For use:
[Require] Replace CLASS in name to the right one.
--]]
function(newPositions, activeRegions)
    local HWA = HWA and HWA[aura_env.id:gsub("Dynamic Effects %- HWA %- ", "")] or {}

    if HWA and HWA.dynamicEffectsGrow then
        HWA.dynamicEffectsGrow(newPositions, activeRegions)
    end
end
